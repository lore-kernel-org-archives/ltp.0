From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Mar 2020 17:03:31 +0100
Subject: [LTP] [PATCH 1/2] lib: Add safe timerfd macros
In-Reply-To: <b42e93cb-b06d-538c-a5ff-1d110ed8ce74@suse.cz>
References: <20200304151201.19117-1-pvorel@suse.cz>
 <b42e93cb-b06d-538c-a5ff-1d110ed8ce74@suse.cz>
Message-ID: <20200304160330.GA7516@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Don't forget to clear errno when you're not using the TEST() macro.

Hmm, I'm not sure how useful is this. Generally the syscalls in libc
have single macro definition that is used everywhere to copy the error
from the errno variable. If that piece of code is buggy half of the test
in LTP would fail anyway.

...

> > +	if (tst_kvercmp(2, 6, 26) <= 0)
> > +		flags = 0;
> 
> I think tst_brk(TCONF) would be better here. Or at least tst_res(TWARN),
> since resetting flags to 0 may render some tests useless.

I think that it's completely wrong to put kernel version comparsion to
the safe_macros. If the test needs specific kernel version it should be
either put into the tst_test structure of handled in the test setup.

-- 
Cyril Hrubis
chrubis@suse.cz
