Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01992C00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 15:14:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 147DE3C954D
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 17:14:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 063CE3C013B
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 17:13:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 96596600803
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 17:13:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D569037F2F;
 Wed, 10 Aug 2022 15:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660144437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sca/31l4Sli9ZJ6W0yBUZfX1zUaahHDxq1m3PlTFjaA=;
 b=SCPX5S6Hizzx9lD5SF87CIcZLnHUKSChITLJhgZlCZOde8QY2zSIHIyXi1fk439c4uISY5
 XkXODwSfJwHhLQA4ruTCbvQrWlagghmxcmiS/rmm1LMbq4N9CzQ3Y3izc/DQcSu7JJR2yG
 +x/Xgkd0RepY6eudAPpD5dI6r1tXgAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660144437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sca/31l4Sli9ZJ6W0yBUZfX1zUaahHDxq1m3PlTFjaA=;
 b=haJ41jU1QNinVvYzk+uIKms/gjxJ98eCgM8WK3GismTEVODdBdgBCWAOEyNNOcshhsOok9
 s6YB+P8/qWd1UvBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA7DB13A7E;
 Wed, 10 Aug 2022 15:13:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H6mNLDXL82LsSgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 10 Aug 2022 15:13:57 +0000
Message-ID: <b7559faa-50db-a339-8685-1e0f55427513@suse.cz>
Date: Wed, 10 Aug 2022 17:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220808113756.11582-1-pvorel@suse.cz>
 <20220808113756.11582-5-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220808113756.11582-5-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] generate_lvm_runfile.sh: Fix bashism
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
I've tested the patchset and the generator script now work correctly.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 08. 08. 22 13:37, Petr Vorel wrote:
> ERR is not on dash (tested on 0.5.11).
> 
> using -e (i.e. implying 'set -e') is required to exit on any non zero
> exit code. It requires 2 previous fixes.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/misc/lvm/generate_lvm_runfile.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
> index 72b286a69..aba706c64 100755
> --- a/testcases/misc/lvm/generate_lvm_runfile.sh
> +++ b/testcases/misc/lvm/generate_lvm_runfile.sh
> @@ -1,6 +1,7 @@
> -#!/bin/sh
> +#!/bin/sh -e
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
> +# Copyright (c) Linux Test Project, 2022
>  #
>  # Generate LTP runfile for LVM tests (runtest/lvm.local)
>  
> @@ -13,7 +14,7 @@ LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
>  
>  generate_runfile()
>  {
> -	trap 'tst_brk TBROK "Cannot create LVM runfile"' ERR
> +	trap '[ $? -eq 0 ] || tst_brk TBROK "Cannot create LVM runfile"' EXIT
>  	INFILE="$LTPROOT/testcases/data/lvm/runfile.tpl"
>  	OUTFILE="$LTPROOT/runtest/lvm.local"
>  	FS_LIST=`tst_supported_fs`


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
