Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VS0Qw-0002lG-G2
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 08:08:22 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VS0Qu-0002w8-Eq
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 08:08:22 +0000
Date: Fri, 4 Oct 2013 04:08:14 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1031362814.1472423.1380874094146.JavaMail.root@redhat.com>
In-Reply-To: <656844534.1470973.1380873788462.JavaMail.root@redhat.com>
MIME-Version: 1.0
Subject: [LTP] Coverity report for ltp-20130904
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
analyzer-version: Coverity Static Analysis for C/C++ version 6.5.3 on Linux 2.6.32-279.el6.x86_64 x86_64

This run includes snapshot of LTP git tree from 20130904 (on top of RHEL6).
Results include also Open Posix testcases, flags: defaults, -MISSING_BREAK:
http://jan.stancek.eu/coverity/ltp-20130904-2.el6.err.xz

Regards,
Jan

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
