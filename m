From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Nov 2018 17:06:08 +0100
Subject: [LTP] [PATCH 1/5] syscalls/fanotify01: check events also on
 mountpoint mark
In-Reply-To: <CAOQ4uxhBON0ej_ABZAVqwa3NfrpRKQcSsDqXV4wW8VoQLWk16g@mail.gmail.com>
References: <20181116065119.6912-1-amir73il@gmail.com>
 <20181116065119.6912-2-amir73il@gmail.com>
 <20181121120103.GB2954@rei>
 <CAOQ4uxhBON0ej_ABZAVqwa3NfrpRKQcSsDqXV4wW8VoQLWk16g@mail.gmail.com>
Message-ID: <20181122160608.GE907@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I've added SAFE_CLOSE(fd_notify) here so that we do not use all
> > available file descriptors with large enough -i parameter and pushed.
> >
> > I do wonder what is the reason to move the fanotify_init() from setup
> > the the test_fanotify(), is there a problem with recycling the same fd
> > for different tests?
> >
> 
> Closing fd_notify is an easier and better cleanup between test cases.
> Otherwise we would need to FAN_MARK_FLUSH all the individual marks
> that we added.

Wouldn't that cover more of kernel codepaths? If we reused the fd and
cleared all the marks we would test that the API for clearing the marks
works as expected. Or should we write a separate test for that?

-- 
Cyril Hrubis
chrubis@suse.cz
