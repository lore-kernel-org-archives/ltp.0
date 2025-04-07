Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853ABC369A2
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:24:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25EF63CAF07
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 16:24:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E4413C9E40
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:24:01 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3ADBD2009C1
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 16:24:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A1587210EF
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744035840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xlfOJ7riGLaJiTKOBEdaFMrWC7Czuw+qry4tdXdwjYI=;
 b=dTXu0KfozSXJItD/4hBJd/9HtvSL6fBO1eakiTakVQKK4cp2nUFeX3cxjme0NFwgZF8f4b
 kwtoymA5NtSId5PlBoVeZw8EzD4c9dRfjPAMJZFlZMcjDplO/H8KFmev9Wq0na6NfxONmh
 UQNB34ROAlkkfAR6IrnyVxu6so/vGDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744035840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xlfOJ7riGLaJiTKOBEdaFMrWC7Czuw+qry4tdXdwjYI=;
 b=9EMqEX1rbXPQcksv/jj+5D+U8ItWqQ9lmUoki4JdkEVYZzUzl2k9TL9Ao2y4NPlbmTHjJR
 97Rrk+u3Bs3xJGAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744035839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xlfOJ7riGLaJiTKOBEdaFMrWC7Czuw+qry4tdXdwjYI=;
 b=s8EkN5B4u8xP+uy6XZHm8yOKbqN/s2AG3yftoiR4Hbu4CUmxPvOFQUqDWnKp7x+j++xtQt
 3u3tC/wfKEBwMmFHw3tvp4Th8xS5l6VYOpXaeDxMRFyPcoFf4vF/oZCiXaD5HPMnDwheKs
 gDMSqk1ic9rZdxOsfzIGXyU+WCtEQk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744035839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xlfOJ7riGLaJiTKOBEdaFMrWC7Czuw+qry4tdXdwjYI=;
 b=Qbx5PyVhnXhiZGFKgsNLi6ofZUKcWfft99vWjfRzVumwmENLLmgU2+MGpLSp9r3Yld0oPi
 XSgGCVtZdwHF06Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C58C13ACA
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AMH5If/f82e5KAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 07 Apr 2025 14:23:59 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  7 Apr 2025 16:23:46 +0200
Message-ID: <20250407142351.25900-3-mdoucha@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] KVM: Add kvm_vmx01 to the runtest file
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
 runtest/kvm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/runtest/kvm b/runtest/kvm
index 74a517add..091bcd43e 100644
--- a/runtest/kvm
+++ b/runtest/kvm
@@ -2,5 +2,6 @@ kvm_svm01 kvm_svm01
 kvm_svm02 kvm_svm02
 kvm_svm03 kvm_svm03
 kvm_svm04 kvm_svm04
+kvm_vmx01 kvm_vmx01
 # Tests below may interfere with bug reproducibility
 kvm_pagefault01 kvm_pagefault01
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
