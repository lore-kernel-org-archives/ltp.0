From: Michael Moese <mmoese@suse.de>
Date: Fri, 9 Feb 2018 16:44:10 +0100
Subject: [LTP] [PATCH] Add regression test for CVE-2017-17053
In-Reply-To: <20180209153001.GA28203@rei>
References: <20180126143700.29609-1-mmoese@suse.de>
 <20180209153001.GA28203@rei>
Message-ID: <20180209154410.aoy63rbcygw5tzn6@linux.suse>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

On Fri, Feb 09, 2018 at 04:30:01PM +0100, Cyril Hrubis wrote:
> Why do we use the sa.sa_sigaction here instead of sa_handler if we are
> not using the siginfo_t anyways? And why don't we just use
I can change that, of course

> SAFE_SIGNAL(SIGSEGV, handler) as well?
I thought about it, but that would use signal(). Using signal should in
general be avoided in a multithreaded programm (see man signal). 

> > +	SAFE_MUNMAP((void *) do_exit, sizeof(*do_exit));
>                      ^
> 		    There is absolutely no reason to cast pointers to
> 		    (void *) in C the conversion is automatic in this
> 		    case.
Eh yes, but I have no idea why I put that cast there in the first 
place. Will remove this for v2.

Thanks,
Michael

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
