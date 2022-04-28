Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC3FC433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 14:43:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDFDD3CA700
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 16:43:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 187323CA6CB
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 16:43:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 54D3F6022A1
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 16:43:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF21A210F3;
 Thu, 28 Apr 2022 14:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651157000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZuiVnDhry/wkJk/1XP+/3oFsXyfnMnNd8SxslPpuVE=;
 b=bQRTZBxVe9vjKJ4okG3U+5vRPdrXaNp5ueJZdSAiOiLoRDE7G9kGIylf+OkxC9juKKScIt
 YGoZj/f+55/dYMLVvCRyFtIJGsKc6wZlw9gZgxin/XQQXvg0ysszX3Hkd+caNPALJyn/jI
 PzQRlB5+EdnBlvAP6LC+zq01IyFRfQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651157000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZuiVnDhry/wkJk/1XP+/3oFsXyfnMnNd8SxslPpuVE=;
 b=/FTSwa41VqA8i4wT8oduHJt2gcxCowSxca2sXcBa0CSONIia3oDW6YXpzxNSIHelOV0xcv
 T7FDLsrkeZllb+BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8EAF13AF8;
 Thu, 28 Apr 2022 14:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kML9MQeoamK9bwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 28 Apr 2022 14:43:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 28 Apr 2022 16:43:06 +0200
Message-Id: <20220428144308.32639-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220428144308.32639-1-pvorel@suse.cz>
References: <20220428144308.32639-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/3] rpc: Remove rup01.sh test
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
Cc: "J . Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org,
 Steve Dickson <steved@redhat.com>, Chuck Lever <chuck.lever@oracle.com>,
 automated-testing@yoctoproject.org, Trond Myklebust <trondmy@hammerspace.com>,
 libtirpc-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

rstatd is a RPC daemon which collects performance statistics from kernel
on serving machine. On a client side there is rup (remote uptime display).

rstat client and server implementation for Linux had the latest release
4.0.1 in 2005. Although it's still installable on Debian, IMHO whole
technology is not used nowadays.

As we have other RPC tests (both RPC/TI-RPC and RPC integration, i.e.
NFS), we don't need to test this particular implementation. If this
implementation is really useful, it should be moved into libtirpc
project.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.rpc                               |  1 -
 .../network/rpc/basic_tests/rup/Makefile      | 29 -----------
 .../network/rpc/basic_tests/rup/rup01.sh      | 50 -------------------
 3 files changed, 80 deletions(-)
 delete mode 100644 testcases/network/rpc/basic_tests/rup/Makefile
 delete mode 100755 testcases/network/rpc/basic_tests/rup/rup01.sh

diff --git a/runtest/net.rpc b/runtest/net.rpc
index fb0665fae..ccee1dda7 100644
--- a/runtest/net.rpc
+++ b/runtest/net.rpc
@@ -4,5 +4,4 @@
 #
 rpc01 rpc01.sh
 rpcinfo rpcinfo01.sh
-rup rup01.sh
 rusers rusers01.sh
diff --git a/testcases/network/rpc/basic_tests/rup/Makefile b/testcases/network/rpc/basic_tests/rup/Makefile
deleted file mode 100644
index e0ebaaa58..000000000
--- a/testcases/network/rpc/basic_tests/rup/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    network/rpc/basic_tests/rup test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= rup01.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/basic_tests/rup/rup01.sh b/testcases/network/rpc/basic_tests/rup/rup01.sh
deleted file mode 100755
index 44f0e73d2..000000000
--- a/testcases/network/rpc/basic_tests/rup/rup01.sh
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2000
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
-
-TCID="rup01"
-TST_TOTAL=7
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
-do_setup()
-{
-	tst_resm TINFO "Checking for rstatd on $(tst_ipaddr)"
-	rpcinfo -u $(tst_ipaddr) rstatd 3 > /dev/null 2>&1 || \
-		tst_brkm TCONF "rstatd is inactive on $(tst_ipaddr)"
-}
-
-do_test()
-{
-	tst_resm TINFO "Test rup with options set"
-
-	EXPECT_RHOST_PASS rup $(tst_ipaddr)
-
-	local opts="-d -h -l -t"
-	for opt in $opts; do
-		EXPECT_RHOST_PASS rup $opt $(tst_ipaddr)
-	done
-
-	tst_resm TINFO "Test rup with bad options"
-	EXPECT_RHOST_FAIL rup bogushost
-	EXPECT_RHOST_FAIL rup -bogusflag $(tst_ipaddr)
-}
-
-do_setup
-do_test
-
-tst_exit
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
