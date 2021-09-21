Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748E2C433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 07:46:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D1D611C5
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 07:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96D1D611C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBC693C8623
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 09:46:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBDEC3C2435
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 09:46:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3185C1000CE0
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 09:46:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 64C331FEA7;
 Tue, 21 Sep 2021 07:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632210361;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbaVPv4vSSElBKs3pswuaVlQJR+eOjyDCJovMxOgnqk=;
 b=dGm4CkiIXYfobIWE/thguVkW5zmNYSu/u0z5fPbFab4djtg6bi3oHTA74TWScP5fqzD/sU
 jSc49jZuB0T40nCP2lUlngCNFC+OndZm9D0ev6uqp5XMKI2NdOlSquZp03MzbE91sX+OHz
 Vo1+8OdvY0XnpIdAItoCzR78If2LYhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632210361;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbaVPv4vSSElBKs3pswuaVlQJR+eOjyDCJovMxOgnqk=;
 b=9fNKcD1Xtg0NULcFj1a/CPLcpYQU6J996R/3UTJIEGnfrGJkBa4NV3QnaJztsQBAl0cHJ5
 Y9AgtJ/az/V0g3CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 306D513B0A;
 Tue, 21 Sep 2021 07:46:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id txCyCbmNSWFnDwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 21 Sep 2021 07:46:01 +0000
Date: Tue, 21 Sep 2021 09:45:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alex Henrie <alexh@vpitech.com>
Message-ID: <YUmNt06CD97u0Drs@pevik>
References: <20210921004140.15041-1-alexh@vpitech.com>
 <20210921004140.15041-3-alexh@vpitech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210921004140.15041-3-alexh@vpitech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH ltp v4 3/3] IMA: Add tests for uid, gid, fowner,
 and fgroup options
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Alex,

...
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2021 VPI Technology
> +# Author: Alex Henrie <alexh@vpitech.com>
> +#
> +# Verify that conditional rules work.
> +
> +TST_NEEDS_CMDS="awk chgrp chown cut sg sudo"
awk, cut are not used. Or is that a dependency from some helpers in
ima_setup.sh? (these should check the dependency themselves via tst_require_cmds).

The rest LGTM, I just need to retest it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
