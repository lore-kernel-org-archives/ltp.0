Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6459CCF9E5
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 15:10:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2809F3C4F19
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 16:10:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 856AC3C0756
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 16:10:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F1BD660029E
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 16:10:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E9E621A7A;
 Mon, 27 Oct 2025 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761577816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DchqwOKr+u7z54xYeQnHOcpFaCA0FEMLCRM00RNskIw=;
 b=BnU+sIiIh20BWW8thpUkNoFIbLSBExJjVFzRcqPWRXhiNVrxhVxUvTYz0YVl4L0MJMNh/r
 tn35qobCFF1OUP85CEj5B/ji5xxjjCP4MUz4ikYVzzLN1TtxVuGY//9/jXCP1edz3sIB1b
 BbRafWoiFUESNuMlOpHDJAWhXyX+OBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761577816;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DchqwOKr+u7z54xYeQnHOcpFaCA0FEMLCRM00RNskIw=;
 b=4Hrv06VZQINZev2Qf1/fafe7dDCzZRuFEE11EB3/j1hAaClaUlSW02ae+v8LinmDFwKA8A
 j4cDZAKK6rbtQ5Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761577815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DchqwOKr+u7z54xYeQnHOcpFaCA0FEMLCRM00RNskIw=;
 b=CySKHhSWCnDrHFt8O6WIfZ/LkXdoC1bQbwoXGkD3+epmOraS4SRg0v5YGGMeAt+NKM6OmR
 htCvC0kJc6JgnZuyA3KoYI75FB84By6ubPKPtreGbQa8l/dGzok1i5rFF8I2LdZXAirK5P
 nzu+TBFHnxt8nBZ8C9H0fRaPNZIlbi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761577815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DchqwOKr+u7z54xYeQnHOcpFaCA0FEMLCRM00RNskIw=;
 b=YNzDeN2YcHl11IJGIj+vWigysKst5ZcXTxyGYlo2oPfnhVxOy419L2rugozWeYRcI1W6cc
 QjkkteclM1a/7KBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77404136CF;
 Mon, 27 Oct 2025 15:10:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B5+2G1eL/2gyOgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 27 Oct 2025 15:10:15 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 Oct 2025 16:09:24 +0100
Message-ID: <20251027150924.17679-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linaro.org:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib/tst_test: Fix FS kernel supported check
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

In case that there is only single filesystem defined in
tst_test.filesystems we format the device in the setup rather in the
function that iterates over all filesystems. However we missed a check
if a filesystem is supported in this shortcut, hence if mkfs for the
filesystem was installed and kernel support was missing the test failed
when it attempted to mount the filesystem.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index b8894f782..d49f34623 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1530,6 +1530,10 @@ static void do_setup(int argc, char *argv[])
 		tdev.fs_type = default_fs_type();
 
 		if (!tst_test->all_filesystems && count_fs_descs() <= 1) {
+
+			if (!tst_fs_is_supported(tdev.fs_type))
+				tst_brk(TCONF, "The %s filesystem is not supported", tdev.fs_type);
+
 			if (tst_test->filesystems && tst_test->filesystems->mkfs_ver)
 				tst_check_cmd(tst_test->filesystems->mkfs_ver, 1);
 
-- 
2.49.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
