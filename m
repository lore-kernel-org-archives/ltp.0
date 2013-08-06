Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V6dbF-0002Hf-Kp
	for ltp-list@lists.sourceforge.net; Tue, 06 Aug 2013 09:30:41 +0000
Date: Tue, 6 Aug 2013 11:30:38 +0200
From: chrubis@suse.cz
Message-ID: <20130806093037.GA24437@rei>
References: <1375668923-15593-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<20130805094648.GB8082@rei.Home>
	<578718909.13087059.1375776716081.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <578718909.13087059.1375776716081.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] sigaction:16-1: leave it untested on the Linux
 kernel less than 2.6.22
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
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi!
> > While I'm completly fine with workarounds for broken kernels in Linux
> > part of the LTP I'm a bit reluctant to add them into the open posix
> > testsuite. Has anybody different opinion?
> 
> I agree when it comes to modifying testcases, but having a list
> of testcases which are known to fail (and avoid running them)
> on linux is also handy.
> 
> How about something like top-level Makefile.linux, which would
> build everything as it does now, but after that it disables
> those which are known to fail? For example by replacing something.run-test
> with script that prints message and returns UNTESTED.

That sounds reasonable to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
