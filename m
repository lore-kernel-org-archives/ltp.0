From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Jan 2021 11:42:26 +0100
Subject: [LTP] [PATCH] include/tst_timer.h: Fix overflows
In-Reply-To: <20210115151936.18809-1-chrubis@suse.cz>
References: <20210115151936.18809-1-chrubis@suse.cz>
Message-ID: <YAVmErn6g+dCfSEr@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> This fixes overflows in tst_timeval_to_us() and tst_timeval_to_ns() on
> 32bit hardware. We have to cast the tv_sec (ulong) to (long long)
> explicitly otherwise the tv_sec will overflow the multiplication.

> This fixes clock_gettime04 where the overflow corrupted the result from
> gettimeofday() when it was converted from timeval to timespec.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
