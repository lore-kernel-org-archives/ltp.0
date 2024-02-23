Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2C7C48BC4
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 09:04:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF1D53CF119
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 10:04:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8E863CCEE9
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 10:04:32 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 09E121410605
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 10:04:30 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 51A0B21F7C;
 Fri, 23 Feb 2024 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708679067;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qIrx8c3Ev1ixGS5DC754ZMYPj67o2AhiXcIB1s91iCU=;
 b=F90EDEKJAIBYjAVXZXXXPZzc6sTxWq/VJTRzOY0QZwCHJExZj2f3PgWqB6K0MHTA/qB5kB
 JLNjor2cNVolT3QbQmfBR5qg6wlCwdPOduWqQonzVWxtQGC7Q7p8jB70g4tUzc7qfHy8Kl
 fy7dJNJ3baxTm7bfFcqVxlqsIsiAASs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708679067;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qIrx8c3Ev1ixGS5DC754ZMYPj67o2AhiXcIB1s91iCU=;
 b=E+jU47OV54kZuomoWvED8gXdWi/D+P0Uz78KBYT6MF0U+a0AnGSKMQ19dzgxymcx3+2sx2
 tP+IXtswaaEPemCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708679066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qIrx8c3Ev1ixGS5DC754ZMYPj67o2AhiXcIB1s91iCU=;
 b=ModHB4zs16nQuaqqtmyJAj4v0UkoGTXB46voVplZQSfnhv5xuJa50Ccuz4QzeLrZA1CRX6
 vhaXrF5G0Btb4yqybvmurYESIFtSRw49ZmjuJ3/mIOwbbo3USZTA/6mjBhMe3M+uZly91u
 VskqAfvvdyx27gLo0pyPkAcWudMLai0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708679066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qIrx8c3Ev1ixGS5DC754ZMYPj67o2AhiXcIB1s91iCU=;
 b=18VPwqbAGg9b8KAeczeyMxcoE3L8I7k4QPBENVTw347AfeG8B/dTzpYulmTze+RgWfqp71
 zPb/MhKTP0tV4FBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 31B7A13776;
 Fri, 23 Feb 2024 09:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id KsjOCppf2GXbOgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 09:04:26 +0000
Date: Fri, 23 Feb 2024 10:04:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240223090416.GC1423688@pevik>
References: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ModHB4zs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=18VPwqbA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email,suse.cz:dkim,suse.cz:email]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 51A0B21F7C
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/7] libltpswap: Add tst_max_swapfiles api
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

Hi Yang Xu,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
generally LGTM, just minor things below.

nit in subject: s/api/API/

> Current, the kernel constant MAX_SWAPFILES value is calculated as below
nit: I'm not a native speaker, but:
s/Current/Currently/

> ------------------------------------
> //#ifdef CONFIG_DEVICE_PRIVATE
> //#define SWP_DEVICE_NUM 4
> //#else
> //#define SWP_DEVICE_NUM 0
> //#endif

> //#ifdef CONFIG_MIGRATION
> //#define SWP_MIGRATION_NUM 3
> //#else
> //#define SWP_MIGRATION_NUM 0

> //#ifdef CONFIG_MEMORY_FAILURE
> //#define SWP_HWPOISON_NUM 1
> //#else
> //#define SWP_HWPOISON_NUM 0
> //#endif

> //#define SWP_PTE_MARKER_NUM 1
> //#define MAX_SWAPFILES_SHIFT   5

> //#define MAX_SWAPFILES \
> //      ((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
> //      SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - \
> //      SWP_PTE_MARKER_NUM)

nit: if you indent this code with space or tab it will be visible without //.
Using // makes text harder to read.

> ------------------------------------
> Also, man-pages missed something after 5.14 kernel. I have sent two patches[1][2] to
> add it. The kernel patches modify this kernel constant in[3][4][5][6]. Also, after kernel 6.2.0
> [7],kernel always compile in pte markers.

> [1]https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=26f3ec74e
> [2]https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=6bf3937fc
> [3]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=5042db43cc
> [4]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=b756a3b5e
> [5]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=679d10331
> [6]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=6c287605f
> [7]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/swap.h?id=ca92ea3dc5

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  include/libswap.h         |  6 +++++
>  libs/libltpswap/libswap.c | 48 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)

> diff --git a/include/libswap.h b/include/libswap.h
> index bdc5aacc6..361d73175 100644
> --- a/include/libswap.h
> +++ b/include/libswap.h
> @@ -21,4 +21,10 @@ int make_swapfile(const char *swapfile, int blocks, int safe);
>   * we are testing on.
>   */
>  bool is_swap_supported(const char *filename);
> +
> +/*
> + * Get kernel constant MAX_SWAPFILES value
nit: . at the end.

> + */
> +int tst_max_swapfiles(void);
> +
>  #endif /* __LIBSWAP_H__ */
> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index c79de19d7..a404a4ada 100644
> --- a/libs/libltpswap/libswap.c
> +++ b/libs/libltpswap/libswap.c
> @@ -16,6 +16,8 @@
>  #include "tst_test.h"
>  #include "libswap.h"
>  #include "lapi/syscalls.h"
> +#include "tst_kconfig.h"
> +#include "tst_safe_stdio.h"

>  static const char *const swap_supported_fs[] = {
>  	"btrfs",
> @@ -217,3 +219,49 @@ bool is_swap_supported(const char *filename)

>  	return true;
>  }
> +
> +/*
> + * Get kernel constant MAX_SWAPFILES value
nit: . at the end.

> + */
> +int tst_max_swapfiles(void)
> +{
> +	unsigned int max_swapfile = 32;
nit never change, maybe
#define DEFAULT_MAX_SWAPFILE 32

> +	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0, swp_device_num = 0, swp_pte_marker_num = 0;
nit: very long line maybe split (readability):
	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0,
		     swp_device_num = 0, swp_pte_marker_num = 0;

But file is full of ugly lines, feel free to ignore.

> +	struct tst_kconfig_var migration_kconfig = TST_KCONFIG_INIT("CONFIG_MIGRATION");
> +	struct tst_kconfig_var memory_kconfig = TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE");
> +	struct tst_kconfig_var device_kconfig = TST_KCONFIG_INIT("CONFIG_DEVICE_PRIVATE");
> +	struct tst_kconfig_var marker_kconfig = TST_KCONFIG_INIT("CONFIG_PTE_MARKER");
Maybe shorten variable - remove "_kconfig" (obvious from use by .choice member).

> +
> +	tst_kconfig_read(&migration_kconfig, 1);
> +	tst_kconfig_read(&memory_kconfig, 1);
> +	tst_kconfig_read(&device_kconfig, 1);
> +	tst_kconfig_read(&marker_kconfig, 1);
> +
> +	if (migration_kconfig.choice == 'y') {
> +		if (tst_kvercmp(5, 19, 0) < 0)
> +			swp_migration_num = 2;
> +		else
> +			swp_migration_num = 3;
> +	}
> +
> +	if (memory_kconfig.choice == 'y')
> +		swp_hwpoison_num = 1;
> +
> +	if (device_kconfig.choice == 'y') {
> +		if (tst_kvercmp(4, 14, 0) >= 0)
> +			swp_device_num = 2;
> +		if (tst_kvercmp(5, 14, 0) >= 0)
> +			swp_device_num = 4;
> +	}
> +
> +	if (tst_kvercmp(6, 2, 0) >= 0) {
> +		swp_pte_marker_num = 1;
> +	} else {
> +		if (marker_kconfig.choice == 'y') {
> +			if (tst_kvercmp(5, 19, 0) >= 0)
> +				swp_pte_marker_num = 1;
> +		}

Maybe just:

	if ((marker_kconfig.choice == 'y' && tst_kvercmp(5, 19, 0) >= 0) ||
		tst_kvercmp(6, 2, 0) >= 0) {
		swp_pte_marker_num = 1;
	}

> +	}
> +
> +	return max_swapfile - swp_migration_num - swp_hwpoison_num - swp_device_num - swp_pte_marker_num;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
