From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 8 Feb 2016 19:02:11 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <20160204105638.GA4615@rei>
References: <20160105111136.GA32659@rei.lan>
 <1146864418.5284131.1452171696007.JavaMail.zimbra@redhat.com>
 <20160204105638.GA4615@rei>
Message-ID: <20160208180211.GE9844@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
New vesion at:

https://github.com/metan-ucw/ltp

Some fixes:

* Fixed a few SAFE_MACROS() (removed forgotten callback parameter)

* Fixed tst_lib.c to compile (defined TST_NO_DEFAULT_MAIN)

* TERRNO and TTERRNO works now


And new functionality:

I've changed SAFE_CLOSE() to set the fd paramter to -1 on sucessful
exit, which makes it easier to use together with the pattern common in
cleanup() which does fd > 0 && close(fd). How do you like this idea?


And also another change I spend some time thinking about is that tcnt is
now divided into two parts. The tcnt strictly defines number of tests
done by the test() function and the newly introduced acnt (assertion
count) defines number of PASS/FAIL reported by the function when it's
called. This makes it easier to work with following pattern:


	fd = create_fd()
	if (fd < 0)
		tst_brk(TBROK, ...);

	if (bar)
		tst_res(TPASS, ...);
	else
		tst_res(TFAIL, ...);

	if (bar)
		tst_res(TPASS, ...);
	else
		tst_res(TFAIL, ...);


Now if we define acnt = 2 in the test structure and tcnt = 2 the library
would expect that there are two tests done by the function and that it
could be called twice with i = 0 and i = 1. Does this sound reasonable
as well?

There is also new converted test creat01:

https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/creat/creat01.c

-- 
Cyril Hrubis
chrubis@suse.cz
