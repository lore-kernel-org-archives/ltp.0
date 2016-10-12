From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Oct 2016 14:36:02 +0200
Subject: [LTP] new shell library
In-Reply-To: <1175646125.448517.1476268354007.JavaMail.zimbra@redhat.com>
References: <20161003145835.GD7583@rei.suse.cz>
 <2007222752.190298.1475569383933.JavaMail.zimbra@redhat.com>
 <20161004084532.GA29418@rei.lan>
 <1484818671.202716.1475571733691.JavaMail.zimbra@redhat.com>
 <20161004093549.GC29418@rei.lan>
 <254451816.211402.1475574875165.JavaMail.zimbra@redhat.com>
 <20161012100806.GA24231@rei.lan>
 <1175646125.448517.1476268354007.JavaMail.zimbra@redhat.com>
Message-ID: <20161012123602.GB24231@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I've started to document the new shell library (the changes to
> > test-writing-guidelines are now included in [1]) and also tried to think
> > of some library hardening, i.e. making sure to avoid common mistakes,
> > the only thing I came up with is [2]. What do you think about this
> > approach?
> 
> I don't have better idea than some checks on inclusion of test.sh or in tst_run.
> 
> As for things we can check, I was thinking matching "set | grep ^TST_"
> against list of all supported variables. A typo or non-existing/deprecated
> variable would immediately show up.

What about greping the test source as in [2] instead? Because that way
we can print error if the test source touches any of the internally used
variables as well. For instance if it tries to do anything with
TST_PASS/TST_FAIL/...

> > [2]
> > https://github.com/metan-ucw/ltp/commit/7ca6be805c9fa4083b7e4de7f28162fca6a4a090

-- 
Cyril Hrubis
chrubis@suse.cz
