Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88861C4345F
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 12:24:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0D0A3C88E3
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 14:24:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E44613CB27D
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:06 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1DF461A010E1
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E8CDF1F7DA
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pem4A+QBzmWPpLHqRnvGUBR35AtW9kladuGFt2GSxlM=;
 b=frdetx3R0vyy6+SsziGkPOE2BADAF6Pr0ZbhqatgkSmR9gnT+1WXPPdaD0+GHEDCvt/8R0
 Z1wytET10U/Ey0mte2G8Fz6c8BTg/gP26mHv4z78LeiFmxKA6P1WEQ0fSY9wnRobXmCk9R
 mKFTnwMdRXF1vOJqAu6BfJu268FjPFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479785;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pem4A+QBzmWPpLHqRnvGUBR35AtW9kladuGFt2GSxlM=;
 b=SZB5FT3PrlXt87o4l92WcYKQUgl77ZaLTX9VNk8dnhLhQ3pubM6M6Apyj0MGFKt7oA6CGw
 O+hyehMjKbN90dAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pem4A+QBzmWPpLHqRnvGUBR35AtW9kladuGFt2GSxlM=;
 b=EEElNLqJGpidrYpCkh2kQ7V/mhqAbgJlE/yaLvymVkYfdIo+LKCa4s5V9f22mVmh0hFOYb
 9kZaxgJmScIl53OX78pD04Andb6lRmenQu075KKY09FvjhJL2033VPESJdwZOmEc+wLXmq
 T3QmNuvtdUrfJ2gSpgLQxriaBwXXxcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pem4A+QBzmWPpLHqRnvGUBR35AtW9kladuGFt2GSxlM=;
 b=yWaBCQKii3wb6bRATZTI/ZZJi2qDAJF3Bta36uHXyWinnQFSd1zXMyykvlB3vHkIBgd6xm
 PU0h9jkhYC9an8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3F8D13A29
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aOqmM6jiMGaQHAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Apr 2024 14:22:05 +0200
Message-ID: <20240430122208.13043-10-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430122208.13043-1-mdoucha@suse.cz>
References: <20240430122208.13043-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.64 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; BAYES_HAM(-0.84)[85.34%];
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 9/9] KVM: Move kvm_pagefault01 to the end of KVM
 runfile
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

The kvm_pagefault01 test reloads the KVM module with special parameters
which may change kernel code paths and hide open bugs from other KVM
tests. Move the test to the end of KVM schedule to prevent interference.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/kvm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/runtest/kvm b/runtest/kvm
index 0e1b2e555..74a517add 100644
--- a/runtest/kvm
+++ b/runtest/kvm
@@ -1,5 +1,6 @@
-kvm_pagefault01 kvm_pagefault01
 kvm_svm01 kvm_svm01
 kvm_svm02 kvm_svm02
 kvm_svm03 kvm_svm03
 kvm_svm04 kvm_svm04
+# Tests below may interfere with bug reproducibility
+kvm_pagefault01 kvm_pagefault01
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
