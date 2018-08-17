From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Aug 2018 15:43:47 +0800
Subject: [LTP] [PATCH v3 4/4] fzsync: Limit execution time to prevent
	test timeouts
In-Reply-To: <20180816120020.11042-4-rpalethorpe@suse.com>
References: <20180816120020.11042-1-rpalethorpe@suse.com>
 <20180816120020.11042-4-rpalethorpe@suse.com>
Message-ID: <CAEemH2c_-_-3TbY_XYkebTCEUT3Bs_5jKc2pGe2i5DNDMPeXdQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
> ...
>
> @@ -99,6 +102,15 @@ struct tst_fzsync_pair {
>         .info_gap = 0x7FFFF     \
>  }
>
> +
> static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair)
> +{
> +       pair->timer.clock_id = CLOCK_MONOTONIC_RAW;
> +       pair->timer.limit.tv_sec = 60 * tst_timeout_mul();
> +       pair->timer.limit.tv_nsec = 0;
> +
> +       tst_timer_start_st(&pair->timer);
> +}
> +
>

There is a loop defect in this method as I commented in patch V2.

If we don't reset the pair->exit to 0 after one loop, it will be never run
into the second
fzsync function because the pair->exit has been set to 1 at the first
expired time.

something result like:
----------------------------
# ./cve-2016-7117 -i 3
tst_test.c:1022: INFO: Timeout per run is 0h 05m 00s
../../include/tst_fuzzy_sync.h:121: INFO: avg_diff = -216ns, avg_dev =
565ns, delay = 02474 loops
../../include/tst_fuzzy_sync.h:121: INFO: avg_diff = 12ns, avg_dev = 430ns,
delay = 02604 loops
../../include/tst_fuzzy_sync.h:330: INFO: Exceeded fuzzy sync time limit,
requesting exit
cve-2016-7117.c:161: PASS: Nothing happened after 1564741 attempts
cve-2016-7117.c:161: PASS: Nothing happened after 1 attempts
cve-2016-7117.c:161: PASS: Nothing happened after 1 attempts

Summary:
passed   3
failed   0
skipped  0
warnings 0

But, if we just reset the pair->exit to 0 in the new function
tst_fzsync_pair_reset(),
there still NOT fix the problem totally, because in the last test expired
time, all threads
created by setup() function have exited, and here we'll only loop
in tst_fzsync_wait_a()
and wait there forever. :(

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180817/df3e421d/attachment.html>
