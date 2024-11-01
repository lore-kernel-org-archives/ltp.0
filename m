Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84720E6F06F
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 16:54:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 415C13CDAA8
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 17:54:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3A993CD9B4
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 17:54:16 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 47C352001AC
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 17:54:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D6ED21B20;
 Fri,  1 Nov 2024 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730480053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p0yzLItMTQFCNBCQMxGluycY+ukPk0B/N7RvxIpjU7E=;
 b=FIi4ICPoDOSy61agfA/K5cSIpH8+gqmsvk8T4HDGrkMyH/bSZ4tateVjka1Ja/kXfnpQpM
 DurO/8jEkBUiZVq3QDrEwO6hN/M/FXdwFwALnNEksPjl8pWfOrraJRbl0mLDkENtfdI1Ls
 2W4mISGWQbX69S5ZHlf1a0ofbR490cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730480053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p0yzLItMTQFCNBCQMxGluycY+ukPk0B/N7RvxIpjU7E=;
 b=XAdUHVODkpdo6UWpb0aSoQHkfrRSgFg3yK9G2o/fMT0/i0TetxzCeAwJgoze1rerm/6W3X
 yInVomuMJ6TmPNDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FIi4ICPo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XAdUHVOD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730480053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p0yzLItMTQFCNBCQMxGluycY+ukPk0B/N7RvxIpjU7E=;
 b=FIi4ICPoDOSy61agfA/K5cSIpH8+gqmsvk8T4HDGrkMyH/bSZ4tateVjka1Ja/kXfnpQpM
 DurO/8jEkBUiZVq3QDrEwO6hN/M/FXdwFwALnNEksPjl8pWfOrraJRbl0mLDkENtfdI1Ls
 2W4mISGWQbX69S5ZHlf1a0ofbR490cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730480053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=p0yzLItMTQFCNBCQMxGluycY+ukPk0B/N7RvxIpjU7E=;
 b=XAdUHVODkpdo6UWpb0aSoQHkfrRSgFg3yK9G2o/fMT0/i0TetxzCeAwJgoze1rerm/6W3X
 yInVomuMJ6TmPNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD0F613722;
 Fri,  1 Nov 2024 16:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QNKkKLQHJWebLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 16:54:12 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Nov 2024 17:53:54 +0100
Message-ID: <20241101165354.1296773-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7D6ED21B20
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tcp_cmds: Remove ftp01.sh test, binary data files
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

FTP login tests were removed in 6282e55b5d, as out of scope of
of kernel testing. ftp01.sh is FTP server unit test, which is also not
relevant for kernel testing, thus removing.

Remove also binary data files bin.sm, bin.med, bin.lg, bin.jmb which are
not needed any more.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
CI: https://github.com/pevik/ltp/actions/runs/11633078452

NOTE: The rest of the FTP tests in testcases/network/stress/ftp/ are
downloading and sending a large amount of data over TCP and are checking
that the data arrives the same at the other end. That is some sort of
kernel testing, thus test kept. But better would be to migrate them to
use LTP custom C code:

https://github.com/linux-test-project/ltp/issues/1207

 runtest/net.tcp_cmds                    |  1 -
 testcases/network/Makefile              |  1 -
 testcases/network/generate.sh           | 26 ---------
 testcases/network/tcp_cmds/Makefile     |  8 +--
 testcases/network/tcp_cmds/Makefile.inc |  2 +-
 testcases/network/tcp_cmds/ftp/Makefile | 30 ----------
 testcases/network/tcp_cmds/ftp/ftp01.sh | 75 -------------------------
 7 files changed, 3 insertions(+), 140 deletions(-)
 delete mode 100644 testcases/network/tcp_cmds/ftp/Makefile
 delete mode 100755 testcases/network/tcp_cmds/ftp/ftp01.sh

diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index 248c7371d1..aba02fb30a 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -5,7 +5,6 @@
 ipneigh01_arp ipneigh01.sh -c arp
 ipneigh01_ip ipneigh01.sh -c ip
 arping01 arping01.sh
-ftp ftp01.sh
 netstat netstat01.sh
 ping01 ping01.sh
 ping02 ping02.sh
diff --git a/testcases/network/Makefile b/testcases/network/Makefile
index ccc9083961..05d7f95fd8 100644
--- a/testcases/network/Makefile
+++ b/testcases/network/Makefile
@@ -14,7 +14,6 @@ CLEAN_TARGETS		+= $(DIR)
 INSTALL_DIR		:= testcases/bin
 
 INSTALL_TARGETS		:= $(addprefix $(DIR)/ascii.,sm med lg jmb)
-INSTALL_TARGETS		+= $(addprefix $(DIR)/bin.,sm med lg jmb)
 
 RM			+= -r
 
diff --git a/testcases/network/generate.sh b/testcases/network/generate.sh
index 939f792cce..af48f77381 100755
--- a/testcases/network/generate.sh
+++ b/testcases/network/generate.sh
@@ -51,29 +51,3 @@ fi
 "$make_file" "$medium_file" $medium_size
 "$make_file" "$large_file" $large_size
 "$make_file" "$jumbo_file" $jumbo_size
-
-if [ ! -e "bin.sm" ] ; then
-	cnt=0
-	while [ $cnt -lt 5 ] ; do
-		gzip -1 -c -n ascii.sm >> "bin.sm"
-		cnt=$(($cnt + 1))
-	done
-fi
-
-genfile() {
-	local input="$1" output="$2"
-	local cnt=19
-
-	[ -e "$output" ] && return $?
-
-	while [ $cnt -ge 0 ] ; do
-		cat "$input" >> "$output"
-		cnt=$(($cnt-1))
-	done
-}
-
-genfile bin.sm bin.med
-genfile bin.med bin.lg
-genfile bin.lg bin.jmb
-
-chmod 666 bin.*
diff --git a/testcases/network/tcp_cmds/Makefile b/testcases/network/tcp_cmds/Makefile
index 2d0f076741..ba8b879efd 100644
--- a/testcases/network/tcp_cmds/Makefile
+++ b/testcases/network/tcp_cmds/Makefile
@@ -7,13 +7,9 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-ifneq ($(WITH_EXPECT),yes)
-FILTER_OUT_SUBDIRS	:= ftp
-endif
+INSTALL_DEPS		:= ../datafiles/ascii.sm
 
-INSTALL_DEPS		:= ../datafiles/bin.sm
-
-../datafiles/bin.sm:
+../datafiles/ascii.sm:
 	$(MAKE) -C .. -f "$(abs_srcdir)/../Makefile" generate
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/tcp_cmds/Makefile.inc b/testcases/network/tcp_cmds/Makefile.inc
index 114141b2cd..0ca5ec0e39 100644
--- a/testcases/network/tcp_cmds/Makefile.inc
+++ b/testcases/network/tcp_cmds/Makefile.inc
@@ -22,7 +22,7 @@
 
 GENERATE_FILE_DIR	:= ../..
 
-MAKE_DEPS		:= $(GENERATE_FILE_DIR)/datafiles/bin.sm
+MAKE_DEPS		:= $(GENERATE_FILE_DIR)/datafiles/ascii.sm
 
 $(MAKE_DEPS):
 	$(MAKE) -C $(GENERATE_FILE_DIR) \
diff --git a/testcases/network/tcp_cmds/ftp/Makefile b/testcases/network/tcp_cmds/ftp/Makefile
deleted file mode 100644
index 35022f8b9a..0000000000
--- a/testcases/network/tcp_cmds/ftp/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-#    network/tcp_cmds/ftp testcases Makefile.
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
-# Ngie Cooper, September 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
-
-INSTALL_TARGETS		:= ftp*
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
deleted file mode 100755
index 53d1eec53a..0000000000
--- a/testcases/network/tcp_cmds/ftp/ftp01.sh
+++ /dev/null
@@ -1,75 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2022 Akihiko Odaki <akihiko.odaki@daynix.com>
-# Copyright (c) 2003 Manoj Iyer <manjo@mail.utexas.edu>
-# Copyright (c) 2001 Robbie Williamson <robbiew@us.ibm.com>
-
-TST_TESTFUNC=do_test
-TST_CNT=4
-TST_NEEDS_CMDS='awk ftp'
-TST_NEEDS_TMPDIR=1
-
-RUSER="${RUSER:-root}"
-RHOST="${RHOST:-localhost}"
-
-do_test()
-{
-    case $1 in
-    1) test_get binary;;
-    2) test_get ascii;;
-    3) test_put binary;;
-    4) test_put ascii;;
-    esac
-}
-
-list_files()
-{
-    case $1 in
-    ascii) echo 'ascii.sm ascii.med ascii.lg ascii.jmb';;
-    binary) echo 'bin.sm bin.med bin.lg bin.jmb';;
-    esac
-}
-
-test_get()
-{
-    local file sum1 sum2
-
-    for file in $(list_files $1); do
-        {
-            echo user $RUSER $PASSWD
-            echo $1
-            echo cd $TST_NET_DATAROOT
-            echo get $file
-            echo quit
-        } | ftp -nv $RHOST
-
-        sum1="$(ls -l $file | awk '{print $5}')"
-        sum2="$(ls -l $TST_NET_DATAROOT/$file | awk '{print $5}')"
-        rm -f $file
-        EXPECT_PASS "[ '$sum1' = '$sum2' ]"
-    done
-}
-
-test_put()
-{
-    local file sum1 sum2
-
-    for file in $(list_files $1); do
-        {
-            echo user $RUSER $PASSWD
-            echo lcd $TST_NET_DATAROOT
-            echo $1
-            echo cd $TST_TMPDIR
-            echo put $file
-            echo quit
-        } | ftp -nv $RHOST
-
-        sum1="$(tst_rhost_run -c "sum $TST_TMPDIR/$file" -s | awk '{print $1}')"
-        sum2="$(sum $TST_NET_DATAROOT/$file | awk '{print $1}')"
-        tst_rhost_run -c "rm -f $TST_TMPDIR/$file"
-        EXPECT_PASS "[ '$sum1' = '$sum2' ]"
-    done
-}
-
-. tst_net.sh
-tst_run
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
