From: zhaogongyi <zhaogongyi@huawei.com>
Date: Tue, 13 Apr 2021 08:19:02 +0000
Subject: [LTP] [PATCH] lib/tst_test.c: Bugfix for heartbeat
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038B47B3@dggeml531-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

According to your review, is there any problems in the patch as follows:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 45753d1ca..0a096d666 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1156,7 +1156,16 @@ static void heartbeat(void)
        if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
                tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");

-       kill(getppid(), SIGUSR1);
+       if (getppid() == 1) {
+               tst_res(TFAIL, "Main test process might have exit!");
+               /*
+                * We need kill the task group immediately since the
+                * main process has exit.
+                */
+               kill(0, SIGKILL);
+               exit(-1);
+       } else
+               kill(getppid(), SIGUSR1);
 }

Thanks so much!

Best Regards,
Gongyi


> 
> Hi!
> > > > +		/*
> > > > +		 * We need kill the task group immediately since the
> > > > +		 * main process has exit.
> > > > +		 */
> > > > +		kill(0, SIGKILL);
> > >
> > > Shouldn't we call exit here? There is no point in continuing once we
> > > reached this point.
> > >
> >
> > Yes, There is no point in continuing once we reached this point.
> > Considering the test might have created sub processes with system,
> > posix_spawn and so on,
> >
> > do we need to kill the task group?
> 
> Yes, I think this is the right course of action, we do the same if the test
> timeouts as well.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
