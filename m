Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MvUSy-0004DU-KK
	for ltp-list@lists.sourceforge.net; Wed, 07 Oct 2009 11:13:56 +0000
Received: from mail-px0-f179.google.com ([209.85.216.179])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MvUSt-0003So-Px
	for ltp-list@lists.sourceforge.net; Wed, 07 Oct 2009 11:13:56 +0000
Received: by pxi9 with SMTP id 9so4695165pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 07 Oct 2009 04:13:46 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 7 Oct 2009 16:43:46 +0530
Message-ID: <f5a7b3810910070413me5f0995j2540c28415f095d8@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: [LTP] HTML not reporting number of Failed test cases
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
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: rohit.170309@gmail.com

Hi,

I think you have noticed difference in the HTML file generation.
HTML file is not reporting number of failure test cases
in summary and failed column with different color.
Some changes are made by Rohit recently.

Rohit,
Please investigate the changes made to HTML file generator.

You can refer the results logs share in LTP release in the below link for
X86
(ltp-full-20090930_results_kernel-2.6.31_architecture-i386.tgz)
Ia64
(ltp-full-20090930_results_kernel-2.6.23.13_architecture-ia64.tgz)

Link : http://sourceforge.net/projects/ltp/files/


Best regards
Naresh Kamboju

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
