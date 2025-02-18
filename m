Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D80C02198
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739889245; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=l/UqP0ptZcNXT+Y6r4+W0Jx6vBza//t8Y7/Y2EkfULU=;
 b=UJHeFHGOvCbsSSXedaXWfP1H6DxRoal5RWNoCMXtFzv5F28BtaL47czSlMxpboyCuQroH
 hkIR8+Q7eyTaeLjlhyJEZFxl5LkKm96tz5BQJBWZxAC0M4RfNmMrd07BPi4Tz/WYKKkbYYA
 5JgjoeJH+BX6TxiNra4ToXr0BsF7vts=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A14A03C9CE1
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 15:34:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34CB53C9C61
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 15:33:44 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F882601B0B
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 15:33:43 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43948021a45so57399595e9.1
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739889223; x=1740494023; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=crcMAIYjb9lQPra1w7gYQOHW6WP1skUJK8vv+Z2pmY8=;
 b=TcInkLRfL6dbGM1nYrbQ2yQw+WVhb89r9JH1jZU7PgQ/n3uYKT/NBwQpa0WHrE6NvK
 vjMP9KveOkM4ur/pqmus9cWQVvWwp2ik3mbJ0SWRgz+cWpam+L/lWF0kJ3PxM+6BSavk
 lJ4FDcqF9km339Oeh3vSjI8IaXlBgXjefd2DnY6nNnWFVTX7VJIDeopxceT3ZxMFMxM+
 P1BUDMStVpRB/e2XmUqqkKSC8dMQzg8kXsd/xZFa0vUqRbPVHloMhR2SiRGE6Ym/fxn2
 HshYwTC2U1j3eK5ty1ClsyWX5NoaKdwHEB66wd4f8rQMw6j7h2Ni3xAqAizbPQqfT4oX
 8N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739889223; x=1740494023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=crcMAIYjb9lQPra1w7gYQOHW6WP1skUJK8vv+Z2pmY8=;
 b=VhZeHA4qcmiScb6ekDjPDnBk5iKtfU8roJSVE91bmNIc1mL/whb32Cyr1OZXz5SQUI
 wrFuYtoDC+75I8zftOXtKo9U8QvL73AXOvwd7QKK5Adx2sHq2rBiLo98PbQAya/YaBYc
 FNihscqncznCMhLydJBFT20knjrGiEV2OYgaxwpcTskQbyPCgcJXbMR9Cy5mwObUCTIH
 8x2jO8Bt+D8jlnGZU3tsiDLXh5rd3zaJqACYqfnV+TB9aX1d6m0dWf3cLUiqGyYHThpv
 hJyPsczaWa7iFSTyE7eq3Vt/06r3AJ4FYD4r7efQ088lHkwGt+lvHVdnhQnW1/zp3wLI
 ZIgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3Ktfl8gplPJiTR6jkeKtA57shWBM7a18+I5gNcJpFh2RG+NJI1PEkFGrz/CpbXxRAKrI=@lists.linux.it
X-Gm-Message-State: AOJu0Yw5hzMX24HGBLqNL1iJXH2IdXn8qgzIWmqFIbJxuKX9uGJ9IEL8
 JHYukKAOKGRrOH0yeSvIn8oLaArx6m1ea4uL32VLKTNUcdrgsL1OqRfqifoKduU=
X-Gm-Gg: ASbGncskeUiUCQkXgENaxmYemVPy2Fw1Jlx+JKybQcPkpvhY//tJMBtF3YFNkCTjIOY
 Ogfu12zs8Dk1SsU2cPFyXIB2HYdXJ00uzgG2AiKTAlgbMF36JLVUtInwP01imDLhwL/mUPjoc8D
 RCJIEJPp3x4m7F/qlZMh+wKF8BTOr0T4To+o2gJiUTHN15QM1fxS+YWgqxUq5ILYXpj+T5NJdcg
 mbjWZ7FTnrx19ZN5d+QySC41K0zY/NYWHogqT4fooZWdof2XSHsE6yAK08I1XMbhf71xtp9hWPS
 i2UVPzmxF2A1FEzBs4iJUUl/Ag==
X-Google-Smtp-Source: AGHT+IFsyT6ySnl4h27kriBWopZ/2pz/2AeEnpWui2vrqL3h6xnXJPAO1Ra0dfn44mqsF1JB4LM0zQ==
X-Received: by 2002:a05:600c:1d95:b0:439:88bb:d02f with SMTP id
 5b1f17b1804b1-43988bbd25amr69667185e9.5.1739889222765; 
 Tue, 18 Feb 2025 06:33:42 -0800 (PST)
Received: from [10.232.133.75] ([88.128.90.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25913f5asm15376076f8f.52.2025.02.18.06.33.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 06:33:41 -0800 (PST)
Message-ID: <f4fd8977-94cc-489a-8e66-3ae7e8a2b991@suse.com>
Date: Tue, 18 Feb 2025 15:33:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250218133443.2484512-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250218133443.2484512-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] doc/conf.py: Replace all titles
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Feel free to merge.

Andrea

On 2/18/25 14:34, Petr Vorel wrote:
> This fixes titles like "[Race Description]".
>
> Fixes: 1bf344a3db ("doc: add tests catalog page")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Link to v1:
> https://patchwork.ozlabs.org/project/ltp/patch/20250218121553.2470592-1-pvorel@suse.cz/
>
> Changes from v1:
> * Use re.compile (Andrea)
>
>   doc/conf.py | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/doc/conf.py b/doc/conf.py
> index 03fcff67e8..2be847d90b 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -434,6 +434,7 @@ def generate_test_catalog(_):
>           metadata = json.load(data)
>   
>       timeout_def = metadata['defaults']['timeout']
> +    regexp = re.compile(r'^\[([A-Za-z][\w\W]+)\]')
>   
>       for test_name, conf in sorted(metadata['tests'].items()):
>           text.extend([
> @@ -455,12 +456,8 @@ def generate_test_catalog(_):
>           if desc:
>               desc_text = []
>               for line in desc:
> -                if line.startswith("[Description]"):
> -                    desc_text.append("**Description**")
> -                elif line.startswith("[Algorithm]"):
> -                    desc_text.append("**Algorithm**")
> -                else:
> -                    desc_text.append(line)
> +                line = regexp.sub(r'**\1**', line)
> +                desc_text.append(line)
>   
>               text.extend([
>                   '\n'.join(desc_text),

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
