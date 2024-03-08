Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F62C54E4A
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 08:48:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 296133CE965
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 09:48:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B67493C196B
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 09:47:57 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A344F64870D
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 09:47:56 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AAF145CB0B;
 Fri,  8 Mar 2024 08:47:52 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 903C01391D;
 Fri,  8 Mar 2024 08:47:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id cxj2IbjQ6mXrLwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 08 Mar 2024 08:47:52 +0000
Date: Fri, 8 Mar 2024 09:47:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240308084751.GA257921@pevik>
References: <20240308045230.3106549-1-liwang@redhat.com>
 <20240308045230.3106549-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240308045230.3106549-2-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: AAF145CB0B
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] init_module: To handle kernel module
 signature enforcement
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

> The patch modifies init_module syscall test cases to account
> for kernel module signature enforcement. It adds parsing for
> the 'module.sig_enforce' parameter and adjusts test expectations
> based on whether signature enforcement is enabled, using
> new conditional logic.

> If enforcement is active, tests expect an EKEYREJECTED error;
> otherwise, they proceed as normal.

...
> diff --git a/testcases/kernel/syscalls/delete_module/delete_module01.c b/testcases/kernel/syscalls/delete_module/delete_module01.c
> index 90d8b5289..4c31f81b0 100644
> --- a/testcases/kernel/syscalls/delete_module/delete_module01.c
> +++ b/testcases/kernel/syscalls/delete_module/delete_module01.c
> @@ -14,8 +14,10 @@
>   * Install dummy_del_mod.ko and delete it with delete_module(2).
>   */

> +#include <stdlib.h>
>  #include "tst_test.h"
>  #include "tst_module.h"
> +#include "tst_kconfig.h"
>  #include "lapi/syscalls.h"

>  #define MODULE_NAME	"dummy_del_mod"
> @@ -25,6 +27,12 @@ static int module_loaded;

>  static void do_delete_module(void)
>  {
> +	struct tst_kcmdline_param params = TST_KCMDLINE_INIT("module.sig_enforce");
> +
> +	tst_kcmdline_parse(&params, 1);
> +	if (atoi(params.value) == 1)
> +		tst_brk(TCONF, "module signature is enforced, skip test");
Only 2 tests do tst_brk(TCONF). I was thinking about adding library flag
.skip_in_module_sig_enforce, but probably not worth of it.

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
