From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Feb 2016 11:40:02 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <56C58B81.3080006@oracle.com>
References: <20160209174618.GB5441@rei.lan>
 <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
 <20160210114134.GA10106@rei.lan> <20160211160313.GA22877@rei.lan>
 <116630920.20260383.1455280426104.JavaMail.zimbra@redhat.com>
 <20160212175308.GA30723@rei.suse.cz>
 <20160216211958.GC2515@rei.lan>
 <1799339064.21851637.1455719961718.JavaMail.zimbra@redhat.com>
 <20160217155406.GA12574@rei> <56C58B81.3080006@oracle.com>
Message-ID: <20160218104002.GA19157@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I haven't removed it yet... I'm still thinking how we can generate
> > things like TAP output that expects us to print exact number of tests on
> > the first line followed by exact number of result lines and make as
> > little rules for result reporting as possible.
> >
> > Maybe we can just say that testcases that define test_all do one just
> > one test and produce one result per such test and do more detailed
> > reporting only for testcases that define tcnt.
> >
> > Or we can turn on the detailed reporting only if acnt has been set.
> 
> Not sure, but if I read TAP spec correctly, it doesn't strictly define
> that it should beon the first line, rather appear only once at the start
> or at the end (if the number of test points is not known).

I missed this part. I guess that we can always generate the number of
tests after the test was run and even when the number of tests is needed
in the result log beforehand we can just write the whole log once the
test finishes.

Explicit number of tests defined beforhand has only one advantage. We
would be able to detect a cases where the test has exited cleanly before
the test has really finished.

> So if tcnt for the test plan, what is 'acnt' for? ... I didn't find the
> analogy in the TAP spec.

Technically now the tcnt defines number of tests implemented by the
test() function. The acnt was meant as number of assertions but is
unused at the moment.

I.e. if test() function prints two PASS/FAIL statements during a call
acnt would have been set to 2 and the total number of PASS/FAIL messages
would be tcnt * acnt. But Jan thinks that this would be unnecessarily
strict requirement.

> Looking at the 'struct tst_test',
> 
> * the names like 'tcnt' and 'acnt' seem not clear. May be we should name 
> 'tcnt' as
> test_planor test_count?

This is definitly something that hasn't been finished yet...

> * also, why bitfields in the struct tst_test have different number of 
> storage bits?
> 
>    int needs_tmpdir:1;
>    int needs_root:2;
>    int forks_child:3;
>    int needs_device:4;
>    int needs_checkpoints:5;
> 
> if their value is just '0' or '1', ':1' - should be instead.

Good catch. This is silly mistake of mine.

-- 
Cyril Hrubis
chrubis@suse.cz
