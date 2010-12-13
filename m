Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PSEKH-00056E-Ek
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 19:44:49 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PSEKG-0007Qd-Ir
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 19:44:49 +0000
Received: by yxd5 with SMTP id 5so3632484yxd.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Dec 2010 11:44:43 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4D0672E6.9000100@ams.org>
Date: Mon, 13 Dec 2010 11:42:25 -0800
Message-Id: <A84F4C36-3DF1-46F8-B7CC-EDE0C885669A@gmail.com>
References: <4D0672E6.9000100@ams.org>
Subject: Re: [LTP] About \"realtime\" build failure
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
To: Todd Vander Does <tvd@ams.org>
Cc: "ltp-list@lists.sourceforge.net List" <ltp-list@lists.sourceforge.net>, gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

On Dec 13, 2010, at 11:24 AM, Todd Vander Does wrote:

> Using gcc44 on RHEL 5.5 solved the realtime compile problem.  It took me a while to take Garrett Cooper's hint., "If you had a more recent compiler this wouldn't be an issue."  Maybe you could recommend a gcc version should in the INSTALL file along with bison, byacc, flex, etc.

	Well, because it's not really critical to put in these overall versions because there are people (for better or for worse) testing on ancient versions of RHEL (4.x), as long as multiple components are gcc/glibc agnostic, etc. However, it would be nice if folks in the individual components which have been imported to clearly list the requirements (*HINT* *HINT* to some IBM folks with the Realtime tests, power management tests, etc)...
	This is also why I've added the --with-realtime-tests option via configure (to tune this feature). Unfortunately there was a small gap of approximately a week or two between when this feature was implemented and when the gcc atomics change was implemented that it appears that some people with older platforms are running into issues with.
Thanks,
-Garrett
------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
