From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 31 Oct 2017 11:03:41 -0700
Subject: [LTP] [PATCH] syscalls/request_key03: new test for key
 instantiation races
In-Reply-To: <20171031082543.udhds5dvuj42kcqr@dell5510>
References: <20171030185036.126451-1-ebiggers3@gmail.com>
 <20171031082543.udhds5dvuj42kcqr@dell5510>
Message-ID: <20171031180341.GC101782@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr, thanks for reviewing.

On Tue, Oct 31, 2017 at 09:25:43AM +0100, Petr Vorel wrote:
> 
> You evaluate test twice: for add_key_pid and then for request_key_pid.
> This can lead to FAIL and PASS together. It's probably ok, it's just unusual for me.
> ./request_key03 
> tst_test.c:958: INFO: Timeout per run is 0h 05m 00s
> request_key03.c:136: FAIL: kernel oops while updating key of type 'encrypted'
> request_key03.c:144: PASS: didn't crash while requesting key of type 'encrypted'
> ...
> 

Would it be better if there was just one PASS, and it is only executed if
neither of the FAILs was reached?

> 
> > +static void do_test(void)
> > +{
> > +	/*
> > +	 * Briefly test the "encrypted" and/or "trusted" key types when
> > +	 * availaible, mainly to reproduce CVE-2017-15299.
> > +	 */
> > +	test_with_key_type("encrypted", "update user:foo 32", 2);
> > +	test_with_key_type("trusted", "update", 2);
> > +
> > +	/*
> > +	 * Test the "user" key type for longer, mainly in order to reproduce
> > +	 * CVE-2017-15951.  However, without the fix for CVE-2017-15299 as well,
> > +	 * WARNs may show up in the kernel log.
> > +	 */
> > +	test_with_key_type("user", "payload", 15);
>
> I wonder (out of curiosity how did you get values for effort (2 and 15).
> 

It's pretty arbitrary; those just select enough iterations to make the bugs
reproducible most of the time for me.  It might be better to use fixed times
rather than fixed iteration counts, but there's no perfect solution.  Also, in
any case the "user" key type needs to be tested for longer than the "encrypted"
and "trusted" key types, in order to have a decent chance of reproducing the
second bug.

Eric
