Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3847BC48BEB
	for <ltp@archiver.kernel.org>; Fri, 16 Feb 2024 11:23:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CD923D0D70
	for <ltp@archiver.kernel.org>; Fri, 16 Feb 2024 12:23:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4523C3C0701
 for <ltp@lists.linux.it>; Fri, 16 Feb 2024 12:23:00 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F07241401630
 for <ltp@lists.linux.it>; Fri, 16 Feb 2024 12:22:59 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20C352200D;
 Fri, 16 Feb 2024 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708082576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R3N/RF9ohSqFrOG9obWPVE7NLGoc1/V0CitQcJB4Ixk=;
 b=UUT0b4kj3N/v7x03qG/kxW3Ip50XP0WqLfz0mWz/j9nYnv1PqaCWIp4U68jGCd+nwqaR/d
 O9ICUbgqozcXlk+GSsrpPSl36BeRDolAJCz75wm0zPQw6AGEGqi98mnzh/x9k44IF7TE5r
 ICXbvxPyqkotqpL9edw4/27K0v8GOY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708082576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R3N/RF9ohSqFrOG9obWPVE7NLGoc1/V0CitQcJB4Ixk=;
 b=nDlpjsslUCOJ+qxfsOy/f0i0MAUl7wIoou7T1VlAJ96JEWLVwOiXgyOCTs/fGJ9dLhIU+r
 LoFSRSbJI5M0F9Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708082574;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R3N/RF9ohSqFrOG9obWPVE7NLGoc1/V0CitQcJB4Ixk=;
 b=WGhYJhZPkk1DGZ9rs7x/tbbRizoT7LxglLrYxo0aUOksdX7vqdShqUi7+p5SHckXTvvWxS
 gjwBwxhq/hXYhbN4LxG62tHmOAP4DI+Ai3gL55bUj+X7zU+2FzGPRLwRMCLfDauHv3JJGS
 2qiX2vUpRX+b3u7QYEewXjAuAWCWWAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708082574;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R3N/RF9ohSqFrOG9obWPVE7NLGoc1/V0CitQcJB4Ixk=;
 b=BTwMXWtMx07d+kq2PT5YzwhtOCwTpSK/cliMPCYAWwiexHkKSoa0PyI+8qlyveMsUz3GGO
 yfi30VC3eXohR3AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E67BD13421;
 Fri, 16 Feb 2024 11:22:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 6W7DNY1Fz2X2EgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 16 Feb 2024 11:22:53 +0000
Date: Fri, 16 Feb 2024 12:22:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240216112251.GA903763@pevik>
References: <20231106093031.1844129-1-liwang@redhat.com>
 <20231106093031.1844129-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231106093031.1844129-2-liwang@redhat.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib: add support for kinds of hpsize
 reservation
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

Hi Li,

> Typically when we make use of huge page via LTP library, .hugepages choose
> the default hugepage size, but this can not satisfy all scenarios.

> So this patch introduces applying a specified types of hugepage for user.

> There is nothing that needs to change for the existing test cases which
> already using .hugepages, it only needs to fill one more field in the
> structure of .hugepages if a different type (GIGANTIC or HUGE) is required.

> e.g.

>     static struct tst_test test = {
> 	.needs_root = 1,
> 	...
> 	.hugepages = {2, TST_NEEDS, TST_GIGANTIC},
>     };

+1

Algorithm looks good to me.
It would be nice to add a new test or to modify at least one of the library
tests to use some of the new functionality.

Below only very minor formatting notes.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  doc/C-Test-API.asciidoc | 42 +++++++++++++++++++++++++--
>  include/tst_hugepage.h  | 11 +++++++
>  lib/tst_hugepage.c      | 63 ++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 107 insertions(+), 9 deletions(-)

> diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
> index dab811564..82a1866d3 100644
> --- a/doc/C-Test-API.asciidoc
> +++ b/doc/C-Test-API.asciidoc
> @@ -2034,9 +2034,13 @@ For full documentation see the comments in 'include/tst_fuzzy_sync.h'.
>  ~~~~~~~~~~~~~~~~~~~~~~~~

>  Many of the LTP tests need to use hugepage in their testing, this allows the
> -test can reserve hugepages from system via '.hugepages = {xx, TST_REQUEST}'.
> +test can reserve specify size of hugepages from system via:
> +  '.hugepages = {xx, TST_REQUEST, TST_HUGE}'  or,
> +  '.hugepages = {xx, TST_NEEDS,   TST_GIGANTIC}'.
very nit: this formats in wiki as inline. If you meant to have the previous following
showing also as a list, it would have to be:

test can reserve specify size of hugepages from system via:

* '.hugepages = {xx, TST_REQUEST, TST_HUGE}'  or,
* '.hugepages = {xx, TST_NEEDS,   TST_GIGANTIC}'.

very nit: maybe N instead of XX?

> -We achieved two policies for reserving hugepages:
> +xx: This is used to set how many pages we wanted.
> +
> +Two policies for reserving hugepage:

>  TST_REQUEST:
>    It will try the best to reserve available huge pages and return the number
> @@ -2049,6 +2053,17 @@ TST_NEEDS:
>    use these specified numbers correctly. Otherwise, test exits with TCONF if
>    the attempt to reserve hugepages fails or reserves less than requested.

> +Two types of the reserved hugepage (optional field):
> +
> +TST_HUGE:
> +  It means target for reserve the default hugepage size (e.g. 2MB on x86_64).
> +  And, if nothing fills in this field LTP also chooses the default hugepage
> +  size to reserve. i.e.
> +  '.hugepages = {xx, TST_REQUEST}' == '.hugepages = {xx, TST_REQUEST, TST_HUGE}'
> +
> +TST_GIGANTIC:
> +  It means target for reserve the largest hugepage size (e.g. 1GB on x86_64)
very nit: missing '.' at the end.

> +
...
> +or,
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	...
> +}
> +
> +struct tst_test test = {
> +	.test_all = run,
> +	/*
> +	 * Specify gigantic page sizes reserved automatically in the library
> +	 * $ echo 2 > /sys/kernel/mm//hugepages/hugepages-1048576kB/nr_hugepages
> +	 * Do check if 2 hpages are reserved correctly in there.
Maybe my bad English, but this looked to me at first as imperative, e.g.:
"Hey, test author, do check the value!" Maybe something like "Library checks
whether 2 hpages is actually set.".

> +	 */
> +	.hugepages = {2, TST_NEEDS, TST_GIGANTIC},
> +	...
> +};
> +-------------------------------------------------------------------------------
> +
>  1.35 Checking for required commands
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
> index 46327c79a..725b4ddaf 100644
> --- a/include/tst_hugepage.h
> +++ b/include/tst_hugepage.h
> @@ -24,9 +24,15 @@ enum tst_hp_policy {
>  	TST_NEEDS,
>  };

> +enum tst_hp_type {
> +	TST_HUGE,
> +	TST_GIGANTIC,
> +};
> +
>  struct tst_hugepage {
>  	const unsigned long number;
>  	enum  tst_hp_policy policy;
> +	enum  tst_hp_type   hptype;
>  };

>  /*
> @@ -34,6 +40,11 @@ struct tst_hugepage {
>   */
>  size_t tst_get_hugepage_size(void);

> +/*
> + * Get the largest hugepage (gigantic) size. Returns 0 if hugepages are not supported.
> + */
> +size_t tst_get_gigantic_size(void);
..
> +++ b/lib/tst_hugepage.c
> @@ -5,6 +5,7 @@

>  #define TST_NO_DEFAULT_MAIN

> +#include <stdio.h>
>  #include "tst_test.h"
>  #include "tst_hugepage.h"

> @@ -20,11 +21,35 @@ size_t tst_get_hugepage_size(void)
>  	return SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
>  }

> +size_t tst_get_gigantic_size(void)
> +{
> +	DIR *dir;
> +	struct dirent *ent;
> +	unsigned long max, g_pgsz;
> +
> +	max = tst_get_hugepage_size() / 1024;
> +
> +	/*
> +	 * Scanning the largest hugepage sisze, for example aarch64 configuration:
nit: s/sisze/size/

> +	 * hugepages-1048576kB hugepages-32768kB hugepages-2048kB hugepages-64kB
> +	 */
> +	dir = SAFE_OPENDIR(PATH_HUGEPAGES);
> +	while ((ent = SAFE_READDIR(dir)) != NULL) {
> +		if (sscanf(ent->d_name, "hugepages-%lukB", &g_pgsz)
> +				&& (g_pgsz > max))
> +			max = g_pgsz;
> +	}
> +
> +	SAFE_CLOSEDIR(dir);
> +	return max * 1024;
> +}
...

The rest LGTM.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
