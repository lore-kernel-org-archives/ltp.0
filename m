Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9519DC433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 06:41:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96AFB3CA68D
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 08:41:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 797DB3CA600
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 08:41:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 87E062005E5
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 08:41:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA1D12272B;
 Mon, 11 Jul 2022 06:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657521659;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IV5rl2gSsN5U+u5uqusJ/VGg7E1AW0NOv+a5S77bUWY=;
 b=TPig+rc8sD/HHfxGroAaWjGb3zc4CfV/EzC6peoHWKSZ99yDLq7oywsRRJbQGqgTa1tLTx
 qj9Ql+PwfalzI4t+mknl8HwcI6FfdA5Ry5L4Jf6z4KPx1zC5AyZbAd/UsANdlB4tunCpwe
 /5x3gyD6fQCciTsZJeUjHZv5yNOAyv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657521659;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IV5rl2gSsN5U+u5uqusJ/VGg7E1AW0NOv+a5S77bUWY=;
 b=fQb/lFja9qG329wgmlyxhgTOTXClq3WkfCoh+WEUVNahOjd6OzObLtOaSyRjgRyjA568Jl
 gBCMRkNTqBK2WCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A44C513322;
 Mon, 11 Jul 2022 06:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id k2e+JvvFy2JEdwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 11 Jul 2022 06:40:59 +0000
Date: Mon, 11 Jul 2022 08:40:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YsvF+aZqnjNB0G0j@pevik>
References: <20220710104449.10387-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220710104449.10387-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> Make use of TST_EXP_FAIL2() macro with testcase descriptions
+1

Also +1 for static :).

...
> +++ b/testcases/kernel/syscalls/open/open08.c
> @@ -33,34 +33,20 @@ static struct test_case_t {
>  	char **fname;
>  	int flags;
>  	int error;
> +	const char *desc;
>  } tcases[] = {
> -	{&existing_fname, O_CREAT | O_EXCL, EEXIST},
> -	{&dir_fname, O_RDWR, EISDIR},
> -	{&existing_fname, O_DIRECTORY, ENOTDIR},
> -	{&toolong_fname, O_RDWR, ENAMETOOLONG},
> -	{&user2_fname, O_WRONLY, EACCES},
> -	{&unmapped_fname, O_CREAT, EFAULT}
> +	{&existing_fname, O_CREAT | O_EXCL, EEXIST, "open() existing file with 'O_CREAT | O_EXCL'"},
> +	{&dir_fname, O_RDWR, EISDIR, "open() existing directory with write access"},
> +	{&existing_fname, O_DIRECTORY, ENOTDIR, "open() non-directory pathname with O_DIRECTORY"},
> +	{&toolong_fname, O_RDWR, ENAMETOOLONG, "open() too long pathname"},
> +	{&user2_fname, O_WRONLY, EACCES, "open() file without requested access rights"},
> +	{&unmapped_fname, O_CREAT, EFAULT, "open() pathname with bad address"}
>  };

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Instead of text descriptions I'd just print flags:

#define FLAGS_DESC(x) .flags = x, .desc = #x

static struct test_case_t {
	char **fname;
	int flags;
	const char *desc;
	int error;
} tcases[] = {
	{&existing_fname, FLAGS_DESC(O_CREAT | O_EXCL), EEXIST},
	{&dir_fname, FLAGS_DESC(O_RDWR), EISDIR},
	{&existing_fname, FLAGS_DESC(O_DIRECTORY), ENOTDIR},
	{&toolong_fname, FLAGS_DESC(O_RDWR), ENAMETOOLONG},
	{&user2_fname, FLAGS_DESC(O_WRONLY), EACCES},
	{&unmapped_fname, FLAGS_DESC(O_CREAT), EFAULT},
};

# ./open08 
tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
open08.c:52: TPASS: O_CREAT | O_EXCL : EEXIST (17)
open08.c:52: TPASS: O_RDWR : EISDIR (21)
open08.c:52: TPASS: O_DIRECTORY : ENOTDIR (20)
open08.c:52: TPASS: O_RDWR : ENAMETOOLONG (36)
open08.c:52: TPASS: O_WRONLY : EACCES (13)
open08.c:52: TPASS: O_CREAT : EFAULT (14)

If you agree, I can merge it with this change.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
