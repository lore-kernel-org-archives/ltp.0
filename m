Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC48CC4345F
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 12:24:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BC7E3CB3DC
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 14:24:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB0683CB373
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:06 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6712A1400519
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E58133402D
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9b68l+fDbEAe36EUccjuLBxv0FLXKcSgsL4+Xs32xc=;
 b=LFkqsIRthq2IXpRmePGAmlAx8TqHO/PFAXOOVsTfsMfDrHe7Ry/PACqQ9bIHRixPGSXSz/
 iwEugjaE5tnBjCg2wreKmwBtse/Exe8oPVw7hUyj0wBXW0/D2TqQmxLOKlDUdyEyClSG5N
 iM9MmP6zUQ3SvjTNVJ0VvcDIT6938DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9b68l+fDbEAe36EUccjuLBxv0FLXKcSgsL4+Xs32xc=;
 b=W/u6lPx8BZM+7/5dA2MxAqmgH5hhsJhYnip1cY2k0Xey3Smz70UcbLbPvCSmdMVaHNYpeX
 7rgDg9wpJbNBtYAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9b68l+fDbEAe36EUccjuLBxv0FLXKcSgsL4+Xs32xc=;
 b=LFkqsIRthq2IXpRmePGAmlAx8TqHO/PFAXOOVsTfsMfDrHe7Ry/PACqQ9bIHRixPGSXSz/
 iwEugjaE5tnBjCg2wreKmwBtse/Exe8oPVw7hUyj0wBXW0/D2TqQmxLOKlDUdyEyClSG5N
 iM9MmP6zUQ3SvjTNVJ0VvcDIT6938DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9b68l+fDbEAe36EUccjuLBxv0FLXKcSgsL4+Xs32xc=;
 b=W/u6lPx8BZM+7/5dA2MxAqmgH5hhsJhYnip1cY2k0Xey3Smz70UcbLbPvCSmdMVaHNYpeX
 7rgDg9wpJbNBtYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBD3513A25
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yLGkMajiMGaQHAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Apr 2024 14:22:03 +0200
Message-ID: <20240430122208.13043-8-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430122208.13043-1-mdoucha@suse.cz>
References: <20240430122208.13043-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/9] KVM: Add VMSAVE/VMLOAD functions to x86 SVM
 library
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
 testcases/kernel/kvm/include/kvm_x86_svm.h |  6 ++++++
 testcases/kernel/kvm/kvm_svm02.c           | 12 ++----------
 testcases/kernel/kvm/lib_x86.c             | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/kvm/include/kvm_x86_svm.h b/testcases/kernel/kvm/include/kvm_x86_svm.h
index b4b1b80e2..73563ed2d 100644
--- a/testcases/kernel/kvm/include/kvm_x86_svm.h
+++ b/testcases/kernel/kvm/include/kvm_x86_svm.h
@@ -163,4 +163,10 @@ struct kvm_svm_vcpu *kvm_create_svm_vcpu(int (*guest_main)(void),
 
 void kvm_svm_vmrun(struct kvm_svm_vcpu *cpu);
 
+/* Load FS, GS, TR and LDTR state from vmsave_buf */
+void kvm_svm_vmload(struct kvm_vmcb *buf);
+
+/* Save current FS, GS, TR and LDTR state to vmsave_buf */
+void kvm_svm_vmsave(struct kvm_vmcb *buf);
+
 #endif /* KVM_X86_SVM_H_ */
diff --git a/testcases/kernel/kvm/kvm_svm02.c b/testcases/kernel/kvm/kvm_svm02.c
index f72fb3812..6914fdcba 100644
--- a/testcases/kernel/kvm/kvm_svm02.c
+++ b/testcases/kernel/kvm/kvm_svm02.c
@@ -33,22 +33,14 @@ static void *vmsave_buf;
 /* Load FS, GS, TR and LDTR state from vmsave_buf */
 static int guest_vmload(void)
 {
-	asm (
-		"vmload %0\n"
-		:
-		: "a" (vmsave_buf)
-	);
+	kvm_svm_vmload(vmsave_buf);
 	return 0;
 }
 
 /* Save current FS, GS, TR and LDTR state to vmsave_buf */
 static int guest_vmsave(void)
 {
-	asm (
-		"vmsave %0\n"
-		:
-		: "a" (vmsave_buf)
-	);
+	kvm_svm_vmsave(vmsave_buf);
 	return 0;
 }
 
diff --git a/testcases/kernel/kvm/lib_x86.c b/testcases/kernel/kvm/lib_x86.c
index 1c0e629c3..8db3abd3f 100644
--- a/testcases/kernel/kvm/lib_x86.c
+++ b/testcases/kernel/kvm/lib_x86.c
@@ -393,3 +393,21 @@ struct kvm_svm_vcpu *kvm_create_svm_vcpu(int (*guest_main)(void),
 	ret->vmcb = vmcb;
 	return ret;
 }
+
+void kvm_svm_vmload(struct kvm_vmcb *buf)
+{
+	asm (
+		"vmload %0\n"
+		:
+		: "a" (buf)
+	);
+}
+
+void kvm_svm_vmsave(struct kvm_vmcb *buf)
+{
+	asm (
+		"vmsave %0\n"
+		:
+		: "a" (buf)
+	);
+}
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
