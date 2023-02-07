Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED52C636D3
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 18:12:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17C603CD0F5
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 19:12:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96ABF3CB14D
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 19:12:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8EA611A0069C
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 19:12:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6DAB51F8AA;
 Tue,  7 Feb 2023 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675793535;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EhsF4YFKuXiHZoKqFbbFmJOpGz0Jc+fIPmh/Mmlh8Ig=;
 b=V0TswfaQt0ZuPW6QAT5R3+Ni7+gnBR+/u7ms9HURm6aaLq6DHrTy4Q1IADVjYvy2pWxe0p
 JapsPhFaKvMsr4ArbOPeY4Fa9vSCV1d4ig8dOMOztefQbKPoe12rv+9SRI7c+7JP45qqhy
 fqUmBdVGW5AAGSPF1UTR4FVoxGOC7qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675793535;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EhsF4YFKuXiHZoKqFbbFmJOpGz0Jc+fIPmh/Mmlh8Ig=;
 b=osJbE6tacjhc9Wv2RDhonrMTTGim8hcoM4qfIyjCnJd0Uwk6fuy80Z1q46B5rSebBo47P/
 Dxfl4uQgZVRgNJDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 472BA139ED;
 Tue,  7 Feb 2023 18:12:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cLOFD3+U4mNsbAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 07 Feb 2023 18:12:15 +0000
Date: Tue, 7 Feb 2023 19:12:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Y+KUfW2BYCddeZcY@pevik>
References: <1675156318-14860-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1675156318-14860-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/mount07: Add new test case for
 MS_NOSYMFOLLOW
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

Hi Xu,

> +static void test_statfs(bool nosymfollow)
> +{
> +	struct statfs buf;
> +
> +	SAFE_STATFS(MNTPOINT, &buf);
> +	if (buf.f_flags & ST_NOSYMFOLLOW) {
> +		tst_res(nosymfollow ? TPASS : TFAIL, "ST_NOSYMFOLLOW set on %s",
> +				MNTPOINT);
> +	} else {
> +		tst_res(nosymfollow ? TFAIL : TPASS, "ST_NOSYMFOLLOW not set on %s",
> +				MNTPOINT);
> +	}
> +}

I was thinking about this:

static void test_statfs(bool nosymfollow)
{
	struct statfs buf;
	bool st_nosymfollow;
	int res;

	SAFE_STATFS(MNTPOINT, &buf);
	st_nosymfollow = buf.f_flags & ST_NOSYMFOLLOW;
	res = !!st_nosymfollow == !!nosymfollow ? TPASS : TFAIL;

	tst_res(res, "ST_NOSYMFOLLOW %sset on %s", st_nosymfollow ? "" : "not ",
		MNTPOINT);
}
but your version is much readable, thus forget the above.

LGTM, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
