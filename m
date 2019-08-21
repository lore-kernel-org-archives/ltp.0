From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 21 Aug 2019 13:56:43 +0200
Subject: [LTP] [RFC PATCH 1/1] capability: Introduce capability API
In-Reply-To: <CAEemH2czBk5KKgFB0_4bWtnwdnJdq0sJNmo=q3_u1UipEhaOJw@mail.gmail.com>
References: <20190808153825.18363-1-rpalethorpe@suse.com>
 <20190808153825.18363-2-rpalethorpe@suse.com>
 <CAEemH2czBk5KKgFB0_4bWtnwdnJdq0sJNmo=q3_u1UipEhaOJw@mail.gmail.com>
Message-ID: <87v9uqviis.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

hi,

> It does not work for this simple cap_test.c, did I miss anything?
>
> # whoami
> root
>
> # ./cap_test
> tst_test.c:1111: INFO: Timeout per run is 0h 05m 00s
> tst_capability.c:42: INFO: Dropping CAP_SYS_ADMIN(21)
> tst_capability.c:65: BROK: tst_capset(CAP_SYS_ADMIN): EPERM

Not sure why this fails for you.

>
> # ./cap_test
> tst_test.c:1111: INFO: Timeout per run is 0h 05m 00s
> tst_capability.c:51: CONF: Need CAP_SYS_ADMIN(21)

Ah, I probably got the binary ops wrong.

>
> # cat cap_test.c
> #include "tst_test.h"
> #include "linux/capability.h"
>
> static void do_test(void)
> {
>         tst_res(TPASS, "Hello");
> }
>
> static struct tst_test test = {
>         .test_all = do_test,
>         .needs_root = 1,
>         .caps = (struct tst_cap []) {
> //                TST_CAP(TST_DROP, CAP_SYS_ADMIN),
>                 TST_CAP(TST_REQUIRE, CAP_SYS_ADMIN),
>                 {},
>         },
> };

I will add a test like this, thanks.

-- 
Thank you,
Richard.
