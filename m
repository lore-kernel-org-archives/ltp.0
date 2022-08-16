Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E914C2BB41
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 06:57:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7BB03C9836
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 08:57:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44D8D3C972C
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 08:57:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A73B76005CC
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 08:57:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F4EB1F9B9;
 Tue, 16 Aug 2022 06:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660633056;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l1S3+SLAOvsJQr5AH/0SCd92/UZqL9QqOd9Yq4T3otw=;
 b=ZsG+bXg8CVuwVsJhvMcrdwLXxhZmVwXMA58ZBsaEiHv5X4eJnFvgeBXr2m7NgwE1NlGBZM
 NY/DVF6Zb4HiRl9KLPDFEeDWgLWL1fbBl+EQkF1X+wNV3NOfqDBpcU2fOusNx/0GW8GrbF
 BN0dyTnhXaYTex61OOUfQC6ASx514DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660633056;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l1S3+SLAOvsJQr5AH/0SCd92/UZqL9QqOd9Yq4T3otw=;
 b=Yn4DwkThGlH/u/oE6O0XVBSucg7OiBrlCFCejDqyIraN6gHIH5loIBdlZ0efz3N6Yfwc6a
 2u8m/sNxGAffQSBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19F53139B7;
 Tue, 16 Aug 2022 06:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tVAfBOA/+2I/OAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 16 Aug 2022 06:57:36 +0000
Date: Tue, 16 Aug 2022 08:57:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yvs/3gBnn/FGyAyq@pevik>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com>
 <YvnqZfyByO42kAX9@pevik>
 <09a4ff13-eaf1-6a97-f868-893c56ac6b4c@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <09a4ff13-eaf1-6a97-f868-893c56ac6b4c@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> >> Why here is nobody_gid?

> >>> +		SAFE_SETGID(nobody_gid);
> >>> +		SAFE_SETREUID(-1, nobody_uid);

> >> What problem do you meet?

> > Using original code SAFE_SETREUID(nobody_uid, nobody_gid);
> > causes mount03_setuid_test to fail (exit 1).
> > The same code is in creat08.c, creat09.c, open10.c.
> > Did I answer your question?

> I look mount03_setuid_test code today, nosuid mount option should
> expect setuid failed when using a non-privileged user even this program 
> has set-user-id bit.

> Old api also think PASS when mount03_setuid_test exit 1

Ah, thanks for catching my error!

> So I think you should use  SAFE_SETREUID(nobody_uid, nobody_uid);
> and then use code as below:

> 	if (WIFEXITED(status)) {
> 		switch (WEXITSTATUS(status)) {
> 		case EXIT_FAILURE:
> 			tst_res(TPASS, "%s passed", TESTBIN);
> 			return;
> 		case EXIT_SUCCESS:
> 			tst_res(TFAIL, "%s failed", TESTBIN);
> 			return;
> 		default:
> 		case TBROK:
> 			break;
> 		}
I guess we can drop the default and TBROK part, right?
It's caught later by tst_brk(TBROK, ...)
> 	}

https://github.com/pevik/ltp/blob/22652d668a5ccbf3c7aa835c2dab6d0eb6058ba2/testcases/kernel/syscalls/mount/mount03.c#L74-L105

static void test_nosuid(void)
{
	pid_t pid;
	int status;
	struct stat st;

	SAFE_CP(TESTBIN, BIN_PATH);
	SAFE_STAT(BIN_PATH, &st);
	if (st.st_mode != SUID_MODE)
		SAFE_CHMOD(BIN_PATH, SUID_MODE);

	pid = SAFE_FORK();
	if (!pid) {
		SAFE_SETREUID(nobody_uid, nobody_uid);
		SAFE_EXECL(BIN_PATH, TESTBIN, NULL);
	}

	SAFE_WAITPID(pid, &status, 0);

	if (WIFEXITED(status)) {
		switch (WEXITSTATUS(status)) {
		case EXIT_FAILURE:
			tst_res(TPASS, "%s passed", TESTBIN);
			return;
		case EXIT_SUCCESS:
			tst_res(TFAIL, "%s failed", TESTBIN);
			return;
		}
	}

	tst_brk(TBROK, "Child %s", tst_strstatus(status));
}

Kind regards,
Petr

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
