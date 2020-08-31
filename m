From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 31 Aug 2020 19:49:48 +0200
Subject: [LTP] [PATCH] [RFC] runtest/quickhit: Remove.
In-Reply-To: <CY4PR13MB1175D7238F6A05AA0A668B9AFD510@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <20200831094617.7764-1-chrubis@suse.cz>
 <CY4PR13MB11758CF355D958B797D2EA9FFD510@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CY4PR13MB1175D7238F6A05AA0A668B9AFD510@CY4PR13MB1175.namprd13.prod.outlook.com>
Message-ID: <20200831174948.GA15731@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thinking about this a bit more....
> 
> Since this test is used (at least by me), more as a test of the testing
> infrastructure rather than the hardware/software under test,
> maybe it make sense to repurpose the test and adjust its contents
> based on this new purpose.  What would be nice is a test that
> exercises a bunch of different possible LTP behaviors or outputs,
> to test whether CI systems calling LTP can handle them all correctly.
> 
> So, there are 2 attributes of the test that are important to me:
>  - it runs quickly (more quickly than a "full" ltp)
>  - it runs a variety of individual LTP test programs
> 
> So it might be good to have this be a test that includes items that
> behave strangely (but quickly).  That would make this test more
> useful for the purpose I'm actually using it for.
> 
> It might even make sense to rename it to reflect this change of purpose
> (if it *is* a change of purpose).  For example, maybe name it
> 'smoketest' or 'weirdstuff' or 'selftest'.  But 'quickhit' at least captures
> one attribute that is important - that this test is used as a quick
> check that basic LTP functionality is working.
> 
> Just some more ideas....

I would vote for removing this one and adding either a smoketest or
selftest. The quickhit name is way too confusing.

Also if we want something as a selftest we can also throw in a few test
test library sanity tests that are not even installed at this point.

-- 
Cyril Hrubis
chrubis@suse.cz
