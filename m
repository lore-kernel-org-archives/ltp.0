From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Jul 2016 13:59:33 +0200
Subject: [LTP] [PATCH] consolidate 4 TCs message_queue_test_02_* into
 message_queue_test_02.sh to avoid fail in case of random execution
In-Reply-To: <4ab8990043b24c1786a12b9dc8dfff3c@FE-MBX1024.de.bosch.com>
References: <1468576023-32754-1-git-send-email-nga.hoangthithuy@vn.bosch.com>
 <20160715095531.GA3268@rei.scz.novell.com>
 <4ab8990043b24c1786a12b9dc8dfff3c@FE-MBX1024.de.bosch.com>
Message-ID: <20160718115932.GB18221@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > >  sem02 sem02
> > >
> > >  message_queue_test_01		message_queue_test_01
> > > -message_queue_test_02_get	message_queue_test_02_get
> > > -message_queue_test_02_snd	message_queue_test_02_snd
> > > -message_queue_test_02_rcv	message_queue_test_02_rcv
> > > -message_queue_test_02_ctl	message_queue_test_02_ctl -r
> > > +message_queue_test_02		message_queue_test_02.sh
> > >  message_queue_test_04		message_queue_test_04
> > >  message_queue_test_05		message_queue_test_05
> > >  pipe_test_01			pipe_test_01
> > 
> > This is exactly against our guidelines, see:
> > 
> > https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#211-runtest-
> > files
> 
> What exactly do you mean?

What I mean and is written in the guidelines is:

The runtest files should have one entry per a test. Creating a wrapper
that runs all your tests and adding it as a single test into runtest
file is strongly discouraged.

> To avoid confusions I need to explain background of this patch: We
> working on remote execution of LTPs on the target. It means, some
> script is taking test list and execute each of entry over ssh.  In
> this case we are able to track resets and continue testing after it.
>
> So, now we found that some resets are not actially triggered by some
> specific test. So we decided to randomize test order.  This allowed us
> to find some more bugs on the system, but introduced issues with tests
> which depend on each other. For example message_queue_test_02_* can be
> executed only in some specific order.

Ah, so they depend on each other. That is a valid reason for executing
them in a defined order.

You should have written better patch description since this is not
exactly clear.

> What would be the proper way to solve this issue?

Looking at the code we should probably avoid running these testcasese in
ipc runtest file, since they were designed to be executed in a loop to
stress the target system. They does not seem very useful when they are
executed just once as from the runtest file.

-- 
Cyril Hrubis
chrubis@suse.cz
