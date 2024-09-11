Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F16EE57C2
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 16:36:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3ED333C1D38
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 18:36:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E22A3C1D2F
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 18:34:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5F4ED1A0C252
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 18:34:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B16BF21A9F
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726072495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgjudO5CcjylGXV2w2JBG4WcEbYoCYkWZJUlh/QZVQA=;
 b=r3K/Zlz2OyjOvrLR4npdpKqNQdkeWbOyj3re2CU2BhBw8KljWeKZ968smKSHBlucYWgU6d
 8HaZXZaZt46lsjvwFnQJrdlRO1/Oa3QyHvT8/oYSHMtVF5I/tgQ4Qd9BeBAId/4/xHpnGG
 l05m2WFYIr979o6FTrpxXKGel4kXmFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726072495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgjudO5CcjylGXV2w2JBG4WcEbYoCYkWZJUlh/QZVQA=;
 b=IgZIQEhQhwJUIzW3z4MC0DMiXMbI1sdwzeaf0tStwTr8+T8sR9E+PFvaDTyyGs7OX28CDG
 qzb/pCytkS/phbCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726072495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgjudO5CcjylGXV2w2JBG4WcEbYoCYkWZJUlh/QZVQA=;
 b=r3K/Zlz2OyjOvrLR4npdpKqNQdkeWbOyj3re2CU2BhBw8KljWeKZ968smKSHBlucYWgU6d
 8HaZXZaZt46lsjvwFnQJrdlRO1/Oa3QyHvT8/oYSHMtVF5I/tgQ4Qd9BeBAId/4/xHpnGG
 l05m2WFYIr979o6FTrpxXKGel4kXmFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726072495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgjudO5CcjylGXV2w2JBG4WcEbYoCYkWZJUlh/QZVQA=;
 b=IgZIQEhQhwJUIzW3z4MC0DMiXMbI1sdwzeaf0tStwTr8+T8sR9E+PFvaDTyyGs7OX28CDG
 qzb/pCytkS/phbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A72E013A7C
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AKCWKK/G4WZcBQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Sep 2024 18:34:38 +0200
Message-ID: <20240911163443.95398-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911163443.95398-1-mdoucha@suse.cz>
References: <20240911163443.95398-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] getdents02: Remove obsolete TCID
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
 testcases/kernel/syscalls/getdents/getdents02.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index 578db9d1e..25aa30d9d 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -28,8 +28,6 @@
 			 S_IXGRP|S_IROTH|S_IXOTH)
 #define TEST_DIR	"test_dir"
 
-char *TCID = "getdents02";
-
 static char *dirp;
 static size_t size;
 
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
