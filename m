From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Mar 2018 11:42:28 +0100
Subject: [LTP] [PATCH] times03: don't assume process initial [us]time is
	0
In-Reply-To: <8385516ec732e57976aeef8789480c6bf0199bcb.1520411634.git.jstancek@redhat.com>
References: <8385516ec732e57976aeef8789480c6bf0199bcb.1520411634.git.jstancek@redhat.com>
Message-ID: <20180307104228.GB9871@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> times() runs immediately after fork(), but syscall alone
> seems to be enough for some systems to already account ticks.
> 
> For example on arm64 with 4.14:
>   tst_test.c:980: INFO: Timeout per run is 0h 05m 00s
>   times03.c:102: PASS: buf1.tms_utime = 0
>   times03.c:105: FAIL: buf1.tms_stime = 1
>   ...
> 
> This patch drops the initial zero check for [us]time.

I wonder if we should drop only the system time counter check, since
agruably the user time should be zero. Or if we should check that these
values are small enough, i.e. < 5 (which should be somewhere between 5ms
and 50ms depending on CONFIG_HZ).


-- 
Cyril Hrubis
chrubis@suse.cz
