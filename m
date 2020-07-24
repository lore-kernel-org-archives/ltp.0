From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 24 Jul 2020 16:04:54 +0530
Subject: [LTP] [PATCH 4/4] libs: sigwait: Get rid of REPORT_SUCCESS()
 macro
In-Reply-To: <20200724055826.GE32086@dell5510>
References: <e51142a397858a2fe6a040563d3c0795a7d0bb05.1595511710.git.viresh.kumar@linaro.org>
 <a83166af3a2b432bb11a0876e18e15705479f32d.1595511710.git.viresh.kumar@linaro.org>
 <20200724055826.GE32086@dell5510>
Message-ID: <20200724103454.ttaqxq3hzmth7gpr@vireshk-mac-ubuntu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24-07-20, 07:58, Petr Vorel wrote:
> Hi Viresh,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Although these errors are still here:

I went to libs/ directory and I don't get any warnings with

$ make clean; make

How can I generate these easily ?

> sigwait.c: In function ?test_masked_matching?:
> sigwait.c:157:42: warning: passing argument 3 to restrict-qualified parameter aliases with argument 2 [-Wrestrict]
>   157 |  TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
>       |                                ~~~~~~~~  ^~~~~~~~
> ../../include/tst_test.h:266:13: note: in definition of macro ?TEST?
>   266 |   TST_RET = SCALL; \
 
> IMHO we shouldn't use oldmask for src and dest.

And I am not really sure what the error says and why it is there.

-- 
viresh
