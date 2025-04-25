Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47C4C369D1
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745587184; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=1KZDqGBKyNPMpl3ZwAoTxRaWAAPI2YbQYk5y6my90Hw=;
 b=W2HkDB995DoOLu8LDNJmWd4Wg23WZyaDUI0vynQca8rjqn139KtTmT7nGAyBPJchVY00B
 V1aEWjb5SHIPcByCv1z/5jPI1qbXSFAe97BpmRBl7ODFwRpr742FxQZqYK1Gk6qSv7mdVOL
 mwxXeXkxqrwIdjrNtFjUcGdVC3wTXks=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 376093CB8C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 15:19:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AE593CB7C1
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 15:19:22 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EAD261A00A4F
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 15:19:21 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so9770065e9.1
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 06:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745587161; x=1746191961; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IPO5PWuQltzzWs8FbNuUMpwYHutNjvcAJ81dZg0TzH4=;
 b=FiyqZ0Df9qlVkxOqQxF+AcC01i2rAJ6eJOfbKZ9Xq1gTYhgaTyXmpQ6GpIaUxC+Tqs
 kCw8LcKAmlJKGbW6tZj4KADNSPg3VGRjkRk9Aw2M+9aq707nBwL/x4AmKLwer5sE48Fo
 hlg1H6H8N8SogcugMqYXP4kpVkaGy9c0jXy6aJ3MSvS/DobA4+lot27MJppt7mP4X9qG
 qYW6+VWAZgl419Wrhmr8DK0RsIu7Ah+5GId+IJ7f/9yThSlGSYSoZyMN/xtGL/4zKlmS
 hiSIt12hzhvCjNEf1Vj6nuAL8lNwQdzKdL57HrgoQ/vpesqPzVkgn6FjTmrDsiu/iWqK
 h/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745587161; x=1746191961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IPO5PWuQltzzWs8FbNuUMpwYHutNjvcAJ81dZg0TzH4=;
 b=wpEnPWJde1TX7HicSZntyPvgFAn1thnLJVmKK2iLKy/7rYfgn0H4zVPe5+v0yEpwnu
 Rr6pVi6/5+vcjSDmcXEwPK/vfbXgLMnyT/LODMfAdGGulfDz2AQ2qv62rtTQYWwpn4Ka
 AWbjICLoMOL5bcZJkDirbe/YA6zRNxiP46JbzkvbZ5VnH1tfWVrrCHYRMXdJnFxvln0o
 xZJCmnG5J+SXNRWgvV3lFvpYe1no1WkHLsEigGeS7zkPDmJXHkNHmBj/kfXqxIl5nizR
 Oahw0wzBFiQbxf+uRttZiqk1ZMQBvbyvnVSYFhivrKJlkKRXYBOv/YbjQQSTfsYPEGl/
 VYuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUy1ihT4GWXMBWP67u2/wmKnNcvTuYvwJvjGMPjdzW67/iTd2WA3SMv4piWWEBJKMxgFY=@lists.linux.it
X-Gm-Message-State: AOJu0Yw3yviFMRfx+CSGqEJotDRrL3Nt+vSTva+4SMpmVgUwWN+dgeIZ
 ZBSGx9pVhgdl1FkJG+nCm5sjAeQL4xEpNI+CfMcyK6HvSaVs5ctgoyIMXl72FtM=
X-Gm-Gg: ASbGncs8qgPNx4DttGAaIlxsowIT//wNi8yLuVDMPt4P/dzwsS5Rt1B5JbI3FzSingN
 vq4FxoUlunDPZ/RMQYdCwKvh3gwGltyfpJAeU9NbLnOjUkZwPgeaV+FGyR9pQkk0I0rlyXdoU2J
 R25HyIWm9U/92CO/wvAva87yi4OnZOb4y4GznWBnbb7PB+BSiBJ5fcrNmt6gMK0PO3doCHzgLsT
 fiC/DaGPMa9zljmqjWAq/sCdutGhrGKH2QR+sMlisX0rJLJOzOieHQrNLASUA+Zz6uF3P/jP+PO
 1Va77UVumppDpEgMgumOrSbu+Sxi7Y8n3TX12lzIAvbdK3wv8WP2keXIxT/9jrNCysLd6qG+w/J
 IutqIbLGr7hk7OOwMXb5GYD6Bim4wFeBboYvZ2OyWnUugrlUm+XNFurtDh8Em/1MOw+FWPygx3K
 H4lMg=
X-Google-Smtp-Source: AGHT+IFyEKK7mJ24zuluNyWxSCH3E104oHDMMOYbxEdTB8CGQW0DDZ+PVDXVbDwyuZmRY3eqlUyk+A==
X-Received: by 2002:a05:600c:4e91:b0:43d:16a0:d82c with SMTP id
 5b1f17b1804b1-440a64c0f47mr18558485e9.2.1745587161275; 
 Fri, 25 Apr 2025 06:19:21 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a538f691sm25024495e9.37.2025.04.25.06.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 06:19:21 -0700 (PDT)
Message-ID: <9e646ff0-20a7-40b4-98fe-0fbfc3c54442@suse.com>
Date: Fri, 25 Apr 2025 15:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250425-ci_enable_sphinx_doc-v1-1-d6e207fd1945@suse.com>
Content-Language: en-US
In-Reply-To: <20250425-ci_enable_sphinx_doc-v1-1-d6e207fd1945@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: enable doc testing for new patchwork patches
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

Hi, please consider the v2.

- Andrea

On 4/25/25 14:58, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Run documentation build in the ci-patchwork-trigger GitHub
> workflow when new patchwork patches arrive in the ML.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   .github/workflows/ci-patchwork-trigger.yml | 13 +++++++++++
>   .github/workflows/ci-sphinx-doc.yml        | 35 ++++++++++++++++++++++++++++++
>   2 files changed, 48 insertions(+)
>
> diff --git a/.github/workflows/ci-patchwork-trigger.yml b/.github/workflows/ci-patchwork-trigger.yml
> index 0938aed5ad0df8af8e2e575283b56475ff219ff3..96f70d086cacbe0c519c846e80b69e8570dc31ec 100644
> --- a/.github/workflows/ci-patchwork-trigger.yml
> +++ b/.github/workflows/ci-patchwork-trigger.yml
> @@ -62,4 +62,17 @@ jobs:
>                 });
>   
>                 console.log(response);
> +
> +              const response = await github.rest.actions.createWorkflowDispatch({
> +                owner: context.repo.owner,
> +                repo: context.repo.repo,
> +                ref: context.ref,
> +                workflow_id: 'ci-sphinx-doc.yml',
> +                inputs: {
> +                  SERIES_ID: series_id,
> +                  SERIES_MBOX: series_mbox,
> +                }
> +              });
> +
> +              console.log(response);
>               }
> diff --git a/.github/workflows/ci-sphinx-doc.yml b/.github/workflows/ci-sphinx-doc.yml
> index e77c766871b98114417dc7d8d1cb108afe885735..61a593d0aad50ed622a92bfa17681e19a6e2608e 100644
> --- a/.github/workflows/ci-sphinx-doc.yml
> +++ b/.github/workflows/ci-sphinx-doc.yml
> @@ -8,6 +8,16 @@ on:
>       paths: ['doc/**']
>     pull_request:
>       paths: ['doc/**']
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
>   permissions: {}
>   
> @@ -25,6 +35,20 @@ jobs:
>             sudo apt update
>             sudo apt install autoconf make python3-virtualenv
>   
> +      - name: Apply Patchwork series
> +        if: inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
> +        env:
> +          PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
> +        run: |
> +          git config --global user.name 'GitHub CI'
> +          git config --global user.email 'github@example.com'
> +          git config --global --add safe.directory "$GITHUB_WORKSPACE"
> +
> +          git checkout -b review_patch_series_"${{ inputs.SERIES_ID }}"
> +          curl -k "${{ inputs.SERIES_MBOX }}" | git am
> +
> +          ./ci/tools/patchwork.sh state "${{ inputs.SERIES_ID }}" "needs-review-ack"
> +
>         - name: Run configure
>           run: |
>             cd "$GITHUB_WORKSPACE/ltp/"
> @@ -42,3 +66,14 @@ jobs:
>             cd "$GITHUB_WORKSPACE/ltp/doc/"
>             . .venv/bin/activate
>             make
> +
> +      - name: Send results to Patchwork
> +        if: always() && inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
> +        env:
> +          PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
> +        run: |
> +          ./ci/tools/patchwork.sh check \
> +            "${{ inputs.SERIES_ID }}" \
> +            "${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}" \
> +            "${{ matrix.container }}" \
> +            "${{ job.status }}"
>
> ---
> base-commit: 037cb53e353abb571e52b52cbaa6b569ac28c50c
> change-id: 20250425-ci_enable_sphinx_doc-3897893080ee
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
