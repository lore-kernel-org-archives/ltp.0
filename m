Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PDwy1-0005UB-D5
	for ltp-list@lists.sourceforge.net; Thu, 04 Nov 2010 10:22:49 +0000
Received: from out19.sjc.mx.trendmicro.com ([216.99.131.76])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PDwxz-0008Id-1x
	for ltp-list@lists.sourceforge.net; Thu, 04 Nov 2010 10:22:49 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.129])
	by out19.sjc.mx.trendmicro.com (Postfix) with ESMTP id 02B4E980467
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Nov 2010 10:22:41 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 56A7F3DD022
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Nov 2010 10:22:40 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Nov 2010 19:22:37 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 4 Nov 2010 19:22:37 +0900
Message-ID: <000001cb7c0a$343bc2c0$9cb34840$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] About "make autotools" failure
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


I tried to build LTP with today's git "ltp-40be648.tar.gz".
But "make autotools" failed in my all systems.

------------
sed -n '1{s:LTP-:m4_define([LTP_VERSION],[:;s:$:]):;p;q}' ChangeLog >
m4/ltp-version.m4
aclocal -I m4
autoconf
autoheader
automake -c -a
configure.ac:18: installing `./config.guess'
configure.ac:18: installing `./config.sub'
configure.ac:4: installing `./install-sh'
configure.ac:4: installing `./missing'
set -x; \
	cd testcases/kernel/syscalls/pcllib && \
	aclocal && \
	autoconf && \
	autoheader && \
	automake --add-missing
+ cd testcases/kernel/syscalls/pcllib
+ aclocal
+ autoconf
configure.in:11: error: possibly undefined macro: AC_PROG_LIBTOOL
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
make: *** [testcases/kernel/syscalls/pcllib/configure] Error 1
------------

The environments of my systems are as follows:
  - RHEL4.8 (kernel version 2.6.9-89)   --- (x86, x86_64, ia64)
  - RHEL5.5 (kernel version 2.6.18-194) --- (x86, x86_64, ia64)


I use "automake", "autoconf" and "m4" whose versions are same as 
written in "INSTALL" file:
------------
[root@RHEL55-64-LTP ~]# automake --version
automake (GNU automake) 1.10.2
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv2+: GNU GPL version 2 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Tom Tromey <tromey@redhat.com>
       and Alexandre Duret-Lutz <adl@gnu.org>.
[root@RHEL55-64-LTP ~]# autoconf --version
autoconf (GNU Autoconf) 2.61
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software.  You may redistribute copies of it under the terms of
the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
There is NO WARRANTY, to the extent permitted by law.

Written by David J. MacKenzie and Akim Demaille.
[root@RHEL55-64-LTP ~]# m4 --version
GNU M4 1.4.7
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Written by Rene' Seindal.
[root@RHEL55-64-LTP ~]#
------------



By the way, in today's git "ltp-40be648.tar.gz", "${LTPROOT}/testcases/
kernel/syscalls/pcllib/aclocal.m4" is overwritten after failure of 
"make autotools" command.
But, in older gits "ltp-7e2cbbd", "${LTPROOT}/testcases/kernel/
syscalls/pcllib/aclocal.m4" is not overwritten after success of 
"make autotools" command.
Why?


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
