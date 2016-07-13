From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Jul 2016 09:20:01 -0400 (EDT)
Subject: [LTP] [PATCH] safe_macros: match oldlib SAFE_CLOSE with docs
In-Reply-To: <20160713125117.GC2232@rei.scz.novell.com>
References: <c173ae5fd35390cdf47c0fed09577c0c0edab814.1468247097.git.jstancek@redhat.com>
 <20160712135542.GD2651@rei.suse.cz>
 <1283099046.4208400.1468339858052.JavaMail.zimbra@redhat.com>
 <442527119.4450656.1468414366190.JavaMail.zimbra@redhat.com>
 <20160713125117.GC2232@rei.scz.novell.com>
Message-ID: <316514866.4459432.1468416001390.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 13 July, 2016 2:51:17 PM
> Subject: Re: [LTP] [PATCH] safe_macros: match oldlib SAFE_CLOSE with docs
> 
> Hi!
> > > That was the plan, but I didn't get to that today.
> > > 
> > > I was thinking syscalls as well, since most common failure seems
> > > to be errno tests, trying to trigger EBADF, etc.
> > > 
> > > I'll reply once I have results.
> > > 
> > > Regards,
> > > Jan
> > > 
> > > > 
> > > > I do not expect that this will break anything, but there it's a
> > > > possibility.
> > 
> > I ran syscalls (+small selection of other tests) on x86_64, ppc64le
> > and s390x. Only failure was inotify06, but it turned out, that kernel
> > didn't have a patch for this specific failure [1]. It failed with or
> > without oldlib SAFE_CLOSE patch. inotify06 passed with 4.7.0-rc7+.
> 
> Thanks for the testing. Patch is acked.

Pushed.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
