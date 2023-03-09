Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BCAC64EC4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 14:59:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D0CF3CD87B
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 15:59:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87E3D3CCD87
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 15:59:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ADD2F601357
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 15:59:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 93B0221C39;
 Thu,  9 Mar 2023 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678373962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CS+VLH0lZBZQ/JUI+LdZeFbdFNrpVL4tJucIKTupVIU=;
 b=DhCpR9Onvs/oL/uL1+hpuvkLsqzhn9L1Ukxi+Gno9gKm9i1hn9khikC2vRCGSnw/sq+eM6
 VnAGEYOyNWlsBOwwqZGHa0bX4u5VHQmJuYPy9k1ftoUUHLraiT5JUnHRlBvL4Q+14kS6qd
 s1p3dxQ1No5iMxNjQZi0pRnsCRhx5N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678373962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CS+VLH0lZBZQ/JUI+LdZeFbdFNrpVL4tJucIKTupVIU=;
 b=rC8nIjxDtel0phYk8A2eNJGvMVGtusrOc21vkz2rZwJ5Cz5n2vz3aQ6Dyvh+oQgKLC4wYR
 K0z1Q0a/3t3azFDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C2CC13A10;
 Thu,  9 Mar 2023 14:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zyvZFEr0CWRoSgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Mar 2023 14:59:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Mar 2023 15:59:17 +0100
Message-Id: <20230309145917.26846-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ns_ifmove.c: Rewrite to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/containers/share/ns_ifmove.c | 98 ++++++-------------
 1 file changed, 28 insertions(+), 70 deletions(-)

diff --git a/testcases/kernel/containers/share/ns_ifmove.c b/testcases/kernel/containers/share/ns_ifmove.c
index 12642c6f4..60dda94d3 100644
--- a/testcases/kernel/containers/share/ns_ifmove.c
+++ b/testcases/kernel/containers/share/ns_ifmove.c
@@ -1,43 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* Copyright (c) 2015 Red Hat, Inc.
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of version 2 the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
+ * Copyright (c) Linux Test Project, 2015-2022
+ * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
  * Written by Matus Marhefka <mmarhefk@redhat.com>
+ */
+
+/*\
+ * [Description]
  *
- ***********************************************************************
  * Moves a network interface to the namespace of a process specified by a PID.
- *
  */
 
-#define _GNU_SOURCE
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#include <unistd.h>
-#include <asm/types.h>
-#include <sys/socket.h>
-#include <linux/rtnetlink.h>
-#include <sys/ioctl.h>
-#include <linux/if.h>
-#include <net/ethernet.h>
-#include <arpa/inet.h>
-#include "test.h"
-
 #include "config.h"
 
-char *TCID = "ns_ifmove";
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_safe_net.h"
+
+#include <linux/if.h>
+#include <linux/rtnetlink.h>
+#include <net/ethernet.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 
-#if HAVE_DECL_IFLA_NET_NS_PID
+#ifdef HAVE_DECL_IFLA_NET_NS_PID
 
 struct {
 	struct nlmsghdr nh;
@@ -55,50 +43,28 @@ int get_intf_index_from_name(const char *intf_name)
 	strncpy(ifr.ifr_name, intf_name, sizeof(ifr.ifr_name) - 1);
 	ifr.ifr_name[sizeof(ifr.ifr_name)-1] = '\0';
 
-	sock_fd = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
-	if (sock_fd == -1) {
-		tst_resm(TINFO | TERRNO, "socket");
-		return -1;
-	}
+	sock_fd = SAFE_SOCKET(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
 
-	/* gets interface index */
-	if (ioctl(sock_fd, SIOCGIFINDEX, &ifr) == -1) {
-		tst_resm(TINFO | TERRNO, "ioctl");
-		close(sock_fd);
-		return -1;
-	}
+	/* interface index */
+	SAFE_IOCTL(sock_fd, SIOCGIFINDEX, &ifr);
+	SAFE_CLOSE(sock_fd);
 
-	close(sock_fd);
 	return ifr.ifr_ifindex;
 }
 
-/*
- * ./ns_ifmove <INTERFACE_NAME> <NAMESPACE_PID>
- */
 int main(int argc, char **argv)
 {
 	struct rtattr *rta;
 	int intf_index, pid, rtnetlink_socket;
 
 	if (argc != 3) {
-		tst_resm(TINFO, "%s <INTERFACE_NAME> <NAMESPACE_PID>",
-			 argv[0]);
+		printf("ns_ifmove <INTERFACE_NAME> <NAMESPACE_PID>\n");
 		return 1;
 	}
 
 	intf_index = get_intf_index_from_name(argv[1]);
-	if (intf_index == -1) {
-		tst_resm(TINFO , "unable to get interface index");
-		return 1;
-	}
-
 	pid = atoi(argv[2]);
-
-	rtnetlink_socket = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
-	if (rtnetlink_socket == -1) {
-		tst_resm(TINFO | TERRNO, "socket");
-		return 1;
-	}
+	rtnetlink_socket = SAFE_SOCKET(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
 
 	memset(&req, 0, sizeof(req));
 	req.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
@@ -115,20 +81,12 @@ int main(int argc, char **argv)
 		RTA_LENGTH(sizeof(pid));
 	memcpy(RTA_DATA(rta), &pid, sizeof(pid));
 
-	if (send(rtnetlink_socket, &req, req.nh.nlmsg_len, 0) == -1) {
-		tst_resm(TINFO | TERRNO, "send");
-		return 1;
-	}
+	SAFE_SEND(1, rtnetlink_socket, &req, req.nh.nlmsg_len, 0);
+	SAFE_CLOSE(rtnetlink_socket);
 
-	close(rtnetlink_socket);
 	return 0;
 }
 
 #else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "IFLA_NET_NS_PID not defined in linux/if_link.h");
-}
-
+	TST_TEST_TCONF("IFLA_NET_NS_PID not defined in linux/if_link.h");
 #endif
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
