Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBAFC43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 12:05:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DA073E49D2
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 14:05:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B4FC3E49D2
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:05:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BF666200392
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:05:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22062741AA;
 Thu,  2 Jul 2026 12:05:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4D45779AA;
 Thu,  2 Jul 2026 12:05:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6hvFKvpTRmpnHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Jul 2026 12:05:14 +0000
Date: Thu, 2 Jul 2026 14:05:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wake Liu <wakel@google.com>
Message-ID: <20260702120509.GA535731@pevik>
References: <20260702042505.389515-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260702042505.389515-1-wakel@google.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 22062741AA
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/lsm_list_modules02: Log unrecognized LSM
 IDs with TINFO instead of TBROK
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
Cc: r.kothari@samsung.corp-partner.google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

> When running lsm_list_modules02 on systems with newer upstream kernels
> containing newly introduced LSMs, or on vendor/OEM kernels with out-of-tree
> security modules enabled, lsm_list_modules(ids, size, 0) returns valid LSM
> IDs that might not yet be mapped in the hardcoded switch (ids[i]) table.

> Currently, encountering any unrecognized LSM ID causes the test to immediately
> terminate with tst_brk(TBROK, "Unsupported LSM: %lu", ids[i]). This prevents
> testing of other well-known standard LSMs present on the system.

> Downgrade the unrecognized LSM ID handling from TBROK to TINFO and continue
> iterating over the remaining IDs. This improves test robustness across
> various kernel configurations while maintaining rigorous verification for all
> known standard LSM modules.

Thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>  testcases/kernel/syscalls/lsm/lsm_list_modules02.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/syscalls/lsm/lsm_list_modules02.c b/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
> index 91e5b7fa2..ede89ee73 100644
> --- a/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
> +++ b/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
> @@ -95,8 +95,11 @@ static void run(void)
>  			break;
>  		}

> -		if (!name)
> -			tst_brk(TBROK, "Unsupported LSM: %lu", ids[i]);
> +		if (!name) {
> +			tst_res(TINFO, "Skipping unrecognized LSM ID: %lu",
How about changing this to TCONF? It would be more obvious something was
skipped. This can be done before merge.

Kind regards,
Petr

> +				(unsigned long)ids[i]);
> +			continue;
> +		}

>  		for (counter = 0; counter < lsm_names_count; counter++) {
>  			if (!strcmp(name, lsm_names[counter].name)) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
