from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from werkzeug.utils import secure_filename
from werkzeug.datastructures import FileStorage
from datetime import datetime
from flaskext.mysql import MySQL
import mysql.connector
import json
import os
import math
from flask_mail import Mail

with open('config.json', 'r') as c:
    params = json.load(c)["params"]

local_server = True
app = Flask(__name__)
app.secret_key = 'the-secret-key'
app.config['UPLOAD_FOLDER'] = params['upload_location']
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail-password']
)
mail = Mail(app)
if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)

class Contact(db.Model):
    SNo = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(80), nullable=False)
    Email = db.Column(db.String(20), nullable=False)
    Phone_No = db.Column(db.String(12), nullable=False)
    Message = db.Column(db.String(120), nullable=False)
    Date = db.Column(db.String(12), nullable=True)

class Post(db.Model):
        SNo = db.Column(db.Integer, primary_key=True)
        Title = db.Column(db.String(80), nullable=False)
        Slug = db.Column(db.String(20), nullable=False)
        Content = db.Column(db.String(120), nullable=False)
        Tagline = db.Column(db.String(50), nullable=False)
        Images = db.Column(db.String(30), nullable=False)
        Date = db.Column(db.String(12), nullable=True)

@app.route("/")
def home():
    post = Post.query.filter_by().all()
    last = math.ceil(len(post)/int(params['no_of_posts']))
    #[0:params['no_of_posts']]
    page = request.args.get('page')
    if(not str(page).isnumeric()):
        page = 1
    page = int(page)
    post = post[(page-1)*int(params['no_of_posts']): (page-1)*int(params['no_of_posts'])+ int(params['no_of_posts'])]
    if (page==1):
        prev = "#"
        next = "/?page=" + str(page+1)
    elif(page==last):
        prev = "/?page=" + str(page - 1)
        next = "#"
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)


    return render_template('index.html', params=params, post=post, prev=prev, next=next)


@app.route("/about")
def about():
    return render_template('about.html', params=params)

@app.route("/dashboard", methods=['GET', 'POST'])
def dashboard():

    if ('user' in session and session['user'] == params['admin_user']):
        posts = Post.query.all()
        return render_template('dashboard.html', params=params, posts = posts)

    if request.method=='POST':
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if (username == params['admin_user'] and userpass == params['admin_password']):
            #setting the session variable
            session['user'] = username
            posts = Post.query.all()
            return render_template('dashboard.html', params=params, post = posts)

    return render_template('login.html', params=params)

@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Post.query.filter_by(Slug=post_slug).first()


    return render_template('post.html', params=params, post=post)

@app.route("/edit/<string:sno>", methods = ["GET", "POST"])
def edit(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == 'POST':
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            image = request.form.get('image')
            date = datetime.now()

            if sno == '0':
                post = Post(Title = box_title, Slug = slug, Content = content, Tagline = tline, Images = image, Date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post = Post.query.filter_by(SNo=sno).first()
                post.Title = box_title
                post.Slug = slug
                post.Content = content
                post.Tagline = tline
                post.Images = image
                post.Date = date
                db.session.commit()
                return redirect('/edit/'+sno)
        post = Post.query.filter_by(SNo=sno).first()

        return render_template('edit.html', params=params, post=post, sno=sno)

@app.route("/uploader", methods = ["GET", "POST"])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
        if (request.method == 'POST'):
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Uploaded Successfully"

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route("/delete/<string:sno>", methods = ["GET", "POST"])
def delete(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        post = Post.query.filter_by(SNo=sno).first()
        db.session.delete(post)
        db.session.commit()
        return redirect('/dashboard')



@app.route("/contact", methods = ["GET", "POST"])
def contact():
    if(request.method == 'POST'):
        '''adding entry to the database'''
        name = request.form.get("name")
        email = request.form.get("email")
        phone = request.form.get("phone")
        message = request.form.get("message")
        contact1 = Contact(Name=name, Email=email, Phone_No=phone, Message=message, Date=datetime.now())
        db.session.add(contact1)
        db.session.commit()
        mail.send_message('New Message From ' + name,
                          sender=email,
                          recipients = [params['gmail-user']],
                          body = message + "\n" + phone
                          )

    return render_template('contact.html', params=params)


app.run(debug=True)

