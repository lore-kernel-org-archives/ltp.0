Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F105AC02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 16:44:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A50F3C2B18
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 17:44:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C89733C0229
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:30 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2F53D660DFD
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 437F91F445
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9jDg/z3f5ZKyDpu6dPVNsbLs4Whek1i4EddktpsBnA=;
 b=giV5qL4CGmJqVwaTb0xAWG+cRqXGTCePoyEOgx6ng7mBkXc+tv8oO2IsvJ1rYmqzGUlwMS
 2IP5invdCJ6WvAGO9fjRG8MF7eZG5m3rVOe8ZrIVov3Lto5cTY3IZw9RUErvAcS6A+C0y0
 OlSQopv7uV+uydiZck/vhe/7x/RdOhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9jDg/z3f5ZKyDpu6dPVNsbLs4Whek1i4EddktpsBnA=;
 b=noLQ8b8IlJAWsV0e6IvNz5KwhmUHuTgoElGkuCylX/ffFNUf/x0nT8R0hf2OZX0ZlIVGkD
 NVJT3pk5w8EsfKAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9jDg/z3f5ZKyDpu6dPVNsbLs4Whek1i4EddktpsBnA=;
 b=giV5qL4CGmJqVwaTb0xAWG+cRqXGTCePoyEOgx6ng7mBkXc+tv8oO2IsvJ1rYmqzGUlwMS
 2IP5invdCJ6WvAGO9fjRG8MF7eZG5m3rVOe8ZrIVov3Lto5cTY3IZw9RUErvAcS6A+C0y0
 OlSQopv7uV+uydiZck/vhe/7x/RdOhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9jDg/z3f5ZKyDpu6dPVNsbLs4Whek1i4EddktpsBnA=;
 b=noLQ8b8IlJAWsV0e6IvNz5KwhmUHuTgoElGkuCylX/ffFNUf/x0nT8R0hf2OZX0ZlIVGkD
 NVJT3pk5w8EsfKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3561813ABC
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iCeFDO3Oj2erPQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 17:44:17 +0100
Message-ID: <20250121164426.27977-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121164426.27977-1-mdoucha@suse.cz>
References: <20250121164426.27977-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 03/10] kvm_x86: Define CR0 flags and additional
 CPUID/MSR constants
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/include/kvm_x86.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/testcases/kernel/kvm/include/kvm_x86.h b/testcases/kernel/kvm/include/kvm_x86.h
index f99fedbca..c782a64ec 100644
--- a/testcases/kernel/kvm/include/kvm_x86.h
+++ b/testcases/kernel/kvm/include/kvm_x86.h
@@ -62,12 +62,14 @@
 
 
 /* CPUID constants */
+#define CPUID_GET_MODEL_INFO 0x1
 #define CPUID_GET_INPUT_RANGE 0x80000000
 #define CPUID_GET_EXT_FEATURES 0x80000001
 #define CPUID_GET_SVM_FEATURES 0x8000000a
 
 
 /* Model-specific CPU register constants */
+#define MSR_IA32_FEATURE_CONTROL 0x3a
 #define MSR_SYSENTER_CS 0x174
 #define MSR_SYSENTER_ESP 0x175
 #define MSR_SYSENTER_EIP 0x176
@@ -95,6 +97,18 @@
 #define VM_CR_SVMDIS (1 << 4)
 
 /* Control register constants */
+#define CR0_PE (1 << 0)
+#define CR0_MP (1 << 1)
+#define CR0_EM (1 << 2)
+#define CR0_TS (1 << 3)
+#define CR0_ET (1 << 4)
+#define CR0_NE (1 << 5)
+#define CR0_WP (1 << 16)
+#define CR0_AM (1 << 18)
+#define CR0_NW (1 << 29)
+#define CR0_CD (1 << 30)
+#define CR0_PG (1 << 31)
+
 #define CR4_VME (1 << 0)
 #define CR4_PVI (1 << 1)
 #define CR4_TSD (1 << 2)
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
