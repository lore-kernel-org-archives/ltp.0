Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC65C4332F
	for <ltp@archiver.kernel.org>; Thu, 22 Dec 2022 09:49:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C75513CB9B0
	for <ltp@archiver.kernel.org>; Thu, 22 Dec 2022 10:49:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51EA23C327F
 for <ltp@lists.linux.it>; Thu, 22 Dec 2022 10:49:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A793960094C
 for <ltp@lists.linux.it>; Thu, 22 Dec 2022 10:49:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81DAD77178;
 Thu, 22 Dec 2022 09:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671702574;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nDDM8Wvxy1oK/zWyEJUIspYMbSo+bbGHs3OvJQ/cGJ4=;
 b=hXLI4/Epc5lCbI+WfOwnjscH/O/wpwxO6shqE8DsCCYibWLTb4xaEkHkCALLOmUIMft70n
 8Hydhr6c3nSwWag2LMH72CEpBh7c+Jpc5CkENqxaXewaqcOBrrTQOH3brt1cnNf6uW/Qs2
 kQAY/w83JMTsClPBgGbl45J51uXBQYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671702574;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nDDM8Wvxy1oK/zWyEJUIspYMbSo+bbGHs3OvJQ/cGJ4=;
 b=Gdfjl1WK9smJP3GNVEcD7B95xgFLMTDci3WOhY5J9C5vY1r6Pj1il9+ZAqpDrLfReRu02Z
 TjdBBj/75yCZXyDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5996B138FD;
 Thu, 22 Dec 2022 09:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PG1kFC4opGOATwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 22 Dec 2022 09:49:34 +0000
Date: Thu, 22 Dec 2022 10:49:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y6QoLAfvY/W175WH@pevik>
References: <Y5xF6PU5Yvh+oku5@pevik> <20221220075714.28762-1-akumar@suse.de>
 <87a63ith0b.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a63ith0b.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] statvfs01: Convert to new LTP API
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh, Richie,

Generally LGTM, thanks for fixing exfat and vfat.

> > +	toolong_fname = SAFE_MALLOC(buf.f_namemax + 1);
However, length could be smaller:
Instead using buf.f_namemax + 1 (1531) also for exfat and vfat,
invalid length is already buf.f_namemax / NLS_MAX_CHARSET_SIZE + 1 (256).

> > +	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
> > +		valid_fname = SAFE_MALLOC(buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1);
> > +	else
> > +		valid_fname = SAFE_MALLOC(buf.f_namemax - 1);

> > -		if (TEST_RETURN == -1) {
> > -			tst_resm(TFAIL | TTERRNO, "statvfs(%s, ...) failed",
> > -				 TEST_PATH);
> > -		} else {
> > -			tst_resm(TPASS, "statvfs(%s, ...) passed", TEST_PATH);
> > -		}
> > +	memset(toolong_fname, 'b', buf.f_namemax + 1);
> > +	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
> > +		memset(valid_fname, 'a', buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1);
> > +	else
> > +		memset(valid_fname, 'a', buf.f_namemax - 1);
Also valid length is for buf.f_namemax, not buf.f_namemax - 1. I guess -1 is for
\0 (NULL terminator), but tests work even with just buf.f_namemax.

Also adding variable to hold the length makes source more readable.
How about this?

	struct statvfs buf;
	char *valid_fname, *toolong_fname;
	long fs_type;
	long valid_len;

	fs_type = tst_fs_type(TEST_PATH);

	TST_EXP_PASS(statvfs(TEST_PATH, &buf));

	valid_len = buf.f_namemax;
	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
		valid_len = buf.f_namemax / NLS_MAX_CHARSET_SIZE;

	valid_fname = SAFE_MALLOC(valid_len);
	memset(valid_fname, 'a', valid_len);

	toolong_fname = SAFE_MALLOC(valid_len + 1);
	memset(toolong_fname, 'b', valid_len + 1);

Final diff is below.

Kind regards,
Petr

diff --git testcases/kernel/syscalls/statvfs/statvfs01.c testcases/kernel/syscalls/statvfs/statvfs01.c
index 034835da7d..f357855eb1 100644
--- testcases/kernel/syscalls/statvfs/statvfs01.c
+++ testcases/kernel/syscalls/statvfs/statvfs01.c
@@ -25,22 +25,21 @@ static void run(void)
 	struct statvfs buf;
 	char *valid_fname, *toolong_fname;
 	long fs_type;
+	long valid_len;
 
 	fs_type = tst_fs_type(TEST_PATH);
 
 	TST_EXP_PASS(statvfs(TEST_PATH, &buf));
 
-	toolong_fname = SAFE_MALLOC(buf.f_namemax + 1);
+	valid_len = buf.f_namemax;
 	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
-		valid_fname = SAFE_MALLOC(buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1);
-	else
-		valid_fname = SAFE_MALLOC(buf.f_namemax - 1);
+		valid_len = buf.f_namemax / NLS_MAX_CHARSET_SIZE;
 
-	memset(toolong_fname, 'b', buf.f_namemax + 1);
-	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
-		memset(valid_fname, 'a', buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1);
-	else
-		memset(valid_fname, 'a', buf.f_namemax - 1);
+	valid_fname = SAFE_MALLOC(valid_len);
+	memset(valid_fname, 'a', valid_len);
+
+	toolong_fname = SAFE_MALLOC(valid_len + 1);
+	memset(toolong_fname, 'b', valid_len + 1);
 
 	TST_EXP_FD(creat(valid_fname, 0444));
 	SAFE_CLOSE(TST_RET);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
