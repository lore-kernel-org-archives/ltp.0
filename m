Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZD5ZZ-00086k-Ab
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:41 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZD5ZX-0004Yx-5j
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 06:44:41 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t696iWaq019619
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t696iWOm022322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:32 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t696iV2f009293
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 06:44:32 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Jul 2015 09:47:25 +0300
Message-Id: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 00/23] Add vlan, ipvlan, gre, macvlan interfaces
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
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Most interfaces share the same ip command syntax and the same test
scenarious can be applied to them. So rename vxlan directory to more
general 'virt' directory and add those interfaces to it.

Alexey Kodanev (23):
  network/vxlan: make names more abstract, use 'virt'
  network/vxlan: rename vxlan dir and library to 'virt'
  network/virt_lib.sh: add virt_add() and virt_add_rhost()
  network/virt_lib.sh: use ROD_SILENT in cleanup
  network/virt_lib.sh: fix regexpr in cleanup
  network/virt/vlan01: add new test-case
  network/virt/vlan02: add new test-case
  network/virt: rename virt_max to virt_count
  network/virt/vlan03: add new test-case
  network/virt/vlan01.sh: add protocol, loose_binding and hdr options
  network/virt/vlan03.sh: add protocol, loose_binding and hdr options
  network/virt: add new macvlan01 test
  network/virt: add new ipvlan01 test
  network/virt/vxlan01.sh: add parameters
  network/virt/vxlan03.sh: add VXLAN-GBP (group policy context) test
  network/virt: add macvtap01 test
  network/virt: add test-case 01 to virt_lib.sh
  network/virt: move checking for command support to virt_lib.sh
  network/virt: add test-case 02 to virt_lib.sh
  network/virt/vxlan03.sh: fix vxlan_compare_netperf()
  network/virt: add gre tunnel test
  network/virt: adjust virt_threshold parameter
  network/virt: don't skip when feature options not supported

 runtest/network_stress.features      |   12 ++
 testcases/network/virt/Makefile      |   33 +++
 testcases/network/virt/gre01.sh      |   63 ++++++
 testcases/network/virt/ipvlan01.sh   |   34 ++++
 testcases/network/virt/macvlan01.sh  |   34 ++++
 testcases/network/virt/macvtap01.sh  |   34 ++++
 testcases/network/virt/virt_lib.sh   |  363 ++++++++++++++++++++++++++++++++++
 testcases/network/virt/vlan01.sh     |   42 ++++
 testcases/network/virt/vlan02.sh     |   34 ++++
 testcases/network/virt/vlan03.sh     |   87 ++++++++
 testcases/network/virt/vxlan01.sh    |   36 ++++
 testcases/network/virt/vxlan02.sh    |   37 ++++
 testcases/network/virt/vxlan03.sh    |   95 +++++++++
 testcases/network/vxlan/Makefile     |   26 ---
 testcases/network/vxlan/vxlan01.sh   |   47 -----
 testcases/network/vxlan/vxlan02.sh   |   40 ----
 testcases/network/vxlan/vxlan03.sh   |   72 -------
 testcases/network/vxlan/vxlan_lib.sh |  210 --------------------
 18 files changed, 904 insertions(+), 395 deletions(-)
 create mode 100644 testcases/network/virt/Makefile
 create mode 100755 testcases/network/virt/gre01.sh
 create mode 100755 testcases/network/virt/ipvlan01.sh
 create mode 100755 testcases/network/virt/macvlan01.sh
 create mode 100755 testcases/network/virt/macvtap01.sh
 create mode 100644 testcases/network/virt/virt_lib.sh
 create mode 100755 testcases/network/virt/vlan01.sh
 create mode 100755 testcases/network/virt/vlan02.sh
 create mode 100755 testcases/network/virt/vlan03.sh
 create mode 100755 testcases/network/virt/vxlan01.sh
 create mode 100755 testcases/network/virt/vxlan02.sh
 create mode 100755 testcases/network/virt/vxlan03.sh
 delete mode 100644 testcases/network/vxlan/Makefile
 delete mode 100755 testcases/network/vxlan/vxlan01.sh
 delete mode 100755 testcases/network/vxlan/vxlan02.sh
 delete mode 100755 testcases/network/vxlan/vxlan03.sh
 delete mode 100644 testcases/network/vxlan/vxlan_lib.sh


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
