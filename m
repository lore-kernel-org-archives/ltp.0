From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 21 Mar 2019 10:57:11 -0300
Subject: [LTP] [PATCH v2 3/3] syscalls/clock_adjtime: create
 clock_adjtime syscall tests
In-Reply-To: <20190321134211.GC1252@rei>
References: <20190313163239.GC6171@rei>
 <20190320214135.7029-1-rafael.tinoco@linaro.org>
 <20190320214135.7029-3-rafael.tinoco@linaro.org>
 <B9AC8C77-9F4D-463A-82B3-E9CB5A4560F2@linaro.org> <20190321134211.GC1252@rei>
Message-ID: <B8760FB3-C4EF-4290-B756-1A6390387DA9@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

> On 21 Mar 2019, at 10:42, Cyril Hrubis <chrubis@suse.cz> wrote:
> 
> Hi!
>>> +	/*
>>> +	 * special case: EFAULT for NULL pointers
>>> +	 * txcptr = tst_get_bad_addr() -> SIGSEGV is thrown (and not EFAULT)
>>> +	 */
>>> +
>>> +	if (tc[i].exp_err == EFAULT)
>>> +		txcptr = NULL;
>> 
>> Cyril,
>> 
>> clock_adjtime() returns an EFAULT in case copy_from_user() returns
>> errors.
>> 
>> Thing is that, using tst_get_bad_addr(), and having a page with no
>> permissions, before getting an error from copy_from_user() and returning
>> - thus getting EFAULT back - we get a SIGSEGV from _copy_from_user()
>> itself, because it tries to sanitize given address, with memset(0),
>> before returning to userland (to avoid leaks of some sort ?).
>> 
>> With this, the EFAULT is only got when using NULL pointers, and not a
>> *bad* pointer??? So, right now, I can???tuse tst_get_bad_addr() like you
>> suggested. Should I remove this test and send a v3 ?
> 
> Hmm that's strange, memseting the structure does not make much sense.

checking lib/usercopy.c -> _copy_from_user(), memset() is only done in
kernel buffer if there was an error in raw_copy_from_user(), so.. you’re
right. Since mmap’ed buffer has PROT_NONE, I guess the SIGSEGV is thrown
during “raw_copy_from_user()” when referencing the user page with no
permissions. This might not happen when a NULL is passed, making adjtime
to ret EFAULT. Anyway, can’t use tst_get_bad_addr() as it seems...

> -- 
> Cyril Hrubis
> chrubis@suse.cz


