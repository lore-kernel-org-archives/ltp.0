From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Jul 2019 10:52:15 +0200
Subject: [LTP] [RFC PATCH] syscalls: Remove getcontext01
In-Reply-To: <20190722083356.10142-1-pvorel@suse.cz>
References: <20190722083356.10142-1-pvorel@suse.cz>
Message-ID: <20190722085215.GA10580@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> According to man getcontext(3) getcontext was this function from
> POSIX.1-2001 (SUSv2) removed from POSIX.1-2008 (SUSv3).

Being deprecated from POSIX is never a reason to remove tests as far as
the API is exposed to userspace it should be tested.

> Given that the test was just a smoke tests (doing nothing) and we don't
> test other functions from this family ({set,swap,make}context) remove it.

I wouldn't say it's doing nothing, it asserts that call to getcontext()
returns 0, which is very basic but still a valid test.

What is the real motivation for this removal?

-- 
Cyril Hrubis
chrubis@suse.cz
