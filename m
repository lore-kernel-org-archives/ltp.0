Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1Wrlwt-0004R7-3m
	for ltp-list@lists.sourceforge.net; Tue, 03 Jun 2014 10:28:07 +0000
Received: from mail-we0-f179.google.com ([74.125.82.179])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Wrlwr-0000is-Bq
	for ltp-list@lists.sourceforge.net; Tue, 03 Jun 2014 10:28:07 +0000
Received: by mail-we0-f179.google.com with SMTP id q59so6488460wes.38
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Jun 2014 03:27:59 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 3 Jun 2014 12:27:58 +0200
Message-ID: <CA+icZUWoiUudQ8yZ0SKOTQUh2brwoCJNL0-FHZdfaKfAR2t_CQ@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [LTP] Testcases especially to test pipes
Reply-To: sedat.dilek@gmail.com
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

while digging into a lockdep problem with OverlayFS [1] the question
came up on how to test pipes on Linux.
Is there a testsuite/testcases for pipes like to test IPC-syscalls only?

Thanks in advance.

Regards,
- Sedat -

[1] http://marc.info/?l=linux-fsdevel&m=140179088718160&w=1

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
