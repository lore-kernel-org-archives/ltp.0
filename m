Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D323CA101F
	for <ltp@archiver.kernel.org>; Fri, 12 Sep 2025 07:32:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 920153CD8A9
	for <ltp@archiver.kernel.org>; Fri, 12 Sep 2025 09:32:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9FD23C0277
 for <ltp@lists.linux.it>; Fri, 12 Sep 2025 09:32:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 23BCF6008DD
 for <ltp@lists.linux.it>; Fri, 12 Sep 2025 09:32:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A9983F121;
 Fri, 12 Sep 2025 07:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757662333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OveaFbmmCbW51d+hljl/KpbVsnuyOCv2Ca/ZyilCq1A=;
 b=ITpDUNSRMd4U4WIJXe5ll8DZt0+vfUAT2uocMpQLPjnF0Jm2PUAHJbiaTYeVivgGSgkIO3
 MjWVWCa0RuJLSyBKBEhHmu9v+NbEYei4mqMxaCbNTQk+xBg0wCSZ6p0+MIOvOfA42EkyWj
 43vqxDQpEwJUyxeQMsDz9oVPD2n6bBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757662333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OveaFbmmCbW51d+hljl/KpbVsnuyOCv2Ca/ZyilCq1A=;
 b=UeZ2JiDf6TqDjO+HEWHhQLFpf2vCI3+GxDRe2fzmVZ4mp/vv1Dpc+v5YL+7FyQms21APJv
 MOSt0enni6QGfPBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757662333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OveaFbmmCbW51d+hljl/KpbVsnuyOCv2Ca/ZyilCq1A=;
 b=ITpDUNSRMd4U4WIJXe5ll8DZt0+vfUAT2uocMpQLPjnF0Jm2PUAHJbiaTYeVivgGSgkIO3
 MjWVWCa0RuJLSyBKBEhHmu9v+NbEYei4mqMxaCbNTQk+xBg0wCSZ6p0+MIOvOfA42EkyWj
 43vqxDQpEwJUyxeQMsDz9oVPD2n6bBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757662333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OveaFbmmCbW51d+hljl/KpbVsnuyOCv2Ca/ZyilCq1A=;
 b=UeZ2JiDf6TqDjO+HEWHhQLFpf2vCI3+GxDRe2fzmVZ4mp/vv1Dpc+v5YL+7FyQms21APJv
 MOSt0enni6QGfPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF951136DB;
 Fri, 12 Sep 2025 07:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Jn/MNXzMw2g7GgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Sep 2025 07:32:12 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 12 Sep 2025 09:32:07 +0200
Message-ID: <20250912073210.47637-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] LTP IMA pre-release fixes
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
Cc: Coiby Xu <coxu@redhat.com>, selinux@vger.kernel.org,
 linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

important is the second patch. It'd be good to merge it before upcoming
LTP release (1-2 weeks).

Kind regards,
Petr

Petr Vorel (2):
  ima_policy.sh: Optimize check for policy writable
  ima_{conditionals,policy}: Handle policy required to be signed

 .../security/integrity/ima/tests/ima_conditionals.sh | 11 ++++++++++-
 .../security/integrity/ima/tests/ima_policy.sh       | 12 ++++++------
 .../kernel/security/integrity/ima/tests/ima_setup.sh |  7 +++++++
 3 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
