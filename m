From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 1 Sep 2020 12:02:14 +0200
Subject: [LTP] [PATCH] [RFC] runtest/quickhit: Remove.
In-Reply-To: <20200831174948.GA15731@yuki.lan>
References: <20200831094617.7764-1-chrubis@suse.cz>
 <CY4PR13MB11758CF355D958B797D2EA9FFD510@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CY4PR13MB1175D7238F6A05AA0A668B9AFD510@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200831174948.GA15731@yuki.lan>
Message-ID: <20200901100214.GA4076@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > Thinking about this a bit more....

> > Since this test is used (at least by me), more as a test of the testing
> > infrastructure rather than the hardware/software under test,
> > maybe it make sense to repurpose the test and adjust its contents
> > based on this new purpose.  What would be nice is a test that
> > exercises a bunch of different possible LTP behaviors or outputs,
> > to test whether CI systems calling LTP can handle them all correctly.

> > So, there are 2 attributes of the test that are important to me:
> >  - it runs quickly (more quickly than a "full" ltp)
> >  - it runs a variety of individual LTP test programs

> > So it might be good to have this be a test that includes items that
> > behave strangely (but quickly).  That would make this test more
> > useful for the purpose I'm actually using it for.

> > It might even make sense to rename it to reflect this change of purpose
> > (if it *is* a change of purpose).  For example, maybe name it
> > 'smoketest' or 'weirdstuff' or 'selftest'.  But 'quickhit' at least captures
> > one attribute that is important - that this test is used as a quick
> > check that basic LTP functionality is working.

> > Just some more ideas....

> I would vote for removing this one and adding either a smoketest or
> selftest. The quickhit name is way too confusing.
+1.
1 or very few tests there which would really test runltp and later runltp-ng
would be enough. Otherwise I don't like duplicity in runtest files (I don't see
much sense in it and we often forget to update it).

> Also if we want something as a selftest we can also throw in a few test
> test library sanity tests that are not even installed at this point.
FYI: A year ago I submitted 'make check' patch
https://patchwork.ozlabs.org/project/ltp/patch/20190924182841.4528-1-pvorel@suse.cz/
I plan to resubmit it + it'd be great to finish Christian's patch which tests
shell library:
https://patchwork.ozlabs.org/patch/1151766/


Kind regards,
Petr
