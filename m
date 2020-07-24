From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 Jul 2020 07:58:26 +0200
Subject: [LTP] [PATCH 4/4] libs: sigwait: Get rid of REPORT_SUCCESS()
 macro
In-Reply-To: <a83166af3a2b432bb11a0876e18e15705479f32d.1595511710.git.viresh.kumar@linaro.org>
References: <e51142a397858a2fe6a040563d3c0795a7d0bb05.1595511710.git.viresh.kumar@linaro.org>
 <a83166af3a2b432bb11a0876e18e15705479f32d.1595511710.git.viresh.kumar@linaro.org>
Message-ID: <20200724055826.GE32086@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Although these errors are still here:

sigwait.c: In function ?test_masked_matching?:
sigwait.c:157:42: warning: passing argument 3 to restrict-qualified parameter aliases with argument 2 [-Wrestrict]
  157 |  TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
      |                                ~~~~~~~~  ^~~~~~~~
../../include/tst_test.h:266:13: note: in definition of macro ?TEST?
  266 |   TST_RET = SCALL; \
      |             ^~~~~
sigwait.c: In function ?test_masked_matching_rt?:
sigwait.c:226:42: warning: passing argument 3 to restrict-qualified parameter aliases with argument 2 [-Wrestrict]
  226 |  TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
      |                                ~~~~~~~~  ^~~~~~~~
../../include/tst_test.h:266:13: note: in definition of macro ?TEST?
  266 |   TST_RET = SCALL; \
      |             ^~~~~
sigwait.c: In function ?test_masked_matching_noinfo?:
sigwait.c:265:42: warning: passing argument 3 to restrict-qualified parameter aliases with argument 2 [-Wrestrict]
  265 |  TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
      |                                ~~~~~~~~  ^~~~~~~~
../../include/tst_test.h:266:13: note: in definition of macro ?TEST?
  266 |   TST_RET = SCALL; \
      |             ^~~~~
sigwait.c: In function ?test_bad_address?:
sigwait.c:312:42: warning: passing argument 3 to restrict-qualified parameter aliases with argument 2 [-Wrestrict]
  312 |  TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
      |                                ~~~~~~~~  ^~~~~~~~

IMHO we shouldn't use oldmask for src and dest.

Kind regards,
Petr
