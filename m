From: FIXED-TERM Rempel Oleksij (CM/ESO3) <fixed-term.Oleksij.Rempel@de.bosch.com>
Date: Fri, 15 Jul 2016 10:26:39 +0000
Subject: [LTP] [PATCH] consolidate 4 TCs message_queue_test_02_* into
 message_queue_test_02.sh to avoid fail in case of random execution
In-Reply-To: <20160715095531.GA3268@rei.scz.novell.com>
References: <1468576023-32754-1-git-send-email-nga.hoangthithuy@vn.bosch.com>
 <20160715095531.GA3268@rei.scz.novell.com>
Message-ID: <4ab8990043b24c1786a12b9dc8dfff3c@FE-MBX1024.de.bosch.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> -----Original Message-----
> From: ltp [mailto:ltp-bounces+fixed-
> term.oleksij.rempel=de.bosch.com@lists.linux.it] On Behalf Of Cyril Hrubis
> Sent: Friday, July 15, 2016 11:56 AM
> To: Hoang Thi Thuy Nga (RBVH/ENG2) <Nga.HoangThiThuy@vn.bosch.com>
> Cc: Hoang Thi Thuy Nga (RBVH/ENG2)
> <ngh1hc@HCUT2832C.hc.apac.bosch.com>; ltp@lists.linux.it
> Subject: Re: [LTP] [PATCH] consolidate 4 TCs message_queue_test_02_* into
> message_queue_test_02.sh to avoid fail in case of random execution
> 
> Hi!
> > diff --git a/runtest/ipc b/runtest/ipc index 50f072a..7c6fed5 100644
> > --- a/runtest/ipc
> > +++ b/runtest/ipc
> > @@ -32,10 +32,7 @@ sem01 sem01
> >  sem02 sem02
> >
> >  message_queue_test_01		message_queue_test_01
> > -message_queue_test_02_get	message_queue_test_02_get
> > -message_queue_test_02_snd	message_queue_test_02_snd
> > -message_queue_test_02_rcv	message_queue_test_02_rcv
> > -message_queue_test_02_ctl	message_queue_test_02_ctl -r
> > +message_queue_test_02		message_queue_test_02.sh
> >  message_queue_test_04		message_queue_test_04
> >  message_queue_test_05		message_queue_test_05
> >  pipe_test_01			pipe_test_01
> 
> This is exactly against our guidelines, see:
> 
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#211-runtest-
> files

What exactly do you mean?

To avoid confusions I need to explain background of this patch:
We working on remote execution of LTPs on the target. It means, some script is taking test list and execute each of entry over ssh.
In this case we are able to track resets and continue testing after it.

So, now we found that some resets are not actially triggered by some specific test. So we decided to randomize test order.
This allowed us to find some more bugs on the system, but introduced issues with tests which depend on each other. For example message_queue_test_02_* can be executed only in some specific order.

What would be the proper way to solve this issue?
