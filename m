Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UUdZX-0000ba-M4
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 13:47:51 +0000
Date: Tue, 23 Apr 2013 15:48:45 +0200
From: chrubis@suse.cz
Message-ID: <20130423134844.GE28044@rei>
References: <605746806.1323310.1360671766487.JavaMail.root@redhat.com>
	<51218CB1.8040709@cn.fujitsu.com> <20130227143845.GA2178@rei>
	<20130227171118.GB30351@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130227171118.GB30351@rei>
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

> I tried to change the generate-makefiles.sh script, but there are some
> problems.
> 
> Some tests are shell scripts that doesn't have build phase. I've
> workarounded them by adding build rules that just copy them to
> name_x-y.sh in the build phase, which unfortunatelly haven't fixed all
> the problems.
> 
> We have quite quite a lot of tests (~270) that are shell scripts that
> prints "This is tested implicitly via assertion xyz" and returns zero.
> I'm quite tempted to remove them. These just increase tests run time,
> log sizes, etc. but doesn't do any actual work.
> 
> Then there are more problematic ones, shell tests that calls one binary
> with different parameters. As in sigignore for example. The paths and
> names are obviously hardcoded, which makes them fail. The fix for such
> cases will depend case by case but what I will probably do is to make
> each test self-contained, but I haven't analyzed all the failures yet.


Good news everyone, I've just commited a patch that modifies the script
that generates the Makefiles (since I've fixed all the issues that
blocked this change).

Now the test binaries and scripts are prefixed with the directory such
as 'sigaction_'. I've did some testruns and everything seems fine.

Please tests.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
