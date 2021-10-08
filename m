Return-Path: <SRS0=B/OF=O4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78330C433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 10:22:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E0660FD8
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 10:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89E0660FD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23DE73C95C7
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 12:22:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AEBD3C7895
 for <ltp@lists.linux.it>; Fri,  8 Oct 2021 12:22:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 92176601CDB
 for <ltp@lists.linux.it>; Fri,  8 Oct 2021 12:22:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E2DDB20118;
 Fri,  8 Oct 2021 10:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633688555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SwsU2QLkSyDLaRxh75FkmWjcUSHr+Hcy6moZX8zMgMw=;
 b=aEVFOZRSppQimB/dg8g5yWX1ARLUXMTlKm4gTSgdogt1klyJ/Usl3nJiRFJ4dMTAkWCqxa
 y0mk+swZJwMJ17qgRiKavRYQwVZUwM5Ecc+1ZxpmEtbYtBR03bVZDW4EGhnL32THhdeKJu
 lC2pXSA90G6TkxS/8ksr7weZtabN/1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633688555;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SwsU2QLkSyDLaRxh75FkmWjcUSHr+Hcy6moZX8zMgMw=;
 b=1AgUenYGsxCO9oJF4QkKov1lsVHOelRiVPSvYQUUKcXuZX/cZvyzVQv3Jew0K9WaWGggvg
 ZigauTffWYj9V7Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF6BD13EB3;
 Fri,  8 Oct 2021 10:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mG0nMusbYGESIQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 08 Oct 2021 10:22:35 +0000
Date: Fri, 8 Oct 2021 12:23:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YWAcENhhcvKGTpnl@yuki>
References: <20211008100024.24351-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211008100024.24351-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] setgroups03: Fix running more iterations
 (-i 2)
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
> -int setup1();			/* setup function to test error EPERM */
> +void setup1(const char *uid, uid_t euid);	/* setup function to test error EPERM */
>  void setup();			/* setup function for the test */
>  void cleanup();			/* cleanup function for the test */
>  
> @@ -95,7 +93,7 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
>  	int list;
>  	char *desc;
>  	int exp_errno;
> -	int (*setupfunc) ();
> +	void (*setupfunc)(const char *uid, uid_t euid);
>  } Test_cases[] = {
>  	{
>  	1, 1, "Size is > sysconf(_SC_NGROUPS_MAX)", EINVAL, NULL}, {
> @@ -126,7 +124,7 @@ int main(int ac, char **av)
>  
>  		for (i = 0; i < TST_TOTAL; i++) {
>  			if (Test_cases[i].setupfunc != NULL) {
> -				Test_cases[i].setupfunc();
> +				Test_cases[i].setupfunc(nobody_uid, ltpuser->pw_uid);
>  			}
>  
>  			gidsetsize = ngroups_max + Test_cases[i].gsize_add;
> @@ -156,8 +154,11 @@ int main(int ac, char **av)
>  					 gidsetsize, test_desc, TEST_ERRNO,
>  					 Test_cases[i].exp_errno);
>  			}
> -		}
>  
> +			if (Test_cases[i].setupfunc != NULL) {
> +				Test_cases[i].setupfunc("root", ltpuser->pw_uid);
> +			}
> +		}
>  	}
>  
>  	cleanup();
> @@ -176,8 +177,9 @@ void setup(void)
>  
>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>  
> -	TEST_PAUSE;
> +	ltpuser = SAFE_GETPWNAM(cleanup, uid);
>  
> +	TEST_PAUSE;
>  }
>  
>  /*
> @@ -187,29 +189,21 @@ void setup(void)
>   *  Get the user info. from /etc/passwd file.
>   *  This function returns 0 on success.
>   */
> -int setup1(void)
> +void setup1(const char *uid, uid_t euid)
>  {
> -	struct passwd *user_info;	/* struct. to hold test user info */
> -
> -/* Switch to nobody user for correct error code collection */
> -	ltpuser = getpwnam(nobody_uid);
> -	if (seteuid(ltpuser->pw_uid) == -1) {
> -		tst_resm(TINFO, "setreuid failed to "
> -			 "to set the effective uid to %d", ltpuser->pw_uid);
> -		perror("setreuid");
> -	}
> +	struct passwd *user_info;
>  
> -	if ((user_info = getpwnam(TESTUSER)) == NULL) {
> -		tst_brkm(TFAIL, cleanup, "getpwnam(2) of %s Failed", TESTUSER);
> -	}
> +	SAFE_SETEUID(cleanup, euid);
> +
> +	user_info = SAFE_GETPWNAM(cleanup, uid);

I still do not get why we call SAFE_GETPWNAM() here. We should do that
in the setup and prepare two different group_list[] lists, if that is
really needed.

But I guess that all we need in this test is:

* Run the EINVAL test as a root

* Run the EPERM test as a nobody

The content of the list should not matter, as a matter of a fact we pass
unitialized data in the EINVAL case. What matters is the size argument,
it should be 1 for the EPERM test and max+1 for the EINVAL case.

>  	if (!GID_SIZE_CHECK(user_info->pw_gid)) {
>  		tst_brkm(TBROK,
>  			 cleanup,
>  			 "gid returned from getpwnam is too large for testing setgroups16");
>  	}
> +
>  	groups_list[0] = user_info->pw_gid;
> -	return 0;
>  }
>  
>  /*
> -- 
> 2.33.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
