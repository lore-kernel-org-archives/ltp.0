Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6391ECD8CAA
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781001424; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mowq+wnXPopvwmemNxw8Ck+fp+oXNdVzlAITjau9DDc=;
 b=NiNgHZ+210uaeTluJFYvwKSboWHtj7cZp56CNBkUO6R4gZDFQFKkyxq+23DJYpQ1osnh/
 zYp3BuI27FZ0VfAeqFnOOvee3BtM1sM0r/bp7DRvUBaNNeGaMp4RPTYoqlCjmsrN+vmZaUb
 jJ7sXeJEXbz+E4eS/XEGb3vwm0Ts8CM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78C2B3E2B33
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 12:37:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CC5A3C6F29
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 12:36:43 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BA5061000940
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 12:36:42 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so2858818f8f.2
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781001402; x=1781606202; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XUIt228fuM1wuoTcqBN1FKosBl4Et+Pz46WOECMOHYQ=;
 b=clWO0LxaDV/NjTXOh1als/3UK+Fk/BniTFUL5gK/OZsdcmZkdfg0/VlYEKyYfyVxhq
 wH6Tf5wXzWxkFQx3bWYT5A7Ob9MQfB3SoUInyx6a18W5x8wAK5jL9fJncPYtgTh7vx4J
 smOaFfBpuvS76d9JYm0YQhSnGQzR0PNIStC79SsTC9dg6gB2TEgD0uYLEKfO4LnIpu9r
 FHLsWLdhEEB9QMSNbFNta/Mwpwer5UALiyvUM37gGrjtnXPbfCXCGy7UCGB9LHwVgAyf
 nOLLQW0Mpx1nOqWS1a1OPma0nFIM8Yff+XLY1q2zGRwVA97mITVyxz0Mf9T2SqzuJg88
 SRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781001402; x=1781606202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XUIt228fuM1wuoTcqBN1FKosBl4Et+Pz46WOECMOHYQ=;
 b=rmvqO8DAU3Tbob+N6hiK6R7XNO+nRt1PnALTJfEcBR4wN5faTRg6pkb0+TTcjMcLY2
 BBOCDLHfFGWzcwwOy3i3oCg7Zgy6ojsHF4/h2tBMUiPLhkhNFRTppNEC5qBOrkbeBTJP
 5RVOvLB4JER7VKnTVz1KKMiqfVuB1r9QhSJOU9c86VdlaeKDKlg3WRebfkkZDpaFRn5Q
 eHQ95gbC5/mas27A1yAFreUgBU+ABGlfXEWiQUFrzv1IBChlvDeIVIsxms0D99aZvk72
 NqOsP5WN9LaeNBgPp7m9t9MdkfJBMs53xDCHEwwEI1DjaX/NmbfmWIml5UBLei7PYRdS
 NSJg==
X-Gm-Message-State: AOJu0YwYgo1Bao2GRFehgnK6iaismfv8YmPewhO/hRx3LtTHtM0bstLi
 OWgWneXEr35PWUGqgn+m06+T/0Mt8Vcgg7YLCCG48Gt9nVArxU5J1IZtBdjqjCa+n30zlaXWxF+
 8pqA=
X-Gm-Gg: Acq92OENdztzFL8x632owqTT6yoDyg5uLTJ0/1tJeYV9OiFu30Q2F2QwAdWxXmqg+mB
 jakYYWkGB4jB7uRbq3cv7P5CyG1xNyznzUFYSRg1Ea5ku0xHSDO0QPEFfgyHbz5PoBbrUvQWhsH
 MX3fEwp8ZU6xQJ+TVDf27rjGyT47nzf3BI3YUCnYVWfw1aTKkG1GPE8BEOzO9DjoHteZCyw4iFc
 M8VpWTBxqMb0lB+6Fa8zjpzZ+e4n9Ghgms7QCLTZ0nH44DpYsKEjLLjU6rA2U9lMbLSrCJ13/1p
 pMKKAIVFHXi3Rw2NL8aYWfB9LExhjvotXt8VBdQRIZWh6VmcA3io9ji/ryw8bjPvldzgfwizABW
 pwXQbE74HjJuFdbozc9W8o3CqSTUAKWrdw0Aq7+p9Wc6jfgdjB7DllJC2OydxVjQ5VL+Q/KAzsW
 vQYMub2MC+T/UAv4+EGXtqTnbqtg5js+un0Xadg/NVfbWChdSU+OA=
X-Received: by 2002:a05:6000:1a88:b0:45e:fa7b:a7d2 with SMTP id
 ffacd0b85a97d-46056680e23mr2928688f8f.7.1781001402059; 
 Tue, 09 Jun 2026 03:36:42 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dc412sm63416786f8f.4.2026.06.09.03.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 03:36:41 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:36:40 +0000
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aifsuHWKhvEsSPJk@autotest-wegao.qe.prg2.suse.org>
References: <20260609-clone10_remove_checkpoint_leftover-v1-1-a2a99f71ba9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260609-clone10_remove_checkpoint_leftover-v1-1-a2a99f71ba9f@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clone10: remove needs_checkpoints leftover
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 09, 2026 at 11:57:31AM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/clone/clone10.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/clone/clone10.c b/testcases/kernel/syscalls/clone/clone10.c
> index 96de811ad079aad05d2014d9bc5afc5c22ca7077..d1e3ae11c5e2939bd1ac2ee7f69674363fb07dd2 100644
> --- a/testcases/kernel/syscalls/clone/clone10.c
> +++ b/testcases/kernel/syscalls/clone/clone10.c
> @@ -88,7 +88,6 @@ static void cleanup(void)
>  static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
> -	.needs_checkpoints = 1,
>  	.test_all = verify_tls,
>  	.supported_archs = (const char *const []) {
>  		"x86_64",
Reviewed-by: Wei Gao <wegao@suse.com>
> 
> ---
> base-commit: 1efb4bb8eb4a8582284a90a70ca2adc22c4e47b0
> change-id: 20260609-clone10_remove_checkpoint_leftover-da204c9cadcc
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
