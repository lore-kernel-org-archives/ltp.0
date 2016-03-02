From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Mar 2016 15:44:21 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <1610317133.22142649.1455794774969.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan>
 <116630920.20260383.1455280426104.JavaMail.zimbra@redhat.com>
 <20160212175308.GA30723@rei.suse.cz>
 <20160216211958.GC2515@rei.lan>
 <1799339064.21851637.1455719961718.JavaMail.zimbra@redhat.com>
 <20160217155406.GA12574@rei>
 <1752902661.22105327.1455786359593.JavaMail.zimbra@redhat.com>
 <20160218110752.GB19157@rei.lan>
 <1610317133.22142649.1455794774969.JavaMail.zimbra@redhat.com>
Message-ID: <20160302144421.GC25763@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The up to date version is at usuall place at:

https://github.com/metan-ucw/ltp


The changes are:

* acnt was removed completly

* the bitflags in struct tst_test were fixed to be 1 bit wide

* the headers were changed so that most of the old headers starts with
  old_ prefix

  The safe_macros.h and test.h were left intact at the moment since
  these are included in numerous testcases. We can rename them in a
  separate patch if needed.

* Added macro TST_TEST_TCONF() to ease writing testcases that are
  guarded by #ifdefs, see newly converted llistxattr testcases

* Few more converted testcases

* Started to update Test-Writing-Guidelines for new API


The open issues:

* The SHM base file path propagation
  - we will probably go with the env variable

* Finishing rewrite of Test Writing Guidelines
  - needs just a bit more work

* Should we allow SAFE_MACROS() in cleanup?

  - we can easily do that since cleanup is executed from the test
    library and we can change tst_brk() to return to the caller
    if cleanup was entered

  - plus point is that writing cleanup is bit easier

  - minus point is that tst_brk() can now return and as a side effect
    tst_brkm() has to return as well (since tst_brkm() from safe macros
    is redirected to tst_brk()) and because of that we have to drop
    the __attribute__((noreturn)) since that causes gcc to optimize out
    return statements from the function which generates compilation
    warnings in some cases


Is there anything else?

-- 
Cyril Hrubis
chrubis@suse.cz
