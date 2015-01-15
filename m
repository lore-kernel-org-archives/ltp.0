Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YBjPn-0003pE-8N
	for ltp-list@lists.sourceforge.net; Thu, 15 Jan 2015 12:20:43 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YBjPk-0003q9-DT
	for ltp-list@lists.sourceforge.net; Thu, 15 Jan 2015 12:20:43 +0000
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 15 Jan 2015 15:22:39 +0300
Message-Id: <1421324561-6680-3-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1421324561-6680-1-git-send-email-alexey.kodanev@oracle.com>
References: <1421324561-6680-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/4] testscripts/network.sh: add reverse IPv6 addresses
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
Cc: vasily.isaenko@oracle.com, akodanev <akodanev@gmail.com>

From: akodanev <akodanev@gmail.com>

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testscripts/network.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index 6bde6ed..b9e1847 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -35,13 +35,19 @@ export LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
 # Set remote host last octet, default is '1'
 export RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
 # Set the reverse of IPV4_NETWORK
-export IPV4_NETWORK_REVERSE=${IPV4_NETWORK_REVERSE:-"0.0.10"}
+export IPV4_NET_REV=${IPV4_NET_REV:-"0.0.10"}
 # Set first three octets of the network address, default is 'fd00:1:1:1'
 export IPV6_NETWORK=${IPV6_NETWORK:-"fd00:1:1:1"}
 # Set local host last octet, default is '2'
 export LHOST_IPV6_HOST=${LHOST_IPV6_HOST:-":2"}
 # Set remote host last octet, default is '1'
 export RHOST_IPV6_HOST=${RHOST_IPV6_HOST:-":1"}
+# Reverse network portion of the IPv6 address
+export IPV6_NET_REV=${IPV6_NET_REV:-"1.0.0.0.1.0.0.0.1.0.0.0.0.0.d.f"}
+# Reverse host portion of the IPv6 address of the local host
+export LHOST_IPV6_REV=${LHOST_IPV6_REV:-"2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
+# Reverse host portion of the IPv6 address of the remote host
+export RHOST_IPV6_REV=${RHOST_IPV6_REV:-"1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
 
 export HTTP_DOWNLOAD_DIR=${HTTP_DOWNLOAD_DIR:-""}
 export FTP_DOWNLOAD_DIR=${FTP_DOWNLOAD_DIR:-""}
-- 
1.7.1


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
