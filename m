Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8D8C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 09:58:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 769063CA2B1
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 10:58:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1B3A3CA2B1
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 10:57:56 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 778291A0088B
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 10:57:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 37D832119D;
 Fri, 28 Mar 2025 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743155870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As4+B8YmPi0hZdGGrM8ai0yEjD4LiNyPWnZEPc6VK0E=;
 b=MVXI/kOFTNrYdTPfZzhllTzEX+EDCgu1Khjc8Q8VBn6y2VWiU3uaHb6olRIQKVvL2ZGsw9
 oPK6L4fLd0mBmNZM3TIcTbminRt0OOL+e5QzD29IoPXlzF+LCg4VGtnqWujWOnPw4eRoSn
 /ZP00jmMJA6ZEi7hBI3VB7gpbDS+V8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743155870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As4+B8YmPi0hZdGGrM8ai0yEjD4LiNyPWnZEPc6VK0E=;
 b=9Z5xKhsz0lLIg3WvgKAXIHCdYJ+afFUDN9jM2D2ZKE5K+i9lGt8sGnw773tbC7cVNoWvbC
 ym3Bj7seN9icOLAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743155870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As4+B8YmPi0hZdGGrM8ai0yEjD4LiNyPWnZEPc6VK0E=;
 b=MVXI/kOFTNrYdTPfZzhllTzEX+EDCgu1Khjc8Q8VBn6y2VWiU3uaHb6olRIQKVvL2ZGsw9
 oPK6L4fLd0mBmNZM3TIcTbminRt0OOL+e5QzD29IoPXlzF+LCg4VGtnqWujWOnPw4eRoSn
 /ZP00jmMJA6ZEi7hBI3VB7gpbDS+V8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743155870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As4+B8YmPi0hZdGGrM8ai0yEjD4LiNyPWnZEPc6VK0E=;
 b=9Z5xKhsz0lLIg3WvgKAXIHCdYJ+afFUDN9jM2D2ZKE5K+i9lGt8sGnw773tbC7cVNoWvbC
 ym3Bj7seN9icOLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CD33139D4;
 Fri, 28 Mar 2025 09:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OC83Ap5y5mcWHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Mar 2025 09:57:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Mar 2025 10:57:43 +0100
Message-ID: <20250328095747.169011-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328095747.169011-1-pvorel@suse.cz>
References: <20250328095747.169011-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/5] doc/Makefile: Remove also metadata/ltp.json
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
Cc: =?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Because there is no detection whether tests changed it's better to
remove JSON file on metadata cleanup.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in previous version.

 doc/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/Makefile b/doc/Makefile
index a07df04d5c..3c5682ad00 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -15,4 +15,5 @@ spelling:
 	sphinx-build -b spelling -d build/doctree . build/spelling
 
 clean:
-	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl
+	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
+		${abs_top_builddir}/metadata/ltp.json
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
