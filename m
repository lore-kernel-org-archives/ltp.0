Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A0DC83F14
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 12:51:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF6693CC005
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 14:51:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D8763C5DFD
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 14:51:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BE28C60042C
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 14:51:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 997C61F74D;
 Wed, 30 Aug 2023 12:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693399887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w5ZoF1jwICw2RBH6OLpFHHUXVko/v9mrg5NRvCz+NT8=;
 b=2XVTpLUAOWheUzTd9xxKiCSD4JdwvUZTL3nZoUz3Wz0N7Nlz4GYZ8QJwWP15M+nbA5w6rD
 loEf/LtYfUii/Ki7kAljSqpvpbL7VMXsoVXSSCaa28xs540i+UQrO++8Izknzz5agtZXl2
 KmLtYjFftFnzdaiHbMGwhs40D49r8yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693399887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w5ZoF1jwICw2RBH6OLpFHHUXVko/v9mrg5NRvCz+NT8=;
 b=Y60/KUH/sd3S28+Yh0dTFMzsFxSE0EyxT37uLITQxuCZ10L/14N22nhUaR86zsdjpr2v98
 UkWEn5HcYXQIjVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 952541353E;
 Wed, 30 Aug 2023 12:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9Q1AEk4772RKVAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 30 Aug 2023 12:51:26 +0000
Date: Wed, 30 Aug 2023 14:51:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZO87OQ7ZC3QMIIZ9@rei>
References: <20230825063932.30875-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230825063932.30875-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] syscalls/mmap08: Rewrite the test using new
 LTP API
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
Pushed with a minor changes, thanks.

Apart from changes similar to the previous tests I've also removed the
whole part that writes the file. There is no point in writing the file
if we are closing the fd before we pass it to the mmap() since the fd is
no longer associated with the file content. So now the test just open
and closes file and then uses that fd as an invalid one.

Full diff:

--- a/testcases/kernel/syscalls/mmap/mmap08.c
+++ b/testcases/kernel/syscalls/mmap/mmap08.c
@@ -21,30 +21,22 @@ static int fd;
 
 static void setup(void)
 {
-	char *buf;
-
-	page_sz = getpagesize();
-
-	buf = SAFE_CALLOC(page_sz, sizeof(char));
-	memset(buf, 'A', page_sz);
-
 	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
-	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, page_sz);
-	free(buf);
 	SAFE_CLOSE(fd);
 }
 
 static void run(void)
 {
-	TESTPTR(mmap(0, page_sz, PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0));
+	TESTPTR(mmap(NULL, page_sz, PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0));
 
 	if (TST_RET_PTR != MAP_FAILED) {
 		tst_res(TFAIL, "mmap() passed unexpectedly");
 		SAFE_MUNMAP(TST_RET_PTR, page_sz);
-	} else if (TST_ERR == EBADF)
+	} else if (TST_ERR == EBADF) {
 		tst_res(TPASS, "mmap() failed with EBADF");
-	else
+	} else {
 		tst_res(TFAIL | TERRNO, "mmap() failed with an invalid errno");
+	}
 }
 
 static void cleanup(void)


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
