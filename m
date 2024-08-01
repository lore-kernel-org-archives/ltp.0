Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6156C3DA64
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:09:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4054D3D1F4F
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:09:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D7F33D1073
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:08:52 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0ED1F608A7C
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:08:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 12211219E2;
 Thu,  1 Aug 2024 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722514130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fk/d4E103Y5ZE19EPXSdP91vreryAA0nYQGgMSXVuQM=;
 b=kecVvDhyR//cVyiWDoWZcMuVyYrzc/dqCA+ug8c2nKYNeHEquraYtTDmUjDFiebOTPFW2d
 drkETjWuxE+1+wM1fHSAtX70NDVl/X4Rh8Y5fAEcxpUo8hAjnBm5m8NLiUi26gi944niV/
 /G/hAv7jmYu7G+E7JomT/wAZacmGg+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722514130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fk/d4E103Y5ZE19EPXSdP91vreryAA0nYQGgMSXVuQM=;
 b=6igLIo3TQ6LEE+uESafQu7teVZuYVOOMy+/ZjmIw38vQptN9Qv3RfGakeWnHRIOpXTsikv
 ZljgLBFgO6IObgBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722514130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fk/d4E103Y5ZE19EPXSdP91vreryAA0nYQGgMSXVuQM=;
 b=kecVvDhyR//cVyiWDoWZcMuVyYrzc/dqCA+ug8c2nKYNeHEquraYtTDmUjDFiebOTPFW2d
 drkETjWuxE+1+wM1fHSAtX70NDVl/X4Rh8Y5fAEcxpUo8hAjnBm5m8NLiUi26gi944niV/
 /G/hAv7jmYu7G+E7JomT/wAZacmGg+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722514130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fk/d4E103Y5ZE19EPXSdP91vreryAA0nYQGgMSXVuQM=;
 b=6igLIo3TQ6LEE+uESafQu7teVZuYVOOMy+/ZjmIw38vQptN9Qv3RfGakeWnHRIOpXTsikv
 ZljgLBFgO6IObgBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3E5213ADB;
 Thu,  1 Aug 2024 12:08:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MMaIMNF6q2aiVwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 12:08:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 14:08:38 +0200
MIME-Version: 1.0
Message-Id: <20240801-landlock-v5-1-663d7383b335@suse.com>
References: <20240801-landlock-v5-0-663d7383b335@suse.com>
In-Reply-To: <20240801-landlock-v5-0-663d7383b335@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=lEb4RXtUvB+vkg/DUtniB4MEsUe79+7QaMidd1Qk3qg=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq3rQmvdNVQCbpK9R9NOzhoPnwYTIcnUHZd4tf
 SWMT38cCfKJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqt60AAKCRDLzBqyILPm
 RhOqDACkr93P8fLv5DACzriRLX4nk3sUOCXvD6Wt6P4ff1lIB/D0aey32GcbfRKFHgM0wQIEiFQ
 ABamoek3uC5TAQkdOXXCtILHgiRrFFXJ117+vBICqbQB36qR8+aBrkZ2e+S5dEhnj61DMt2PctJ
 RjY+xnn4A+YdNXJv+tAetqRW8msASc/n61z8ofyhHw/Il8GGUcS/nBixIgZdHiWUWrgpSe/Cy5R
 uqTBgTk1JoM9f1hlHc/rRXNDDMFCRPstnhBH+DgbvEYjGeN8oC1Waxyn70lCYG0x1+Fg4gWVn8n
 UxNZCnHyBdAj1bI7OlP9PbdvpfXhvukGMntU27Yw5yBouuOqMc1YZyv2FMIldBvfyo/oTmu52I5
 VXSJqaKwkUiF9MeZm1FjG29qqWvdU/FPtwRoxgRa7RN8EsijQ1IuXxHsCV7WBDZE3lwzJv0xf63
 IBxLnY4uj0DYeOO9iTRgvpru9IUkepmdzR6IlLou+fHbI9NZ1YeDCxbaqJKKmWkPBJxws=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-1.10 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/6] Get ABI version from landlock common library
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

Return the ABI version when verify_landlock_is_enabled() is called.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/landlock/landlock_common.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock_common.h b/testcases/kernel/syscalls/landlock/landlock_common.h
index 66f8fd19a..1d3864934 100644
--- a/testcases/kernel/syscalls/landlock/landlock_common.h
+++ b/testcases/kernel/syscalls/landlock/landlock_common.h
@@ -10,7 +10,7 @@
 #include "lapi/fcntl.h"
 #include "lapi/landlock.h"
 
-static inline void verify_landlock_is_enabled(void)
+static inline int verify_landlock_is_enabled(void)
 {
 	int abi;
 
@@ -28,6 +28,8 @@ static inline void verify_landlock_is_enabled(void)
 	}
 
 	tst_res(TINFO, "Landlock ABI v%d", abi);
+
+	return abi;
 }
 
 static inline void apply_landlock_rule(

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
