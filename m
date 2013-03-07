Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1UDWbG-0001LW-VZ
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:54:54 +0000
Received: from plane.gmane.org ([80.91.229.3])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UDWbF-0007Kw-G9
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 08:54:54 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1UDWbP-0004Vk-7p
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 09:55:03 +0100
Received: from SNAT01-lb25.sgp.ssn.bosch.com ([103.4.125.30])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Thu, 07 Mar 2013 09:55:03 +0100
Received: from shashi859 by SNAT01-lb25.sgp.ssn.bosch.com with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Thu, 07 Mar 2013 09:55:03 +0100
From: Shashi <shashi859@gmail.com>
Date: Thu, 7 Mar 2013 08:51:02 +0000 (UTC)
Message-ID: <loom.20130307T053207-617@post.gmane.org>
References: <51237A44.6080508@mpi-sws.org>
Mime-Version: 1.0
Subject: Re: [LTP] Building LTP in a 64-bit machine for 32-bit target
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

Pedro Fonseca <pfonseca@...> writes:

> 
> Hi,
> 
> I've been trying to cross compile LTP on a 64-bit x86 machine to produce 
> tests for a 32-bit x86 machines. Unfortunately, so far I haven't found a 
> clean way of achieving this.
> 
> I've tried configuring with "./configure --host=i386" but this still 
> produces x86-64 binaries.
> 
> I've also tried configuring with "CFLAGS=-m32 ./configure CFLAGS=-m32" 
> but it gives compilation errors on some tests (e.g. 
> testcases/kernel/syscalls/chown01_16). I can get past some of the errors 
> by disabling the "/../utils/compat_16.mk" lines in the individual test 
> Makefiles. But is there a better way to compile LTP for 32-bit on a 64-bit?
> 
> Thanks,
> Pedro
> 
> ------------------------------------------------------------------------------
> Everyone hates slow websites. So do we.
> Make your web apps faster with AppDynamics
> Download AppDynamics Lite for free today:
> http://p.sf.net/sfu/appdyn_d2d_feb
> 

Hello Pedra Fonseca,

./configure --build=i686-pc-linux-gnu --target=i686-pc-linux-gnu "CFLAGS=-m32"
"CPPFLAGS=-m32" "LDFLAGS=-m32"

I use the above command to build ltp for 32-bit architecture on 64-bit machine.
Once you do run this, you can check the CFLAGS, CPPFLAGS, LDFALGS being set in 
config.status file. --target flag is to set target environment if it is
different from build environment.
http://stackoverflow.com/questions/5139403/whats-the-difference-of-configure-option-build-host-and-target

In fedora-64 bit, to build a 32-bit binary you need following packages
sudo yum install glibc-devel.i686 libgcc.i686

May be in Ubuntu, you may need these packages or similar kind. If not installed
gcc will throw some error. Let me know if you still find problem.

Regards,
ShashiKiran




------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
