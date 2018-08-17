From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Aug 2018 17:04:45 +0800
Subject: [LTP] [PATCH v3 4/4] fzsync: Limit execution time to prevent
	test timeouts
In-Reply-To: <CAEemH2c_-_-3TbY_XYkebTCEUT3Bs_5jKc2pGe2i5DNDMPeXdQ@mail.gmail.com>
References: <20180816120020.11042-1-rpalethorpe@suse.com>
 <20180816120020.11042-4-rpalethorpe@suse.com>
 <CAEemH2c_-_-3TbY_XYkebTCEUT3Bs_5jKc2pGe2i5DNDMPeXdQ@mail.gmail.com>
Message-ID: <CAEemH2cx7qLCR3kVd6Vt2Wq2p5cubi4m-h998DjrkMiZWBtFZA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Li Wang <liwang@redhat.com> wrote:

>
> Richard Palethorpe <rpalethorpe@suse.com> wrote:
>>
>> ...
>>
>> @@ -99,6 +102,15 @@ struct tst_fzsync_pair {
>>         .info_gap = 0x7FFFF     \
>>  }
>>
>> +
>> static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair)
>> +{
>> +       pair->timer.clock_id = CLOCK_MONOTONIC_RAW;
>> +       pair->timer.limit.tv_sec = 60 * tst_timeout_mul();
>> +       pair->timer.limit.tv_nsec = 0;
>> +
>> +       tst_timer_start_st(&pair->timer);
>> +}
>> +
>>
>
> There is a loop defect in this method as I commented in patch V2.
>
> If we don't reset the pair->exit to 0 after one loop, it will be never run
> into the second
> fzsync function because the pair->exit has been set to 1 at the first
> expired time.
>
> something result like:
> ----------------------------
> # ./cve-2016-7117 -i 3
> tst_test.c:1022: INFO: Timeout per run is 0h 05m 00s
> ../../include/tst_fuzzy_sync.h:121: INFO: avg_diff = -216ns, avg_dev =
> 565ns, delay = 02474 loops
> ../../include/tst_fuzzy_sync.h:121: INFO: avg_diff = 12ns, avg_dev =
> 430ns, delay = 02604 loops
> ../../include/tst_fuzzy_sync.h:330: INFO: Exceeded fuzzy sync time limit,
> requesting exit
> cve-2016-7117.c:161: PASS: Nothing happened after 1564741 attempts
> cve-2016-7117.c:161: PASS: Nothing happened after 1 attempts
> cve-2016-7117.c:161: PASS: Nothing happened after 1 attempts
>
> Summary:
> passed   3
> failed   0
> skipped  0
> warnings 0
>
> But, if we just reset the pair->exit to 0 in the new function
> tst_fzsync_pair_reset(),
> there still NOT fix the problem totally, because in the last test expired
> time, all threads
> created by setup() function have exited, and here we'll only loop
> in tst_fzsync_wait_a()
> and wait there forever. :(
>

I just come up with a stupid patch to fix that, but personally I insist
believe
that maybe we should not leave this kind of works to LTP user, we'd better
encapsulate that all in fuzzy_sync library.

Just FYI:

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 5e0ff36..862ab7e 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -102,8 +102,14 @@ struct tst_fzsync_pair {
        .info_gap = 0x7FFFF     \
 }

-static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair)
+static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 {
+       pair->exit = 0;
+       pair->delay = 0;
+       pair->a_cntr = pair->b_cntr = 0;
+       pair->avg_dev = pair->avg_diff = 0;
+       pair->a.tv_sec = pair->a.tv_nsec = 0;
+       pair->b.tv_sec = pair->b.tv_nsec = 0;
        pair->timer.clock_id = CLOCK_MONOTONIC_RAW;
        pair->timer.limit.tv_sec = 60 * tst_timeout_mul();
        pair->timer.limit.tv_nsec = 0;
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index fecc588..f8993c7 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -136,7 +136,10 @@ static void run(void)

        msghdrs[0].msg_hdr.msg_iov->iov_base = (void *)&rbuf;

-       tst_fzsync_pair_reset(&fzsync_pair);
+       if (fzsync_pair.exit == 1)
+               setup();
+
+       tst_fzsync_pair_init(&fzsync_pair);
        for (i = 1; i < ATTEMPTS; i++) {
                if (socketpair(AF_LOCAL, SOCK_DGRAM, 0, (int *)socket_fds))
                        tst_brk(TBROK | TERRNO, "Socket creation failed");

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180817/fb6ddbf3/attachment.html>
