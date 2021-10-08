Return-Path: <SRS0=B/OF=O4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EDAC433F5
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 11:12:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A58160F59
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 11:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A58160F59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C6D43CA59C
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 13:12:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EBD33C52B3
 for <ltp@lists.linux.it>; Fri,  8 Oct 2021 13:12:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0B0F72003BB
 for <ltp@lists.linux.it>; Fri,  8 Oct 2021 13:12:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F1881FD72;
 Fri,  8 Oct 2021 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633691533;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X9XwFYrzJay+iGdpvl1bsGcn39qbjAXS1nBL8NmnK1M=;
 b=dxeNk8Rpwr+NnW4vlZUdNjQfCqNPqwdQXX8+dQZlDGHttc/zeNBjEpBbbne8GOcoIFgsRk
 +AN82nbRWOhjpomk98qvvc3rs48jLUhpE7XOLMTdqf8oBHAwrjtPfSM/jjAgSi80itcj9a
 RpQXpoDbZiHmsjGdlZAhKQOcpZkzTlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633691533;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X9XwFYrzJay+iGdpvl1bsGcn39qbjAXS1nBL8NmnK1M=;
 b=SPxI12YGqNhkyTA7AgyjMGxZiXAy/2QN9MOqSN2bzE9/t7UAvCopkKaRUfpT3Di3tt0fJF
 OiT1Z1baEa1djfAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 442DB13EB2;
 Fri,  8 Oct 2021 11:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pirLDo0nYGGzMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 08 Oct 2021 11:12:13 +0000
Date: Fri, 8 Oct 2021 13:12:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YWAni7GqNGQswW5P@pevik>
References: <20211008100024.24351-1-pvorel@suse.cz>
 <YWAcENhhcvKGTpnl@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YWAcENhhcvKGTpnl@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Zhao,

> Hi!
> > -int setup1();			/* setup function to test error EPERM */
> > +void setup1(const char *uid, uid_t euid);	/* setup function to test error EPERM */
> >  void setup();			/* setup function for the test */
> >  void cleanup();			/* cleanup function for the test */

> > @@ -95,7 +93,7 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
> >  	int list;
> >  	char *desc;
> >  	int exp_errno;
> > -	int (*setupfunc) ();
> > +	void (*setupfunc)(const char *uid, uid_t euid);
> >  } Test_cases[] = {
> >  	{
> >  	1, 1, "Size is > sysconf(_SC_NGROUPS_MAX)", EINVAL, NULL}, {
> > @@ -126,7 +124,7 @@ int main(int ac, char **av)

> >  		for (i = 0; i < TST_TOTAL; i++) {
> >  			if (Test_cases[i].setupfunc != NULL) {
> > -				Test_cases[i].setupfunc();
> > +				Test_cases[i].setupfunc(nobody_uid, ltpuser->pw_uid);
> >  			}

> >  			gidsetsize = ngroups_max + Test_cases[i].gsize_add;
> > @@ -156,8 +154,11 @@ int main(int ac, char **av)
> >  					 gidsetsize, test_desc, TEST_ERRNO,
> >  					 Test_cases[i].exp_errno);
> >  			}
> > -		}

> > +			if (Test_cases[i].setupfunc != NULL) {
> > +				Test_cases[i].setupfunc("root", ltpuser->pw_uid);
> > +			}
> > +		}
> >  	}

> >  	cleanup();
> > @@ -176,8 +177,9 @@ void setup(void)

> >  	tst_sig(NOFORK, DEF_HANDLER, cleanup);

> > -	TEST_PAUSE;
> > +	ltpuser = SAFE_GETPWNAM(cleanup, uid);

> > +	TEST_PAUSE;
> >  }

> >  /*
> > @@ -187,29 +189,21 @@ void setup(void)
> >   *  Get the user info. from /etc/passwd file.
> >   *  This function returns 0 on success.
> >   */
> > -int setup1(void)
> > +void setup1(const char *uid, uid_t euid)
> >  {
> > -	struct passwd *user_info;	/* struct. to hold test user info */
> > -
> > -/* Switch to nobody user for correct error code collection */
> > -	ltpuser = getpwnam(nobody_uid);
> > -	if (seteuid(ltpuser->pw_uid) == -1) {
> > -		tst_resm(TINFO, "setreuid failed to "
> > -			 "to set the effective uid to %d", ltpuser->pw_uid);
> > -		perror("setreuid");
> > -	}
> > +	struct passwd *user_info;

> > -	if ((user_info = getpwnam(TESTUSER)) == NULL) {
> > -		tst_brkm(TFAIL, cleanup, "getpwnam(2) of %s Failed", TESTUSER);
> > -	}
> > +	SAFE_SETEUID(cleanup, euid);
> > +
> > +	user_info = SAFE_GETPWNAM(cleanup, uid);

> I still do not get why we call SAFE_GETPWNAM() here. We should do that
> in the setup and prepare two different group_list[] lists, if that is
> really needed.

> But I guess that all we need in this test is:

> * Run the EINVAL test as a root

> * Run the EPERM test as a nobody

> The content of the list should not matter, as a matter of a fact we pass
> unitialized data in the EINVAL case. What matters is the size argument,
> it should be 1 for the EPERM test and max+1 for the EINVAL case.

Good point, thank you!

@Zhao feel free to let me know you're doing to implement it.
Otherwise I'll have look on Monday.

Kind regards,
Petr

> >  	if (!GID_SIZE_CHECK(user_info->pw_gid)) {
> >  		tst_brkm(TBROK,
> >  			 cleanup,
> >  			 "gid returned from getpwnam is too large for testing setgroups16");
> >  	}
> > +
> >  	groups_list[0] = user_info->pw_gid;
> > -	return 0;
> >  }

> >  /*
> > -- 
> > 2.33.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
