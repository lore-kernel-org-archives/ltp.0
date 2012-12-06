Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TgeQM-00048L-F9
	for ltp-list@lists.sourceforge.net; Thu, 06 Dec 2012 16:35:46 +0000
Date: Thu, 6 Dec 2012 17:35:33 +0100
From: chrubis@suse.cz
Message-ID: <20121206163533.GB31201@rei.nue.novell.com>
References: <20121206141336.GA2317@rei.nue.novell.com>
	<878595998.11610861.1354808151182.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878595998.11610861.1354808151182.JavaMail.root@redhat.com>
Subject: Re: [LTP] open posix testsuite and names of testcases
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Well I don't think that the option one is that hard, at least I'm not
> > aware of much cases of hardcoded names in the Open Posix Testsuite.
> > On
> > the other hand having better test driver that executes the tests and
> > presents the result in more convinient way would be more appealing.
> > Or
> > we can do both of them.
> 
> I think we should do the renaming anyway.
> Would the following format work for everyone? "testdirname-[number]-[number].c"
> For example: pthread_create-1-5.c
> It's unique, and it's easy to tell what old name was.

I'm ok with that.

> > I was thinking of creating a relatively simply test driver that runs
> > the
> > tests, takes care of timeouts (and anything else) and logs
> > information
> > in some reasonable format (I used JSON in similar case). And then
> > about
> > some tools that could compare the results, print list of failed
> > testcases and so on. Does that sound reasonable?
> 
> How would this be related to ltp-pan? Would this be only for open posix testsuite
> or also for LTP?

Well, that is a good question. The differencies between Open Posix
Testsuite and the rest of the LTP aren't too big so it may be possible
to create a test driver for both and share most of the code. On the
other hand. To just run the tests you just need to export right
VARIABLES and modify PATH accordingly. To collect the result you need to
translate the test return values.

On the other hand I'm not even sure about all the features that ltp-pan
has and what subset of them is used by different people. But I will
surely like to have more up to date test driver that produces more
usefull data.

There are couple possibilities what we can do.

We may start creating something that could run the Open Posix Testsuite
and then gradually extend it to work with the rest of the LTP adding all
the features we would need while deprecating the ltp-pan and removing it
once we have full replacement.

Or we may look if there is something to fit our meets out there
allready and modify it to meet our needs.

Or anything that any of you may come up with.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
