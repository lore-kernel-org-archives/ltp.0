Return-Path: <SRS0=m48/=OU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8C9C433EF
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 11:17:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0345615E0
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 11:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0345615E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A86263C893B
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 13:17:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB47D3C818B
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 13:17:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 03145200938
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 13:17:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0016A1FE4F;
 Thu, 30 Sep 2021 11:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633000655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQv/8kwlBwVZOF6sa10iAtOiV0ItpvRBZQ/PWDYusww=;
 b=l49avnolOTQbppFI4TN3Bd0iIIuKb0bjZqlxYHlRuJbfMvzk0lCJQpDJ2ysWgF7GZGAw3P
 Pi8W/Ffgq9of+RMpJmfpkFbdmWHdToezDEQsICbH14GZFLbbqCtVWYhUBsVc/rtZyqqrSn
 ejNU0RnKE2Bv65ljlPOcO/uM1YRaqbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633000655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQv/8kwlBwVZOF6sa10iAtOiV0ItpvRBZQ/PWDYusww=;
 b=p9qkH1HLjSALFjnPKzB49EoL3LnWxr+WZdDYJa1Sjv8a0vAj75jkBttNz0vo8d+AAxSyl4
 gydtz5tCG2xT41AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB71213B05;
 Thu, 30 Sep 2021 11:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ND9DNM6cVWEqEwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 30 Sep 2021 11:17:34 +0000
Message-ID: <17c1aab9-6c53-f1ec-692d-735721eb9290@suse.cz>
Date: Thu, 30 Sep 2021 13:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To: Petr Vorel <petr.vorel@gmail.com>, ltp@lists.linux.it
References: <20210929181709.31788-1-petr.vorel@gmail.com>
 <20210929181709.31788-3-petr.vorel@gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20210929181709.31788-3-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] lapi/if_addr.h: Define IFA_FLAGS
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

On 29. 09. 21 20:17, Petr Vorel wrote:
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
>  include/lapi/if_addr.h            | 4 ++++
>  testcases/cve/icmp_rate_limit01.c | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/lapi/if_addr.h b/include/lapi/if_addr.h
> index 07e6a7c9b..0f7e44784 100644
> --- a/include/lapi/if_addr.h
> +++ b/include/lapi/if_addr.h
> @@ -8,6 +8,10 @@
>  
>  #include <linux/if_addr.h>
>  
> +#ifndef IFA_FLAGS
> +# define IFA_FLAGS 8
> +#endif

I don't understand why the move of IFA_FLAGS from lapi/rtnetlink.h to
lapi/if_addr.h is split into two separate patches. IFA_FLAGS is required
for compiling tst_netdevice.c so this patchset is not very bisect-friendly.

> +
>  #ifndef IFA_F_NOPREFIXROUTE
>  # define IFA_F_NOPREFIXROUTE	0x200
>  #endif
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
