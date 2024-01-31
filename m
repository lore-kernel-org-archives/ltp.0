Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88231C47DDF
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 10:00:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 105FB3CE0A9
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 11:00:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20C0E3CB75C
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:00:21 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6DA261BBCF0B
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:00:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C70521EE2;
 Wed, 31 Jan 2024 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706695220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0c8pRARCo/Sgf6p6waNkVYu2bZl0F7rX4oAri/YEvI=;
 b=WfGyzusnjho55JHgt44bFiD5oiZ+Kpy84ajFFEEY1om9rLAwsuCUl0EWLe1N17RhgxlqFA
 iQXxwJKlcRtwfIt4mqdvc1jrEWtIiCOVqxKNFTN1AVXeFoXM+lO59/I4IvjLbEmXXh+BI1
 fUU0YChmyu2yA0V2MunowrjP0ptYlEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706695220;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0c8pRARCo/Sgf6p6waNkVYu2bZl0F7rX4oAri/YEvI=;
 b=2FT4JAwU1cQJ5w1MsdV8Q5CgN9WuyXHvCHZyzTjUkcDhATjTaJ9Uc+aNU9usrPkRM7t0YW
 IhCKxS02Xecj5/DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706695220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0c8pRARCo/Sgf6p6waNkVYu2bZl0F7rX4oAri/YEvI=;
 b=WfGyzusnjho55JHgt44bFiD5oiZ+Kpy84ajFFEEY1om9rLAwsuCUl0EWLe1N17RhgxlqFA
 iQXxwJKlcRtwfIt4mqdvc1jrEWtIiCOVqxKNFTN1AVXeFoXM+lO59/I4IvjLbEmXXh+BI1
 fUU0YChmyu2yA0V2MunowrjP0ptYlEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706695220;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0c8pRARCo/Sgf6p6waNkVYu2bZl0F7rX4oAri/YEvI=;
 b=2FT4JAwU1cQJ5w1MsdV8Q5CgN9WuyXHvCHZyzTjUkcDhATjTaJ9Uc+aNU9usrPkRM7t0YW
 IhCKxS02Xecj5/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4181413A7E;
 Wed, 31 Jan 2024 10:00:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mG1lDTQaumVPWAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 31 Jan 2024 10:00:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 11:00:17 +0100
Message-Id: <20240131100018.15767-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240131100018.15767-1-andrea.cervesato@suse.de>
References: <20240131100018.15767-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] Fix dio_append/aiodio_append tests
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

Ensure that dio_append and aiodio_append will end all children if
parent asked for it. The way we have to do it, is to ensure that
*run_child variable is checked before opening the file to read.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/io/ltp-aiodio/common.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
index 200bbe18e..9a2d27166 100644
--- a/testcases/kernel/io/ltp-aiodio/common.h
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -62,8 +62,12 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
 	int i;
 	int r;
 
-	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
+	while ((fd = open(filename, O_RDONLY, 0666)) < 0) {
+		if (!*run_child)
+			return;
+
 		usleep(100);
+	}
 
 	tst_res(TINFO, "child %i reading file", getpid());
 
@@ -102,8 +106,12 @@ static inline void io_read_eof(const char *filename, volatile int *run_child)
 	int fd;
 	int r;
 
-	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
+	while ((fd = open(filename, O_RDONLY, 0666)) < 0) {
+		if (!*run_child)
+			return;
+
 		usleep(100);
+	}
 
 	tst_res(TINFO, "child %i reading file", getpid());
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
