Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EC3C44500
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769074902; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=N38zfYfRyyrIJ154Zf7RwMNCttzz0VqeIM/hgK5zD/A=;
 b=KGjSu4sYgbNxaiYAH8AogbXGFAunI+Ff8qNFgmXYoGdPa2JPHFeenurt/YmhVcnEm5heU
 mY8BxlIcuRDgaDVOHlDs2POWV4Vz0FEKEa2CHYW+XCZyrx/zWJcMm1KxBjsEXr4iyW5/zU+
 x/bXk9S94M/nKDfwVD+SzVtrHQk8lZE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACF173CB36B
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 10:41:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D51BE3C0F41
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 10:41:19 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CA0E31400DE2
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 10:41:18 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so646238f8f.0
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 01:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769074878; x=1769679678; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mmsewka2/5X+W189qG7OzwmBO64KZ2poD5qZCSp9kRo=;
 b=IRT/lU0eQ0b0+yzHSsjf6CZNkLutuj7FFDWlJj1TJF9SpEtjsuRKgANXT12MGNVmfG
 FkWxMjx4F2EQpygrp6tSwwVbGJjTZxtkHdL5wWP5LldT8z/6kt27VdWdHt70XZVS1vr+
 W/x+AlvTlB+2h7l5ak8XHD3mKWjTY+3gvLrqH167FXvus30aPZFYCyrMvkfo03R5/7gk
 tK3NGxThmzSRwfzrRGUrcFym16z+6AdOlKKmcNpoXcqM82KgrFYV6fsGjepsGfiVpkQD
 OHEAfB2II9kKjzevnV5OPKrHOA8MUYQIgUEIrfTz+IXTRoQdSSdolRNuBXd2YiPYo9XZ
 vSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769074878; x=1769679678;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mmsewka2/5X+W189qG7OzwmBO64KZ2poD5qZCSp9kRo=;
 b=asfLkOFlIXr/ypVhnKoW9KmVVa4tYAT8SEqqag9GaKMeCZLHWH26tG4btUYCCYUawT
 7atPy0fjZMYvxhJTp9JELjpAD6qu5X+0tFlrN/Lq0qDfvpTGjmbVeWPx4IjVQYvgOuJV
 gSTtotRy1OlmtTci0efQNCSN2Hrak+uDLoM+VceoM3X8tAWopbFmSc8hgm66XBEb5Io7
 fjPhMISAz7IPciIMgmDr4plB9m5DRoOlQs9wnuCfpydQ3jfdMb5PJqZS9qTgFbJQm5SE
 GOzoIXuJWm0CSvHhemCBw7l8KHVkxZGZ0Tif4cdqdzprp5gv4Wv3f+L7/MZ64l4oR0Iu
 7/iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNBqsZJZB9tY/dvrcAMWeASl8Cf0tmGZwOMxYnoTeawsR7Z5ng/mLXhUkbdBtG4hZV21M=@lists.linux.it
X-Gm-Message-State: AOJu0YxU3k7m7SKHdRECa21yEBNVU+MqghfNE6QILrvZFrHHMv58MjTN
 lhBVsJC88sbplmOWDNxfN0hB0UgGcWf6obXE8nBOkih856KgTIFFqBzcKFLFQgV+wsHCozTNqXJ
 Ab40Q
X-Gm-Gg: AZuq6aKGfgEhjTWVpgOQDSv4o/MiSt/rZf+bAIPPF4q+f40uIDz8ZHdoZ9Rc2NF6FT+
 vWQ/LY93OqoqYpwerO4W2BAbhhyC4khhnqgz5FbAp6uH5od+ox84KxbO3MRKFrLd/WIWYY4qbvf
 T5RAsmydc4WVdAR7ZK8brVv9SzkRw/l8egRkeUPbllhu8/3ERnyFWj/sY4vfuGDRuAs575yhJJ4
 nGeNouMuwsFOtLdxWkhRG4qwZOzB8xXLVLsjLU5eFizYYW3xCsbSm4J7ya4QBZd9W4VofmTGU9T
 tfQleMAxjALvsCS2XgY5iSwzW/XSR0If6NPH8rqE93hC2etkHC+P2VxUF9uzSqIg+L3/MVyLkWt
 ex+lAtDpVXclZBL28UdBXTKgzAOyfLM8WObcdJyPNYyzmi+JKmRw+X/nwBGfew2RGmdX90InVnB
 K9vrlrA9+al3xtaf/ep7qbmfvuOhKKTBKppZyhYyXNVxNc4Ar0noP0I/bddKu0eWY9iGS6CcQ2U
 /Zjeic=
X-Received: by 2002:a05:6000:40cc:b0:435:8d80:1b74 with SMTP id
 ffacd0b85a97d-4358fed7e77mr14838903f8f.25.1769074877978; 
 Thu, 22 Jan 2026 01:41:17 -0800 (PST)
Received: from localhost
 (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de.
 [2003:ef:2f16:4900:1c62:6999:955e:52c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e664sm39442719f8f.30.2026.01.22.01.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 01:41:17 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 22 Jan 2026 10:41:16 +0100
Message-Id: <DFV0PEZ7A9WY.28043CZ8X8DEA@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260121225258.15820-1-pvorel@suse.cz>
In-Reply-To: <20260121225258.15820-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/setup_mailinglist: Improve title,
 mention b4
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Wed Jan 21, 2026 at 11:52 PM CET, Petr Vorel wrote:
> Title was misleading (we setup git, not the mailing list).
> While at it, mention also b4.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/developers/setup_mailinglist.rst | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/doc/developers/setup_mailinglist.rst b/doc/developers/setup_mailinglist.rst
> index 80d5cb95a1..dd5fa27df1 100644
> --- a/doc/developers/setup_mailinglist.rst
> +++ b/doc/developers/setup_mailinglist.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0-or-later
>  
> -Setting up the Mailing list
> -===========================
> +Setting up git for the LTP mailing list
> +=======================================
>  
>  Before using :manpage:`git-send-email(1)`, you need to set up your email client
>  to send emails from the command line. This typically involves configuring an
> @@ -48,3 +48,7 @@ For any corner case, please take a look at the
>      This method still works in most of the cases, but nowadays we often
>      require to setup a two factor authentication. If this is the case, please
>      consider setting up Git accordingly.
> +
> +    Instead of :manpage:`git-send-email(1)` you may want to use
> +    `b4 tool <https://b4.docs.kernel.org/en/latest/contributor/send.html>`_.
> +    See LTP ``b4`` configuration: :master:`.b4-config`.

+1 

I'm thinking that we might add a section for b4 setup and usage. I used
it for a long time now, so I can take care of it if needed.

We did it for ML, it's worth to do it for b4.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
