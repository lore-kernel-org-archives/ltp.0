Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15A2C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 07:46:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 064183CD990
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 08:46:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B718C3CB700
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 08:46:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C3FEA1400F98
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 08:46:30 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA99D1F37E;
 Tue, 28 Nov 2023 07:46:27 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B50CE133B5;
 Tue, 28 Nov 2023 07:46:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id IF0NK9OaZWVXNAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 07:46:27 +0000
Date: Tue, 28 Nov 2023 08:46:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Stefan Roesch <shr@devkernel.io>
Message-ID: <20231128074626.GA298624@pevik>
References: <20231127174517.2369593-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231127174517.2369593-1-shr@devkernel.io>
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [6.15 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 ARC_NA(0.00)[]; R_SPF_SOFTFAIL(4.60)[~all];
 RCPT_COUNT_FIVE(0.00)[6];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_COUNT_THREE(0.00)[3]; DMARC_NA(1.20)[suse.cz];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(0.46)[0.132];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: DA99D1F37E
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mem: disable KSM smart scan for ksm tests
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
Cc: linux-mm@kvack.org, kernel-team@fb.com, oliver.sang@intel.com,
 ltp@lists.linux.it, david@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stefan,

> This disables the "smart scan" KSM feature to make sure that the volatile
> count remains at 0.

> Signed-off-by: Stefan Roesch <devkernel.io>
nit: you forgot 'shr@'
Signed-off-by: Stefan Roesch <shr@devkernel.io>

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202311161132.13d8ce5a-oliver.sang@intel.com
> ---
>  testcases/kernel/mem/lib/mem.c | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index fbfeef026..ef274a3ac 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -454,6 +454,9 @@ void create_same_memory(int size, int num, int unit)
>  	       {'a', size*MB}, {'a', size*MB}, {'d', size*MB}, {'d', size*MB},
>  	};

> +  /* Disable smart scan for correct volatile counts. */
> +  SAFE_FILE_PRINTF(PATH_KSM "smart_scan", "0");
NOTE, this fails on the systems without /sys/kernel/mm/ksm/smart_scan:

mem.c:458: TBROK: Failed to open FILE '/sys/kernel/mm/ksm/smart_scan' for writing: EACCES (13)

NOTE, we normally handle the setup like this in test setup function.

But new API has .save_restore which is more robust for tasks  like this.
It's already used in ksm01.c, you need just to add this line:
	{"/sys/kernel/mm/ksm/smart_scan", "0", TST_SR_SKIP},

(instead of both SAFE_FILE_PRINTF)

See:
https://github.com/linux-test-project/ltp/wiki/C-Test-API#127-saving--restoring-procsys-values

I wonder if ksm01.c is the only ksm test which needs to disable this.

also nit: there is a wrong indent (spaces instead of tabs), please be consistent
with the file content.

NOTE: while this fixes problem on 6.7.0-rc1-2.g86e46c2-default (openSUSE),
it does not fixes other problem on 6.5.10 on Debian (16 errors like these below):

mem.c:252: TFAIL: pages_shared is not 2 but 5038.
mem.c:252: TFAIL: pages_sharing is not 98302 but 593629.
mem.c:252: TFAIL: pages_volatile is not 0 but 391.
mem.c:252: TFAIL: pages_unshared is not 0 but 149157.

I have no idea if this is a real bug which needs to be fixed or test false
positive to be fixed, or whether the problem has already been fixed in newer
kernels.

> +
>  	ps = sysconf(_SC_PAGE_SIZE);
>  	pages = MB / ps;

> @@ -526,6 +529,7 @@ void create_same_memory(int size, int num, int unit)

>  	tst_res(TINFO, "stop KSM.");
>  	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
> +  SAFE_FILE_PRINTF(PATH_KSM "smart_scan", "1");
nit: Again, wrong indent. You could have seen it also in the generated patch.

Kind regards,
Petr

>  	final_group_check(0, 0, 0, 0, 0, 0, size * pages * num);

>  	while (waitpid(-1, &status, 0) > 0)

> base-commit: 8c89ef3d451087ed6e18750bd5eedd10e5ab3d2e

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
