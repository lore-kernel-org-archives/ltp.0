Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1R5YbZ-0000DT-TJ
	for ltp-list@lists.sourceforge.net; Mon, 19 Sep 2011 07:49:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1R5YbZ-000441-3w
	for ltp-list@lists.sourceforge.net; Mon, 19 Sep 2011 07:49:29 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8J7nNPJ004153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Sep 2011 03:49:23 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id p8J7nM4s030042
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Sep 2011 03:49:22 -0400
Message-ID: <4E76F401.6090305@redhat.com>
Date: Mon, 19 Sep 2011 09:49:21 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 0/3] cgroup/memcg_regression_test fixes
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

Following 3 patches fix small issues in
memcg/regression/memcg_regression_test.sh

These are similar to ones already submitted for
cgroup/cgroup_regression_test.sh

Jan Stancek (3):
   cgroup/memcg_regression_test: clear dmesg before test
   cgroup/memcg_regression_test: fix test4 cleanup
   cgroup/memcg_regression_test: treat failed mount as error

  .../memcg/regression/memcg_regression_test.sh      |   20 
+++++++++++++++-----
  1 files changed, 15 insertions(+), 5 deletions(-)

------------------------------------------------------------------------------
BlackBerry&reg; DevCon Americas, Oct. 18-20, San Francisco, CA
Learn about the latest advances in developing for the 
BlackBerry&reg; mobile platform with sessions, labs & more.
See new tools and technologies. Register for BlackBerry&reg; DevCon today!
http://p.sf.net/sfu/rim-devcon-copy1 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
