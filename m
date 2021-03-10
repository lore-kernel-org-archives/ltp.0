From: Li Wang <liwang@redhat.com>
Date: Wed, 10 Mar 2021 16:34:23 +0800
Subject: [LTP] [PATCh v2] clock_gettime04: print more info to help
 debugging
In-Reply-To: <20210309115623.ze5c7li7vuf65gvg@vireshk-i7>
References: <20210309080028.16284-1-liwang@redhat.com>
 <20210309094525.4ggmppfpvavsvjzl@vireshk-i7>
 <YEdhgvXg/mYkppz6@pevik> <20210309115623.ze5c7li7vuf65gvg@vireshk-i7>
Message-ID: <CAEemH2esvVfy0YeCL2nXgj441XeBY7F+Y8MVEJ31nKRNPvjC+g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Viresh Kumar <viresh.kumar@linaro.org> wrote:

> ...
> > > >   clock_gettime04.c:158: TPASS: CLOCK_BOOTTIME: Difference between
> successive readings is reasonable for following variants:
> > > >   clock_gettime04.c:162: TINFO:   - vDSO or syscall with libc spec
> > > >   clock_gettime04.c:162: TINFO:   - syscall with old kernel spec
> > > >   clock_gettime04.c:162: TINFO:   - vDSO with old kernel spec
> >
> > Sorry for putting my opinion late. Instead of repeating variants
> (duplicity)
> > I'd prefer just print variants once at the beginning + print which
> variant
> > failed.
>
> I too thought about that, but then realized that the variant list
> isn't same for all the clocks, like gettimeofday only there for
> CLOCK_REALTIME and so let it go.
>

But we can put the printing behind the 'gettimeofday+CLOCK_REALTIME'
checking.
Just similar to what I did in patch V1, is that your mean, Petr?

--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -108,6 +108,9 @@ static void run(unsigned int i)
                        if (tv->clock_gettime == my_gettimeofday && clks[i]
!= CLOCK_REALTIME)
                                continue;

+                       if (count == 10000)
+                                tst_res(TINFO, "\t- %s", tv->desc);
+
                        ret = tv->clock_gettime(clks[i], tst_ts_get(&ts));
                        if (ret) {
                                /*
@@ -139,8 +142,8 @@ static void run(unsigned int i)

                        diff = end + slack - start;
                        if (diff < 0) {
-                               tst_res(TFAIL, "%s: Time travelled
backwards (%d): %lld ns",
-                                       tst_clock_name(clks[i]), j, diff);
+                               tst_res(TFAIL, "%s(%s): Time travelled
backwards (%d): %lld ns",
+                                       tst_clock_name(clks[i]), tv->desc,
j, diff);
                                return;
                        }



-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210310/52a86054/attachment.htm>
