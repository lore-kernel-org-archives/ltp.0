Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <pfonseca@mpi-sws.org>) id 1U7nHc-000684-KQ
	for ltp-list@lists.sourceforge.net; Tue, 19 Feb 2013 13:30:56 +0000
Received: from hera.mpi-sb.mpg.de ([139.19.1.49] helo=hera.mpi-klsb.mpg.de)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1U7nHV-0008CK-GD
	for ltp-list@lists.sourceforge.net; Tue, 19 Feb 2013 13:30:56 +0000
Message-ID: <51237A44.6080508@mpi-sws.org>
Date: Tue, 19 Feb 2013 14:12:36 +0100
From: Pedro Fonseca <pfonseca@mpi-sws.org>
MIME-Version: 1.0
Subject: [LTP] Building LTP in a 64-bit machine for 32-bit target
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
To: ltp-list@lists.sourceforge.net

Hi,

I've been trying to cross compile LTP on a 64-bit x86 machine to produce 
tests for a 32-bit x86 machines. Unfortunately, so far I haven't found a 
clean way of achieving this.

I've tried configuring with "./configure --host=i386" but this still 
produces x86-64 binaries.

I've also tried configuring with "CFLAGS=-m32 ./configure CFLAGS=-m32" 
but it gives compilation errors on some tests (e.g. 
testcases/kernel/syscalls/chown01_16). I can get past some of the errors 
by disabling the "/../utils/compat_16.mk" lines in the individual test 
Makefiles. But is there a better way to compile LTP for 32-bit on a 64-bit?

Thanks,
Pedro

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
