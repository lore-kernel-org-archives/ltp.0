Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EEDCE79AC
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 07:55:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E7123CE174
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 09:55:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA3303CA3D7
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 09:55:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A84CA601400
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 09:55:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A48122676;
 Wed, 20 Sep 2023 07:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695196516;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MfH2PZSvc1TYk05BRcu3yveegkQlrMJ6eaT7levY6v0=;
 b=wneGtGzl8INeeCYDfrSuvSpdbsJdw0Ky0Cex1SrmVJjl+HfUNyxXneOV2AeSKiwv2V/Ehg
 F4QUMyBn29ZiuaA9k+nD9C1GgJXR4Yy/w+XdnC0LUxq0sHN+65PBCkyF24yQh1JNmm+sfU
 kWKsTyQUV7YBUtEPejZhOy2GBg5+ykE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695196516;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MfH2PZSvc1TYk05BRcu3yveegkQlrMJ6eaT7levY6v0=;
 b=Z+Lvq7RsyZSUqyLy7WeZOxMkEWImPS6j6aqQKijn4NDU3V3AmIQ76y8GsKELP81tpkyC2i
 4tbOwXNjXVLhqwDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43781132C7;
 Wed, 20 Sep 2023 07:55:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ooBJD2SlCmVyQgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 20 Sep 2023 07:55:16 +0000
Date: Wed, 20 Sep 2023 09:55:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230920075514.GA208385@pevik>
References: <20230913144706.7126-1-andrea.cervesato@suse.de>
 <20230913144706.7126-2-andrea.cervesato@suse.de>
 <ZQLgv0WWc7bTMRyD@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQLgv0WWc7bTMRyD@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 1/4] Refactor mqns_03 using new LTP API
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

Hi Andrea, Cyril,

> Hi!
> Since we are getting close to release I've fixed the remaining problems
> and pushed, thanks.

> What I fixed:

> - runtest entries were not updated
> - license did not match the original
> - there was no need for asprintf() for statically defined strings
> - the mq_freed was set but not used, so I've removed it
> - changed the SAFE_STAT() to access() so that we have clear TPASS/TFAIL
>   messages

I found that mqns_03.c and mqns_04.c fails on Debian in cleanup, when they try
to unmont DEVDIR:

static void cleanup(void)
{
	if (!access(MQUEUE1, F_OK))
		SAFE_MQ_UNLINK(MQNAME1);

	if (!access(MQUEUE2, F_OK))
		SAFE_MQ_UNLINK(MQNAME2);

	if (tst_is_mounted(DEVDIR))
		SAFE_UMOUNT(DEVDIR);
}

While on some distros (e.g. Tumbleweed) it's already unmounted in cleanup, thus
it just warns:
mqns_03.c:88: TINFO: Umounting /tmp/LTP_mqniOxGTg/ltp_mqueue
tst_device.c:442: TINFO: No device is mounted at ltp_mqueue

on Debian it's mounted and fail with EINVAL:
mqns_03.c:136: TINFO: Umounting /tmp/LTP_mqniOxGTg/ltp_mqueue
tst_device.c:402: TWARN: umount('ltp_mqueue') failed with EINVAL
mqns_03.c:136: TWARN: umount(ltp_mqueue) failed: EINVAL (22)

Any idea what can cause this?
(it's a regression)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
