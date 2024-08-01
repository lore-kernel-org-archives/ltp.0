Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C8BC3DA64
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:10:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 495763D1F45
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:10:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 873B83D1073
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:08:53 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CA6A31400E03
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:08:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5026F219E3;
 Thu,  1 Aug 2024 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722514130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwxL6x9ojNMWLGfxd169k0V4S3vAdbUcoqM0qDs6LXc=;
 b=oHsL0Pa0UrxffrGThGB35FexzJ4U06uYARpLm7Zta81W6/oVVj85YWGZwg8pikx4328M4Q
 Y3wLnWUBKPYm0WkzWRL/83s46EuhoxqSwUvS3rMGI/3Z+OEqmMjCsxAc8dEsbknw7+S9ef
 hCRtaz1Z8Qm2dw9AjqvDRCdc8yN/ZOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722514130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwxL6x9ojNMWLGfxd169k0V4S3vAdbUcoqM0qDs6LXc=;
 b=QlNJzoyovLFvp/8HQyNTcr9ZMee7Z6Muv3ZHFi5fNxNEae3ScoAyBNb9jzu+byDqH23pcS
 YJhmvDBdSL9n98CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722514130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwxL6x9ojNMWLGfxd169k0V4S3vAdbUcoqM0qDs6LXc=;
 b=oHsL0Pa0UrxffrGThGB35FexzJ4U06uYARpLm7Zta81W6/oVVj85YWGZwg8pikx4328M4Q
 Y3wLnWUBKPYm0WkzWRL/83s46EuhoxqSwUvS3rMGI/3Z+OEqmMjCsxAc8dEsbknw7+S9ef
 hCRtaz1Z8Qm2dw9AjqvDRCdc8yN/ZOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722514130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwxL6x9ojNMWLGfxd169k0V4S3vAdbUcoqM0qDs6LXc=;
 b=QlNJzoyovLFvp/8HQyNTcr9ZMee7Z6Muv3ZHFi5fNxNEae3ScoAyBNb9jzu+byDqH23pcS
 YJhmvDBdSL9n98CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B1C713946;
 Thu,  1 Aug 2024 12:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8OrkA9J6q2aiVwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 12:08:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 14:08:39 +0200
MIME-Version: 1.0
Message-Id: <20240801-landlock-v5-2-663d7383b335@suse.com>
References: <20240801-landlock-v5-0-663d7383b335@suse.com>
In-Reply-To: <20240801-landlock-v5-0-663d7383b335@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=805;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=I5hW96VlmW8BZ5/r39V5osTTOpFT20UL1w7cD37/4bg=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq3rQDiYu5M00P3PYicHMpqPKxO4ZwzrCyioiL
 umEBlU+DQqJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqt60AAKCRDLzBqyILPm
 RkUbC/wOzrKyaSzzS2xH4qNpf1qQieCbIV3HEzirT8F6xbW/MdtG2rt3qjEI7GrmY4VE7DchCLU
 DQ7Z2eQPnqE5ThvkedSvC5STiO5qp9eZDLGWLabjEB0WV53aabqr4iVmrCd5kg1W1R+CdXr569Q
 3H2un6v6ZI0vgSsAVX7RbKky3jRgkMAboSuAGMl2RxXXWjNan4DAfqUMvnF6M0faV72BwqoQOyo
 cY5EqWvBF3K71uFDtSvFRUeXzL2bBkhlANXFWx/TjyCaLyHfZai6vPXF7iJNN7PYvayxHlXxye3
 xAQZfly/Ia/YnJKKUb66fgmJN8kz/UI5mq9reGbZdUvpRihyh39A/uF5bljCZ7H6mggy4jYI9kC
 5Sid6zpkfXVZ7SIv4Q7ioZ6q75oKcPEw8ai9KUeo/c6w2bLHStey693VDA81yXoANNor+sjaKU/
 mXvnU7t4huHHNopt6dYsYXK9VdRvdSJpi4l2S1eRm1zzhYD9ITj9w+fNZQaqGIp31pMOQ=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/6] Add CAP_MKNOD fallback in lapi/capability.h
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

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/capability.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 2b593797c..0f317d6d7 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -44,14 +44,18 @@
 # define CAP_SYS_TIME         25
 #endif
 
-#ifndef CAP_AUDIT_READ
-# define CAP_AUDIT_READ       37
-#endif
-
 #ifndef CAP_SYS_RESOURCE
 # define CAP_SYS_RESOURCE     24
 #endif
 
+#ifndef CAP_MKNOD
+# define CAP_MKNOD            27
+#endif
+
+#ifndef CAP_AUDIT_READ
+# define CAP_AUDIT_READ       37
+#endif
+
 #ifndef CAP_BPF
 # define CAP_BPF              39
 #endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
