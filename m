From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 May 2017 15:59:34 +0200
Subject: [LTP] [RFC] [PATCH] pselect01: Tune thresholds
In-Reply-To: <20170512131730.GA25149@rei.lan>
References: <20170505131855.32545-1-chrubis@suse.cz>
 <2075581666.10581422.1494518085371.JavaMail.zimbra@redhat.com>
 <20170512065131.GA24762@rei.lan>
 <1541549049.10767477.1494573107488.JavaMail.zimbra@redhat.com>
 <20170512071719.GB24762@rei.lan>
 <1049610106.10797216.1494574389728.JavaMail.zimbra@redhat.com>
 <trinity-29096542-6ccc-407c-b312-5b55c487a1f3-1494583440399@3capp-gmx-bs13>
 <20170512131730.GA25149@rei.lan>
Message-ID: <20170512135929.GB25149@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Additionally, please keep in mind that on some architectures the
> > time measured is based on the jiffies clock resolution which depends
> > on the CONFIG_HZ value and results in a resolutions of e.g. 0.01, 
> > 0.004, or 0.001 seconds which is way above the resolution you get
> > on the x86 platform (with the TSC clock).
> > 
> > This testcase was failing for me on the parisc platform because of this inaccuracy.
> > 
> > Maybe the resolution of the CLOCK_MONOTONIC clock (which is basically used in this
> > test) should be checked with clock_getres() and it's result included in the calculation?
> 
> Right, I've dusted off old pxa270 and indeed we cannot measure less than
> 20us interval there. But clock_getres() returns 10ms which is much more
> than the actuall measured value...

And I did a mistake in conversion, looks like 20ms is minimal time the
pselect() can sleep there while reported precision is 10ms, so adding
2 * clock_monotonic_resolution fixes the test there. I will send v2
for the testcase right away.

-- 
Cyril Hrubis
chrubis@suse.cz
