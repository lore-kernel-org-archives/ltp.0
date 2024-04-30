Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DB6C4345F
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 12:23:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 545BF3CB46B
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 14:23:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EE973C88E3
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:06 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1E528200C18
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CBE6A3402B
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9lcW4E//q+U168SqvJeCBa9DmrnsSTOXTISJtmRyD0=;
 b=YVlZPDtx0SPa3aK7FkakFV8HGdAtIbldmXl7HtGUhzRE7tmGr/pipRQDzxfBL3siJwM5fS
 g0M/Kzm8ZMIz9SvQW9zRjVkH/ZBkz5oGqNHH9IA+eInKh9o9XKKuEnnitBsAKdYxYQ4FJD
 j7br0SMcvQ6L1pUSIchibws+eqMiiKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9lcW4E//q+U168SqvJeCBa9DmrnsSTOXTISJtmRyD0=;
 b=4GkueORBLO52A1iss2OXzIvrI8QrtHkIh1OcguLXkIK7pP08Mp/kFsldUhlPlBvrdCUm0H
 UqFFP95KmhlusHAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9lcW4E//q+U168SqvJeCBa9DmrnsSTOXTISJtmRyD0=;
 b=YVlZPDtx0SPa3aK7FkakFV8HGdAtIbldmXl7HtGUhzRE7tmGr/pipRQDzxfBL3siJwM5fS
 g0M/Kzm8ZMIz9SvQW9zRjVkH/ZBkz5oGqNHH9IA+eInKh9o9XKKuEnnitBsAKdYxYQ4FJD
 j7br0SMcvQ6L1pUSIchibws+eqMiiKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9lcW4E//q+U168SqvJeCBa9DmrnsSTOXTISJtmRyD0=;
 b=4GkueORBLO52A1iss2OXzIvrI8QrtHkIh1OcguLXkIK7pP08Mp/kFsldUhlPlBvrdCUm0H
 UqFFP95KmhlusHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C280F13A22
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uBdbL6jiMGaQHAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Apr 2024 14:22:00 +0200
Message-ID: <20240430122208.13043-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430122208.13043-1-mdoucha@suse.cz>
References: <20240430122208.13043-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.76 / 50.00]; BAYES_HAM(-2.96)[99.81%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/9] kvm_svm02: Fix saved stack segment index value
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

The VMCB init helper function expects GDT item index while the VMCB
segment selector values are byte offsets. Shift the byte offset
of saved stack segment selector to get the correct GDT index.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/kvm_svm02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/kvm/kvm_svm02.c b/testcases/kernel/kvm/kvm_svm02.c
index 5d2e2ce37..f72fb3812 100644
--- a/testcases/kernel/kvm/kvm_svm02.c
+++ b/testcases/kernel/kvm/kvm_svm02.c
@@ -96,7 +96,7 @@ void main(void)
 	vmsave_buf = kvm_alloc_vmcb();
 
 	/* Save allocated stack for later VM reinit */
-	ss = vcpu->vmcb->ss.selector;
+	ss = vcpu->vmcb->ss.selector >> 3;
 	rsp = vcpu->vmcb->rsp;
 
 	/* Load partial state from vmsave_buf and save it to vcpu->vmcb */
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
