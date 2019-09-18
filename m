From: Li Wang <liwang@redhat.com>
Date: Wed, 18 Sep 2019 13:56:17 +0800
Subject: [LTP] [RFC PATCH] tst_taint: TCONF when kernel is alreay tainted
In-Reply-To: <20190918053519.26244-1-liwang@redhat.com>
References: <20190918053519.26244-1-liwang@redhat.com>
Message-ID: <CAEemH2de4T6+rRuBrYaQDA-ubXaX6nfCykY+EbGi-Sj_tu-3Sw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 18, 2019 at 1:35 PM Li Wang <liwang@redhat.com> wrote:

> As the tst_taint_init comments described, If the tainted-flags are already
> set
> by the kernel, there is no reason to continue and TCONF is generated. But
> in
> the function achieve, it uses TBROK.
>
>   cmdline="cve-2017-17053"
>   tst_test.c:1096: INFO: Timeout per run is 0h 10m 00s
>   tst_taint.c:88: BROK: Kernel is already tainted: 536871424
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Chang Yin <cyin@redhat.com>
> Cc: Michael Moese <mmoese@suse.de>
> ---
>
> Notes:
>     Hi Cyril & Michael,
>
>     I'm not sure if that's a good choice to skip whole test if the kernel
> already
>     tainted, so maybe we could also perform it but not do a strict
> tainted-flags
>     check after testing? The reason I think is it probably have chance to
> find
>     new issue even with a tainted kernel.
>

Something maybe change like below, which way is better?

--- a/lib/tst_taint.c
+++ b/lib/tst_taint.c
@@ -7,6 +7,7 @@
 #define TAINT_FILE "/proc/sys/kernel/tainted"

 static unsigned int taint_mask = -1;
+static unsigned int taint_check = 1;

 static unsigned int tst_taint_read(void)
 {
@@ -84,8 +85,10 @@ void tst_taint_init(unsigned int mask)
        taint_mask = mask;

        taint = tst_taint_read();
-       if ((taint & mask) != 0)
-               tst_brk(TCONF, "Kernel is already tainted: %u", taint);
+       if ((taint & mask) != 0) {
+               tst_res(TINFO, "Kernel is already tainted: %u", taint);
+               taint_check = 0;
+       }
 }


@@ -98,5 +101,5 @@ unsigned int tst_taint_check(void)

        taint = tst_taint_read();

-       return (taint & taint_mask);
+       return (taint & taint_mask & taint_check);
 }
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190918/2a2f7a28/attachment.htm>
