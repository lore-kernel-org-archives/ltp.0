Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A8AC369A1
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 17:18:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDB5B3CB41A
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 19:18:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F00B3CB412
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 19:18:29 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 07B0514010EB
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 19:18:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC30721168;
 Wed,  9 Apr 2025 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744219107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fDGx4KOecLD2QMjvZBUYhtQ9QB5cmptKz7Xu15YRA9s=;
 b=G6y9MRDu4ME56v51cwu6A5QVyqXRApOvMuME+ilf6JsQMtZEWd6OXL5Uhwfr+iX1EP7mSD
 23Lay3dopiWFv6IMyMkhLm97Zw4VNNqTvRCtBx+NZH4JWbnfH09JOS6BY2aQEaBa26nVv7
 llMQG7N8SfkoZhdVUa+CaMmjJ3V/1b8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744219107;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fDGx4KOecLD2QMjvZBUYhtQ9QB5cmptKz7Xu15YRA9s=;
 b=MLz1xc8vjzz/F9+BaGJBczCo4n38ciEH77hZozPFP3iG2Y1vtIW6bMHo/Ixv4GUOnGDjj9
 +3CEjiKTOawbq1Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744219107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fDGx4KOecLD2QMjvZBUYhtQ9QB5cmptKz7Xu15YRA9s=;
 b=G6y9MRDu4ME56v51cwu6A5QVyqXRApOvMuME+ilf6JsQMtZEWd6OXL5Uhwfr+iX1EP7mSD
 23Lay3dopiWFv6IMyMkhLm97Zw4VNNqTvRCtBx+NZH4JWbnfH09JOS6BY2aQEaBa26nVv7
 llMQG7N8SfkoZhdVUa+CaMmjJ3V/1b8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744219107;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fDGx4KOecLD2QMjvZBUYhtQ9QB5cmptKz7Xu15YRA9s=;
 b=MLz1xc8vjzz/F9+BaGJBczCo4n38ciEH77hZozPFP3iG2Y1vtIW6bMHo/Ixv4GUOnGDjj9
 +3CEjiKTOawbq1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7951913691;
 Wed,  9 Apr 2025 17:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +Sw1FuOr9mdoCQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Apr 2025 17:18:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Apr 2025 19:18:26 +0200
MIME-Version: 1.0
Message-Id: <20250409-ci_testing_branch-v1-1-ccea0cdf0781@suse.com>
X-B4-Tracking: v=1; b=H4sIAOGr9mcC/x3MQQqAIBBA0avErBNMKqqrRMhoo87GQiOC8O5Jy
 7f4/4VMiSnD0ryQ6ObMR6zo2gZswOhJ8F4NSqpB9nIWlvVF+eLotUkYbRBoaFKIrnPDCLU7Ezl
 +/ue6lfIB+pJckWMAAAA=
X-Change-ID: 20250409-ci_testing_branch-abe82aaf1f56
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744219107; l=505;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=C4dOS9FDVrHBy/+d+EISE4amCJweW+CdKVOdm0lPfxg=;
 b=zaUOr5qPEA3s22XA7qtpPrxFfh1K2Uyzgy3I1zLxTOro/tlwEPPIb86Rg2xzShsZvEVa8IHE8
 T6pfidCYFOuBryfLg139X0PepsYeMcJ9uR5SJKKm1+i4p+KUPT/Rx4e
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH WIP] testing patch for patchwork CI
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

Please ignore any possible review.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 myfile.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/myfile.txt b/myfile.txt
new file mode 100644
index 0000000000000000000000000000000000000000..e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

---
base-commit: 8000c950d6ba61a541a9278cdda6d68141c2fc0d
change-id: 20250409-ci_testing_branch-abe82aaf1f56

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
