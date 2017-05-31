From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 31 May 2017 10:42:45 +0200
Subject: [LTP] [RFC] [PATCH] syscalls: Add timer measurement library
In-Reply-To: <20170531083045.GA2276@rei.lan>
References: <20170526123354.8564-1-chrubis@suse.cz>
 <775099814.23313843.1496073205696.JavaMail.zimbra@redhat.com>
 <20170530121501.GC24720@rei.lan>
 <502320923.23716336.1496150233908.JavaMail.zimbra@redhat.com>
 <20170531083045.GA2276@rei.lan>
Message-ID: <20170531084245.GB2276@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > Hmm, we can also fill in the standard tst_test structure in the test
> > > then "override" some of the fields in the timer test library.
> > > 
> > > I.e. test defines tst_test structure and the sampling function, timer
> > > library main() stores and replaces setup & cleanup, sets the test
> > > function then calls the tst_run_tcases() function. Does that sound
> > > better?
> > 
> > Yes. This would mean we extend tst_test struct and add sampling function.
> > As long as rest of fields continue to work (with some exceptions [1]),
> > it sounds good.
> 
> We can setup the test/sample functions as an union. As we can then
> distinguish between them based on .tcnt being non-zero in a case of
> standard test and expect sampling function to be set in a case of the
> timer test. However this makes the whole interface less type safe and
> also much harder to extend. I was thinking of adding support for NULL
> terminated array of test funcitons as well since we have some testcases
> that use the test() function as dispatcher with a long switch()
> statement...
> 
> So maybe we should just add a few more function pointers there.

Or we may as well avoid adding sampling function to the test structure
and pass it explicitly in the timer library main().

int main(int argc, char *argv[])
{
	tst_run_timer_testcases(argc, argv, test, sample_fn, scall);
}

We do that with the test structure anyway so this would be a small
logical extension. And we may as well pass the syscall name in tid field
of the test stucture...

-- 
Cyril Hrubis
chrubis@suse.cz
