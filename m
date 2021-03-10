From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 10 Mar 2021 14:13:04 +0530
Subject: [LTP] [PATCh v2] clock_gettime04: print more info to help
 debugging
In-Reply-To: <CAEemH2esvVfy0YeCL2nXgj441XeBY7F+Y8MVEJ31nKRNPvjC+g@mail.gmail.com>
References: <20210309080028.16284-1-liwang@redhat.com>
 <20210309094525.4ggmppfpvavsvjzl@vireshk-i7>
 <YEdhgvXg/mYkppz6@pevik>
 <20210309115623.ze5c7li7vuf65gvg@vireshk-i7>
 <CAEemH2esvVfy0YeCL2nXgj441XeBY7F+Y8MVEJ31nKRNPvjC+g@mail.gmail.com>
Message-ID: <20210310084304.d6b626clzj5rafvh@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10-03-21, 16:34, Li Wang wrote:
> But we can put the printing behind the 'gettimeofday+CLOCK_REALTIME'
> checking.
> Just similar to what I did in patch V1, is that your mean, Petr?
> 
> --- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> @@ -108,6 +108,9 @@ static void run(unsigned int i)
>                         if (tv->clock_gettime == my_gettimeofday && clks[i]
> != CLOCK_REALTIME)
>                                 continue;
> 
> +                       if (count == 10000)
> +                                tst_res(TINFO, "\t- %s", tv->desc);
> +
>                         ret = tv->clock_gettime(clks[i], tst_ts_get(&ts));
>                         if (ret) {
>                                 /*
> @@ -139,8 +142,8 @@ static void run(unsigned int i)
> 
>                         diff = end + slack - start;
>                         if (diff < 0) {
> -                               tst_res(TFAIL, "%s: Time travelled
> backwards (%d): %lld ns",
> -                                       tst_clock_name(clks[i]), j, diff);
> +                               tst_res(TFAIL, "%s(%s): Time travelled
> backwards (%d): %lld ns",
> +                                       tst_clock_name(clks[i]), tv->desc,
> j, diff);
>                                 return;
>                         }

I think it would be worth keeping it simple then and just print all
variants only once from setup(). Leave the special case of REALTIME
clock.

-- 
viresh
