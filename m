Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57925CA5FF1
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 14:01:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B6FC3E9C89
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 16:01:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4DF33CD600
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 16:00:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E1074600B2B
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 16:00:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 952EE1F745;
 Wed,  7 Oct 2026 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791381650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pkg8A2rtQruqmC9BxwJvZocPUkfKSSjHqFzjrmtNUts=;
 b=Wpeznys82V5BxExqZnSrwTYZw6c6j5EkqDVxEXOF+OlUXjJyHJ4feT2CQSsxLtohcslcQB
 gvy+7zI97UseP7+HJhf/d/in139oRf+Ch1x8yZQUFgWTJ/0gRx6cdCubcgn3OlkRkx8XVF
 ebm9Ggh3srdArcWpt9xL8Kub6BLDzdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791381650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pkg8A2rtQruqmC9BxwJvZocPUkfKSSjHqFzjrmtNUts=;
 b=8HSIv4IzPUYh8xAdlhTDvtKA6P8DR1o5kh6lOfTXPaKolKa76dYV8RB7I1cfOxRHT3GNxB
 68uQitRV8CrUDDDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bd7oTLkg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iOIuZ7Bs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791381649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pkg8A2rtQruqmC9BxwJvZocPUkfKSSjHqFzjrmtNUts=;
 b=bd7oTLkgr0Ynii9eNTGvOu3H8w/kFzr7v31fCOPPcHPInegL67LiFyHi1rfaK9bqQv9vKs
 fd7KAlLNNdCeHXh76x+5TdhCbcKvQhFJkg8Y5HZyraZ/7bhoQAAZ4j2WsoCFit4RcEQh3p
 YwTA0pauOGwzpEx6hUKpEJD0WXjm41M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791381649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pkg8A2rtQruqmC9BxwJvZocPUkfKSSjHqFzjrmtNUts=;
 b=iOIuZ7Bsy3LtRcZ5CHFHqpmk43ngcuOpjRtLamOkpbxtwqi9afSP+qbt7kmyqSM9qJWu9c
 t6xDU+JkiR8/IjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D1D8139B3;
 Wed,  7 Oct 2026 14:00:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cP34H5BQxmqSLgAAD6G6ig:T4
 (envelope-from <andrea.cervesato@suse.de>); Wed, 07 Oct 2026 14:00:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 07 Oct 2026 16:00:47 +0200
MIME-Version: 1.0
Message-Id: <20261007-fix_leftovers-v1-3-63a1e7acd0e6@suse.com>
References: <20261007-fix_leftovers-v1-0-63a1e7acd0e6@suse.com>
In-Reply-To: <20261007-fix_leftovers-v1-0-63a1e7acd0e6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791381648; l=2232;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=E4u7e0i1chQNoi4XWbEIxXVghAhs1H+6jTyURh/QKgU=;
 b=FUZpq5VOBh9aIF08KZG2JVz0uMZzVhM9No4RLktE+tu9uTNZpuvfRbf8Ie8V8I0M/j5ahrw/p
 m628ENgeRj4Bck8kUKW2SNWzsApmqog5bV0Em6eeOyS7g4mQ9jnhmal
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 952EE1F745
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] tree: Remove stale .gitignore entries
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Remove .gitignore entries for test binaries that have been deleted
or merged into other tests.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 lib/newlib_tests/.gitignore                    | 1 -
 testcases/commands/.gitignore                  | 1 -
 testcases/kernel/syscalls/getitimer/.gitignore | 1 -
 testcases/kernel/syscalls/syslog/.gitignore    | 1 -
 testcases/network/.gitignore                   | 3 ---
 5 files changed, 7 deletions(-)

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index b85163824..3a6e1643c 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -43,7 +43,6 @@ tst_bool_expr
 test_macros01
 test_macros02
 test_macros03
-test_macros04
 test_macros05
 test_macros06
 tst_filesystems01
diff --git a/testcases/commands/.gitignore b/testcases/commands/.gitignore
index ed5e13e29..2fb05e547 100644
--- a/testcases/commands/.gitignore
+++ b/testcases/commands/.gitignore
@@ -1,5 +1,4 @@
 /ldd/datafiles/lddfile.out
 /ldd/datafiles/*.obj.so
-/eject/eject_check_tray
 /insmod/ltp_insmod01.ko
 /lsmod/ltp_lsmod01.ko
diff --git a/testcases/kernel/syscalls/getitimer/.gitignore b/testcases/kernel/syscalls/getitimer/.gitignore
index 6533d4b50..0a46a1021 100644
--- a/testcases/kernel/syscalls/getitimer/.gitignore
+++ b/testcases/kernel/syscalls/getitimer/.gitignore
@@ -1,3 +1,2 @@
 /getitimer01
 /getitimer02
-/getitimer03
diff --git a/testcases/kernel/syscalls/syslog/.gitignore b/testcases/kernel/syscalls/syslog/.gitignore
index ec2b9412e..09d2e1b50 100644
--- a/testcases/kernel/syscalls/syslog/.gitignore
+++ b/testcases/kernel/syscalls/syslog/.gitignore
@@ -1,3 +1,2 @@
 /syslog11
 /syslog12
-/syslogtst
diff --git a/testcases/network/.gitignore b/testcases/network/.gitignore
index 3ebb6e33c..3011b4ba2 100644
--- a/testcases/network/.gitignore
+++ b/testcases/network/.gitignore
@@ -32,9 +32,6 @@
 /stress/ns-tools/ns-mcast_join
 /stress/ns-tools/ns-mcast_receiver
 /stress/ns-tools/ns-udpsender
-/tcp_cmds/echo/createfile
-/tcp_cmds/echo/echoes
-/tcp_cmds/echo/echoes6
 /tcp_cmds/sendfile/testsf_c
 /tcp_cmds/sendfile/testsf_c6
 /tcp_cmds/sendfile/testsf_s

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
