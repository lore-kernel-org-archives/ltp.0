From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 May 2019 11:00:51 +0200
Subject: [LTP] NS_* ioctl commands fail in 32bit compat mode (-m32)
In-Reply-To: <8736lrx3xu.fsf@rpws.prws.suse.cz>
References: <20190403152245.GC26464@rei.lan>
 <20190411192534.30525-1-fedebonfi95@gmail.com>
 <20190412143318.GA29856@haruka.lan>
 <874l67x53e.fsf@rpws.prws.suse.cz>
 <8736lrx3xu.fsf@rpws.prws.suse.cz>
Message-ID: <20190513090051.GB12685@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > All the tests fail with something similar to:
> > ioctl_ns01.c:45: FAIL: unexpected ioctl error: ENOTTY
> >
> > when compiled with the -m32 flag on at least SUSE kernel 4.20 and
> > 4.12.
> >
> > Do you know if this feature is expected to work in 32bit compat mode?
> > Maybe the size of the arguments should be different when using 32bit mode?
> 
> FYI, it seems the size of the argument and value are the same on both 32bit
> and 64bit mode in user space.

Most likely these calls were not implemented for 32bit compat mode
because nobody needs them there. I guess that the best solution would be
just report TCONF on ENOTTY.

Also it would be nice to have this sorted before the upcomming release.

-- 
Cyril Hrubis
chrubis@suse.cz
