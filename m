Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DD3CD3430
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 15:12:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F3F13E6218
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 17:12:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A24F3E5C80
 for <ltp@lists.linux.it>; Mon,  4 May 2026 17:11:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 06E8D1400217
 for <ltp@lists.linux.it>; Mon,  4 May 2026 17:11:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1AF9A5C711;
 Mon,  4 May 2026 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777907504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ESmUCsGq2PkKOj+Gcv/tEVsOnv53fscCEtV+bTx8DM=;
 b=HbAIoNOxWeUj9VvGBXkp3gAqTRsNyEkTyiHZFSaDTzxZSL1XukicGDCAmBjT7Z2ytNrVoL
 v4ZazdEogqi66MTdbqQ38yqz0XIeJQaGLVmvzSQTU/oYPDxutFzg8d/aZqcSJk2oUNdAOp
 HBErGSMLBYT4aM3PKC0GvRQvWHjrKA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777907504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ESmUCsGq2PkKOj+Gcv/tEVsOnv53fscCEtV+bTx8DM=;
 b=GRa1MT8kcu0gVHqmLU56KxgA1HbDRrGuucSD49FjU9rNsNX3x3mEnG8DHvBTmYulcGS6n+
 6ayRMxJ/XZkegIDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777907504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ESmUCsGq2PkKOj+Gcv/tEVsOnv53fscCEtV+bTx8DM=;
 b=HbAIoNOxWeUj9VvGBXkp3gAqTRsNyEkTyiHZFSaDTzxZSL1XukicGDCAmBjT7Z2ytNrVoL
 v4ZazdEogqi66MTdbqQ38yqz0XIeJQaGLVmvzSQTU/oYPDxutFzg8d/aZqcSJk2oUNdAOp
 HBErGSMLBYT4aM3PKC0GvRQvWHjrKA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777907504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ESmUCsGq2PkKOj+Gcv/tEVsOnv53fscCEtV+bTx8DM=;
 b=GRa1MT8kcu0gVHqmLU56KxgA1HbDRrGuucSD49FjU9rNsNX3x3mEnG8DHvBTmYulcGS6n+
 6ayRMxJ/XZkegIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09E96593A3;
 Mon,  4 May 2026 15:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7TqKATC3+GmkBQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 04 May 2026 15:11:44 +0000
Date: Mon, 4 May 2026 17:11:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <li.wang@linux.dev>
Message-ID: <afi3Ml5vFv2irnc0@yuki.lan>
References: <20260501135100.42278-1-li.wang@linux.dev>
 <20260504133020.14129-1-li.wang@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260504133020.14129-1-li.wang@linux.dev>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,linux.dev:email];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 linux.dev:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Introduce tst_path.h to consolidate
 system paths
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Linux Test Project, 2026
> + * Copyright (c) 2026 Li Wang <li.wang@linux.dev>
> + */
> +
> +#ifndef TST_PATH__
> +#define TST_PATH__
> +
> +/* PROC */
> +#define PROC_SYS_VM		"/proc/sys/vm/"
> +#define PROC_SYS_FS		"/proc/sys/fs/"
> +#define PROC_SYS_NET		"/proc/sys/net/"
> +#define PROC_SYS_USER		"/proc/sys/user/"
> +#define PROC_SYS_KERNEL		"/proc/sys/kernel/"
> +/* SYS */
> +#define SYS_KERNEL_MM		"/sys/kernel/mm/"

I wonder if this is really better. The macro name is not shorter and the
kernel path is not going to change since it's part of API.

> +
> +/* VM */
> +#define PATH_VM_NR_HPAGES       PROC_SYS_VM "nr_hugepages"
> +#define PATH_VM_OC_HPAGES       PROC_SYS_VM "nr_overcommit_hugepages"
> +#define PATH_VM_DROP_CACHES     PROC_SYS_VM "drop_caches"
> +#define PATH_VM_COMPACT_MEMORY  PROC_SYS_VM "compact_memory"
> +
> +/* HUGETLB */
> +#define PATH_MM_HUGEPAGES	SYS_KERNEL_MM "hugepages/"
> +#define PATH_MM_THP		SYS_KERNEL_MM "transparent_hugepage/"

These make more sense since the path is long and the macro makes it
shorter.

> +/* KSM */
> +#define PATH_MM_KSM		SYS_KERNEL_MM "ksm/"
> +#define MM_KSM_FP(s)		(PATH_MM_KSM s)
> +
> +/* NETWORK */
> +#define PATH_NET_IPV4		PROC_SYS_NET "ipv4/"
> +#define NET_IPV4_FP(s)		(PATH_NET_IPV4 s)
> +
> +/* MEMINFO */
> +#define MEMINFO_HPAGE_TOTAL	"HugePages_Total:"
> +#define MEMINFO_HPAGE_FREE	"HugePages_Free:"
> +#define MEMINFO_HPAGE_RSVD	"HugePages_Rsvd:"
> +#define MEMINFO_HPAGE_SURP	"HugePages_Surp:"
> +#define MEMINFO_HPAGE_SIZE	"Hugepagesize:"
> +
> +#endif /* TST_PATH_H */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index f12c59f39..4898cfe4c 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -26,6 +26,7 @@
>  #include "tst_mkfs.h"
>  #include "tst_fs.h"
>  #include "tst_pid.h"
> +#include "tst_path.h"
>  #include "tst_cmd.h"
>  #include "tst_cpu.h"
>  #include "tst_process_state.h"
> diff --git a/lib/newlib_tests/test19.c b/lib/newlib_tests/test19.c
> index a5683eaa4..0a7766192 100644
> --- a/lib/newlib_tests/test19.c
> +++ b/lib/newlib_tests/test19.c
> @@ -10,7 +10,7 @@
>  
>  static void setup(void)
>  {
> -	SAFE_FILE_PRINTF("/proc/sys/kernel/core_pattern", "changed");
> +	SAFE_FILE_PRINTF(PROC_SYS_KERNEL "core_pattern", "changed");
>  	tst_sys_conf_dump();
>  }
>  
> @@ -25,8 +25,8 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.save_restore = (const struct tst_path_val[]) {
>  		{"/proc/nonexistent", NULL, TST_SR_SKIP},
> -		{"/proc/sys/kernel/numa_balancing", NULL, TST_SR_TBROK},
> -		{"/proc/sys/kernel/core_pattern", NULL, TST_SR_TCONF},
> +		{PROC_SYS_KERNEL "numa_balancing", NULL, TST_SR_TBROK},
> +		{PROC_SYS_KERNEL "core_pattern", NULL, TST_SR_TCONF},

This is exactly what I'm unsure about, it's not shorter, nor more
readable.

Maybe if this was PATH_NUMA_BALANCING and PATH_CORE_PATTERN it would be
shorter and would make much more sense.

Shortening this to SYS_KERNEL("numa_balancing") would be confusing since
we have both /proc/sys/ and /sys/

...

> diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
> index be03f943f..d61ac77b5 100644
> --- a/testcases/kernel/mem/ksm/ksm01.c
> +++ b/testcases/kernel/mem/ksm/ksm01.c
> @@ -74,13 +74,13 @@ static struct tst_test test = {
>  	},
>  	.setup = setup,
>  	.save_restore = (const struct tst_path_val[]) {
> -		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
> -		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
> -		{"/sys/kernel/mm/ksm/max_page_sharing", NULL,
> +		{MM_KSM_FP("run"), NULL, TST_SR_TBROK},
> +		{MM_KSM_FP("sleep_millisecs"), NULL, TST_SR_TBROK},
> +		{MM_KSM_FP("max_page_sharing"), NULL,
>  			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> -		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
> +		{MM_KSM_FP("merge_across_nodes"), "1",
>  			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> -		{"/sys/kernel/mm/ksm/smart_scan", "0",
> +		{MM_KSM_FP("smart_scan"), "0",
>  			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
>  		{}
>  	},

These looks reasonable.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
