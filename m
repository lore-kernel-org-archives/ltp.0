Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MyFMw-0003qz-9t
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 01:43:06 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyFMq-00037g-41
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 01:43:06 +0000
Received: by pzk26 with SMTP id 26so326396pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 18:42:54 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 18:37:39 -0700
Message-ID: <364299f40910141837j51f61ea3h5d337412bba26780@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [Issue 14] powermanagement test issues
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
To: LTP list <ltp-list@lists.sourceforge.net>

I'm seeing the following noise in the powermanagement testcases as
well as what I reported earlier:

./pm_include.sh: line 74: $cpu_cores: ambiguous redirect

cat: /sys/devices/system/cpu/cpu?/topology/physical_package_id: No
such file or directory

./pm_include.sh: line 117: [: -gt: unary operator expected

./pm_include.sh: line 128: [: -eq: unary operator expected

Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
