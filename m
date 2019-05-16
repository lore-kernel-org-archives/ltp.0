From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 May 2019 11:07:05 +0200
Subject: [LTP] Oldest still supported kernel
In-Reply-To: <1051593197.23090826.1557995723298.JavaMail.zimbra@redhat.com>
References: <20190516073826.GA14532@dell5510>
 <1051593197.23090826.1557995723298.JavaMail.zimbra@redhat.com>
Message-ID: <20190516090705.GA21814@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Is it the oldest version we want to support or even something older?
> 
> I'd like minimum to be at least 3.10.0 / glibc-2.17 (RHEL7).
> 
> Older distros use LTP mostly for regression tests, so it might be acceptable
> for users to switch to older release tag, rather than always latest master.
> 
> There's also an option, we create a "legacy" branch for old distros,
> and accept only critical fixes (no new tests, rewrites, etc.). It would
> be unsupported, but provide place where legacy users can cooperate.

I was trying to avoid having several active branches for LTP for several
reasons. Mainly to avoid people running old LTP on reasonably modern
kernels because they were under an impression that older release is more
stable. Hence I would like to avoid having this if possible.

-- 
Cyril Hrubis
chrubis@suse.cz
