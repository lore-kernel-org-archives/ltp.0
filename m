Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PBGuU-0008OB-Ac
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 01:04:06 +0000
Received: from out12.sjc.mx.trendmicro.com ([216.99.131.49])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PBGuS-0007Mr-Qj
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 01:04:06 +0000
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.129])
	by out12.sjc.mx.trendmicro.com (Postfix) with ESMTP id E021998045E
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Oct 2010 01:03:58 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 27926114B858
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Oct 2010 01:03:58 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Oct 2010 10:03:56 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 28 Oct 2010 10:03:56 +0900
Message-ID: <000901cb763b$ff0644a0$fd12cde0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] About results of POSIX tests in recent git
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

Yesterday, I tried POSIX tests with "ltp-7e2cbbd.tar.gz".
But all of testsets passed in my all systems.
Recent version git "ltp-332cdb8.tar.gz" too.

Environment is as follows:
  - RHEL4.8 --- (x86, x86_64, ia64)
  - RHEL5.5 --- (x86, x86_64, ia64)
  - kernel  --- kernel-2.6.9-89.EL
  - glibc   --- glibc-2.3.4-2.43

This phenomenon is mysterious because about fifty failures occurred 
in former version gits in my systems.


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
