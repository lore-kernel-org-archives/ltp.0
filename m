Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C327BC36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:24:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50F8F3CB04B
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 16:24:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD8723CB08F
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:24:05 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A75A60083E
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:24:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDE601F393
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744035840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcj3y7u/gBAG7q/bw23hLklzvbjB7Dk1HY85kfpmHP0=;
 b=ZSfrnNX3AuCxAaik7ZzxqSuxTLmJ2DY73CPL8PvMyblElhyAbs79OWOIb6lRDOrgq17Ecs
 rDvzSrblo1cMZHJ2M/LX5R+4/gmyhsiCTeTZsjFagNgFMD4mxemiIbHXDbqkzSyIhpROLz
 3yqI5U2k5U76kwZGkuHRn7CC6jyxDc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744035840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcj3y7u/gBAG7q/bw23hLklzvbjB7Dk1HY85kfpmHP0=;
 b=GrsMEjbJj6r/Zn/ekG6m1PucQqyYdgUM/9XrPcKsJ6J3Bl60t0zuC296Yf5w3FLjfAgJb+
 uTyCXPlSXevEAdBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744035839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcj3y7u/gBAG7q/bw23hLklzvbjB7Dk1HY85kfpmHP0=;
 b=akeGA+3wT/YDage4aimhgIFsiVjA/ihPfD71U4sQSu2dcXJjeo5nn7xeZ9F0TEeGoMKvvg
 VphWt9UfwEIu6Au1dGzTN3rYW+lxLCy/SIPtqNgra+np3E/x2AsyGgw97JMjunJUOvMza9
 e+GqGLnbTqFQmSUGqX4MAgAR/KbhBtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744035839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcj3y7u/gBAG7q/bw23hLklzvbjB7Dk1HY85kfpmHP0=;
 b=oRp/rcfXm2zBelUawaAAlrDOeQP4doanRIbyncgfSAntXVbSOBFVaUk0JdT5ozxhvvxkNd
 DhBGA054v4TfrDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2C8513ACF
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UOdvK//f82e5KAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 07 Apr 2025 14:23:59 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  7 Apr 2025 16:23:48 +0200
Message-ID: <20250407142351.25900-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407142351.25900-1-mdoucha@suse.cz>
References: <20250407142351.25900-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] KVM: Add constants for Intel VMX vAPIC control
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
 testcases/kernel/kvm/include/kvm_x86_vmx.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/kvm/include/kvm_x86_vmx.h b/testcases/kernel/kvm/include/kvm_x86_vmx.h
index 92e3c683e..672c1b932 100644
--- a/testcases/kernel/kvm/include/kvm_x86_vmx.h
+++ b/testcases/kernel/kvm/include/kvm_x86_vmx.h
@@ -61,7 +61,10 @@
 #define VMX_VMCS_HOST_GS	0xc0a
 #define VMX_VMCS_HOST_TR	0xc0c
 
-#define VMX_VMCS_LINK_POINTER	0x2800
+#define VMX_VMCS_MSR_BITMAP_POINTER	0x2004
+#define VMX_VMCS_VIRT_APIC_POINTER	0x2012
+#define VMX_VMCS_VIRT_APIC_BASE		0x2014
+#define VMX_VMCS_LINK_POINTER		0x2800
 
 #define VMX_VMCS_GUEST_ES_LIMIT		0x4800
 #define VMX_VMCS_GUEST_CS_LIMIT		0x4802
@@ -143,8 +146,14 @@
 #define VMX_VMCS_EXIT_QUALIFICATION	0x6400
 
 #define VMX_INTERCEPT_HLT (1 << 7)
+#define VMX_EXECCTL_TPR_SHADOW (1 << 21)
+#define VMX_EXECCTL_MSR_BITMAP (1 << 28)
 #define VMX_EXECCTL_ENABLE_CTL2 (1 << 31)
 
+#define VMX_EXECCTL2_VIRT_APIC (1 << 0)
+#define VMX_EXECCTL2_VIRT_X2APIC (1 << 4)
+#define VMX_EXECCTL2_VIRT_APIC_REG (1 << 8)
+#define VMX_EXECCTL2_VIRT_INTR (1 << 9)
 #define VMX_EXECCTL2_SHADOW_VMCS (1 << 14)
 
 #define VMX_EXITCTL_SAVE_DR (1 << 2)
@@ -160,6 +169,7 @@
 #define VMX_INVALID_VMCS 0xffffffffffffffffULL
 
 #define VMX_EXIT_HLT 12
+#define VMX_EXIT_RDMSR 31
 #define VMX_EXIT_FAILED_ENTRY 0x80000000
 
 struct kvm_vmcs {
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
