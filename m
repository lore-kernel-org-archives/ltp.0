From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Feb 2016 11:56:39 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <1146864418.5284131.1452171696007.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan>
 <1146864418.5284131.1452171696007.JavaMail.zimbra@redhat.com>
Message-ID: <20160204105638.GA4615@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Since we successfuly released LTP I've restored the effort to create
better test library, updated changes are at:

https://github.com/metan-ucw/ltp

There are couple of smaller changes:

* The minimal kernel version is now stored in tst_test structure
  (which avoids calling tst_kvercmp() in setup())

* The tst_resm() and tst_brkm() are now rerouted to new library
  in case that test was started using the new library and in case
  that cleanup is NULL for tst_brkm().

  Now the SAFE_MACROS() and rest of the library calls works from newlib
  tests as well. Though most of the library calls would end up with
  wrappers without the cleanup callback just like I did for the
  SAFE_MACROS() allready.

* Unless TST_NO_DEFAULT_MAIN is defined the tst_test.h adds default main
  that picks up struct tst_test named test and run the tests.

* tst_syscall() has been added since the ltp_syscall() quietly adds
  cleanup parameter to tst_brkm()


There are two more tests converted:

https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/add_key/add_key01.c
https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/add_key/add_key02.c

And preadv test is updated:

https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/preadv/preadv01.c


My current plan is to try to convert a few more testcases and edhance
the new lib API on the go, then work more on the library internals that
are pretty minimalistic at the moment.

-- 
Cyril Hrubis
chrubis@suse.cz
