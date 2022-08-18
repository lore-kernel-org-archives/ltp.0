Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5FFC00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 10:26:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4BC53CA19F
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 12:26:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAC773CA15B
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 12:26:37 +0200 (CEST)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5E6646008ED
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 12:26:37 +0200 (CEST)
Received: by mail-vk1-xa29.google.com with SMTP id w129so543724vkg.10
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=7+r7W3svkRSdJcnpaWaB2DvD+IRxpuoIXxBKwZMsSws=;
 b=Us/2jgLZfhrwNau5bUMJ1J88BX7YCKzKEUeBAorpg/FfpE6DsUMD3aeQrdi5U2MFBa
 RNWjozl1y+F4/gKwnmmPjrrrkQ16e1m6gilC7XjRhPuLD1relxUfQhKpmPgIpnOCwtO2
 yRWdm01qutenz6oMBlgIVAN+8SCxwfY6EQqBwcCpRBVsf9ZBGBRdh++W256oc1yGy9yD
 10uxVVyti4UHTfPfkqNPhyU+OuqeqlQaTWzfn+xIcp659IPr8lmlwiahd8VhOl8e+/qL
 awDPRL/AHlrV0aXqxbQcNVl5fOcTfLECfqphdiAUXrMJg0j1bQ3WXhmM/d6PudAplAUw
 VVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=7+r7W3svkRSdJcnpaWaB2DvD+IRxpuoIXxBKwZMsSws=;
 b=48V/O56Pz1PVhMfzP+9V317Z95jc+FhosakP3YT3PrITxEYnptwtL9dokZUlDvDEbN
 rQSdLs5YORe9hdvCrJTOBB7uUpnEphDiXH8EJi8xB/nNZhMmK6Npyz6k7COpBALhRazw
 DbKXw83FaZozHAA9q5qlmH7RzpkNeqFATmcYb1QZpWjd5faGBtPEZWPqBtAQFVeGLe1n
 vFvgsTu3SmXSyZk9CG8+/wmAeNy2mF6qO9gIPX1SQv7DKZOQ6MLDFMaiwI6J1X1LKbJa
 pWyIskzZQ/zbCHIWcn1rTiSRLUc/K2XfPFxLcgKst3NFjmNGI8VFyZFtKyzf/yqTQ0Rt
 8lCQ==
X-Gm-Message-State: ACgBeo0+x7ZZdBHSUc/jjbjQ4a9qbv4ewUThT8lFNAPiPkPqza7sVJYP
 GsmxIseZC3SRf6vqqks8gm2QhkeTiHIt+sw+U/E=
X-Google-Smtp-Source: AA6agR5SqC7l0dJ2r8KqotVu1oD/blm2wmzJ0u/ngxlujqtHvCwW/qlPmS5BeEA7TzOuiRpxS4IaiyLPV18YyqL7cqE=
X-Received: by 2002:a1f:2d06:0:b0:380:679d:fb9b with SMTP id
 t6-20020a1f2d06000000b00380679dfb9bmr825982vkt.25.1660818396244; Thu, 18 Aug
 2022 03:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220818100945.7935-1-pvorel@suse.cz>
 <20220818100945.7935-2-pvorel@suse.cz>
In-Reply-To: <20220818100945.7935-2-pvorel@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Aug 2022 13:26:24 +0300
Message-ID: <CAOQ4uxhvf11FxVJcGiy_GpVHALXNnC4qFc0azTi2Qn_FS3oqyw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] tst_device: Increase DEV_MIN_SIZE to 300 MB
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Aug 18, 2022 at 1:10 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Previous default 256 MB was not enough for mkfs.xfs since v5.19.0-rc1
> [1] which refuses to create filesystems < 300 MB. Although the
> limitation can be workarounded by setting three environment variables,
> it's better to increase the variable.
>
> [1]: https://lore.kernel.org/all/164738662491.3191861.15611882856331908607.stgit@magnolia/
>
> Reported-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/tst_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index c34cbe6d1..8419b80c3 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -44,7 +44,7 @@
>  #define LOOP_CONTROL_FILE "/dev/loop-control"
>
>  #define DEV_FILE "test_dev.img"
> -#define DEV_SIZE_MB 256u
> +#define DEV_SIZE_MB 300u

Subject is wrong - it is saying DEV_MIN_SIZE

It really looks weird that DEV_SIZE_MB < DEV_MIN_SIZE
What am I missing?

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
