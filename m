From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 09:23:48 +0100
Subject: [LTP] [PATCH] Add library support for /proc/sys/kernel/tainted
In-Reply-To: <20180124131313.GB26495@rei.lan>
References: <20180123143013.2879-1-mmoese@suse.de>
 <20180124131313.GB26495@rei.lan>
Message-ID: <20180125082348.inp2nfhubfdwrjky@linux.suse>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
Thanks for all the remarks. I won't comment on those where I totally agree.

On Wed, Jan 24, 2018 at 02:13:13PM +0100, Cyril Hrubis wrote:
> > + * ...
> > + * #include "tst_test.h"
> > + * #include "tst_taint.h"
> > + * ..
> > + * void setup(void)
> > + * {
> > + *	if (!tst_taint_supported())
> > + *		tst_brk(TCONF, "Kernel does not support tainted flags");
> 
> I think that we should check here if the kernel was tainted before the
> test here and issue TBROK.
> 
> And also I would like to have the API tailored for the most common case
> as well. So what about something as adding tst_check_taint(unsigned mask)
> to be called from the test setup that would:
> 
> * check if kernel is new enough, otherwise do TCONF
> 
> * check if all flags in the mask are not set, otherwise do TBROK

This one kept me busy thinking about it yesterday evening.
I wonder if we could reduce it to two functions:
  tst_taint_init(unsigned mask)
and
  tst_taint_check()

The first one saves the desired flags, checks for support in kernel etc.
and the latter just checks if the tainted flags remain the same.

After thinking it through, I can hardly imagine a different use case.

Thanks,
Michael

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
