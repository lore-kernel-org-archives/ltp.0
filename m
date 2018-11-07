From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 7 Nov 2018 06:31:07 -0500 (EST)
Subject: [LTP] Question about the usage of tst_brk()
In-Reply-To: <20181107110922.GC8603@rei>
References: <5BE2BF88.3090902@cn.fujitsu.com>
 <5BE2C0D2.6090602@cn.fujitsu.com> <20181107110922.GC8603@rei>
Message-ID: <1969756779.70592769.1541590267313.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > If only TFAIL, TBROK and TCONF should be supported by tst_brk() in new
> > library,
> > i will add check to mark TWARN and TPASS as invalid.
> 
> First of all I think that tst_brk() will only work with TBROK and TCONF at
> the
> moment, see the check_child_status() function, we do handle only TBROK and
> TCONF in the switch there, anything else will cause the test library to exit
> with invalid exit value. Well the tst_brk(TPASS, ...) will work by accident
> since we have to handle zero exit value there as well.
> 
> However how the code is now the tst_brk(TPASS, ...) in new library will not
> account the passed result in the result counters, so it would be a good idea
> to
> check what value has been passed to the tst_brk() and allow only TBROK and
> TCONF there.

tst_brk is macro in newlib, so maybe we can catch this at compile-time?

> 
> If we wanted to enable TPASS and TFAIL we would have to first define sane
> semantic for it. I guess that something as "exit currect test process and
> increment result counters" would be reasonable, this could be done with:

tst_brk() always suggested to me that this is somehow unusual termination
of test - something's not right with environment or test itself.

Our docs say "Printf-like function to report error and exit the test",
so my preference would to not use it for "good" outcomes.

Regards,
Jan
