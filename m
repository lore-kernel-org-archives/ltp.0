Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA297606A31E
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cOif3zCl;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZIQtIpBI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cOif3zCl;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZIQtIpBI
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35BCA3E9156
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 07:02:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB47B3C84E1
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 07:01:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D96D960081C
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 07:01:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0778521FCB;
 Tue, 24 Nov 2026 06:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795500105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6Yh1GWXB948u9rz8DHhevIHZApOJpVmsLSiFbdrk9g=;
 b=cOif3zClEZFVZ/B1HQfq7RZfY3+2ZhCbvPHi6+occzzvyw29Cwt1CGPTZlv8p+ETfNhYtJ
 2rnn0Bxije/pEhS39TsqwvvvhMjsU+0exY7Jk7MmM1Z5H1MNzo8dRdJYo+3RUhj4MJJzRK
 IOTHgvx7WVZskuICWxONZwabeF61vZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795500105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6Yh1GWXB948u9rz8DHhevIHZApOJpVmsLSiFbdrk9g=;
 b=ZIQtIpBI1JLVFED9nn8jiCe1/xdoDs+6MEFGQENNir4eM1eKM4Imj6+5TDVOkwAOtA9K2b
 dlRsJGPfVVBEpbCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cOif3zCl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZIQtIpBI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795500105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6Yh1GWXB948u9rz8DHhevIHZApOJpVmsLSiFbdrk9g=;
 b=cOif3zClEZFVZ/B1HQfq7RZfY3+2ZhCbvPHi6+occzzvyw29Cwt1CGPTZlv8p+ETfNhYtJ
 2rnn0Bxije/pEhS39TsqwvvvhMjsU+0exY7Jk7MmM1Z5H1MNzo8dRdJYo+3RUhj4MJJzRK
 IOTHgvx7WVZskuICWxONZwabeF61vZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795500105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6Yh1GWXB948u9rz8DHhevIHZApOJpVmsLSiFbdrk9g=;
 b=ZIQtIpBI1JLVFED9nn8jiCe1/xdoDs+6MEFGQENNir4eM1eKM4Imj6+5TDVOkwAOtA9K2b
 dlRsJGPfVVBEpbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA83B1339F;
 Tue, 24 Nov 2026 06:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7JJNGkcoBWu0eAAAD6G6ig
 (envelope-from <gpathak@suse.de>); Tue, 24 Nov 2026 06:01:43 +0000
From: Gaurav Pathak <gpathak@suse.de>
To: Linux Test Project <ltp@lists.linux.it>
Date: Tue, 24 Nov 2026 11:31:25 +0530
Message-ID: <20261124-statx-atomic-write-v12-0-57e8b2dc4a18@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <awBmECbdo7iUCXPv@yuki.lan>
References: <awBmECbdo7iUCXPv@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Change-ID: 20261124-statx-atomic-write-14269476dc39
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=gaurav.pathak@suse.com;
 h=from:subject:message-id; bh=etIgM7j3Kaj82uwta/xivYukoEcH2VD2r4hjXKm3+AM=;
 b=owGbwMvMwCUWE1e4+dFlWS3G02pJDNmsaseTa+KX+H7Lc77y5eO97MB/SW1xMRx5b62PJ26+v
 Jld8L1hRykLgxgXg6yYIouxQrO431XmaltNTTmYOaxMIEMYuDgFYCIXGBn+p/x9ZzNhL9ea008N
 WH+VxqiX79KbIMYatP+BziYrUcUv8owMa89N1nhrUV6w6/LC1rvxfpOLCmvfM28Re9m7gX/FOZW
 fTAA=
X-Developer-Key: i=gaurav.pathak@suse.com; a=openpgp;
 fpr=332083174ED5037B3D29291E5C5E71B3E2D31D2A
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 0778521FCB
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 0/2] Subject: [PATCH v12] statx13: Add
 STATX_WRITE_ATOMIC test and helper macros
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Gaurav Pathak <gaurav.pathak@suse.com>, Gaurav Pathak <gpathak@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This series adds a new statx13 test to verify STATX_WRITE_ATOMIC
reporting and introduces reusable less-than and power-of-2 assertion
macros in tst_test_macros.h.

Changes in v12:
- include/tst_test_macros.h:
  - Add TST_EXP_LT_LU() and TST_EXP_LT_LU_SILENT() macros for less-than
    comparisons on unsigned long long values.
  - Add TST_EXP_POW2_LU() and TST_EXP_POW2_LU_SILENT() macros to verify
    that an unsigned long long value is a non-zero power of 2.
- statx13:
  - Replace manual TST_EXP_EXPR() and if/else validation checks with
    TST_EXP_LE_LU(), TST_EXP_LT_LU(), and TST_EXP_POW2_LU().
  - Shorten TCONF and TFAIL diagnostic messages in verify_statx() and
    setup().
  - Remove redundant explanatory comments in setup().
  - Drop redundant .needs_tmpdir = 1 from struct tst_test.

Signed-off-by: Gaurav Pathak <gaurav.pathak@suse.com>
---
Gaurav Pathak (2):
      syscalls/statx13: Add test for STATX_WRITE_ATOMIC on regular file
      statx13: Add LT/POW2 macros in tst_test_macros.h and simplify statx13 checks

 include/lapi/stat.h                        |  17 +-
 include/tst_test_macros.h                  | 111 +++++++++++
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/statx/.gitignore |   1 +
 testcases/kernel/syscalls/statx/statx13.c  | 296 +++++++++++++++++++++++++++++
 5 files changed, 425 insertions(+), 1 deletion(-)
---
base-commit: 3b962a950b3f37153a45bf1240d07d73ab07676e
change-id: 20261124-statx-atomic-write-14269476dc39

Best regards,
-- 
Gaurav Pathak <gaurav.pathak@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
