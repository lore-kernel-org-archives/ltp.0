Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C42C433EF
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 14:07:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 649A03C92C2
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 15:07:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34F7E3C12D0
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 15:07:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B06FC600873
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 15:07:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 99A6821126;
 Fri,  7 Jan 2022 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641564457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GlBPWgkxjumB1VMkgbd3PLkklcdf3wNKYxQa5Nx880Q=;
 b=eAh6kcCNxK3KFGynixz9rgHecSgzegkVBnCIy1B7+P9ESfQ6JPIjHDVcQPEibpcwR0hDrx
 0pyBESteMiIVWs7RlJZp5uoHVrd/5fLUAQctOjjZUvRXGHfO/SuH+qEeAYVGD6EYNH/nO4
 daCH1NfhOrqglfB3/+BJqJrolPasUK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641564457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GlBPWgkxjumB1VMkgbd3PLkklcdf3wNKYxQa5Nx880Q=;
 b=rVfpqay72Tm5bHF03uhVvda9Q2DcbfYBipkfdoG51F/YbSvYFG2ZEKif0sE4eigfx9NSEE
 Hw1W3sCUr0H8P9Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EAF313350;
 Fri,  7 Jan 2022 14:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Y0PUHSlJ2GEmbgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 07 Jan 2022 14:07:37 +0000
Date: Fri, 7 Jan 2022 15:09:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YdhJhtWIYUjWdeAk@yuki>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/6] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
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
> +static void verify_quota(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	res_dq.dqb_bsoftlimit = 0;
> +	res_qf.dqi_igrace = 0;
> +	fmt_buf = 0;
> +	res_ndq.dqb_id = -1;
> +
> +	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
> +	if ((tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA) ||
> +		tc->cmd == QCMD(Q_GETNEXTQUOTA, GRPQUOTA)) &&
> +		getnextquota_nsup) {
> +		tst_res(TCONF, "current system doesn't support this cmd");
                                                                ^
								Can we
								print
								tc->des
								here?
> +		return;
> +	}
> +	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
> +		return;
> +	}

And this can be TST_EXP_PASS_SILENT() followed by if (!TST_PASS) return;

The difference is that the TST_EXP* macros are more comprehensive if
there is a bug in kernel that makes quotaclt() return a possitive number
on success this test would still succeed while the macro will fail it.


Other than these two minor issues:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
