Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90547C0218A
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 14:09:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CD0F3C2C4A
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 15:09:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D98D33C0558
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:29 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4417564AC85
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5658A1F383
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPg+VPlafyfRPU4gxUJfwKYx5RK5/U7Nkf1uo7px980=;
 b=qqGDKkL2DymDsSc1n9+uPDtam6UCQ3hPYbnnp1wNvIErB4jKEr9FoGmmvHHODLpKbMGdNn
 qbt7mFtClW1Ga1rCexI4YoyHFKoyrn6WuEucWD6iqNn2SCc4F8uDoZBiAiFiMmYFb0yDwa
 LVuM2eaytosdcVD4w2eSR2hzOwVIyVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPg+VPlafyfRPU4gxUJfwKYx5RK5/U7Nkf1uo7px980=;
 b=6UEuZbkPKQ4NhqxcQ2FFYZQAEIrV1eWA2edqZ7LWxs3mP8XeIm8mLmeL9Ef8eM15d4Ao1m
 xTea1qE05v8cbnCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPg+VPlafyfRPU4gxUJfwKYx5RK5/U7Nkf1uo7px980=;
 b=qqGDKkL2DymDsSc1n9+uPDtam6UCQ3hPYbnnp1wNvIErB4jKEr9FoGmmvHHODLpKbMGdNn
 qbt7mFtClW1Ga1rCexI4YoyHFKoyrn6WuEucWD6iqNn2SCc4F8uDoZBiAiFiMmYFb0yDwa
 LVuM2eaytosdcVD4w2eSR2hzOwVIyVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPg+VPlafyfRPU4gxUJfwKYx5RK5/U7Nkf1uo7px980=;
 b=6UEuZbkPKQ4NhqxcQ2FFYZQAEIrV1eWA2edqZ7LWxs3mP8XeIm8mLmeL9Ef8eM15d4Ao1m
 xTea1qE05v8cbnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 292EB137DB
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kGw3CFuTl2dfZQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 27 Jan 2025 15:08:19 +0100
MIME-Version: 1.0
Message-Id: <20250127-xattrat-v1-1-c3ee31e2543b@suse.com>
References: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
In-Reply-To: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737986906; l=8330;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=rNP4imRQZOWo7NIL4Pndk9aYESNrR2PbkzY3CMtv+Oc=;
 b=OeNywQRDOvDTU4GtwfCz/uSZqvAizSWSsEY26wJXWSwvxm3ZRZo0KEBqMdWQhkY5+jueYtiGR
 xqZl+mYku2lDBK+clT1ix61nkNZf+neepMVso2zZUabZIm4ZCjMFD1D
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/8] syscalls: add *xattrat syscalls
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

Add following syscalls:

- setxattrat
- getxattrat
- listxattrat
- removexattrat

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/arc.in         | 4 ++++
 include/lapi/syscalls/arm.in         | 4 ++++
 include/lapi/syscalls/arm64.in       | 4 ++++
 include/lapi/syscalls/i386.in        | 4 ++++
 include/lapi/syscalls/loongarch64.in | 4 ++++
 include/lapi/syscalls/mips64.in      | 4 ++++
 include/lapi/syscalls/mips64n32.in   | 4 ++++
 include/lapi/syscalls/mipso32.in     | 4 ++++
 include/lapi/syscalls/parisc.in      | 4 ++++
 include/lapi/syscalls/powerpc.in     | 4 ++++
 include/lapi/syscalls/powerpc64.in   | 4 ++++
 include/lapi/syscalls/s390.in        | 4 ++++
 include/lapi/syscalls/s390x.in       | 4 ++++
 include/lapi/syscalls/sh.in          | 4 ++++
 include/lapi/syscalls/sparc.in       | 4 ++++
 include/lapi/syscalls/sparc64.in     | 4 ++++
 include/lapi/syscalls/x86_64.in      | 4 ++++
 17 files changed, 68 insertions(+)

diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index f680d4119c10f73e2f1b8938c3be4a7254965ed0..5eff428f30b8cf4395edffbd3a002e6a6cad22b9 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -340,3 +340,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 32e48b2151afbf55a19e493518395e4265c670a0..1e8732b4be1a7c94d5ba46d1466cad6809bfc298 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -413,3 +413,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/arm64.in b/include/lapi/syscalls/arm64.in
index be7e9df6480c065ff63345d55082b1a6b2532760..f5c3653e7ee7433ca6bf06748064835bd9f4e857 100644
--- a/include/lapi/syscalls/arm64.in
+++ b/include/lapi/syscalls/arm64.in
@@ -316,3 +316,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 13f72e7950ded9393e665cb1a44fe955343f820c..32f85a36cb56c4a9e176f7a18a0bf48ad91cb923 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -447,3 +447,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/loongarch64.in b/include/lapi/syscalls/loongarch64.in
index 2c1ecd7aeeb2fa4f38999bad144cfceee39a4a54..70b8033ae561d147b5a94e5363a5e284a96fdba5 100644
--- a/include/lapi/syscalls/loongarch64.in
+++ b/include/lapi/syscalls/loongarch64.in
@@ -312,3 +312,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/mips64.in b/include/lapi/syscalls/mips64.in
index 8be734158fb7840b7757a012b6ed823f29eb7ab9..27e3fd168f22e38e6ac01794b1cc3c19a5834978 100644
--- a/include/lapi/syscalls/mips64.in
+++ b/include/lapi/syscalls/mips64.in
@@ -362,3 +362,7 @@ lsm_get_self_attr 5459
 lsm_set_self_attr 5460
 lsm_list_modules 5461
 mseal 5462
+setxattrat 5463
+getxattrat 5464
+listxattrat 5465
+removexattrat 5466
diff --git a/include/lapi/syscalls/mips64n32.in b/include/lapi/syscalls/mips64n32.in
index 153fe50bf9a7c62978e458e1cb7225aa63b9edda..6f41bf200fd705a791925bedd2881a6633f5e191 100644
--- a/include/lapi/syscalls/mips64n32.in
+++ b/include/lapi/syscalls/mips64n32.in
@@ -386,3 +386,7 @@ lsm_get_self_attr 6459
 lsm_set_self_attr 6460
 lsm_list_modules 6461
 mseal 6462
+setxattrat 6463
+getxattrat 6464
+listxattrat 6465
+removexattrat 6466
diff --git a/include/lapi/syscalls/mipso32.in b/include/lapi/syscalls/mipso32.in
index 1ed74c1ecf281a3d208eded4a0dbd35fcc57e45f..c97e7d952d880ec7470e1e0d971b53f1daabc5c7 100644
--- a/include/lapi/syscalls/mipso32.in
+++ b/include/lapi/syscalls/mipso32.in
@@ -426,3 +426,7 @@ lsm_get_self_attr 4459
 lsm_set_self_attr 4460
 lsm_list_modules 4461
 mseal 4462
+setxattrat 4463
+getxattrat 4464
+listxattrat 4465
+removexattrat 4466
diff --git a/include/lapi/syscalls/parisc.in b/include/lapi/syscalls/parisc.in
index 662bfea4428cf3b090b03632f2087251aaf3b513..87508325bf263896bbfb2e1dcfbe2c2700ce7645 100644
--- a/include/lapi/syscalls/parisc.in
+++ b/include/lapi/syscalls/parisc.in
@@ -395,3 +395,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index faaa75883a7d2a0b70ca0e8064b6c91dae21d20c..9be82e6d2084b4a57ff11c8bf4be6510224b27c6 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -437,3 +437,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 23b65e7840869c0cc08559324271b3b0d865ac01..756f224c48ef97459c0e61ab7d6721db4abae7df 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -409,3 +409,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 69d7408b7bdf0d9019d3c319cd52ff48022aca39..5f17ed825841698e88807c03f06a260b8aaf8628 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -430,3 +430,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index fa98054c732787b62528c71f60b04de490b98958..cf7866fdb5ecc3c6412af29e7359feb56da44983 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -378,3 +378,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 2e584253c61d51b140c3b2f586e3c49e5740e7af..4dc31daaaa4b777715e0dec4faf9835329f5f355 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -424,3 +424,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index fcdb9b812ee6844d4981550f3eeed7ff081852f8..094170372b6ca261129b5c82979d5895d0029e51 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -428,3 +428,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 4256aaf77674ed0c00bbd092d7c715038e52f1c3..16509d27794d4c36d508ec433e6bfbbbc05f064f 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -391,3 +391,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index e6c0a3b4047d60e0e372c023c8f6a9bab76697af..458748a995764cd046558164799d07b7cd6e79f9 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -373,3 +373,7 @@ lsm_get_self_attr 459
 lsm_set_self_attr 460
 lsm_list_modules 461
 mseal 462
+setxattrat 463
+getxattrat 464
+listxattrat 465
+removexattrat 466

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
