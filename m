Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C21C3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:31:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F6113D1F3B
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 16:31:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BBBA3D1EF3
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 16:30:03 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 35CFE1402F8E
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 16:30:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A972D219D0;
 Thu,  1 Aug 2024 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722522602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GiTOO/J3EOp8tZFFNNmPyT12gCaQH1/sGQlbsoHZjA0=;
 b=hGE8yGMsPoIWsnN1oqaW40+EoCk/YMeRG8/BAtLXeB2W6nBFgVS3zr3wkCjHVBhwhRk8ce
 crHJsGxAF8i6xAZyqW+1m4cV/j5EGzvOY8j77MXHTE3cOQ69R6PUx+iy5VxREDvKL4JBdY
 zJfJJVq6NBViASmGaokkORhz5FY1H/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722522602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GiTOO/J3EOp8tZFFNNmPyT12gCaQH1/sGQlbsoHZjA0=;
 b=4NaeQvSnQ6Z5R0r+BGpJhifzE2HCqOZK8F96d6AzSRnbcQM7irqme2aQ11yYrOnj/meN8u
 eRGZ6SOXXq2QlADQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722522602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GiTOO/J3EOp8tZFFNNmPyT12gCaQH1/sGQlbsoHZjA0=;
 b=hGE8yGMsPoIWsnN1oqaW40+EoCk/YMeRG8/BAtLXeB2W6nBFgVS3zr3wkCjHVBhwhRk8ce
 crHJsGxAF8i6xAZyqW+1m4cV/j5EGzvOY8j77MXHTE3cOQ69R6PUx+iy5VxREDvKL4JBdY
 zJfJJVq6NBViASmGaokkORhz5FY1H/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722522602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GiTOO/J3EOp8tZFFNNmPyT12gCaQH1/sGQlbsoHZjA0=;
 b=4NaeQvSnQ6Z5R0r+BGpJhifzE2HCqOZK8F96d6AzSRnbcQM7irqme2aQ11yYrOnj/meN8u
 eRGZ6SOXXq2QlADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5878F13946;
 Thu,  1 Aug 2024 14:30:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yNqED+qbq2Z2AwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 14:30:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 16:29:42 +0200
MIME-Version: 1.0
Message-Id: <20240801-fchmodat2-v4-3-7f2f11a53a09@suse.com>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
In-Reply-To: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=989;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=lwHjxHTqER240MD5y8g/17CQWRAgmHcYgBpsz03WA64=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq5vnRkd1rg2vI1JJ3vb7W8SbeTOoxsbyyrwkA
 62RIGmKT9mJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqub5wAKCRDLzBqyILPm
 RnNnC/9ItlC9pBYRHiqhjUCYAZYE0u5v4qSvV5oflqN/UbzOi2wSHzmh4da1G1MohOsn4n42UO8
 G9h9DYYnvVvGJOl1F19a0Xn4l32UojBop3fAEP8qy7P7FJ22wW5V6ifAUF5bTaCvdCHkJeJoQfm
 MS92Q9T98UppVTO5kd5dmHynF0IDKoZqgDiR7u0j56bFcoZNA7bb8zSdy9TzhDr6AZgdKm8iuy5
 9lrvJFJfYPQblL8IlR3L/XCj02dm+JDhBsIdI+OS4wOJQiQQGrEHHNkDN15Sn0//ROdhwcwMuVp
 zZL4QF+KPgh+7wvcAPT1ZY6+q/uMjzJ95o/79KoYkE8p+ZDNG2maLwzWvtgn5ttSKmLULjV3/AX
 0gCwkoHQcKtstAha0Du490umzvyagPs2H0pf9lJkHG8STn+ku8/HunW3zmGnK0Z5cmZRPsMWwQH
 lSpNPcxPLa+nvjOpnx88TfJWnzbmI+iHeTXxmT0QQQdQn9Xwje6EDFGqPMSUMqK7Z3LLY=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/5] Add fchmodat2 fallback definition
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
 include/lapi/stat.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 3606c9eb0..8e38ecfef 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -229,4 +229,20 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_ATTR_VERITY	0x00100000
 #endif
 
+#define SAFE_FCHMODAT2(dfd, filename, mode, flags) \
+	safe_fchmodat2(__FILE__, __LINE__, (dfd), (filename), (mode), (flags))
+
+static inline int safe_fchmodat2(const char *file, const int lineno,
+		int dfd, const char *filename, mode_t mode, int flags)
+{
+	int ret;
+
+	ret = tst_syscall(__NR_fchmodat2, dfd, filename, mode, flags);
+	if (ret == -1)
+		tst_brk_(file, lineno, TBROK | TERRNO, "%s(%d,%s,%d,%d) error",
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
