Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1Tr0XD-0002YL-06
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 06:13:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tr0XB-0000Fj-Pf
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 06:13:38 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r046DWVb031153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 4 Jan 2013 01:13:32 -0500
From: Zhouping Liu <zliu@redhat.com>
Date: Fri,  4 Jan 2013 14:12:08 +0800
Message-Id: <cover.1357277005.git.zliu@redhat.com>
Subject: [LTP] [PATCH v2 0/2] updated create_same_memory() inside lib/mem.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

changed in v2:
 - modified '_function_name' as 'function_name'
 - added 'static' key word for internal function
 - updated a little commit log

Zhouping Liu (2):
  mm/lib: rewrote create_same_memory()
  mm/include: removed the global var 'memory'

 testcases/kernel/mem/include/_private.h |   2 +-
 testcases/kernel/mem/include/mem.h      |   5 -
 testcases/kernel/mem/lib/mem.c          | 425 +++++++++++++-------------------
 3 files changed, 170 insertions(+), 262 deletions(-)

-- 
1.7.11.7


------------------------------------------------------------------------------
Master HTML5, CSS3, ASP.NET, MVC, AJAX, Knockout.js, Web API and
much more. Get web development skills now with LearnDevNow -
350+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122812
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
