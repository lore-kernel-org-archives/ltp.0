Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FFBCA5FF1
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 14:01:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C6133E2E81
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 16:01:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5ABE73E9C87
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 16:00:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CB85F1000A0E
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 16:00:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6B5A921BCB;
 Wed,  7 Oct 2026 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791381650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFLaAU8dcuDnT3DUj2CZYIW26N/N4+0MCbZPqxhSz3w=;
 b=uVUbHLTDN7FTq61j014/T8+ckYWZq8zcVrsHpjAPKxPZidfy+Dr1OcNNuB0OQm9FWNy9jE
 wMt4e3QKQtxhicgoZwuJiLFqH6/6LIwDL4AQrz14koJdAlS/96ps9S/uI55dorXDV/zcKS
 7rIQr8/bQn8VHc3FYTIAH9Ae5Gmikaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791381650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFLaAU8dcuDnT3DUj2CZYIW26N/N4+0MCbZPqxhSz3w=;
 b=Ukl5zVpBWmZkaHHJr9Oo5y1X0pLtL6TiiZmm9XM1TkRCkQx9n1L4kE+gatxmI+X7eU6skQ
 pjqa7ILyclPEnHAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791381649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFLaAU8dcuDnT3DUj2CZYIW26N/N4+0MCbZPqxhSz3w=;
 b=vRWsI5j8uYvgvaDSe/eGnrT0JTvx7kABNjXPcs8Nvxz55dHCW3RwmWeuQS/AfTXRCNOa0t
 8sumbBNWen2M7MbpOppJGHkGWPOqu2iAlG9qeRgK34dgk2yJoze0b18zDCXPRse4ZeA6hB
 VJ3igKYqNmoS+ODN6B0E7AZvAOV5PFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791381649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFLaAU8dcuDnT3DUj2CZYIW26N/N4+0MCbZPqxhSz3w=;
 b=o/RB+Xm1goa84avqSQ1rgC1pTFl2LxtGbQeiLMEsj91OLvekMTDhGaexu2actqIYjpIr6X
 6SNumsJX9cnlI3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0802139B1;
 Wed,  7 Oct 2026 14:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cP34H5BQxmqSLgAAD6G6ig:T3
 (envelope-from <andrea.cervesato@suse.de>); Wed, 07 Oct 2026 14:00:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 07 Oct 2026 16:00:46 +0200
MIME-Version: 1.0
Message-Id: <20261007-fix_leftovers-v1-2-63a1e7acd0e6@suse.com>
References: <20261007-fix_leftovers-v1-0-63a1e7acd0e6@suse.com>
In-Reply-To: <20261007-fix_leftovers-v1-0-63a1e7acd0e6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791381648; l=5252;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=EgD2hJzcNxVy8qQ/wgDs61F3/xkcQX697LkW9K7FShM=;
 b=wGUtc9NcpTndZRF3SquSrrRBOcMKoAabO9batS0phJme/ZImtWpN8WmK5Am/mCinx5JYXGks/
 FfHE4owr4S9DLPHgusMSXUS/aNYyCAE79CuRBDY4rtesGprTrSBuifg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] tree: Remove needs_checkpoints leftovers
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

Several tests declare .needs_checkpoints = 1 in struct tst_test,
but do not make use of any checkpoint synchronization. Remove this
leftover flag from those tests.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/cve/cve-2015-3290.c                             | 1 -
 testcases/kernel/containers/sysvipc/shmnstest.c           | 1 -
 testcases/kernel/containers/utsname/utsname04.c           | 1 -
 testcases/kernel/syscalls/exit_group/exit_group01.c       | 1 -
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c | 1 -
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c | 1 -
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c | 1 -
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c | 1 -
 testcases/kernel/uevents/uevent03.c                       | 1 -
 9 files changed, 9 deletions(-)

diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index d44276860..021b5702d 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -499,7 +499,6 @@ static void run(void)
 static struct tst_test test = {
 	.forks_child = 1,
 	.needs_root = 1,
-	.needs_checkpoints = 1,
 	.setup = setup,
 	.runtime = 180,
 	.test_all = run,
diff --git a/testcases/kernel/containers/sysvipc/shmnstest.c b/testcases/kernel/containers/sysvipc/shmnstest.c
index aa576eb08..de27cb585 100644
--- a/testcases/kernel/containers/sysvipc/shmnstest.c
+++ b/testcases/kernel/containers/sysvipc/shmnstest.c
@@ -66,7 +66,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.forks_child = 1,
 	.needs_root = 1,
-	.needs_checkpoints = 1,
 	.options = (struct tst_option[]) {
 		{ "m:", &str_op, "Test execution mode <clone|unshare|none>" },
 		{},
diff --git a/testcases/kernel/containers/utsname/utsname04.c b/testcases/kernel/containers/utsname/utsname04.c
index 2bcf61156..c328543a7 100644
--- a/testcases/kernel/containers/utsname/utsname04.c
+++ b/testcases/kernel/containers/utsname/utsname04.c
@@ -53,7 +53,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.forks_child = 1,
-	.needs_checkpoints = 1,
 	.options = (struct tst_option[]) {
 		{ "m:", &str_op, "Test execution mode <clone|unshare>" },
 		{},
diff --git a/testcases/kernel/syscalls/exit_group/exit_group01.c b/testcases/kernel/syscalls/exit_group/exit_group01.c
index 9005f4679..09bcccbea 100644
--- a/testcases/kernel/syscalls/exit_group/exit_group01.c
+++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
@@ -121,5 +121,4 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = run,
 	.forks_child = 1,
-	.needs_checkpoints = 1,
 };
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
index 07836cc69..9d93d21e6 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
@@ -118,7 +118,6 @@ static struct tst_test test = {
 	.test = verify_set_mempolicy,
 	.tcnt = 2,
 	.forks_child = 1,
-	.needs_checkpoints = 1,
 	.timeout = 600,
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_NUMA=y",
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
index d98f81545..73a9f09b4 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
@@ -108,7 +108,6 @@ static struct tst_test test = {
 	.test = verify_set_mempolicy,
 	.tcnt = 2,
 	.forks_child = 1,
-	.needs_checkpoints = 1,
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_NUMA=y",
 		NULL
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
index 43e0439d4..dd9fc53b3 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
@@ -102,7 +102,6 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.mntpoint = MNTPOINT,
 	.forks_child = 1,
-	.needs_checkpoints = 1,
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_NUMA=y",
 		NULL
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
index fa88385ce..55065f64a 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
@@ -133,7 +133,6 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.all_filesystems = 1,
 	.mntpoint = MNTPOINT,
-	.needs_checkpoints = 1,
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_NUMA=y",
 		NULL
diff --git a/testcases/kernel/uevents/uevent03.c b/testcases/kernel/uevents/uevent03.c
index 8c8a464af..2993acb99 100644
--- a/testcases/kernel/uevents/uevent03.c
+++ b/testcases/kernel/uevents/uevent03.c
@@ -237,7 +237,6 @@ static void verify_uevent(void)
 static struct tst_test test = {
 	.test_all = verify_uevent,
 	.forks_child = 1,
-	.needs_checkpoints = 1,
 	.needs_kconfigs = (const char *const[]) {
 		"CONFIG_INPUT_UINPUT",
 		NULL

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
