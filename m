Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857B9C0218B
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 16:46:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 229763C2A8C
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 17:46:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BB983C0229
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:30 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2FED6600C3B
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:44:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 498E82115B
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRG2Q48/koShHMEwbvWHoxhlyJVQxzPBGgIyD0ik98U=;
 b=uoDT+RdoOrUJYAQ1HPKJ1M8OuXLX8IjL6onXzKEsW3J/j4Yf1L4xLPyoUKuvQZ9Nh66f3m
 EKb/5NFy82A+aH6tzbsUpcxoDrUzZoXr4WoBMJe6MjgZ4BtXVvk1pSt4yFNn4mfEyn9DEu
 YZbYio6PgXa+bCdFDWAFwv94+6zVocA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRG2Q48/koShHMEwbvWHoxhlyJVQxzPBGgIyD0ik98U=;
 b=hjHbMyr5qVg8OwjpAP5LEmhvPES153o1Nb/OGyttTO/zKRXtV0Dh3aUTK0eKRopJcJXM15
 /jX1O2xqI9yNkRDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uoDT+Rdo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hjHbMyr5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737477869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRG2Q48/koShHMEwbvWHoxhlyJVQxzPBGgIyD0ik98U=;
 b=uoDT+RdoOrUJYAQ1HPKJ1M8OuXLX8IjL6onXzKEsW3J/j4Yf1L4xLPyoUKuvQZ9Nh66f3m
 EKb/5NFy82A+aH6tzbsUpcxoDrUzZoXr4WoBMJe6MjgZ4BtXVvk1pSt4yFNn4mfEyn9DEu
 YZbYio6PgXa+bCdFDWAFwv94+6zVocA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737477869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wRG2Q48/koShHMEwbvWHoxhlyJVQxzPBGgIyD0ik98U=;
 b=hjHbMyr5qVg8OwjpAP5LEmhvPES153o1Nb/OGyttTO/zKRXtV0Dh3aUTK0eKRopJcJXM15
 /jX1O2xqI9yNkRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E2A613AEB
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YNr8Du3Oj2erPQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 16:44:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 17:44:18 +0100
Message-ID: <20250121164426.27977-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121164426.27977-1-mdoucha@suse.cz>
References: <20250121164426.27977-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 498E82115B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/10] KVM: Implement helper functions for setting x86
 control registers
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
 testcases/kernel/kvm/include/kvm_x86.h |  3 +++
 testcases/kernel/kvm/lib_x86.c         | 27 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/testcases/kernel/kvm/include/kvm_x86.h b/testcases/kernel/kvm/include/kvm_x86.h
index c782a64ec..296dc3859 100644
--- a/testcases/kernel/kvm/include/kvm_x86.h
+++ b/testcases/kernel/kvm/include/kvm_x86.h
@@ -221,6 +221,9 @@ unsigned int kvm_create_stack_descriptor(struct segment_descriptor *table,
 void kvm_get_cpuid(unsigned int eax, unsigned int ecx, struct kvm_cpuid *buf);
 void kvm_read_cregs(struct kvm_cregs *buf);
 void kvm_read_sregs(struct kvm_sregs *buf);
+void kvm_set_cr0(unsigned long val);
+void kvm_set_cr3(unsigned long val);
+void kvm_set_cr4(unsigned long val);
 uint64_t kvm_rdmsr(unsigned int msr);
 void kvm_wrmsr(unsigned int msr, uint64_t value);
 
diff --git a/testcases/kernel/kvm/lib_x86.c b/testcases/kernel/kvm/lib_x86.c
index 8db3abd3f..266d7195c 100644
--- a/testcases/kernel/kvm/lib_x86.c
+++ b/testcases/kernel/kvm/lib_x86.c
@@ -214,6 +214,33 @@ void kvm_get_cpuid(unsigned int eax, unsigned int ecx, struct kvm_cpuid *buf)
 	);
 }
 
+void kvm_set_cr0(unsigned long val)
+{
+	asm (
+		"mov %0, %%cr0\n"
+		:
+		: "r" (val)
+	);
+}
+
+void kvm_set_cr3(unsigned long val)
+{
+	asm (
+		"mov %0, %%cr3\n"
+		:
+		: "r" (val)
+	);
+}
+
+void kvm_set_cr4(unsigned long val)
+{
+	asm (
+		"mov %0, %%cr4\n"
+		:
+		: "r" (val)
+	);
+}
+
 uint64_t kvm_rdmsr(unsigned int msr)
 {
 	unsigned int ret_lo, ret_hi;
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
