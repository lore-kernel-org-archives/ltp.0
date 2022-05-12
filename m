Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACA0C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 11:44:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4367A3CA9DE
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 13:44:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8D0B3C8CC3
 for <ltp@lists.linux.it>; Thu, 12 May 2022 13:43:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED1B61000484
 for <ltp@lists.linux.it>; Thu, 12 May 2022 13:43:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC9141F88F
 for <ltp@lists.linux.it>; Thu, 12 May 2022 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652355832;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fNa/64PsNmZ7Edbc3sLEV6Bi26OKqG2SwBedhVf3WJE=;
 b=O8c8Ogo9uct3Sn4EO918m9UZ3JZ5Hp9VwJPEVEICoALOfTrvEsjJ18a/Q9CEveZwzzsj7h
 u9VMasoiekjOIkydIlOIU2cjJK8RfhE7fSN56ZrkDcArR3AAl1+IiUBg4c9DJHzop+MUs5
 2UWaKZKrE84hOfCGkRKNUqa8bviFZEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652355832;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fNa/64PsNmZ7Edbc3sLEV6Bi26OKqG2SwBedhVf3WJE=;
 b=HWV7QLPGCSbe7KWCipd+B4CU7VczOXOFlkCRipXJsQV0acGb/aCULx9xXAiwEL/+iDrYlc
 LjzYN/cwEYu77XAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B665113A84
 for <ltp@lists.linux.it>; Thu, 12 May 2022 11:43:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3z1/KfjyfGJOewAAMHmgww
 (envelope-from <pvorel@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 12 May 2022 11:43:52 +0000
Date: Thu, 12 May 2022 13:43:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Ynzy9inZ9vsKA4sB@pevik>
References: <20220510155438.15754-1-pvorel@suse.cz>
 <20220510155438.15754-5-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220510155438.15754-5-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] shell: Add test for TST_MOUNT_DEVICE=1
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> +++ b/lib/newlib_tests/shell/tst_mount_device.sh
...
> +TST_MOUNT_DEVICE=1
> +TST_FS_TYPE=ext4
> +TST_TESTFUNC=test
> +TST_CNT=2
> +. tst_test.sh
Obviously loading should be later.
> +
> +test1()
> +{
> +	tst_res TPASS "device formatted"
> +}
> +
> +test2()
> +{
> +	EXPECT_PASS "grep '$TST_MNTPOINT $TST_FS_TYPE' /proc/mounts"
> +}
> +
Here.
I'll fix it before merge (if it's the only change requested).
> +tst_run

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
