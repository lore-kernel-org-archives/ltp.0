Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SXqZF-0000A9-0q
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 09:12:17 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SXqZ9-0003Ru-90
	for ltp-list@lists.sourceforge.net; Fri, 25 May 2012 09:12:16 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4P9C5pQ011251
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 May 2012 05:12:05 -0400
Message-ID: <4FBF4CE3.30800@redhat.com>
Date: Fri, 25 May 2012 11:12:03 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 0/2] move_pages: dont use hardcoded node numbers
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
Cc: Jeffrey Burke <jburke@redhat.com>

Similar to previous patch for mbind01 and get_mempolicy01,
move_pages tests are also using hardcoded nodes 0/1.

This patch series is introducing get_allowed_nodes() function
to move_pages_support, which is using
    get_mempolicy(..., MPOL_F_MEMS_ALLOWED)
to obtain list of nodes tests can use.

I tested it with following setups. Note that setup 4 and 5 will
end with TCONF as there is only 1 node with memory.

1.
# numactl -H
available: 8 nodes (2,4-10)
node 2 cpus: 0
node 2 size: 127 MB
node 2 free: 9 MB
node 4 cpus:
node 4 size: 128 MB
node 4 free: 9 MB
node 5 cpus:
node 5 size: 128 MB
node 5 free: 64 MB
node 6 cpus:
node 6 size: 128 MB
node 6 free: 121 MB
node 7 cpus:
node 7 size: 128 MB
node 7 free: 121 MB
node 8 cpus:
node 8 size: 128 MB
node 8 free: 121 MB
node 9 cpus:
node 9 size: 128 MB
node 9 free: 121 MB
node 10 cpus:
node 10 size: 127 MB
node 10 free: 123 MB

2.
# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5
node 0 size: 2047 MB
node 0 free: 564 MB
node 1 cpus: 6 7 8 9 10 11
node 1 size: 2046 MB
node 1 free: 451 MB
node 2 cpus: 18 19 20 21 22 23
node 2 size: 2048 MB
node 2 free: 595 MB
node 3 cpus: 12 13 14 15 16 17
node 3 size: 2048 MB
node 3 free: 236 MB
node distances:
node   0   1   2   3 
  0:  10  16  16  16 
  1:  16  10  16  16 
  2:  16  16  10  16 
  3:  16  16  16  10

3.
# numactl -H
available: 2 nodes (2-3)
node 2 cpus: 0
node 2 size: 511 MB
node 2 free: 154 MB
node 3 cpus:
node 3 size: 511 MB
node 3 free: 490 MB


4.
# numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
node 0 size: 0 MB
node 0 free: 0 MB
node 1 cpus:
node 1 size: 12288 MB
node 1 free: 9689 MB
node distances:
node   0   1 
  0:  10  40 
  1:  40  10 

5.
# numactl -H
available: 1 nodes (0)
node 0 cpus: 0
node 0 size: 1023 MB
node 0 free: 654 MB
node distances:
node   0 
  0:  10 


Jan Stancek (2):
  move_pages_support: use only allowed nodes
  move_pages: dont use hardcoded node numbers

 .../kernel/syscalls/move_pages/move_pages02.c      |   13 +++-
 .../kernel/syscalls/move_pages/move_pages03.c      |   13 +++-
 .../kernel/syscalls/move_pages/move_pages04.c      |   13 +++-
 .../kernel/syscalls/move_pages/move_pages05.c      |   13 +++-
 .../kernel/syscalls/move_pages/move_pages06.c      |   10 ++-
 .../kernel/syscalls/move_pages/move_pages07.c      |   13 +++-
 .../kernel/syscalls/move_pages/move_pages08.c      |   12 +++-
 .../kernel/syscalls/move_pages/move_pages09.c      |    8 ++-
 .../kernel/syscalls/move_pages/move_pages10.c      |   13 +++-
 .../kernel/syscalls/move_pages/move_pages11.c      |   13 +++-
 .../syscalls/move_pages/move_pages_support.c       |   74 ++++++++++++++++----
 .../syscalls/move_pages/move_pages_support.h       |    1 +
 12 files changed, 157 insertions(+), 39 deletions(-)


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
