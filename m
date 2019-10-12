From: Li Wang <liwang@redhat.com>
Date: Sat, 12 Oct 2019 13:58:09 +0800
Subject: [LTP] [PATCH v2] read_all: retry to queue work for any worker
In-Reply-To: <CAEemH2d82pP2mwHnw42h-17HipGsVeYesfzg7o4axvCiRKU0=Q@mail.gmail.com>
References: <26d555b1d9deddb5a6f0a93a7c7d3b00e8abc1ff.1570616598.git.jstancek@redhat.com>
 <8c5d507fd19bc3110561ed1c666b7ac47442e09e.1570632125.git.jstancek@redhat.com>
 <CAEemH2d82pP2mwHnw42h-17HipGsVeYesfzg7o4axvCiRKU0=Q@mail.gmail.com>
Message-ID: <CAEemH2eYc1VVtavWKTE-x1gqY6q7qyMVZ-bETXJytPkdvHJriw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

On Fri, Oct 11, 2019 at 4:24 PM Li Wang <liwang@redhat.com> wrote:

>
>
> On Wed, Oct 9, 2019 at 10:43 PM Jan Stancek <jstancek@redhat.com> wrote:
>
>> read_all is currently retrying only for short time period and it's
>> retrying to queue for same worker. If that worker is busy, it easily
>> hits timeout.
>>
>> For example 'kernel_page_tables' on aarch64 can take long time to
>> open/read:
>>   # time dd if=/sys/kernel/debug/kernel_page_tables of=/dev/null count=1
>> bs=1024
>>   1+0 records in
>>   1+0 records out
>>   1024 bytes (1.0 kB, 1.0 KiB) copied, 13.0531 s, 0.1 kB/s
>>
>>   real    0m13.066s
>>   user    0m0.000s
>>   sys     0m13.059s
>>
>> Rather than retrying to queue for specific worker, pick any that can
>> accept
>> the work and keep trying until we succeed or hit test timeout.
>>
>
RFC:

Base on your patch, I'm thinking to achieve a new macro TST_INFILOOP_FUNC
which can repeat the @FUNC infinitely. Do you feel it satisfies your
requirements to some degree or meaningful to LTP?
+/**
+ * TST_INFILOOP_FUNC() - Infinitely retry a function with an increasing
delay.
+ * @FUNC - The function which will be retried
+ * @ERET - The value returned from @FUNC on success
+ *
+ * This macro will call @FUNC in an infinite loop with a delay. If @FUNC
+ * returns @ERET then the loop exits. The delay between retries starts at
one
+ * microsecond and is then doubled each iteration until it exceeds one
second.
+ * When the delay exceeds one-second @FUNC keep repeat until get success
or hit
+ * test timeout.
+ */
+#define TST_INFILOOP_FUNC(FUNC, ERET) \
+       TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, -1)
+
 #define TST_RETRY_FN_EXP_BACKOFF(FUNC, ERET, MAX_DELAY)        \
-({     int tst_delay_ = 1;                                             \
+({     int tst_delay_ = 1, tst_max_delay_ = MAX_DELAY;                 \
+       if (MAX_DELAY < 0)                                              \
+                tst_max_delay_ *= MAX_DELAY;                           \
        for (;;) {                                                      \
                typeof(FUNC) tst_ret_ = FUNC;                           \
                if (tst_ret_ == ERET)                                   \
                        break;                                          \
-               if (tst_delay_ < MAX_DELAY * 1000000) {                 \
-                       usleep(tst_delay_);                             \
+               usleep(tst_delay_);                                     \
+               if (tst_delay_ < tst_max_delay_ * 1000000) {            \
                        tst_delay_ *= 2;                                \
                } else {                                                \
-                       tst_brk(TBROK, #FUNC" timed out");              \
+                        if (MAX_DELAY > 0)                             \
+                               tst_brk(TBROK, #FUNC" timed out");      \
                }                                                       \
        }                                                               \
        ERET;                                                           \

Add pastebin to better readable: http://pastebin.test.redhat.com/805437

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191012/782621dd/attachment-0001.htm>
