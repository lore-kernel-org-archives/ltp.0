Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FEAC47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 20:47:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8B793CE75B
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:47:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14FC03C810A
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2FBD9600126
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B1C2121E18;
 Thu,  4 Jan 2024 20:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UefY1jUiQfvsNh78tvTBiME0ouHDP1s98Z5iXymXe50=;
 b=hlUT5ckIu4SJ7GVrRuQ3gUJZk6KkIp9R3CfOUZ1oXmgzDVhvJ8cEnBLVN/8e5txqFOqHnj
 rdTqQUxbMAXoQyYuLITGANRr8kAvuf1SBH7larOC5hsAoVkt9OAMFANFGkdO4FXPhWbKEe
 8ThQc6y+Rg3NKEiLdzasuy9i6uLM3iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UefY1jUiQfvsNh78tvTBiME0ouHDP1s98Z5iXymXe50=;
 b=8vR+jd5Xoy8gI+TQWqNmEF6CWopEkfMyFwSAVg96ydmZFZ/8D64WfJHG7xwtsUaV+PEIFQ
 mBPIbnIn3Vmah6AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UefY1jUiQfvsNh78tvTBiME0ouHDP1s98Z5iXymXe50=;
 b=hlUT5ckIu4SJ7GVrRuQ3gUJZk6KkIp9R3CfOUZ1oXmgzDVhvJ8cEnBLVN/8e5txqFOqHnj
 rdTqQUxbMAXoQyYuLITGANRr8kAvuf1SBH7larOC5hsAoVkt9OAMFANFGkdO4FXPhWbKEe
 8ThQc6y+Rg3NKEiLdzasuy9i6uLM3iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UefY1jUiQfvsNh78tvTBiME0ouHDP1s98Z5iXymXe50=;
 b=8vR+jd5Xoy8gI+TQWqNmEF6CWopEkfMyFwSAVg96ydmZFZ/8D64WfJHG7xwtsUaV+PEIFQ
 mBPIbnIn3Vmah6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BA6E13C96;
 Thu,  4 Jan 2024 20:46:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +CF6IB0Zl2WsIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 20:46:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 21:46:09 +0100
Message-ID: <20240104204614.1426027-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104204614.1426027-1-pvorel@suse.cz>
References: <20240104204614.1426027-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hlUT5ckI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8vR+jd5X
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[32.95%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: B1C2121E18
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/9] metadata: test.sh: Print more info on VERBOSE=1
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 metadata/tests/test.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/metadata/tests/test.sh b/metadata/tests/test.sh
index 475d721df..a00e32bb4 100755
--- a/metadata/tests/test.sh
+++ b/metadata/tests/test.sh
@@ -3,6 +3,7 @@
 fail=0
 
 for i in *.c; do
+	[ "$VERBOSE" ] && echo "$0: testing $i"
 	../metaparse $i > tmp.json
 	if ! diff tmp.json $i.json >/dev/null 2>&1; then
 		echo "***"
@@ -15,4 +16,5 @@ done
 
 rm -f tmp.json
 
+[ "$VERBOSE" ] && echo "$fail"
 exit $fail
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
