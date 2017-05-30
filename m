From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 30 May 2017 09:17:13 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] syscalls: Add timer measurement library
In-Reply-To: <20170530121501.GC24720@rei.lan>
References: <20170526123354.8564-1-chrubis@suse.cz>
 <775099814.23313843.1496073205696.JavaMail.zimbra@redhat.com>
 <20170530121501.GC24720@rei.lan>
Message-ID: <502320923.23716336.1496150233908.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > +
> > > +struct tst_timer_test {
> > > +	const char *scall;
> > > +	int (*sample)(int clk_id, long long usec);
> > > +	void (*setup)(void);
> > > +	void (*cleanup)(void);
> > > +};
> > 
> > I'd rather keep tst_test struct and expose some new function,
> > that would do all of this.
> > 
> > void test_all()
> > {
> >     tst_timer_test("select()", test_sample_function);
> > }
> > 
> > void tst_timer_test(fn_name, test_sample_function)
> > {
> >   timer_parse_options();
> >   timer_setup();
> >   for n ... {
> >      do_timer_test(timer_tcases[n].usec, timer_tcases[n].samples,
> >      test_sample_function);
> >   }
> >   timer_cleanup();
> > }
> > 
> > What I'm afraid of is that we end up mirror-ing lot of functionality
> > in tst_test struct: needsroot, tmpdir, kernelversion, extra parameter
> 
> Hmm, we can also fill in the standard tst_test structure in the test
> then "override" some of the fields in the timer test library.
> 
> I.e. test defines tst_test structure and the sampling function, timer
> library main() stores and replaces setup & cleanup, sets the test
> function then calls the tst_run_tcases() function. Does that sound
> better?

Yes. This would mean we extend tst_test struct and add sampling function.
As long as rest of fields continue to work (with some exceptions [1]),
it sounds good.

I see you still want to keep timer library main(), but I'm not sure
how you are going to select it instead of tst_test main.

[1] obvious exception is that we can't allow test/test_all and
sampling function at the same time.
