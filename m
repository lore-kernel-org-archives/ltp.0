From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Mar 2019 14:42:11 +0100
Subject: [LTP] [PATCH v2 3/3] syscalls/clock_adjtime: create
 clock_adjtime syscall tests
In-Reply-To: <B9AC8C77-9F4D-463A-82B3-E9CB5A4560F2@linaro.org>
References: <20190313163239.GC6171@rei>
 <20190320214135.7029-1-rafael.tinoco@linaro.org>
 <20190320214135.7029-3-rafael.tinoco@linaro.org>
 <B9AC8C77-9F4D-463A-82B3-E9CB5A4560F2@linaro.org>
Message-ID: <20190321134211.GC1252@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +	/*
> > +	 * special case: EFAULT for NULL pointers
> > +	 * txcptr = tst_get_bad_addr() -> SIGSEGV is thrown (and not EFAULT)
> > +	 */
> > +
> > +	if (tc[i].exp_err == EFAULT)
> > +		txcptr = NULL;
> 
> Cyril,
> 
> clock_adjtime() returns an EFAULT in case copy_from_user() returns
> errors.
> 
> Thing is that, using tst_get_bad_addr(), and having a page with no
> permissions, before getting an error from copy_from_user() and returning
> - thus getting EFAULT back - we get a SIGSEGV from _copy_from_user()
> itself, because it tries to sanitize given address, with memset(0),
> before returning to userland (to avoid leaks of some sort ?).
> 
> With this, the EFAULT is only got when using NULL pointers, and not a
> *bad* pointer??? So, right now, I can???tuse tst_get_bad_addr() like you
> suggested. Should I remove this test and send a v3 ?

Hmm that's strange, memseting the structure does not make much sense.

-- 
Cyril Hrubis
chrubis@suse.cz
