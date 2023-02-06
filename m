Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696C5C05027
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 16:20:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBDC03CC239
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 17:20:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22AC63CB174
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 17:19:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7FE2A600564
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 17:19:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 65B471FDD4;
 Mon,  6 Feb 2023 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675700396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mt4iCjjbd7h4nX40B/OcLTEVHQuNamLeAafpJaXrVu0=;
 b=1EyPC4f4z5q2Tlo4qLDT2FaeN44obOVRafFwKvUZIdz+AN6IS4LAINo9LcNDCSkzriVg2+
 KUH5Z3H08PPWUse0OrNhK/KDONiF8MOXzeuK3cqLqd404fcAuXQcbjkytnvihpxYWDyRkq
 AbiI3yuEsQS6xuRq1Xwcf+bhnycTYsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675700396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mt4iCjjbd7h4nX40B/OcLTEVHQuNamLeAafpJaXrVu0=;
 b=UmORhZqWFP+pKr/Zgt3eFBw/GpYCY2iFYsvgw65J9u4uyawKt1jOnMTjPHTC+OyZdSTo14
 i/JK729OtKfoWqBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE7BB138E7;
 Mon,  6 Feb 2023 16:19:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0hVXNaso4WOeCAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Feb 2023 16:19:55 +0000
Date: Mon, 6 Feb 2023 17:19:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y+Eoqd5+bWPxlpXD@pevik>
References: <20230129115021.25778-1-wegao@suse.com> <Y9pf5075zsuAhznN@pevik>
 <Y+DYmkBnv/NQK8gZ@aa>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+DYmkBnv/NQK8gZ@aa>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fsconfig: New case cover CVE-2022-0185
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

Hi Wei,

...
> > Hm, there is a kernel fix from 5.17 [1]. But test fails when I run it on 6.2.0-rc5:

> > tst_supported_fs_types.c:165: TINFO: Skipping FUSE based ntfs as requested by the test
> > tst_supported_fs_types.c:157: TINFO: Skipping tmpfs as requested by the test
> > tst_test.c:1634: TINFO: === Testing on ext3 ===
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> > mke2fs 1.46.5 (30-Dec-2021)
> > fsconfig03.c:44: TFAIL: fsconfig(FSCONFIG_SET_STRING) failed: EINVAL (22)

> > Isn't it the opposite: we expect to fail, thus TST_EXP_FAIL() should here be
> > used?

> I have not test on 6.2.0 kernel, i need reproduce this firstly.

FYI 6.0.6 is also broken, works on 5.10.46.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
