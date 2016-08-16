From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 16 Aug 2016 07:50:55 -0400 (EDT)
Subject: [LTP] [PATCH] tst_test: Propagate SIGINT to test process
In-Reply-To: <20160816113451.GA25092@rei.lan>
References: <20160804144508.GA8001@rei.lan>
 <321891608.1353493.1470404076410.JavaMail.zimbra@redhat.com>
 <20160816113451.GA25092@rei.lan>
Message-ID: <677837031.3058710.1471348255113.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 16 August, 2016 1:34:51 PM
> Subject: Re: [PATCH] tst_test: Propagate SIGINT to test process
> 
> Hi!
> > This still gives me a warning:
> >   tst_test.c: In function ???sigint_handler???:
> >   tst_test.c:732:3: warning: ignoring return value of ???write???, declared
> >   with attribute warn_unused_result [-Wunused-result]
> >    (void)write(2, SIGINT_MSG, sizeof(SIGINT_MSG) - 1);
> >    ^
> > We could use fprintf(stderr):
> >   fprintf(stderr, "%s\n", SIGINT_MSG);
> 
> Ping.
> 
> What do you think about this?
> 
> Should we ignore the warning for the time being or add the dummy if ()
> to silence it?

I'd go with dummy if (). I think we should try to keep warnings down,
at least for lib. I always check compilation output, and one less
warning to go through each time is IMO worth making this simple workaround.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
