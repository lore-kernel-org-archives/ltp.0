Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BBFC43334
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 08:59:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5C7F3CA6AB
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 10:59:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4993D3CA5E5
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 10:59:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AAB966006D7
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 10:59:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D0B1E22555;
 Mon, 11 Jul 2022 08:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657529984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5ct+/OuCcMvoepRjp1L/mmakGCXxNQcO/DKlHEqY6U=;
 b=GmG48RXffpv0r2N/XV/de87HwzrEEuJrBNIo3i2Z01iqyITw7m/avlh91eif4sSbHXlHYT
 cGVh1QNhzCGW4Ck4or4uYB/oDMla51HHArbUivngu1r1FST/Cew38NPOiYUb1YENk5gbDj
 8aXgvibr7cPmoSDTwILW4HJNv0gCliI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657529984;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5ct+/OuCcMvoepRjp1L/mmakGCXxNQcO/DKlHEqY6U=;
 b=RSztmyw1PlnchWTuuIc3df4ZTLPBGsNv7zn1D1H2fSFsKBawYPczeufzP60THVm1CqOwbp
 Kl0yAwEmXjDDROBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6E7C13322;
 Mon, 11 Jul 2022 08:59:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2c5lIX/my2KDMwAAMHmgww
 (envelope-from <akumar@suse.de>); Mon, 11 Jul 2022 08:59:43 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 11 Jul 2022 14:29:40 +0530
Message-ID: <3415287.WrLqWuVBv1@localhost>
Organization: SUSE
In-Reply-To: <YsvF+aZqnjNB0G0j@pevik>
References: <20220710104449.10387-1-akumar@suse.de> <YsvF+aZqnjNB0G0j@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] open08.c: Use TST_EXP_FAIL2() and SAFE_CLOSE()
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

Hi Petr, 

On Monday, July 11, 2022 12:10:57 PM IST Petr Vorel wrote:
> Hi Avinesh,
> 
> > Make use of TST_EXP_FAIL2() macro with testcase descriptions
> +1
> 
> Also +1 for static :).
> 
> ...
> > +++ b/testcases/kernel/syscalls/open/open08.c
> > @@ -33,34 +33,20 @@ static struct test_case_t {
> >  	char **fname;
> >  	int flags;
> >  	int error;
> > +	const char *desc;
> >  } tcases[] = {
> > -	{&existing_fname, O_CREAT | O_EXCL, EEXIST},
> > -	{&dir_fname, O_RDWR, EISDIR},
> > -	{&existing_fname, O_DIRECTORY, ENOTDIR},
> > -	{&toolong_fname, O_RDWR, ENAMETOOLONG},
> > -	{&user2_fname, O_WRONLY, EACCES},
> > -	{&unmapped_fname, O_CREAT, EFAULT}
> > +	{&existing_fname, O_CREAT | O_EXCL, EEXIST, "open() existing file with 'O_CREAT | O_EXCL'"},
> > +	{&dir_fname, O_RDWR, EISDIR, "open() existing directory with write access"},
> > +	{&existing_fname, O_DIRECTORY, ENOTDIR, "open() non-directory pathname with O_DIRECTORY"},
> > +	{&toolong_fname, O_RDWR, ENAMETOOLONG, "open() too long pathname"},
> > +	{&user2_fname, O_WRONLY, EACCES, "open() file without requested access rights"},
> > +	{&unmapped_fname, O_CREAT, EFAULT, "open() pathname with bad address"}
> >  };
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Instead of text descriptions I'd just print flags:
> 
> #define FLAGS_DESC(x) .flags = x, .desc = #x
> 
> static struct test_case_t {
> 	char **fname;
> 	int flags;
> 	const char *desc;
> 	int error;
> } tcases[] = {
> 	{&existing_fname, FLAGS_DESC(O_CREAT | O_EXCL), EEXIST},
> 	{&dir_fname, FLAGS_DESC(O_RDWR), EISDIR},
> 	{&existing_fname, FLAGS_DESC(O_DIRECTORY), ENOTDIR},
> 	{&toolong_fname, FLAGS_DESC(O_RDWR), ENAMETOOLONG},
> 	{&user2_fname, FLAGS_DESC(O_WRONLY), EACCES},
> 	{&unmapped_fname, FLAGS_DESC(O_CREAT), EFAULT},
> };
> 
> # ./open08 
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> open08.c:52: TPASS: O_CREAT | O_EXCL : EEXIST (17)
> open08.c:52: TPASS: O_RDWR : EISDIR (21)
> open08.c:52: TPASS: O_DIRECTORY : ENOTDIR (20)
> open08.c:52: TPASS: O_RDWR : ENAMETOOLONG (36)
> open08.c:52: TPASS: O_WRONLY : EACCES (13)
> open08.c:52: TPASS: O_CREAT : EFAULT (14)
> 
> If you agree, I can merge it with this change.
Yes, this is nice, please go ahead.

> 
> Kind regards,
> Petr
> 

Thanks,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
