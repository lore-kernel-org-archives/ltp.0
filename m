From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 7 Nov 2018 07:38:10 -0500 (EST)
Subject: [LTP] Question about the usage of tst_brk()
In-Reply-To: <20181107115446.GE8603@rei>
References: <5BE2BF88.3090902@cn.fujitsu.com>
 <5BE2C0D2.6090602@cn.fujitsu.com> <20181107110922.GC8603@rei>
 <1969756779.70592769.1541590267313.JavaMail.zimbra@redhat.com>
 <20181107115446.GE8603@rei>
Message-ID: <507818311.70614726.1541594289994.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > tst_brk is macro in newlib, so maybe we can catch this at compile-time?
> 
> Interesting idea, will you look into that?

Yes, I can.

> 
> > > If we wanted to enable TPASS and TFAIL we would have to first define sane
> > > semantic for it. I guess that something as "exit currect test process and
> > > increment result counters" would be reasonable, this could be done with:
> > 
> > tst_brk() always suggested to me that this is somehow unusual termination
> > of test - something's not right with environment or test itself.
> > 
> > Our docs say "Printf-like function to report error and exit the test",
> > so my preference would to not use it for "good" outcomes.
> 
> Well yes, the name suggests that.
> 
> Maybe we just need a few more reporting functions, I was thinking of
> adding tst_chk() that would print PASS/FAIL based on expression passed
> as first argument, since it seems that several people wanted to have
> something like this.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
