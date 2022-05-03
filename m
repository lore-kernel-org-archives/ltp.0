Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D142C433FE
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 14:38:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD8F53CA8C8
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 16:38:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B05653CA48D
 for <ltp@lists.linux.it>; Tue,  3 May 2022 16:38:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4DB686000EC
 for <ltp@lists.linux.it>; Tue,  3 May 2022 16:38:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8378D1F749;
 Tue,  3 May 2022 14:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651588684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TvgMKhvz5t6eCTXAPaaIG8f+eawTHbBB7SKYrcZGueY=;
 b=bA3Vg/iNTRIRXLS8U14gViLpAIJPIbOpDAoMtes0GWrr4DZv5GXlBWTcU9h2sdLo3DyckB
 OG8+hIDUjND4dH/Ch3iHyYZtL89RbBKOJw7ge/hNF8l/dWwvvv2BLpQn7yCNisQwYssXx2
 bTXekLKDP0e7ZEFd2lE2yfTF1RxpQUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651588684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TvgMKhvz5t6eCTXAPaaIG8f+eawTHbBB7SKYrcZGueY=;
 b=oKFEwrQJ9iyqBtQNP//Z3hI8FnbhDpr8nS7oT0Ym2F5XAPQuHMyZM7vGkoogpx4TxsIyIb
 iOL5lTRZdYzRB5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55B5B13AA3;
 Tue,  3 May 2022 14:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id e6hME0w+cWKNawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 May 2022 14:38:04 +0000
Date: Tue, 3 May 2022 16:38:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Message-ID: <YnE+SjQ9E5yQ6RIM@pevik>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
 <2a67385fe34905b5b631abadb6daefb6f595a924.1651176646.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a67385fe34905b5b631abadb6daefb6f595a924.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/19] tst_test_macros: Add TST_TOSTR macro
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

Hi Luke,

> Add the TST_TOSTR macro which uses a preprocessor trick to concetenate
> variables into strings.

> Useful when needing to create strings from other #define variables.

> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
>  include/tst_test_macros.h | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index 2e7b7871c..f5d86c421 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
include/tst_common.h would be probably a better place.
Because tst_test_macros.h contains tests which call TEST() helpers.

> @@ -36,6 +36,9 @@ extern void *TST_RET_PTR;

>  #define TST_2_(_1, _2, ...) _2

> +#define _TST_TOSTR(STR) #STR
At least 3 tests have:
#define str(s) #s (or STR)

(testcases/network/stress/route/route-change-netlink.c
testcases/kernel/controllers/freezer/vfork.c
testcases/kernel/pty/pty04.c)

therefore IMHO it'd be better to define:
#define TST_STR(s) #s
#define TST_TOSTR(s) TST_STR(s)

> +#define TST_TOSTR(STR) _TST_TOSTR(STR)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
