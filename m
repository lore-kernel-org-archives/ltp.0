Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195F5C001B0
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 13:12:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F36F3CE1B8
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 15:12:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A99D63C62DA
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 15:12:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E7327600BDC
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 15:12:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8EB2621900;
 Mon,  7 Aug 2023 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691413951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=arBrU/YHqqTqaWZ9EzlKpV5WkztDyedvYJPj2sUp6gg=;
 b=ecaEvhv0drWn1ESDtH/Ml6qF4vXiVc3gQUeIGtHp+2cjKpj5wt36kx+1jo5EcfpTm8QNMc
 bfhbowsxCeYjqHnKgFXKZwf125xAFwTHTy4pV3zP5Sowib0xi8Z+mnUldLFYtNE9Jqqu5k
 4Vn3AsghyNGAyvJYbRbl0UBD36k20AA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691413951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=arBrU/YHqqTqaWZ9EzlKpV5WkztDyedvYJPj2sUp6gg=;
 b=bsoVj6Wn+ablH46mE1GABqfXT4NqiHhOj6w/y43wJ+86HiTpm2IQshkCRXa33VNLUpGbFF
 RQ/s5ocnm/QnI8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68DBA13487;
 Mon,  7 Aug 2023 13:12:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zNpOF7/t0GTlFAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 07 Aug 2023 13:12:31 +0000
Date: Mon, 7 Aug 2023 15:13:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZNDt-PogUzCebHSl@yuki>
References: <1690888046-18662-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1690888046-18662-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1690888046-18662-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] syscalls/setgroups02: Convert to new API
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
> +static GID_T groups_get[NGROUPS];
> +static GID_T groups_set[NGROUPS];

Since you are using the guarded buffers these two has to be just
pointers, i.e.

static GID_T *groups_get;

> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - *
> - *  Make sure the test process uid is root.
> - *  Get the supplimentrary group id of test user from /etc/passwd file.
> - */
> -void setup(void)
> +static void verify_setgroups(void)
>  {
> +	int gidsetsize = 1;

There is no point in passing the value via variable, we can as well pass
1 directly to the getgroups/setgroups calls.

> -	tst_require_root();
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	groups_set[0] = 42;

We have to clear the groups_get[0] here as well, in the case that we are
looping with the -i parameter, i.e.

	groups_get[0] = 0;

> -	TEST_PAUSE;
> +	TST_EXP_PASS(SETGROUPS(gidsetsize, groups_set));
>  
> -	/* Get the group id info. of TESTUSER from /etc/passwd */
> -	if ((user_info = getpwnam(TESTUSER)) == NULL) {
> -		tst_brkm(TFAIL, cleanup, "getpwnam(2) of %s Failed", TESTUSER);
> -	}
> +	TST_EXP_VAL(GETGROUPS(gidsetsize, groups_get), 1);
>  
> -	if (!GID_SIZE_CHECK(user_info->pw_gid)) {
> -		tst_brkm(TBROK,
> -			 cleanup,
> -			 "gid returned from getpwnam is too large for testing setgroups16");
> -	}
> -
> -	groups_list[0] = user_info->pw_gid;
> +	TST_EXP_EQ_LI(groups_get[0], groups_set[0]);
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
> +	.bufs = (struct tst_buffers []) {
> +		{&groups_get, .size = sizeof(groups_get)},
> +		{&groups_set, .size = sizeof(groups_set)},
                                          ^
					  Since we are using arrays of
					  size 1 with elements of a size
					  GID_T this should be just
					  sizeof(GID_T)

If it was array of size 2 it would have been 2 * sizeof(GID_T) etc.


The rest of the changes looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
