From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Mar 2018 16:42:03 +0200
Subject: [LTP] [PATCH] fcntl37: test posix lock across execve
In-Reply-To: <20180326143313.GE27423@rei>
References: <1522070895-2289-1-git-send-email-xzhou@redhat.com>
 <20180326143313.GE27423@rei>
Message-ID: <20180326144203.GA16692@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +	pthread_t th;
> > +	SAFE_PTHREAD_CREATE(&th, NULL, thread_fn, (void *)&fd);
>                                                     ^
> 						    Here as well, we
> 						    have to cast the fd
> 						    to intptr_t first.

Scratch that, you are passing the fd by pointer not by value, which is
questionable practice for a value on the function stack.

What is usually done when you need to pass integers to threads as
paramters is to cast the integer to a type with the same width as a
pointer then casting it to a void*, which is (void*)(intptr_t)fd in this
case.

-- 
Cyril Hrubis
chrubis@suse.cz
