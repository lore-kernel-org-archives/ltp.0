Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFajO-0007Qc-7w
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 00:39:18 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFajL-00042f-UC
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 00:39:18 +0000
Received: by pbcum15 with SMTP id um15so940158pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Apr 2012 17:39:10 -0700 (PDT)
Date: Wed, 4 Apr 2012 17:35:16 -0700 (PDT)
From: Garrett Cooper <yanegomi@gmail.com>
Message-ID: <alpine.BSF.2.00.1204041734030.25027@toaster.local>
MIME-Version: 1.0
Subject: [LTP] [PATCH 0/2] Minor inotify(7) testcase cleanup
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

The attached changes consolidate some duplicated wrapper APIs and
remove a homegrown struct for dealing with inotify events.

Garrett Cooper (2):
   Clean up inotify(7) wrappers
   Replace struct event_t with struct inotify_event

  testcases/kernel/syscalls/inotify/inotify.h   |   45 
+++++++++++++++++++++++++
  testcases/kernel/syscalls/inotify/inotify01.c |   16 +--------
  testcases/kernel/syscalls/inotify/inotify02.c |   29 +++-------------
  testcases/kernel/syscalls/inotify/inotify03.c |   16 +--------
  4 files changed, 52 insertions(+), 54 deletions(-)
  create mode 100644 testcases/kernel/syscalls/inotify/inotify.h


------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
