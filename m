From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 Nov 2018 18:57:47 +0200
Subject: [LTP] [PATCH 1/5] syscalls/fanotify01: check events also on
	mountpoint mark
In-Reply-To: <20181122160608.GE907@rei.lan>
References: <20181116065119.6912-1-amir73il@gmail.com>
 <20181116065119.6912-2-amir73il@gmail.com>
 <20181121120103.GB2954@rei>
 <CAOQ4uxhBON0ej_ABZAVqwa3NfrpRKQcSsDqXV4wW8VoQLWk16g@mail.gmail.com>
 <20181122160608.GE907@rei.lan>
Message-ID: <CAOQ4uxgt4UqHhkROP_JZQ2Y54_RrrNReKgtiHi5hLTeW_rkYsQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 22, 2018 at 6:07 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > I've added SAFE_CLOSE(fd_notify) here so that we do not use all
> > > available file descriptors with large enough -i parameter and pushed.
> > >
> > > I do wonder what is the reason to move the fanotify_init() from setup
> > > the the test_fanotify(), is there a problem with recycling the same fd
> > > for different tests?
> > >
> >
> > Closing fd_notify is an easier and better cleanup between test cases.
> > Otherwise we would need to FAN_MARK_FLUSH all the individual marks
> > that we added.
>
> Wouldn't that cover more of kernel codepaths? If we reused the fd and
> cleared all the marks we would test that the API for clearing the marks
> works as expected. Or should we write a separate test for that?

I see that fanotify04 exercises FAN_MARK_FLUSH.
Besides it is probably the less common case (??).
Most of the time I imagine that a monitoring program sets a mark
and watches events until it closes the fd.

Thanks,
Amir.
