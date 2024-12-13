Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053C0E7717F
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 22:22:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93A9B3EB894
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 23:22:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33C743EB884
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:20:21 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 96EE010154C9
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 23:20:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D7C41F394;
 Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734128418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8/U+Ch2bJ8t8VQWtTlo5ySV+zmxuP8YmkpK5rGFIEU=;
 b=I2KBoSRU3A28VjUmCtweUXPQtKD8kw3s0X3tYQQ7zRe00S8BhPIS/3o8PaoFN5k01vOzb1
 mjh2DIGsEPVq68/EDPmrV7M3mZowcBOOwQR61Yv7XuK+Whykqg0lBHL5AX8/U64EVrlRQC
 ag9KiVJ20njVVMunaRVCLNRJJ5G4jTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734128418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8/U+Ch2bJ8t8VQWtTlo5ySV+zmxuP8YmkpK5rGFIEU=;
 b=ezCxDRs3P3b0AWXOUMfgCb4lTyOH2zV47vrUVUcS7U57vW65EoHPSY8mRNxVPP7h7PWBbr
 8YSYfynZeDFOVUAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734128417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8/U+Ch2bJ8t8VQWtTlo5ySV+zmxuP8YmkpK5rGFIEU=;
 b=ZqoDs/3MkizEcuKjrbV+FD2IPEzm5bBZiMEM2K8Mbr9vZ56oHSuFypN4uUNDrS20YSjM06
 mz6JYXT7OGUQY5Faj5rlulMDTQUQdeTsX7gfpSJTrJlv1yFBtShQPEM+EomRQlrwGh1hpV
 LMjzrzuHXvCltc5XvlMlW1G9xBwF8Nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734128417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8/U+Ch2bJ8t8VQWtTlo5ySV+zmxuP8YmkpK5rGFIEU=;
 b=6dIbI435E4eXn3Z8DtuW0sc3j2wFUVG92zKEzzYx99HqTW+CT2bqu7bpPrwEnN8J19dwHN
 nB2vKfQMrn+3A0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D4B813939;
 Fri, 13 Dec 2024 22:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CEUuESGzXGf5QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Dec 2024 22:20:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Dec 2024 23:20:07 +0100
Message-ID: <20241213222014.1580991-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213222014.1580991-1-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/8] IMA: Add TCB policy as an example for
 ima_measurements.sh
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Taken from IMA docs [1], removed dont_measure fsmagic=0x1021994 (tmpfs)
as suggested by Mimi.

[1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I would like to check in ima_measurements.sh for this policy as an
variant to ima_policy=tcb command line parameter. Do I need to check for
all of these (suppose all are in ima_policy=tcb).

 .../ima/datafiles/ima_measurements/tcb.policy | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy

diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
new file mode 100644
index 0000000000..1c919f7260
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/tcb.policy
@@ -0,0 +1,19 @@
+dont_measure fsmagic=0x9fa0
+dont_measure fsmagic=0x62656572
+dont_measure fsmagic=0x64626720
+dont_measure fsmagic=0x1cd1
+dont_measure fsmagic=0x42494e4d
+dont_measure fsmagic=0x73636673
+dont_measure fsmagic=0xf97cff8c
+dont_measure fsmagic=0x43415d53
+dont_measure fsmagic=0x27e0eb
+dont_measure fsmagic=0x63677270
+dont_measure fsmagic=0x6e736673
+dont_measure fsmagic=0xde5e81e4
+measure func=MMAP_CHECK mask=MAY_EXEC
+measure func=BPRM_CHECK mask=MAY_EXEC
+measure func=FILE_CHECK mask=^MAY_READ euid=0
+measure func=FILE_CHECK mask=^MAY_READ uid=0
+measure func=MODULE_CHECK
+measure func=FIRMWARE_CHECK
+measure func=POLICY_CHECK
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
