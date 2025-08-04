Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFAFC87FCB
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 18:09:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3E903CCFC2
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 20:09:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA8543C8EB8
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:09:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF48B60054F
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:09:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC9841F74A;
 Mon,  4 Aug 2025 18:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754330967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSYoblK/upDucpofZekKDuxlI3gYmc/YXMgEWAVk3lI=;
 b=lsoOc6DiVeDXEHkqbp70h7S44+kgYuB9HLMnYNgLxSy4BmTo7/yC5nyuvSqXmZR0Owi05C
 qu7NoZB6xp1ic0Jepag9QGXrsSIaYWXV12cPsiaXZp3Hx9DG/x0Z8gq++FIT0z9s4iWdZT
 1vslV0op18VSEJX+K051wgYSIIc6gBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754330967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSYoblK/upDucpofZekKDuxlI3gYmc/YXMgEWAVk3lI=;
 b=mfJgb7y+3jMLtR9OBm9fkbIzxc9B4j/oliZZ3B/LiAcnwF2e6v/rT8JEfCJDtzHbi4NpkR
 5dqxoHyKUExUHADg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754330967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSYoblK/upDucpofZekKDuxlI3gYmc/YXMgEWAVk3lI=;
 b=lsoOc6DiVeDXEHkqbp70h7S44+kgYuB9HLMnYNgLxSy4BmTo7/yC5nyuvSqXmZR0Owi05C
 qu7NoZB6xp1ic0Jepag9QGXrsSIaYWXV12cPsiaXZp3Hx9DG/x0Z8gq++FIT0z9s4iWdZT
 1vslV0op18VSEJX+K051wgYSIIc6gBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754330967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSYoblK/upDucpofZekKDuxlI3gYmc/YXMgEWAVk3lI=;
 b=mfJgb7y+3jMLtR9OBm9fkbIzxc9B4j/oliZZ3B/LiAcnwF2e6v/rT8JEfCJDtzHbi4NpkR
 5dqxoHyKUExUHADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE92D13A83;
 Mon,  4 Aug 2025 18:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ADnCJ1f3kGjyJgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Aug 2025 18:09:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 Aug 2025 20:09:19 +0200
MIME-Version: 1.0
Message-Id: <20250804-file_setattr_getattr-v1-1-6a43c3962c87@suse.com>
References: <20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com>
In-Reply-To: <20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754330967; l=9465;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=4NsCX1Gsmeax6GGB2wDu9e4BjhWlWP9ynEBj7cWb12k=;
 b=EOm0zoaoyCyZFRCp+25Cawx7rI8hWRY3ItWP/9btS7yTI7aR5c2YQQiE7Cx67k3fj0eU8YwDL
 7xY35+Z6NoMCaKTohtsmBmfqO+kJASdxau5UCQ1Lf26gmxjDyac6/Hj
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] Update LTP to the latest syscalls
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

Add the following syscalls:

- setxattrat
- getxattrat
- listxattrat
- removexattrat
- open_tree_attr
- file_getattr
- file_setattr

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/arc.in         | 7 +++++++
 include/lapi/syscalls/arm.in         | 7 +++++++
 include/lapi/syscalls/arm64.in       | 7 +++++++
 include/lapi/syscalls/i386.in        | 7 +++++++
 include/lapi/syscalls/loongarch64.in | 7 +++++++
 include/lapi/syscalls/mips64.in      | 7 +++++++
 include/lapi/syscalls/mips64n32.in   | 7 +++++++
 include/lapi/syscalls/mipso32.in     | 7 +++++++
 include/lapi/syscalls/parisc.in      | 7 +++++++
 include/lapi/syscalls/powerpc.in     | 7 +++++++
 include/lapi/syscalls/powerpc64.in   | 7 +++++++
 include/lapi/syscalls/s390.in        | 7 +++++++
 include/lapi/syscalls/s390x.in       | 7 +++++++
 include/lapi/syscalls/sh.in          | 7 +++++++
 include/lapi/syscalls/sparc.in       | 7 +++++++
 include/lapi/syscalls/sparc64.in     | 7 +++++++
 include/lapi/syscalls/x86_64.in      | 7 +++++++
 17 files changed, 119 insertions(+)

diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index f680d4119c10f73e2f1b8938c3be4a7254965ed0..0f0fbef6be74d06abbf4f1bbf77eeaf72a1e6b71 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -340,3 +340,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 32e48b2151afbf55a19e493518395e4265c670a0..d0238dec5ecbf3849dff3b2c91ec88866dfb440c 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -413,3 +413,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/arm64.in b/include/lapi/syscalls/arm64.in
index be7e9df6480c065ff63345d55082b1a6b2532760..c76930e20df02905c9c640a749b4ec2df421c665 100644
--- a/include/lapi/syscalls/arm64.in
+++ b/include/lapi/syscalls/arm64.in
@@ -316,3 +316,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 13f72e7950ded9393e665cb1a44fe955343f820c..38ea71fb282d9dc69914b863cba352349fd1c9b9 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -447,3 +447,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/loongarch64.in b/include/lapi/syscalls/loongarch64.in
index 2c1ecd7aeeb2fa4f38999bad144cfceee39a4a54..5407b86eaf738354f645f894bd95900ff614b3e1 100644
--- a/include/lapi/syscalls/loongarch64.in
+++ b/include/lapi/syscalls/loongarch64.in
@@ -312,3 +312,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/mips64.in b/include/lapi/syscalls/mips64.in
index 8be734158fb7840b7757a012b6ed823f29eb7ab9..436d5c681c21f32623d779268b9c3daaaac5b5e0 100644
--- a/include/lapi/syscalls/mips64.in
+++ b/include/lapi/syscalls/mips64.in
@@ -362,3 +362,10 @@ lsm_get_self_attr 5459
 lsm_set_self_attr 5460
 lsm_list_modules 5461
 mseal 5462
+setxattrat 5463
+getxattrat 5464
+listxattrat 5465
+removexattrat 5466
+open_tree_attr 5467
+file_getattr 5468
+file_setattr 5469
diff --git a/include/lapi/syscalls/mips64n32.in b/include/lapi/syscalls/mips64n32.in
index 153fe50bf9a7c62978e458e1cb7225aa63b9edda..860a19c8b62866aeaf5b03c5c45ef5d6d58cab0f 100644
--- a/include/lapi/syscalls/mips64n32.in
+++ b/include/lapi/syscalls/mips64n32.in
@@ -386,3 +386,10 @@ lsm_get_self_attr 6459
 lsm_set_self_attr 6460
 lsm_list_modules 6461
 mseal 6462
+setxattrat 6463
+getxattrat 6464
+listxattrat 6465
+removexattrat 6466
+open_tree_attr 6467
+file_getattr 6468
+file_setattr 6469
diff --git a/include/lapi/syscalls/mipso32.in b/include/lapi/syscalls/mipso32.in
index 1ed74c1ecf281a3d208eded4a0dbd35fcc57e45f..5e53e46ce1e47c4618ceeeda03130cbdd621b180 100644
--- a/include/lapi/syscalls/mipso32.in
+++ b/include/lapi/syscalls/mipso32.in
@@ -426,3 +426,10 @@ lsm_get_self_attr 4459
 lsm_set_self_attr 4460
 lsm_list_modules 4461
 mseal 4462
+setxattrat 4463
+getxattrat 4464
+listxattrat 4465
+removexattrat 4466
+open_tree_attr 4467
+file_getattr 4468
+file_setattr 4469
diff --git a/include/lapi/syscalls/parisc.in b/include/lapi/syscalls/parisc.in
index 662bfea4428cf3b090b03632f2087251aaf3b513..238756694d9a03bcb063c21d3644aaa2af47f3fc 100644
--- a/include/lapi/syscalls/parisc.in
+++ b/include/lapi/syscalls/parisc.in
@@ -395,3 +395,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index faaa75883a7d2a0b70ca0e8064b6c91dae21d20c..6911f9af96247739a1ba7020aa3df77ef70ef55a 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -437,3 +437,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 23b65e7840869c0cc08559324271b3b0d865ac01..98190ba266a1c7a6c3dbca1346e9d5e55783e271 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -409,3 +409,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 69d7408b7bdf0d9019d3c319cd52ff48022aca39..a6cb85da805bec2540433783be9445645ab913ab 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -430,3 +430,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index fa98054c732787b62528c71f60b04de490b98958..31f3ec5532c8c3017188b60907f7666b41f44102 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -378,3 +378,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 2e584253c61d51b140c3b2f586e3c49e5740e7af..ac281acf81ffe6770fa0d941d406714fbdce1bbd 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -424,3 +424,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index fcdb9b812ee6844d4981550f3eeed7ff081852f8..ffc0d9f7abdaa8873ec73ed1a5e0ec98b5f8b1d7 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -428,3 +428,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 4256aaf77674ed0c00bbd092d7c715038e52f1c3..992bd307deb07d50ff814c603406842b5aedb431 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -391,3 +391,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index e6c0a3b4047d60e0e372c023c8f6a9bab76697af..e9c0d0599e25e3fa408686544c5d80c5a3e876d7 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -373,3 +373,10 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
+open_tree_attr 467
+file_getattr 468
+file_setattr 469

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
