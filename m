Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sumitbd@linsyssoft.com>) id 1OZe90-0000E8-3b
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 06:11:34 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OZe8z-0007Kd-4s
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 06:11:34 +0000
Received: by pwi10 with SMTP id 10so762841pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Jul 2010 23:11:27 -0700 (PDT)
From: sumitbd@linsyssoft.com
Date: Fri, 16 Jul 2010 11:41:40 +0530
Message-ID: <1279260700.4313.0.camel@sumit>
Mime-Version: 1.0
Subject: [LTP]  [PATCH 0/2] multicasttest: Bug Fixing
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

I am working on LTP-20100630. While doing networktest for multicast, I
came across to following bugs.

I have fixed these bugs  and created a patch which is I am sending in
subsequent mail.

[PATCH 1/2] mc_opts: network/multicast/mc_opts/mc_opts script - bug
fixing
[PATCH 2/2] runtest/multicast: wrong TCsrc path exported for multicast
tests


Thanks & Regards
Sumit Dhoot
Linsyssoft Technologies Pvt. Ltd.
sumitbd@linsyssoft.com






------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
