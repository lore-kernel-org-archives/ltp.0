From: Xiong Zhou <xzhou@redhat.com>
Date: Thu, 29 Mar 2018 22:09:41 +0800
Subject: [LTP] [PATCH] fcntl37: test posix lock across execve
In-Reply-To: <20180326143313.GE27423@rei>
References: <1522070895-2289-1-git-send-email-xzhou@redhat.com>
 <20180326143313.GE27423@rei>
Message-ID: <20180329140941.4ixqvjxx2t5ro6y6@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 26, 2018 at 04:33:33PM +0200, Cyril Hrubis wrote:
> Hi!
> > diff --git a/testcases/kernel/syscalls/fcntl/Makefile b/testcases/kernel/syscalls/fcntl/Makefile
> > index ae37214..7a06aa7 100644
> > --- a/testcases/kernel/syscalls/fcntl/Makefile
> > +++ b/testcases/kernel/syscalls/fcntl/Makefile
> > @@ -27,6 +27,9 @@ fcntl34_64: LDLIBS += -lpthread
> >  fcntl36: LDLIBS += -lpthread
> >  fcntl36_64: LDLIBS += -lpthread
> >  
...snip......

> > +	char prog_name[PATH_MAX];
> > +	ret = readlink("/proc/self/exe", prog_name, PATH_MAX);
> > +	char * const newargv[] = { prog_name, NULL, NULL };
> 
> This is far to complicated for no reason. The path to LTP test binaries
> is in $PATH so you can execute any LTP binary just by it's name.
> Absolute path is absolutely unneeded.

According to man 3 execve and my tests, i see absolute path is needed.

The perror after execve reports "No such file or directory".

Thanks,
Xiong
