Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <radoslav.kolev@rnd.bg>) id 1NAhOI-0002vd-Fa
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 10:03:58 +0000
Received: from delta.superhosting.bg ([91.196.124.9])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NAhOC-0003hj-74
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 10:03:58 +0000
Received: from 87-126-155-98.btc-net.bg ([87.126.155.98] helo=[192.168.51.137])
	by delta.superhosting.bg with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.69) (envelope-from <radoslav.kolev@rnd.bg>)
	id 1NAhO1-00045m-W5
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 12:03:43 +0200
From: Radoslav Kolev <radoslav.kolev@rnd.bg>
Date: Wed, 18 Nov 2009 12:04:20 +0200
Message-Id: <1258538660.7556.213.camel@rado-desktop>
Mime-Version: 1.0
Subject: [LTP] [PATCH] Network stress tests patches
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Hello guys,

I have run into some problems with the network stress tests. I submitted
a bug through the sourceforge bug tracker, but after subscribing to the
mailing list I can see that it's here where all the action is. If this
is not the right place, then please tell me what is the preferred way to
submit bug reports and patches.

I am using ltp-full-20091031. 

A lot of the TCP tests involving packet loss fail with this error:

./tcp4-uni-basic01: line 394: netem_param: unbound variable

The reason is that strict checking for undefined variables is enabled
with "set -u", but the variable netem_param is not always defined before
testing its contents.

The fix I have applied is to initialize the netem_param variable with an
empty string. 

Also if4-addr-change always fails with this error:

TBROK  :  Failed to set an IPv4 address at the remote host

I have found the reason to be a missing semicolon. 

Best regards,
Radoslav Kolev

--- ltp-full-20091031.orig/testcases/network/stress/tcp/uni-basic/tcp4-uni-basic01	2009-11-18 11:41:02.000000000 +0200
+++ ltp-full-20091031/testcases/network/stress/tcp/uni-basic/tcp4-uni-basic01	2009-11-18 11:44:37.000000000 +0200
@@ -379,6 +379,7 @@
     esac
 
     # Make the network delay
+    netem_param=""
     if $DO_NET_DELAY ; then
 	netem_param="delay ${NET_DELAY}ms ${NET_DELAY_DEFL}ms distribution normal"
 	ret=`$LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH tc' qdisc add dev $rhost_ifname root netem $netem_param' ; echo $?'`


--- ltp-full-20091031.orig/testcases/network/stress/interface/if4-addr-change	2009-11-18 11:41:02.000000000 +0200
+++ ltp-full-20091031/testcases/network/stress/interface/if4-addr-change	2009-11-18 11:56:23.000000000 +0200
@@ -70,7 +70,7 @@
 LINK_NUM=0
 
 # Network portion of the IPv4 address
-IPV4_NETWORK=${IPV4_NETWORK-"10.0.0"}
+IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
 
 # Netmask of for the tested network
 IPV4_NETMASK="255.255.255.0"



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
