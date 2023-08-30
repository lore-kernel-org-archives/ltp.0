Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47AFC83F01
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 12:22:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FA303CC005
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 14:22:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B19E3C5DFD
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 14:21:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D54FB1000987
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 14:21:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 599DB2185F;
 Wed, 30 Aug 2023 12:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693398112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zsf4PC0cUJvONnTVszq1fYS8gURhBK3QVDiAnwMWMJk=;
 b=eqjsZ73bKPGvgC3FcHaYwKsokc+DuVJ8ZN1v4K4OwkvD2juFZt8SQDxZyqRleAaFcwOWE+
 ELUszsexr9h26efRbP0fo3cNwPxd/XoVrlWI12j0HfqUo/84jhc45txKEJptv2nV4g46Z9
 XdOaKsncI+YbRrXvNhX6Ra2/ADYFRDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693398112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zsf4PC0cUJvONnTVszq1fYS8gURhBK3QVDiAnwMWMJk=;
 b=PER9rdtmjj5QkvIDIgjyK95gtkshBcLJOGcJ2fSaSVJGNnCxxgpMbN5r1PCpPQsmdeRXl5
 laSstHZq3AeZkRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FFB11353E;
 Wed, 30 Aug 2023 12:21:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NG5tBl8072T2QgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 30 Aug 2023 12:21:51 +0000
Date: Wed, 30 Aug 2023 14:21:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZO80SpyyoMYQT0Ik@rei>
References: <20230824074406.1129-1-akumar@suse.de>
 <20230824074406.1129-2-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230824074406.1129-2-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/mmap06: Refactor and add scenarios
 for EACCES test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with minor changes, thanks.

- sizeof(char) == 1 again
- first mmap() parameter is pointer, hence should be NULL
- there is no point in printing the TERRNO if mmap() succeeded
- LKML coding style prefers curly braces around else block if they are
  around the if block

diff --git a/testcases/kernel/syscalls/mmap/mmap06.c b/testcases/kernel/syscalls/mmap/mmap06.c
index 05e0ffc69..012e7de41 100644
--- a/testcases/kernel/syscalls/mmap/mmap06.c
+++ b/testcases/kernel/syscalls/mmap/mmap06.c
@@ -36,7 +36,7 @@ static void setup(void)
 	char *buf;
 
 	page_sz = getpagesize();
-	buf = SAFE_CALLOC(page_sz, sizeof(char));
+	buf = SAFE_MALLOC(page_sz);
 	memset(buf, 'A', page_sz);
 
 	fd = SAFE_OPEN(TEMPFILE, O_WRONLY | O_CREAT, 0666);
@@ -48,15 +48,16 @@ static void run(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
 
-	TESTPTR(mmap(0, page_sz, tc->prot, tc->flags, fd, 0));
+	TESTPTR(mmap(NULL, page_sz, tc->prot, tc->flags, fd, 0));
 
 	if (TST_RET_PTR != MAP_FAILED) {
-		tst_res(TFAIL | TERRNO, "mmap() was successful unexpectedly");
+		tst_res(TFAIL, "mmap() was successful unexpectedly");
 		SAFE_MUNMAP(TST_RET_PTR, page_sz);
-	} else if (TST_ERR == EACCES)
+	} else if (TST_ERR == EACCES) {
 		tst_res(TPASS, "mmap() failed with errno EACCES");
-	else
+	} else {
 		tst_res(TFAIL | TERRNO, "mmap() failed but unexpected errno");
+	}
 }
 
 static void cleanup(void)

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
