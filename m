From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Jul 2016 08:52:46 -0400 (EDT)
Subject: [LTP] [PATCH] safe_macros: match oldlib SAFE_CLOSE with docs
In-Reply-To: <1283099046.4208400.1468339858052.JavaMail.zimbra@redhat.com>
References: <c173ae5fd35390cdf47c0fed09577c0c0edab814.1468247097.git.jstancek@redhat.com>
 <20160712135542.GD2651@rei.suse.cz>
 <1283099046.4208400.1468339858052.JavaMail.zimbra@redhat.com>
Message-ID: <442527119.4450656.1468414366190.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Cyril Hrubis" <chrubis@suse.cz>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 12 July, 2016 6:10:58 PM
> Subject: Re: [LTP] [PATCH] safe_macros: match oldlib SAFE_CLOSE with docs
> 
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Cyril Hrubis" <chrubis@suse.cz>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: ltp@lists.linux.it
> > Sent: Tuesday, 12 July, 2016 3:55:43 PM
> > Subject: Re: [LTP] [PATCH] safe_macros: match oldlib SAFE_CLOSE with docs
> > 
> > Hi!
> > > Docs say that SAFE_CLOSE() sets the passed file descriptor to -1
> > > after it's successfully closed, but oldlib SAFE_CLOSE doesn't
> > > do that.
> > 
> > Have you tried to run at least syscalls testsuite after this change?
> 
> That was the plan, but I didn't get to that today.
> 
> I was thinking syscalls as well, since most common failure seems
> to be errno tests, trying to trigger EBADF, etc.
> 
> I'll reply once I have results.
> 
> Regards,
> Jan
> 
> > 
> > I do not expect that this will break anything, but there it's a
> > possibility.

I ran syscalls (+small selection of other tests) on x86_64, ppc64le
and s390x. Only failure was inotify06, but it turned out, that kernel
didn't have a patch for this specific failure [1]. It failed with or
without oldlib SAFE_CLOSE patch. inotify06 passed with 4.7.0-rc7+.

Regards,
Jan

[1] https://patchwork.kernel.org/patch/8953231/

> > 
> > --
> > Cyril Hrubis
> > chrubis@suse.cz
> > 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
