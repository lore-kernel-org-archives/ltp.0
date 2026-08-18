Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA76C5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 11:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787051153; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=kThOOvlC9bsL2l6c9aE4/9wRGIOSxN6GZK93aG0VLDo=;
 b=k8WQu+DSfhg8TxlqM26K+Y4MHucuuZIDMnZpzY9XkUyAsvKmGSc92AAdFgddcSDYPGJcq
 9BC3NTqkTGEYba9jZpB3KKLBPw6VTnFB6b9pJBu2O3aRhxTF1hmzkyoU3MpOm9geDTqaMSt
 VzbHls5q1mZsdt8W3dZtAAxv8wm/pXA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E830B3C4B6D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 13:05:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF42A3C2804
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 13:05:33 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 398E310000E7
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 13:05:33 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4998e0916faso25318355e9.2
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787051132; x=1787655932; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WnU8DsoGhzuA7DtQiSh4wgpgTvvq1MFAVF6V3zAKgyI=;
 b=OeumXJIagpwaMI9elzF05egeIk10WUlouNgKFFdTgqnzpM3gergX8IGYhdjggJeWi9
 aOIETlxi3xTDjDWwkhtKdH5NvPJKHlH3Wh3KoilnJsiIotgvMHNmGWFED7nRE4QV7koa
 2PcF8LawBQC1TUaLbxWPIMlWgIGwSAvHXu5ioMwEl7/KfyzWk0ZObJ+U8LCN9HL8q1RP
 5t9UgwkqEGDVTurKma6dGLvu223W5RwcH+8E9fxykHopkE8+o8Ry7F0h4alGmGonqJ+S
 kZPFsuOYX7wVs07otX50as8Ry34afPtKzmWH6h6jrAS6cVCl2Qo26024xqvd19WnkB/a
 i+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787051132; x=1787655932;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WnU8DsoGhzuA7DtQiSh4wgpgTvvq1MFAVF6V3zAKgyI=;
 b=nsS/8qq5lxyBbhTvch53CVX1fi//NPkLgytPcQ0mpYMqXy/jbmD2DxpwupB34NdkdZ
 YhnEnbV0GdF5RTAUqRPhB5BUXMGVv2s/q6jepug+kN1YXxN7TKOrHuo8slA5aj4nfdrG
 j9XDzmlbehi9HUxN2lpS1W39oCm6bSMGnhIL3SAENjlUJSA/BYm7Y9MFADbtWj2r78tT
 nMY0W1XGMklhZILy8XRtCAsjPPRVdZuvR58PxYnJs5e+G1GIM70x18Q6S19GEPhV3ox4
 fh+1gHkv8/IwoDoCu/yRWdSsy+mu4tWzYml/5xgJoO7VsT7JDHuOdhuuckuPWawZbyvJ
 qC6w==
X-Gm-Message-State: AOJu0Yw9Hlhb7L05BDeKS6SF/a50RCjvhSZ7m1hZOrMB+BpUAhYs1ir4
 nM4nUYfusrKGzkoGCv6Ra8Kh+335H5F9CFu2KXUUX8zR9EO7kEvom4fscZxMhkxiMA8hEWQYB5K
 fPBeJPZ4=
X-Gm-Gg: AR+sD12LB6ILDXmMs4oQntielK8UXPW+5IpNpKKyjqdi6jF7bAI98N8PoHkkchCzeLC
 QEPh/F8fOehERpOW+VX/9sRXEexPMW2sib2CiYGj1eLJ+Y8SZbKslpYRSP50DS0eAyItBoVeUax
 GD5BiKTvQ/cggkp653ISxF/jPXQL5MWzRvjZq0+cjWtINnUz02hYkl9U88TWBMhxNkZfJYrChSy
 AiUHrSzlBWGlTIaiXrlg0lb7IxLuPovRv6wcdzThznuChhHP6n6+WfudLMdWUKxil1VjAo0ezko
 +NuSzqnN6sjskV/3W1OOLPNT/vF0WE4TDlFG2u8vERXEImEek430Fvo/LYNLCBKdoSxwSvo70OV
 ZzvODGLhVgtQDHuPiz55+gg/o9T99GSJo7cna6fV+91qSLCXK0U/ghcWXdZzRLO85ILg3qQenvf
 jGkZ5ZdzXweyeDrgcCU3WFBPbV5mlP6LRv6A2skO6+As2C6pttW/wxMc10E9Zi9wvdteww5DM=
X-Received: by 2002:a05:600c:c109:b0:499:a5fc:2087 with SMTP id
 5b1f17b1804b1-499a5fc219fmr33520145e9.6.1787051132433; 
 Tue, 18 Aug 2026 04:05:32 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610ed6dsm299768215e9.8.2026.08.18.04.05.31
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 04:05:31 -0700 (PDT)
Message-ID: <6a843c7b.e11288f4.14d360.f5e7@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260813192649.192136-1-avinesh.kumar@suse.com>
Date: Tue, 18 Aug 2026 11:05:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: rename11: Convert test to new API
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> +static char elooppathname[sizeof(ELOOPFILE) * 43] = ".";

Magic numbers are a bit unfortunate. It's better to define a single buffer,
which is "big enough", usually PATH_MAX, then append in there the strings we
need.

> +static struct tcase {
> +	void (*run)(void);
> +	const char *tname;
> +} tcases[] = {
> +	{test_eloop, "eloop"},
> +	{test_erofs, "erofs"},
> +	{test_emlink, "emlink"},
> +};

It's better if we split the test in three, since their are three different
errors reproducers with different input values.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
