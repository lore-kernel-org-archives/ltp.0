Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WaS4v-0002St-5H
	for ltp-list@lists.sourceforge.net; Wed, 16 Apr 2014 15:48:49 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WaS4t-0003Lq-9c
	for ltp-list@lists.sourceforge.net; Wed, 16 Apr 2014 15:48:49 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Wed, 16 Apr 2014 17:48:13 +0200
Message-ID: <1397663294-60210-1-git-send-email-mats.liljegren@enea.com>
In-Reply-To: <0247700D01F14443B9209F90AD938CC524366845@sestoex05.enea.se>
References: <0247700D01F14443B9209F90AD938CC524366845@sestoex05.enea.se>
MIME-Version: 1.0
Subject: [LTP] [RFC][PATCH] partrt_nohz_full: Introducing a new test case
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
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Kevin Hilman <khilman@linaro.org>


This patch introduces a new test case, partrt_nohz_full.

This is sent as an RFC since as far as I understand it ltp is under
stabilization. But I still wanted to send what I've got currently to see if
there are any major issues with it.

This test case requires a couple of tools which can be cloned from here:

https://github.com/OpenEneaLinux/rt-tools

The tools are scripts so they are easily copied to somewhere PATH will find
them.

The patch applies on ltp, which can be cloned from here:

https://github.com/linux-test-project/ltp.git

The patch applies to commit hash b24ce8f6bcf315078bdc48bbddf780b964ffa59a.

To run the test case, do the following:

partrt create <cpumask>
runltp -f partrt_nohz_full

where <cpumask> should be a hexadecimal mask of nohz_full kernel boot parameter.
If you're too lazy to translate it by hand, you can use list2mask tool from
the rt-tools repository:

partrt create 0x$(list2mask --nohz)
runltp -f partrt_nohz_full

Regards
Mats Liljegren

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
