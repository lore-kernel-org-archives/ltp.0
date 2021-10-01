Return-Path: <SRS0=BYKQ=OV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588EFC433F5
	for <ltp@archiver.kernel.org>; Fri,  1 Oct 2021 09:19:28 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E66E610C8
	for <ltp@archiver.kernel.org>; Fri,  1 Oct 2021 09:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E66E610C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E3F33C961A
	for <ltp@archiver.kernel.org>; Fri,  1 Oct 2021 11:19:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28D763C6D2D
 for <ltp@lists.linux.it>; Fri,  1 Oct 2021 11:19:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5994D200FC5
 for <ltp@lists.linux.it>; Fri,  1 Oct 2021 11:19:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 373512269A;
 Fri,  1 Oct 2021 09:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633079954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqfcaRuHMeWL/Pp8ToEOk3s1hKFA4475JqwCT9seqQs=;
 b=l9AMK28MYbouuK+JocPWuXLV1MisDFSbRKgUyHdP9JqPTUS0yXHptqDk2R1BLNRhEVIxJG
 CSE66EKEDHxyHi0NHcM+5jzwPppQ3XvAFy9LxGvzpWns9vQjTeXQPr3B3dD4vB7luoJVfi
 kRPoQEzmvKtB1tRGTMqGt6msbVVr0bU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633079954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqfcaRuHMeWL/Pp8ToEOk3s1hKFA4475JqwCT9seqQs=;
 b=z8lRznaFV0MnL0wx9+2ljAgxde/Ip3JxLRnQSs82gitb66EcOHkSHPrQsm2lJn3MNK0tHZ
 ajW/fxB/goFRrJDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2208713A5C;
 Fri,  1 Oct 2021 09:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id U6AmB5LSVmHGawAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 01 Oct 2021 09:19:14 +0000
Message-ID: <8868d50b-0f30-7570-5d26-d93d809e6cf6@suse.cz>
Date: Fri, 1 Oct 2021 11:19:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To: Petr Vorel <petr.vorel@gmail.com>, ltp@lists.linux.it
References: <20210930183058.5240-1-petr.vorel@gmail.com>
 <20210930183058.5240-4-petr.vorel@gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20210930183058.5240-4-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v2 3/3] lapi/if_addr.h: Define IFA_FLAGS
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
commit message for this patch should be "Define IFA_F_NOPREFIXROUTE" but
that can be fixed during merge. Apart from that, the whole patchset
looks good.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 30. 09. 21 20:30, Petr Vorel wrote:
> and use it in icmp_rate_limit01.c.
> 
> This fixes error on toolchains with very old kernel headers, e.g.
> Buildroot sourcery-arm:
> 
> icmp_rate_limit01.c:82:3: error: 'IFA_F_NOPREFIXROUTE' undeclared (first use in this function)
>    IFA_F_NOPREFIXROUTE);
> 
> Fixed because IFA_F_NOPREFIXROUTE was added in 3.14 and the oldest
> system we still support is Cent0S 7 with 3.10 kernel.
> 
> NOTE: Cent0S 7 is obviously heavily patched thus it contains
> IFA_F_NOPREFIXROUTE and therefore CI build didn't catch this error.
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  include/lapi/if_addr.h            | 3 +++
>  testcases/cve/icmp_rate_limit01.c | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/lapi/if_addr.h b/include/lapi/if_addr.h
> index 4e50a0a4e..0f7e44784 100644
> --- a/include/lapi/if_addr.h
> +++ b/include/lapi/if_addr.h
> @@ -12,5 +12,8 @@
>  # define IFA_FLAGS 8
>  #endif
>  
> +#ifndef IFA_F_NOPREFIXROUTE
> +# define IFA_F_NOPREFIXROUTE	0x200
> +#endif
>  
>  #endif /* LAPI_IF_ADDR_H__ */
> diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
> index b3a237b30..3ada32675 100644
> --- a/testcases/cve/icmp_rate_limit01.c
> +++ b/testcases/cve/icmp_rate_limit01.c
> @@ -27,11 +27,12 @@
>  #include <sys/socket.h>
>  #include <netinet/in.h>
>  #include <arpa/inet.h>
> -#include <linux/if_addr.h>
>  #include <linux/errqueue.h>
>  
>  #include <sched.h>
>  #include <limits.h>
> +
> +#include "lapi/if_addr.h"
>  #include "tst_test.h"
>  #include "tst_netdevice.h"
>  
> 


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
