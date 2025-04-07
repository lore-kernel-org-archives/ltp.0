Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D300EC36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:25:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59E073CB1CB
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 16:25:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88B563CB2CC
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:24:10 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 86FD16003AC
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:24:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E18A1F38D
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744035840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TAWq4d5zvlatDWEK96+zQhnR6c98isfbXENiGQNmrg=;
 b=rkuXljSoUKYXh/QaYd3ClpGGMh2zBJfcbbhHBdU5P3ACsP8+y1hi6fR1oP5iuwIUDFGJWG
 ul3Ml+rWHj2J8R/RzEP+158l5FsqDCm0ddVzmkFUMrGoWb0f77QDuGx6U3v6/hxWfYCPth
 dQfJ/O51H0ROFHb7ECzWHx/ND//BVxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744035840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TAWq4d5zvlatDWEK96+zQhnR6c98isfbXENiGQNmrg=;
 b=RKtx9KNdz8IQbm9jtyWZAzPYTGknFfoSNpkl5Tolm3MYNLnrVGOlnrSS+9pLrxolrpXHNJ
 w7t2opdeV+dZqlBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2mPWNR3R;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IV0RzkHZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744035839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TAWq4d5zvlatDWEK96+zQhnR6c98isfbXENiGQNmrg=;
 b=2mPWNR3RYS9LIGWb2k6TYaq8cQparcRGsA4NxszJuei7c7NHA9CvPXtDxAjozxGcqbRQtI
 za+ybGhUWXl1IITtbPnxmyKnxVy8WpGen0HdgSEnGB53S1dHjfmN3gJl1hA+pbH/KdDOjY
 elwmqtNHPh/en5Vs2IkhOrkc1K7jq9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744035839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TAWq4d5zvlatDWEK96+zQhnR6c98isfbXENiGQNmrg=;
 b=IV0RzkHZVFb+UWjlHWq1DB/KYV32+OoGPkMWZ93ptFXTQKaC2hYICGSpi3IL8RWbi3Ouz2
 pYH1x+h/O/EMBoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A2B313AB8
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iICiHf/f82e5KAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 07 Apr 2025 14:23:59 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  7 Apr 2025 16:23:45 +0200
Message-ID: <20250407142351.25900-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407142351.25900-1-mdoucha@suse.cz>
References: <20250407142351.25900-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8E18A1F38D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] kvm_vmx01: Fix 32bit compiler warnings
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

Fix printf formatting warnings due to type mismatch during 32bit
compilation.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/kvm_vmx01.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/kvm/kvm_vmx01.c b/testcases/kernel/kvm/kvm_vmx01.c
index c413b4148..31ad75137 100644
--- a/testcases/kernel/kvm/kvm_vmx01.c
+++ b/testcases/kernel/kvm/kvm_vmx01.c
@@ -25,7 +25,7 @@
 struct vmcs_field_table {
 	unsigned long field_id;
 	const char *name;
-	uint64_t value;
+	unsigned long value;
 };
 
 /* Data written into shadow VMCS by the parent VM and read by the nested VM */
@@ -110,7 +110,7 @@ static struct vmcs_field_table guest_data[SHADOW_DATA_LENGTH] = {
 	{VMCS_FIELD(VMX_VMCS_GUEST_LDTR_BASE), 0xb1d72}
 };
 
-static uint64_t vmread_buffer[SHADOW_DATA_LENGTH];
+static unsigned long vmread_buffer[SHADOW_DATA_LENGTH];
 
 int guest_main(void)
 {
@@ -221,7 +221,7 @@ void main(void)
 			continue;
 
 		errors++;
-		tst_res(TFAIL, "Shadow %s guest mismatch: %llx != %llx",
+		tst_res(TFAIL, "Shadow %s guest mismatch: %lx != %lx",
 			host_data[i].name, vmread_buffer[i],
 			host_data[i].value);
 	}
@@ -239,7 +239,7 @@ void main(void)
 			continue;
 
 		errors++;
-		tst_res(TFAIL, "Shadow %s parent mismatch: %llx != %llx",
+		tst_res(TFAIL, "Shadow %s parent mismatch: %llx != %lx",
 			guest_data[i].name, val, guest_data[i].value);
 	}
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
