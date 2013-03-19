Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UHyJE-0004CK-AI
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 15:18:40 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UHyJC-0007Zl-Vi
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 15:18:40 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r2JFIXr3028626
	for <ltp-list@lists.sourceforge.net>; Tue, 19 Mar 2013 11:18:33 -0400
Date: Tue, 19 Mar 2013 11:18:33 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <623806259.21081036.1363706313082.JavaMail.root@redhat.com>
In-Reply-To: <1437086244.21063924.1363705319128.JavaMail.root@redhat.com>
MIME-Version: 1.0
Subject: [LTP] Coverity report for ltp-20130109
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

I ran it for current LTP stable (20130109) (on top of RHEL6.4)
and I'm sharing results here:
http://jan.stancek.eu/coverity/ltp-20130109-1.el6.err.xz

I looked at results only very briefly so far. The one that caught my
eye was actually my previous email: inode02: fix "slash" array overrun.
This run includes "--all" parameter, so it's likely there are some false
positives.

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
