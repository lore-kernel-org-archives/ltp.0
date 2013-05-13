Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UbrZd-0002XC-Th
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 12:09:49 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UbrZc-00010s-0T
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 12:09:49 +0000
Date: Mon, 13 May 2013 08:09:41 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1761588100.736663.1368446981907.JavaMail.root@redhat.com>
In-Reply-To: <1763657579.728071.1368446381686.JavaMail.root@redhat.com>
MIME-Version: 1.0
Subject: [LTP] Coverity report for ltp-20130503
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
To: ltp-list <ltp-list@lists.sf.net>

Hi,

What is Coverity?
Coverity Prevent is commercial enterprise level tool for static analysis
(analysis based only on compiling of sources, not based on running of binary)
of the C/C++ and Java code.

analyzer: coverity
analyzer-args: --wait-for-license -co BAD_FREE:allow_first_field:true
analyzer-version: Coverity Static Analysis for C/C++ version 6.5.2 on Linux 2.6.32-279.el6.x86_64 x86_64

This run includes snapshot of LTP git tree from 20130503 (on top of RHEL6.4).
Results include also Open Posix testcases and use default coverity flags:
http://jan.stancek.eu/coverity/ltp-20130503-1.el6.err.xz

Regards,
Jan

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
