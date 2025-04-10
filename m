Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B60AC3601E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 18:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744308747; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : cc : content-type : content-transfer-encoding
 : sender : from; bh=ju7WD2VA2Kh9Ce3/wa6tkcNpEQ4UyCZOU2snp9gfLDo=;
 b=TY4vhN9+TVC5OklJJwRn5eAdHp+BQl9veT/GX9jlS7o529SWitqp7UsYOJMF1e2Ad5oil
 lr5ajV+Nm9qfw6rH7Km0/Sgs1uXFeUgRQ2/Y7ro4VnaLiJjacbBIYbMPBvfGOra4wUhDKf2
 HYVG/+zH9Wk2S00zxVTMWpkUqxRdvfU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A48FA3CB53B
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 20:12:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id 57F233CABDF
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:12:06 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with UTF8SMTPS id 35DB9140010B
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:12:05 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so898712f8f.0
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 11:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744308724; x=1744913524;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HPb9oEu2dH3By8WgmKjSUsgc892uOHe8Ylwpgw7V0UE=;
 b=iOVEoZTsyKN5xcH+d2RyebsM/MisukIeHbFr8C9YA0xVwzRA08wTuBB4IW+15yqgmU
 puVGmZt19KMLX/hNSj6Hewgl4ZvBOfOBqWOKezj5tHBcj7KaaRITbl5i2ZmLQRcBjo79
 JzE+g/BqoEys0OfZEb3cJBFMeyiNbvA5LiPWVRyR26AOQpYuEJcWueuDyemt0tRThQQg
 6WAL1TQb0SH8oHHKyeOl2fbLE65nk3Dhtx4J333pJH7r/FElgf2GHNCNoI4ksMjfjsIx
 gz7jcGr0zufcerwQWY3lAIGpCTFPeg79qALR8UuNjeXPkuW+Ivu3OMfExjI0hlZ+nQWW
 M3Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtNeLeMUtMo7jWVxPPbo3o8WFjyhoYrKnESJ9wDoznh4nlDkFOji6lXjFuF4CXbl+3P/I=@lists.linux.it
X-Gm-Message-State: AOJu0YwHgjSMg/Gs2HdlMaucDKFLlK3p7N6Gy+QnYNccXyZ/Sr3Yx9Ws
 ElbPMaIkqD2lf3ysszA39NkwpZep2oYbPl4uhEWank/kYr+OljxUw8B4HsB+fml5etxPU9mD5Hc
 S
X-Gm-Gg: ASbGncvtr+9vaUCPTWeGOiw1PAayB4Mc5I8bD1tRx0mIcgQPJ2uf9qy71XLQaHgYZUX
 e3RTZ+XHYpiw/DN8lwMS4WWVQBDhMHJgzanoUUp2je+rFhyzXA+QMjTuGU4nA5xJnzK6Sz00FzA
 AmBDZcmvtGNSoe07erE3GACFYE6SckXpBLE6uuph24xXRZIrzqCJ6/WQ6bwJLBYkVPu/t26kEuU
 kmlkb0qpKTijEPmnxbBUgwPVrsNXy+ZiHoyu8bazRkofEBlVMXNnxzuFMhqPk5NAu5rv78vp9ES
 wl7BWyZtYNIcv1lw4Ve3gwYHKOLB+w==
X-Google-Smtp-Source: AGHT+IFKaHB3toDFjFkAPNGuho0vyPuLaGMvtDX8jef2b5OT/No/1R0W+xKBUCBBbDQpUU8n8yHP/w==
X-Received: by 2002:a05:6000:2a3:b0:39c:13fd:e50e with SMTP id
 ffacd0b85a97d-39d8fd63db9mr3582218f8f.10.1744308724561; 
 Thu, 10 Apr 2025 11:12:04 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b02a08180e2sm3376214a12.14.2025.04.10.11.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 11:12:03 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 10 Apr 2025 15:11:57 -0300
Message-Id: <D935U2KQA85M.1Q8BM04DP9WHM@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250410-patchwork_ci-v1-0-def85825f46a@suse.com>
 <20250410-patchwork_ci-v1-4-def85825f46a@suse.com>
In-Reply-To: <20250410-patchwork_ci-v1-4-def85825f46a@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] ci: apply patchwork series in ci-docker-build
 workflow
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
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsae+/ve+/vXJlIHZpYSBsdHA=?=
 <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marlière" <rbm@suse.com>
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea!

On Thu Apr 10, 2025 at 12:29 PM -03, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Modify ci-docker-build workflow in order to apply untested new
> patchwork patch-series inside the current branch and to send back
> results in the patchwork instance.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .github/workflows/ci-docker-build.yml | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
> index 44dcca055018a1fb06541a788e3152239aea2e66..21a9ba0bf6af3fdf77f15258d761da0ab311ce16 100644
> --- a/.github/workflows/ci-docker-build.yml
> +++ b/.github/workflows/ci-docker-build.yml
> @@ -1,7 +1,19 @@
>  # Copyright (c) 2021-2024 Petr Vorel <pvorel@suse.cz>
>  
>  name: "Test building in various distros in Docker"
> -on: [push, pull_request]
> +on:
> +  push:
> +  pull_request:
> +  workflow_dispatch:
> +    inputs:
> +      SERIES_ID:
> +        description: LTP patch series ID
> +        required: false
> +        default: ''
> +      SERIES_MBOX:
> +        description: LTP patch series URL
> +        required: false
> +        default: ''
>  
>  permissions:
>    contents: read # to fetch code (actions/checkout)
> @@ -125,6 +137,10 @@ jobs:
>      - name: Compiler version
>        run: $CC --version
>  
> +    - name: Apply Patchwork series
> +      if: inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
> +      run: ./ci/patchwork-ci.sh apply ${{ inputs.SERIES_ID }} ${{ inputs.SERIES_MBOX }}
> +

That `if:` condition will disable this job to be run when we push to a
fork, right?

>      - name: ver_linux
>        run: ./ver_linux
>  
> @@ -158,3 +174,14 @@ jobs:
>        run: |
>          if [ "$MAKE_INSTALL" = 1 ]; then INSTALL_OPT="-i"; fi
>          ./build.sh -r install -o ${TREE:-in} $INSTALL_OPT
> +
> +    - name: Send results to Patchwork
> +      if: always() && inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
> +      env:
> +        PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}

Even with the `if:`, I think it would be better to check if
$PATCHWORK_TOKEN is null in patchwork-ci.sh

> +      run: |
> +        ./ci/patchwork-ci.sh check \
> +          "${{ inputs.SERIES_ID }}" \
> +          "${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}" \
> +          "${{ matrix.container }}" \
> +          "${{ job.status }}"

Nice work!

Thank you,
-	rbm



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
