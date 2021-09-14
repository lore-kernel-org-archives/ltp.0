Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54149C433FE
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 09:35:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA6B604AC
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 09:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BA6B604AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C99943C923E
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 11:35:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEB1C3C1D8F
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 11:35:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF121140012D
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 11:35:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 25DC222095
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 09:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631612119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQ0FehoR7IxYIGV8geS4TkJGPor1/19Fw2Ue14VzdBk=;
 b=MxU59cvyxSCGNK98wtCaZEaMaWOIf6Wrw/A3ppo35gJ1bGV+C5BRMxTqLWdu5oo6wXl76M
 G4fst4pPMWLxC/lf0b75fd6iaop3R5cZolljgXj752O5BSCi0VwGOF5PD6mvLECvTahWPt
 elhShjXrKTKP3/giTJeWGnblUupmr94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631612119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQ0FehoR7IxYIGV8geS4TkJGPor1/19Fw2Ue14VzdBk=;
 b=8YUEh6WI5QMGNpKhrAHI6X/OaBRZhjXGS5aAA4t/5OZNdJLeN/zq8MGd6vhMKPascIt/wj
 LiuJVwwfATKsG1Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18B1E13E55
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 09:35:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OVmSBNdsQGFpSAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 09:35:19 +0000
Message-ID: <3a764f27-b453-0aab-4938-7b7b34496885@suse.cz>
Date: Tue, 14 Sep 2021 11:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
References: <20210913144454.22992-1-mdoucha@suse.cz>
 <20210913144454.22992-2-mdoucha@suse.cz>
In-Reply-To: <20210913144454.22992-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] syscalls/setresuid01: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210914093518.sIl5zU8cOexzdM9FmLVuL61n5v1hXdKcVZeuj_YdLVk@z>

On 13. 09. 21 16:44, Martin Doucha wrote:
> The original test needs user "bin" which may not exist on some systems. Use
> any non-root UID instead.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> Changes since v1: None
> 
>  .../kernel/syscalls/setresuid/setresuid01.c   | 256 ++++--------------
>  1 file changed, 59 insertions(+), 197 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setresuid/setresuid01.c b/testcases/kernel/syscalls/setresuid/setresuid01.c
> index 9f448896b..e9eb8517e 100644
> --- a/testcases/kernel/syscalls/setresuid/setresuid01.c
> +++ b/testcases/kernel/syscalls/setresuid/setresuid01.c
> @@ -1,221 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.

Oops, I've accidentally copy-pasted the wrong SPDX header to all three
setresuid tests. Patch 1 is correct as is but patches 2-4 should have
GPL-2.0-or-later instead. Please update it before merge.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
