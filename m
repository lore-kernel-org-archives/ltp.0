Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB54C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 14:00:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B06B03CA66D
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 16:00:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 777323C9482
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 16:00:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 940EB1A000A0
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 16:00:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E046221118;
 Wed, 27 Apr 2022 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651068031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBYPiXfB5e+e5N8W0V5gphHaWVDdFWQHdwjXRCwZWMM=;
 b=a/RUCCJLHNU2iwCaCSHF+vV/A2n9IoK/s5G702m1Ui53mG5aOoYimHO6H2kMWUpTlyEH4+
 E9f7fQf5VAzld8wGwP5RDoQEDXyo1bpV1oGaTPY49mfdui/iMtGCyt/IAPD0RNszXZ8dC/
 9MBBY6an8Q3t9EKTq6/PDUwB3Qq+ndE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651068031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zBYPiXfB5e+e5N8W0V5gphHaWVDdFWQHdwjXRCwZWMM=;
 b=th7Rrs33IiqVK8tnSEBlEnBxerpZHE8GDPr76s7JmYoaTPqqdGk7SZxG4uruidXREwVgP1
 LDLu7WxjBKgTSlCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C049813A39;
 Wed, 27 Apr 2022 14:00:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DnXlLX9MaWK4aQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 27 Apr 2022 14:00:31 +0000
Message-ID: <12b407ae-c5c9-8d80-9feb-3daf6d116528@suse.cz>
Date: Wed, 27 Apr 2022 16:00:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220427125003.20815-1-pvorel@suse.cz>
 <20220427125003.20815-2-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220427125003.20815-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/5] busy_poll_lib.sh: Mention setup/cleanup
 defined in tests
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

Hi,

On 27. 04. 22 14:49, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v3
> 
>  testcases/network/busy_poll/busy_poll_lib.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/network/busy_poll/busy_poll_lib.sh b/testcases/network/busy_poll/busy_poll_lib.sh
> index d17504466..69e590031 100755
> --- a/testcases/network/busy_poll/busy_poll_lib.sh
> +++ b/testcases/network/busy_poll/busy_poll_lib.sh
> @@ -1,10 +1,14 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) Linux Test Project, 2016-2022
>  # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
>  
> -TST_SETUP="setup"
>  TST_TESTFUNC="test"
> +
> +# setup and cleanup defined in tests using this library

Hooking up callbacks on the reverse end of include is some seriously
dirty code. I'd recommend dropping this patch and then making a separate
patchset to move those TST_SETUP/TST_CLEANUP variables out of the library.

> +TST_SETUP="setup"
>  TST_CLEANUP="cleanup"
> +
>  TST_MIN_KVER="3.11"
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_ROOT=1


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
