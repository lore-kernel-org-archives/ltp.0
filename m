From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Mar 2019 11:47:20 +0100
Subject: [LTP] [PATCH 1/1] sigpending: Use 3 variants via
	test_multiplex()
In-Reply-To: <20190326101022.GA28312@rei>
References: <20190325151438.3712-1-pvorel@suse.cz> <20190326101022.GA28312@rei>
Message-ID: <20190326104719.GA16888@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> >  static void run(void)
> >  {
> > +	sigpending_info();
> >  	test_sigpending();
> >  	test_efault_on_invalid_sigset();
> >  }

> >  static struct tst_test test = {
> > -	.test_all = run
> > +	.test_all = run,
> > +	.test_variants = 3,
> >  };

> I would rather see .setup = singpending_info, here so that we don't spam
> the output that much, otherwise it looks good.

No problem, but with the following diff is the output the same. Am I missing
something?


Kind regards,
Petr

+++ testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -151,12 +151,12 @@ static void test_efault_on_invalid_sigset(void)
 
 static void run(void)
 {
-	sigpending_info();
 	test_sigpending();
 	test_efault_on_invalid_sigset();
 }
 
 static struct tst_test test = {
+	.setup = sigpending_info,
 	.test_all = run,
 	.test_variants = 3,
 };

---
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
sigpending02.c:24: INFO: Testing libc sigpending()
sigpending02.c:113: PASS: basic sigpending test successful
sigpending02.c:143: PASS: expected failure: EFAULT
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
sigpending02.c:27: INFO: Testing __NR_sigpending syscall
sigpending02.c:42: CONF: syscall(-1) __NR_sigpending not supported
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
sigpending02.c:30: INFO: Testing __NR_rt_sigpending syscall
sigpending02.c:113: PASS: basic sigpending test successful
sigpending02.c:143: PASS: expected failure: EFAULT

Summary:
passed   4
failed   0
skipped  0
warnings 0
