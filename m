Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189E9C0015E
	for <ltp@archiver.kernel.org>; Wed, 26 Jul 2023 12:50:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94B613CD72B
	for <ltp@archiver.kernel.org>; Wed, 26 Jul 2023 14:50:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EF003C8B4A
 for <ltp@lists.linux.it>; Wed, 26 Jul 2023 14:50:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5A1301A00215
 for <ltp@lists.linux.it>; Wed, 26 Jul 2023 14:50:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C6D81F88B;
 Wed, 26 Jul 2023 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690375809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9j25kFWlCsJBhL++NAe+5LgsETsIkiB6KLymnPX6hk=;
 b=IYwYW+1W8iaRhm0Vz1Ro4FQU4I+fWJCuJaBDnA3NhX93mHOHwoUJgrcjFGiskOOGxp1sGS
 B+WS6emA2ZyXuDSn9UnJ64xihAhJjUA8w4WeW0b3iDIGAPq3wYsuT64lCB6EoocDkEVN+0
 ad0L595qsCm++LzKI0LNEgCSyANTgg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690375809;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z9j25kFWlCsJBhL++NAe+5LgsETsIkiB6KLymnPX6hk=;
 b=nTP0irFhXVIhozzd4amfSTDdRK0GOL68iY5qAO1g9zl6i7fI6LtzSh24uAmx2zjsNT5DwN
 +jyv/c91Nb8n5SBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68A33139BD;
 Wed, 26 Jul 2023 12:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dTkxGIEWwWQrUgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Jul 2023 12:50:09 +0000
Date: Wed, 26 Jul 2023 14:51:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZMEWwCwC0DPrtdAi@yuki>
References: <1689760756-865-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1689760756-865-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1689760756-865-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/setgroups02: Convert to new API
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
> +	TEST(SETGROUPS(gidsetsize, groups_set));

TST_EXP_PASS(SETGROUPS(gidsetsize, groups_set)) ?

> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/*
> -		 * Call setgroups() to set supplimentary group IDs of
> -		 * the calling super-user process to gid of TESTUSER.
> -		 */
> -		TEST(SETGROUPS(cleanup, gidsetsize, groups_list));
> +	if (TST_RET < 0) {
> +		tst_res(TFAIL, "setgroups(%d, groups_set) Failed, "
> +			"errno=%d : %s", gidsetsize,
> +			TST_ERR, strerror(TST_ERR));
> +	}
>  
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL, "setgroups(%d, groups_list) Failed, "
> -				 "errno=%d : %s", gidsetsize, TEST_ERRNO,
> -				 strerror(TEST_ERRNO));
> -			continue;
> -		}
> +	GETGROUPS(gidsetsize, groups_get);

TST_EXP_VAL(GETGROUPS(gitsetsize, groups_get), 1) ?

Also I suppose that we should make sure that the groups_get[0] value is
not equal to the groups_set[0], expecially with -i 2

So maybe:
	groups_get[0] = ~groups_set[0];

> -		/*
> -		 * Call getgroups(2) to verify that
> -		 * setgroups(2) successfully set the
> -		 * supp. gids of TESTUSER.
> -		 */
> -		groups_list[0] = '\0';
> -		if (GETGROUPS(cleanup, gidsetsize, groups_list) < 0) {
> -			tst_brkm(TFAIL, cleanup, "getgroups() Fails, "
> -				 "error=%d", errno);
> -		}
> -		for (i = 0; i < NGROUPS; i++) {
> -			if (groups_list[i] == user_info->pw_gid) {
> -				tst_resm(TPASS,
> -					 "Functionality of setgroups"
> -					 "(%d, groups_list) successful",
> -					 gidsetsize);
> -				PASS_FLAG = 1;
> -			}
> -		}
> -		if (PASS_FLAG == 0) {
> -			tst_resm(TFAIL, "Supplimentary gid %d not set "
> -				 "for the process", user_info->pw_gid);
> -		}
> +	if (groups_get[0] == groups_set[0]) {
> +		tst_res(TPASS,
> +			"Functionality of setgroups"
> +			"(%d, groups_set) successful",
> +			gidsetsize);
>  	}

TST_EXP_EQ_LI(groups_get[0], groups_set[0]);

At least that will produce TFAIL results if they don't match, which is
missing here.

> -	cleanup();
> -	tst_exit();
>  }
>  
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - *
> - *  Make sure the test process uid is root.
> - *  Get the supplimentrary group id of test user from /etc/passwd file.
> - */
> -void setup(void)
> +static void setup(void)
>  {
> +	user_info = SAFE_GETPWNAM(TESTUSER);
>  
> -	tst_require_root();
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/* Get the group id info. of TESTUSER from /etc/passwd */
> -	if ((user_info = getpwnam(TESTUSER)) == NULL) {
> -		tst_brkm(TFAIL, cleanup, "getpwnam(2) of %s Failed", TESTUSER);
> -	}
> +	GID16_CHECK(user_info->pw_gid, setgroups);
>  
> -	if (!GID_SIZE_CHECK(user_info->pw_gid)) {
> -		tst_brkm(TBROK,
> -			 cleanup,
> -			 "gid returned from getpwnam is too large for testing setgroups16");
> -	}
> -
> -	groups_list[0] = user_info->pw_gid;
> +	groups_set[0] = user_info->pw_gid;

Do we really need this? I suppose that any random value will do, e.g.

	groups_set[0] = 42;

is going to be as good as anything else.

>  }
>  
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *	       completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -
> -}
> +static struct tst_test test = {
> +	.test_all = verify_setgroups,
> +	.setup = setup,
> +	.needs_root = 1,
> +};
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
