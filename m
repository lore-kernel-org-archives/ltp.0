Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NdGBG-0003g6-DB
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 04:52:34 +0000
Received: from mail-pz0-f174.google.com ([209.85.222.174])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NdGBF-0007vE-Iw
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 04:52:34 +0000
Received: by pzk4 with SMTP id 4so177137pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 04 Feb 2010 20:52:27 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 4 Feb 2010 20:52:27 -0800
Message-ID: <364299f41002042052p28f48b22i58b16e9cf14bf13f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Race in utimensat.sh
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

    There's a race condition somewhere in utimensat.sh from what I've
seen where one of the processes executes and then it blocks
indefinitely [I was stracing the script and it was blocking on a
wait(2) call]. Have others seen similar issues?

gcooper@orangebox /scratch/ltp $ emerge --info
Portage 2.1.7.16 (default/linux/amd64/10.0, gcc-4.3.4,
glibc-2.10.1-r1, 2.6.31-gentoo-r6 x86_64)
=================================================================
System uname: Linux-2.6.31-gentoo-r6-x86_64-Intel-R-_Core-TM-2_Quad_CPU_Q9400_@_2.66GHz-with-gentoo-1.12.13
Timestamp of tree: Sat, 30 Jan 2010 09:30:01 +0000
app-shells/bash:     4.0_p35
dev-java/java-config: 2.1.9-r2
dev-lang/python:     2.6.4
sys-apps/baselayout: 1.12.13
sys-apps/sandbox:    1.6-r2
sys-devel/autoconf:  2.13, 2.63-r1
sys-devel/automake:  1.9.6-r2, 1.10.2
sys-devel/binutils:  2.18-r3
sys-devel/gcc-config: 1.4.1
sys-devel/libtool:   2.2.6b
virtual/os-headers:  2.6.27-r2

Thanks,
-Garrett

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
