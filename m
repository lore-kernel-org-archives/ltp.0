From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Jan 2018 14:40:39 +0100
Subject: [LTP] [PATCH] Add library support for /proc/sys/kernel/tainted
In-Reply-To: <20180125082348.inp2nfhubfdwrjky@linux.suse>
References: <20180123143013.2879-1-mmoese@suse.de>
 <20180124131313.GB26495@rei.lan>
 <20180125082348.inp2nfhubfdwrjky@linux.suse>
Message-ID: <20180125134039.GC19878@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This one kept me busy thinking about it yesterday evening.
> I wonder if we could reduce it to two functions:
>   tst_taint_init(unsigned mask)
> and
>   tst_taint_check()
> 
> The first one saves the desired flags, checks for support in kernel etc.
> and the latter just checks if the tainted flags remain the same.
> 
> After thinking it through, I can hardly imagine a different use case.

Agreed, we also have the luxury of having all the code that uses the
library in one repository. Hence we do not have to carry on with API
mistakes for years as libc and other core library have to...

-- 
Cyril Hrubis
chrubis@suse.cz
