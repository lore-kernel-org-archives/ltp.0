From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Nov 2016 17:50:41 +0100
Subject: [LTP] [PATCH 1/1] Tiny doc fixes
In-Reply-To: <20161115164633.qromjokaqfw57jxr@dell5510>
References: <20161115100614.29222-1-pvorel@suse.cz>
 <20161115162007.GD24751@rei.lan>
 <20161115164633.qromjokaqfw57jxr@dell5510>
Message-ID: <20161115165040.GF24751@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > >  static struct tst_test test = {
> > >  	.tid = "getenv01",
> > > -	.test_all = test,
> > > +	.test_all = do_test,
> > >  	.setup = setup,
> > >  };
> 
> > What is wrong with this one?
> Name collision (function test and struct test). I know, it's just a doc...

Ah, right. I guess that we should to fix the example code to compile
cleanly.

> > And even if we decide to change the function name, we should fix it in
> > the text as well:
> 
> > -The test itself is done in the 'test()' function. The test function must work
> > +The test itself is done in the 'do_test()' function. The test function must work
> Sorry, it seems I can't do search and replace :-(.

Well the word test is used in the document so often that you have to
actually read the paragraph to figure out what needs to be updated.

-- 
Cyril Hrubis
chrubis@suse.cz
