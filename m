Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5583CC54EE9
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 18:50:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E51B83CAD41
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 20:50:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7FF73CA8A3
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 20:49:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E48191A00E38
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 20:49:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D14C421B81;
 Tue, 20 Sep 2022 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663699789;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ykd2rBfi+oI6tu85F8gYh3rur2OBbfJP2tTLayWo3Oo=;
 b=A0xFrrhO2epNyvpW6DqyDdk6Ev0KNK0kKVqLJdT9Kny1Rkn4yT5Bj5+kljD2u9AfJwuq3N
 WXyL+k8cgdNVyI/GNmqIU20pVk8aEwIhFAnTC8hd5keAXSwHuANtxL31akqimaTf11n65y
 OaGt8kk8r0ITq9R2NSHxQxtJB+02X3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663699789;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ykd2rBfi+oI6tu85F8gYh3rur2OBbfJP2tTLayWo3Oo=;
 b=7pXjWmP7DzmiEDYNThsdIb76PnTH71w9kVLNFVGKhqvr+kzBU3DNINAiHmZBj27HAObbQU
 4g8iYmd49+nbhCCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F7CB1346B;
 Tue, 20 Sep 2022 18:49:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NUBADE0LKmOrBAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Sep 2022 18:49:49 +0000
Date: Tue, 20 Sep 2022 20:49:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Randolph Lin <randolph@andestech.com>
Message-ID: <YyoLS/lLgCGRlmKg@pevik>
References: <20220920114358.2259862-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220920114358.2259862-1-randolph@andestech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls: Fix tst_res() format string for
 64-bit offset
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
Cc: alankao@andestech.com, Mina <minachou@andestech.com>, kester.tw@gmail.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Randolph,

> When compiling format string contains off_t type, to print off_t
> correctly is cast it to (long long int) type and change the format
> string to %lli.
LGTM, I'd just use %lld instead of %lli (it's exactly the same, but %lld is IMHO
more common.

Kind regards,
Petr

...
> +++ b/testcases/kernel/syscalls/lseek/lseek11.c
> @@ -159,7 +159,7 @@ static void setup(void)
>  	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0666);

>  	get_blocksize();
> -	tst_res(TINFO, "The block size is %lu", block_size);
> +	tst_res(TINFO, "The block size is %d", block_size);
This is wrong. While blksize_t is on aarch64 and riscv64 int, on 
most archs is long, thus this needs to have the same approach as the rest
(%lld and (long long int) cast.

with these 2 changes:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
