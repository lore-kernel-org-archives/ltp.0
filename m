Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <radoslav.kolev@rnd.bg>) id 1NHLAp-0002qo-2J
	for ltp-list@lists.sourceforge.net; Sun, 06 Dec 2009 17:45:31 +0000
Received: from delta.superhosting.bg ([91.196.124.9])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NHLAg-0004pT-Hc
	for ltp-list@lists.sourceforge.net; Sun, 06 Dec 2009 17:45:30 +0000
Received: from [83.228.52.239] (helo=[192.168.1.14])
	by delta.superhosting.bg with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.69) (envelope-from <radoslav.kolev@rnd.bg>)
	id 1NHLAT-0006KQ-5v
	for ltp-list@lists.sourceforge.net; Sun, 06 Dec 2009 19:45:09 +0200
From: Radoslav Kolev <radoslav.kolev@rnd.bg>
Date: Sun, 06 Dec 2009 19:46:19 +0200
Message-Id: <1260121579.7556.487.camel@rado-desktop>
Mime-Version: 1.0
Subject: [LTP] [PATCH] if4-alias-addlarge - default values for IPV4_NETWORK
	and	IPV4_HOST
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

The testcase code expects class A (or /8 ) network addresses to be
assigned to the tested interfaces and fails with the default values of
class C (or /24).

Signed-off-by: Radoslav Kolev <radoslav.kolev@rnd.bg>

--- ltp-full-20091031.orig/testcases/network/stress/interface/if4-alias-addlarge	2009-11-18 11:41:02.000000000 +0200
+++ ltp-full-20091031/testcases/network/stress/interface/if4-alias-addlarge	2009-12-06 19:31:34.000000000 +0200
@@ -72,7 +72,7 @@
 LINK_NUM=0
 
 # Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+IPV4_NETWORK=${IPV4_NETWORK:-"10"}
 
 # Netmask of for the tested network
 IPV4_NETMASK="255.0.0.0"
@@ -82,8 +82,8 @@
 IPV4_BROADCAST=${IPV4_NETWORK}.255.255.255
 
 # Host portion of the IPv4 address
-LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
-RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
+LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"0.0.2"}
+RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"0.0.1"}
 
 



------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
