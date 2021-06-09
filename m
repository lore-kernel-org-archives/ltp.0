From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Jun 2021 16:09:03 +0200
Subject: [LTP] [PATCH] futex_wake04: avoid tst_ts_from_ns overflow on
 32-bit platforms
In-Reply-To: <YMDOkVaCIWEA6Etl@mussarela>
References: <20210608132723.255996-1-cascardo@canonical.com>
 <YMB6aoVvTKJQ6wif@yuki> <YMCkB/iS54OJaby4@mussarela>
 <YMDEPYSWZG5FzUTi@yuki> <YMDOkVaCIWEA6Etl@mussarela>
Message-ID: <YMDLf5B+YvqQhuor@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Yes, there are even uses where NSEC_PER_SEC is redefined.
> 
> I am fine with this other change. I had already tested that it fixes the
> problem just the same.
> 
> How about the commit below?

Looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
