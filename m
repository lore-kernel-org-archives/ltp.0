From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Mar 2019 15:10:15 +0100
Subject: [LTP] [PATCH v2 3/3] syscalls/clock_adjtime: create
 clock_adjtime syscall tests
In-Reply-To: <20190321140550.GE1252@rei>
References: <20190313163239.GC6171@rei>
 <20190320214135.7029-1-rafael.tinoco@linaro.org>
 <20190320214135.7029-3-rafael.tinoco@linaro.org>
 <B9AC8C77-9F4D-463A-82B3-E9CB5A4560F2@linaro.org>
 <20190321134211.GC1252@rei>
 <B8760FB3-C4EF-4290-B756-1A6390387DA9@linaro.org>
 <20190321140550.GE1252@rei>
Message-ID: <20190321141015.GG1252@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > checking lib/usercopy.c -> _copy_from_user(), memset() is only done in
> > kernel buffer if there was an error in raw_copy_from_user(), so.. you???re
> > right. Since mmap???ed buffer has PROT_NONE, I guess the SIGSEGV is thrown
> > during ???raw_copy_from_user()??? when referencing the user page with no
> > permissions. This might not happen when a NULL is passed, making adjtime
> > to ret EFAULT. Anyway, can???t use tst_get_bad_addr() as it seems...
> 
> Looking at strace of the test we manage to get -1 and EFAULT followed by
> the signal, which is strange. I do wonder why this is the only syscall
> that behaves that way.

Found the bug :-), the kernel is not the problem but rather the lines:

	if (txcptr)
		timex_show("TEST", *txcptr);


You have to change these to something as:

	if (tcxptr != bad_addr)
		timex_show("TEST", *txcptr);

-- 
Cyril Hrubis
chrubis@suse.cz
