From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Aug 2016 11:26:33 +0200
Subject: [LTP] [PATCH] tst_test: Propagate SIGINT to test process
In-Reply-To: <CAFEAcA8aMpXvLYNaqoRCO0x+rkMQ=4oTUM8MZqjoHaaxkbZi+A@mail.gmail.com>
References: <20160804144508.GA8001@rei.lan>
 <321891608.1353493.1470404076410.JavaMail.zimbra@redhat.com>
 <CAFEAcA8aMpXvLYNaqoRCO0x+rkMQ=4oTUM8MZqjoHaaxkbZi+A@mail.gmail.com>
Message-ID: <20160809092633.GB30544@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This still gives me a warning:
> >   tst_test.c: In function ???sigint_handler???:
> >   tst_test.c:732:3: warning: ignoring return value of ???write???, declared with attribute warn_unused_result [-Wunused-result]
> >    (void)write(2, SIGINT_MSG, sizeof(SIGINT_MSG) - 1);
> >    ^
> > We could use fprintf(stderr):
> >   fprintf(stderr, "%s\n", SIGINT_MSG);
> 
> fprintf() isn't guaranteed to work inside a signal handler,
> unlike write() [see the list of "async-signal-safe" functions
> in the signal(7) manpage]. I think the officially recommended
> way to shut up this warning is something like
> 
>     if (write(fd, msg, len) < len) {
>         /* It's OK to ignore the error because ... */
>     }
> 
> which is a bit longwinded but works.

More about this in:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66425

In short somebody thought that suppressing the warning with (void) is a
bad idea for security. Which it indeed is for cases where somebody does
it for setuid() and friends. But it's more or less fine for cases like
this.

And at the bottom of the bug they decided that we need two
warn_unused_result, one where it's OK to suppress the warning and one
where it's not. But nobody implemented that so far.

I would be inclined to ingrore this warning in this case rather than
working around compiler bugs.

-- 
Cyril Hrubis
chrubis@suse.cz
