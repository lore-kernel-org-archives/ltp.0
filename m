From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Jul 2016 13:33:12 +0800
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
In-Reply-To: <578F8CB6.2020602@redhat.com>
References: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
 <20160719055844.GA31704@gmail.com>
 <1822250385.6269456.1468911402613.JavaMail.zimbra@redhat.com>
 <20160719085756.GB31704@gmail.com> <578F8CB6.2020602@redhat.com>
Message-ID: <20160721053312.GA10220@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jul 20, 2016 at 04:37:42PM +0200, Jan Stancek wrote:
> 
> Attached is a different approach, that watches progress of SwapCached
> from /proc/meminfo and as soon as it sees 128M increase it takes that
> as PASS or gives up after 5 seconds with FAIL.
> 
> GOOD kernel:
> tst_test.c:701: INFO: Timeout per run is 300s
> madvise06.c:98: INFO: SwapCached (before madvise): 53576
> madvise06.c:113: INFO: SwapCached (after madvise): 568080
> madvise06.c:115: PASS: Regression test pass
> 
> BAD kernel:
> # ./madvise06
> tst_test.c:701: INFO: Timeout per run is 300s
> madvise06.c:98: INFO: SwapCached (before madvise): 43712
> madvise06.c:113: INFO: SwapCached (after madvise): 45636
> madvise06.c:117: FAIL: Bug has been reproduced
> 
> If you still have the setup, can you try how reliable is this approach?

Yes, it works for me. the GOOD kernel get PASS, and BAD kernel
always FAIL.

I didn't fully understand this method, could you give more
explanation in the upcoming patch?


Regards,
Li Wang
