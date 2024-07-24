Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F65C3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:46:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C16D3D1C0A
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 11:46:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53FA73D1B59
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:46:08 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C8E4814088EB
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:46:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B460F21B22;
 Wed, 24 Jul 2024 09:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721814366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wn4AUPCAINYbsjPHwo3Kzubjli8gEifZ3rcwEBGawAs=;
 b=Av7Q0snfWpUVmeHqRCBVeXXxjG0zVjY++hyfgTyieGtUXXFB6k6zlSy5/jUtNZIieizwKl
 nTa10njx1wJempD/vDxYKVBmy+Wn2oLwNkVRjNcGLHuMV35DgvHpAgShLsBbMVRXr10Va8
 8f0tRZ6x4U4IUzvj9rEyRsl8FS+qJCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721814366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wn4AUPCAINYbsjPHwo3Kzubjli8gEifZ3rcwEBGawAs=;
 b=NRBH3HhU80sAlSv7M99t8gVx6iDyV97uPPIk78muZX5sgeQMHD7Sme9NYZMBM5XsCj4Wmo
 7sXgeqjV14xCqXBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721814366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wn4AUPCAINYbsjPHwo3Kzubjli8gEifZ3rcwEBGawAs=;
 b=Av7Q0snfWpUVmeHqRCBVeXXxjG0zVjY++hyfgTyieGtUXXFB6k6zlSy5/jUtNZIieizwKl
 nTa10njx1wJempD/vDxYKVBmy+Wn2oLwNkVRjNcGLHuMV35DgvHpAgShLsBbMVRXr10Va8
 8f0tRZ6x4U4IUzvj9rEyRsl8FS+qJCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721814366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wn4AUPCAINYbsjPHwo3Kzubjli8gEifZ3rcwEBGawAs=;
 b=NRBH3HhU80sAlSv7M99t8gVx6iDyV97uPPIk78muZX5sgeQMHD7Sme9NYZMBM5XsCj4Wmo
 7sXgeqjV14xCqXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 164CC13411;
 Wed, 24 Jul 2024 09:46:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UOXUNl3NoGYxWwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 24 Jul 2024 09:46:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 24 Jul 2024 11:45:33 +0200
MIME-Version: 1.0
Message-Id: <20240724-fchmodat2-v3-3-1dc7cfc634b8@suse.com>
References: <20240724-fchmodat2-v3-0-1dc7cfc634b8@suse.com>
In-Reply-To: <20240724-fchmodat2-v3-0-1dc7cfc634b8@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=798;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=coG/Sr6m6VtDhSTp55MPcNGf3m9wsY63eAFVUcXpPYE=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmoM1EYAfd37PrirRCzD56BuG+U0oO0iSFjuEsP
 tp2zJhn//aJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqDNRAAKCRDLzBqyILPm
 RrP9C/0WmDWzph5dDp//kbHeRgzRj3VGlvSsXG5ZWJUoexUxfZWGCr5ozFurVB757c6vqEVl2j0
 1oDgLPbeh5apCIqVJvYo1q6JkylirVZETcyBoTvK6FtgzKeH5x8NYOtIniZrYM+d4CXGlz151Vo
 gQHcZ812+06n4d909mqrhzw6u2qvEC1Zk2Nx46n+S/Kisjshtn6znpcwgX0N3r1vz1mLdH3RVVj
 wdTDxliziA/tYkfbzQoEN4/iN+FpLDBHgop+ygUbImD26aN7mU4UNXoq1aMYKLsT4QnFp5g9/gw
 a11ZkZi2B6DkSpjTQx7SYdJNgWao4Fsxrf1R/I9HIwkK+uwYjZYMdzEYSFqO4LwEmawA51X77nh
 HybWNA6+Sr8uut8Qnr+piyV7dOxBP+QcGRuWMbCqppvTDkVkVZ7pekGRO7qTBAqsxybjiYW3z86
 GGh3f0PyiQ9FwFREgNgOJ8Sy4zueE5FpRWOkrcoCHwmytj9IjsIXBQ+9O4yt6cRP8tskY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/5] Add fchmodat2 fallback definition
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/stat.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 3606c9eb0..5e289d3ca 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -229,4 +229,17 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_ATTR_VERITY	0x00100000
 #endif
 
+static inline int fchmodat2(
+	int dfd, const char *filename, mode_t mode, int flags)
+{
+	int ret;
+
+	ret = tst_syscall(__NR_fchmodat2, dfd, filename, mode, flags);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "%s(%d,%s,%d,%d) error",
+			__func__, dfd, filename, mode, flags);
+
+	return ret;
+}
+
 #endif /* LAPI_STAT_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
