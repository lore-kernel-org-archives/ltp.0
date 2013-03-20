Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UIFmG-00020R-AO
	for ltp-list@lists.sourceforge.net; Wed, 20 Mar 2013 09:57:48 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UIFmE-0007gn-Qe
	for ltp-list@lists.sourceforge.net; Wed, 20 Mar 2013 09:57:48 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r2K9veew004313
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Mar 2013 05:57:40 -0400
Date: Wed, 20 Mar 2013 05:57:40 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1973851267.21619084.1363773460784.JavaMail.root@redhat.com>
In-Reply-To: <165189158.21613313.1363773111224.JavaMail.root@redhat.com>
MIME-Version: 1.0
Subject: [LTP] Coverity report for ltp-20130320
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
To: LTP List <ltp-list@lists.sourceforge.net>

Hi,

What is Coverity?
Coverity Prevent is commercial enterprise level tool for static analysis
(analysis based only on compiling of sources, not based on running of binary)
of the C/C++ and Java code.

analyzer coverity
analyzer-args --wait-for-license -co BAD_FREE:allow_first_field:true --all
analyzer-version Coverity Static Analysis for C/C++ version 6.5.1 on Linux 2.6.32-279.el6.x86_64 x86_64

This run is with LTP git snapshot from 20130320 (on top of RHEL6.4),
the results now include also Open Posix testcases:
http://jan.stancek.eu/coverity/ltp-20130320-1.el6.err.xz

Regards,
Jan

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
