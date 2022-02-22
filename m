Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F830C4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 15:55:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 580A43CA225
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 16:55:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1BBA3C97EB
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 16:55:32 +0100 (CET)
Received: from relay.sw.ru (unknown [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 026A4602446
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 16:55:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=vAc2t6Ug8g6bwjF4GWexH6+Q4PyKfrV4/zUcgL9Gl+M=; b=N045wDpDhdgo
 zWjhosb2zAPWz7J7UFI1y2J4RkyX9kcs5Jh1Rw0LAhVQscJUOWqE7zy/5TZ+y+KmFjlgt5WSGTyJG
 Iv//Zsq3s3RGfN9Z33qr6F9b2dpIty6TFCEheWoDEOyWExX8u/InXo4u+N2EBdj74Vij977hU0YEr
 0MbEs=;
Received: from vz-out.virtuozzo.com ([185.231.240.5] helo=cobook.home)
 by relay.sw.ru with esmtp (Exim 4.94.2)
 (envelope-from <nikita.yushchenko@virtuozzo.com>)
 id 1nMXVQ-00AFj7-0m; Tue, 22 Feb 2022 16:55:12 +0100
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Feb 2022 18:55:14 +0300
Message-Id: <20220222155514.2255913-1-nikita.yushchenko@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] testcases/lib: introduce sysctl wrapper
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Nikita Yushchenko via ltp <ltp@lists.linux.it>
Reply-To: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc: kernel@openvz.org, ltp@lists.linux.it,
 Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Linux sysctl utility does not propagate errors returned from proc writes
to it's exit code:

> sysctl -q -w net.ipv4.tcp_congestion_control=dctcp
sysctl: setting key "net.ipv4.tcp_congestion_control": Operation not permitted
> echo $?
0

This causes the tests to not notice issues.

Workaround that by using a wrapper instead of sysctl. The wrapper calls
sysctl with given arguments, and returns non-zero exit status if either
sysctl returned non-zero exist status, or sysctl's stderr was not empty.

Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
---
 testcases/lib/Makefile       |  2 +-
 testcases/lib/sysctl_wrapper | 10 ++++++++++
 testcases/lib/tst_net.sh     |  6 +++---
 3 files changed, 14 insertions(+), 4 deletions(-)
 create mode 100644 testcases/lib/sysctl_wrapper

diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index f2de0c832..ecf4bdc2d 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -6,7 +6,7 @@ top_srcdir		?= ../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-INSTALL_TARGETS		:= *.sh
+INSTALL_TARGETS		:= *.sh sysctl_wrapper
 
 MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
diff --git a/testcases/lib/sysctl_wrapper b/testcases/lib/sysctl_wrapper
new file mode 100644
index 000000000..59e7fb7c0
--- /dev/null
+++ b/testcases/lib/sysctl_wrapper
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+stderr=$(mktemp)
+err=0
+sysctl $* 2>$stderr || err=1
+test -s $stderr && err=1
+cat $stderr >&2
+rm -f $stderr
+
+exit $err
diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 047686dc3..c7b835cbf 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -517,7 +517,7 @@ tst_init_iface()
 		ip link set $iface down || return $?
 		ip route flush dev $iface || return $?
 		ip addr flush dev $iface || return $?
-		sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
+		sysctl_wrapper -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
 		ip link set $iface up
 		return $?
 	fi
@@ -529,7 +529,7 @@ tst_init_iface()
 	tst_rhost_run -c "ip link set $iface down" || return $?
 	tst_rhost_run -c "ip route flush dev $iface" || return $?
 	tst_rhost_run -c "ip addr flush dev $iface" || return $?
-	tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
+	tst_rhost_run -c "sysctl_wrapper -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
 	tst_rhost_run -c "ip link set $iface up"
 }
 
@@ -922,7 +922,7 @@ tst_set_sysctl()
 	local rparam=
 	[ "$TST_USE_NETNS" = "yes" ] && rparam="-i -r '-e'"
 
-	tst_net_run $safe -q $rparam "sysctl" "-q -w $name=$value"
+	tst_net_run $safe -q $rparam "sysctl"_wrapper "-q -w $name=$value"
 }
 
 tst_cleanup_rhost()
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
