Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UNg3d-0000pt-QQ
	for ltp-list@lists.sourceforge.net; Thu, 04 Apr 2013 09:02:09 +0000
Date: Thu, 4 Apr 2013 11:02:54 +0200
From: chrubis@suse.cz
Message-ID: <20130404090254.GA6273@rei.Home>
References: <1364958179-5410-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<20130403115218.GC2002@rei> <515C2398.4060906@cn.fujitsu.com>
	<20130403125509.GD2002@rei> <515CDA27.9010309@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <515CDA27.9010309@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] su01: fix the uncompleted string match
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
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> > I've looked in the expect docs and the syntax for regular expressions
> > should be '-re "^$USER\r"' (beware not tested).
> 
> I tested this and saw that it can't work, because the buffer of expect
> is not line oriented, the "^" and "$" can't work well at most time.

Thanks for the testing.

Lets proceed with the original version.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
