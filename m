Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TNpKE-0001hA-Kp
	for ltp-list@lists.sourceforge.net; Mon, 15 Oct 2012 18:23:38 +0000
Date: Mon, 15 Oct 2012 20:21:22 +0200
From: chrubis@suse.cz
Message-ID: <20121015182122.GA6698@rei.suse.cz>
References: <1349679654-16708-1-git-send-email-GuoJian.Zhou@windriver.com>
	<201210150014.47389.vapier@gentoo.org>
	<507B9964.8070905@windriver.com>
	<201210151332.57424.vapier@gentoo.org>
	<20121015181808.GA6380@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121015181808.GA6380@rei.suse.cz>
Subject: Re: [LTP] [PATCH] There was no "processor" key word in the
 "cpuinfo" on the non-SMP ARM Platforms. So the tracing
 "ftrace_buffer_size.sh" script would report "division by 0" error,
 then it would exit soon. The tracing test would check failed when it could
 not find this script running.
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: Zhou Guojian <Guojian.Zhou@windriver.com>, ltp-list@lists.sourceforge.net

> > really we should be using `getconf _NPROCESSORS_ONLN` instead and centralizing 
> > this parsing logic.  /proc/cpuinfo is directly accessed by many scripts.  the 
> > -i suggestion i provided came from its usage in those other files which, 
> > according to your findings, are also broken.
> > 
> > i'd suggest updating tools/apicmds/ to add a new helper program like 
> > `tst_ncpus` which will call sysconf() and we convert all of our .sh scripts 
> > from reading /proc/cpuinfo to calling that program.
> 
> That is coincidentally soultion I would about to propose.

Should have been: "was about to propose"

Now we only need somebody to get it implemented ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
