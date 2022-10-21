Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4736ECDFA1
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 22:58:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9161D3CB264
	for <ltp@archiver.kernel.org>; Sat, 22 Oct 2022 00:58:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9743A3CB171
 for <ltp@lists.linux.it>; Sat, 22 Oct 2022 00:58:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A28C320004F
 for <ltp@lists.linux.it>; Sat, 22 Oct 2022 00:58:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F6F3219DB;
 Fri, 21 Oct 2022 22:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666393121;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wU2EcKN+Eb8O/Y0o1EBUsrQk3iBEPBS3I869j3rG1EM=;
 b=JTPKArS1i7IMSfJjyRNtLFryXjVcwLVfG1skrW+uQNf8K6F+T0Kv5t92A1xh1aOibL51V8
 6H1MrSeCwCxv5fQ7sqnISioKFYfc2Tu+JG5nzUzukBCRHPgGQnwEwdnAQfOA2pB4K7iXGi
 D5HmXgKSto91esi7xYU1Gn22b3OUwsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666393121;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wU2EcKN+Eb8O/Y0o1EBUsrQk3iBEPBS3I869j3rG1EM=;
 b=ipj/r2CEyyyutQY+86wDJxR+M5dVaIe1thaLCza0vmT8AWODytFa01bzEsqIx68V9XU/e1
 yhphXQ5j8FZQR3DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F4FB1331A;
 Fri, 21 Oct 2022 22:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HgLMDSEkU2PDAwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Oct 2022 22:58:41 +0000
Date: Sat, 22 Oct 2022 00:58:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <Y1MkHzCOXZYzomH/@pevik>
References: <20221012064929.4725-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221012064929.4725-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsgid01: Rewrite using new LTP API
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

Hi Avinesh,

> Rewrite using new API and add test setfsgid(-1) which will always
> fail but will determine if the preceding setfsgid() call changed
> the filesystem group ID as expected.
+1

Thanks, merged with fix below.

> -		gid = getegid();
> -		GID16_CHECK(gid, setfsgid, cleanup);
> -
> -		TEST(SETFSGID(cleanup, gid));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO,
> -				"setfsgid() failed unexpectedly");
> -			continue;
> -		}
> -
> -		if (TEST_RETURN != gid) {
> -			tst_resm(TFAIL, "setfsgid() returned %ld, expected %d",
> -				 TEST_RETURN, gid);
> -		} else {
> -			tst_resm(TPASS,
> -				"setfsgid() returned expected value : %ld",
> -				TEST_RETURN);
> -		}
> -	}
...
> +	gid = getegid();
> +	GID16_CHECK(gid, setfsgid);

> -static void cleanup(void)
> -{
> +	SAFE_SETEUID(0);
> +	TST_EXP_VAL(setfsgid(nobody_gid), gid);
> +	TST_EXP_VAL(setfsgid(-1), nobody_gid);
> +	TST_EXP_VAL_SILENT(setfsgid(gid), nobody_gid);

NOTE: all of these needed to be SETFSGID(), otherwise setfsgid01_16 would
happily test 32-bit version instead of 16-bit version.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
