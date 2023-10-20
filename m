Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84428CDB474
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 14:34:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A40113CEDC4
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 16:34:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23EF03C8495
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 16:34:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5C6921BB9FC8
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 16:34:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9FFE01F854;
 Fri, 20 Oct 2023 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697812469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXr+sTan/cGHm53B5v8HCFh72nCh6Tq20pxDp0I6khQ=;
 b=pamiXrnW8AD9DTfgVCBI0d2WBpjIz5O9SXeYNAV0s75Ie2O3sz3lZHbTqdByLU68l+DMo8
 eAFMY03ctpva/AumuehHp+bU1jUn3KtIi4G6WuSKhBFz8RdY17tw31WQtRgrPi/f79Z3FM
 LRS5O8xJhuL+G8IRDGb3JXy1IvcN9yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697812469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXr+sTan/cGHm53B5v8HCFh72nCh6Tq20pxDp0I6khQ=;
 b=Mn9/tcfQEiFJLYGg7LoqulsKiHarPzY5GuRRUh+N5w97VCVsz3VttQdkXOtFE6HRAdWPML
 tjOAPUvYG5CDTNCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77B7813584;
 Fri, 20 Oct 2023 14:34:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bJ6rG/WPMmXvSQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 20 Oct 2023 14:34:29 +0000
Message-ID: <ca93e490-bd8e-3ecc-9426-9637bb9a6c6b@suse.cz>
Date: Fri, 20 Oct 2023 16:34:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20231020110918.26066-1-pvorel@suse.cz>
 <20231020110918.26066-2-pvorel@suse.cz>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20231020110918.26066-2-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-11.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] setsockopt10: Use lapi/{socket,
 tcp}.h to fix compilation
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
I've checked that setsockopt10 will compile on SLE-15SP1. For both patches:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 20. 10. 23 13:09, Petr Vorel wrote:
> Distros with glibc-2.26 and older will fail due missing SOL_TLS
> in <sys/socket.h> and TCP_ULP in <netinet/tcp.h>. Use fallback
> definitions in lapi/socket.h and lapi/tcp.h.
> 
> Also replace quotes ("") with sharp brackets (<>) for <netinet/in.h>
> (it's a system header, the same was for netinet/tcp.h, but it was
> replaced with lapi).
> 
> Fixes: bdb37aab9 ("Add setsockopt10 TLS ULP UAF CVE-2023-0461")
> Reported-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/syscalls/setsockopt/setsockopt10.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt10.c b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
> index afd2c40a1..4e7e44938 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt10.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
> @@ -49,10 +49,11 @@
>   #ifdef HAVE_LINUX_TLS_H
>   
>   #include <linux/tls.h>
> -#include "netinet/in.h"
> -#include "netinet/tcp.h"
> +#include <netinet/in.h>
>   
>   #include "lapi/sched.h"
> +#include "lapi/socket.h"
> +#include "lapi/tcp.h"
>   #include "tst_checkpoint.h"
>   #include "tst_net.h"
>   #include "tst_safe_net.h"

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
