Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D233C3600C
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 06:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744094126; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=3W8XutDfui+yzNueJZjNxshAeawVP4euf6yWKBLdRu8=;
 b=r2g3vwUFESWUEnbXwSczQOWfUzUJgM3TErNX5XFJKS3iFYgztZQjljfGhCHeW19W1PoBe
 iEllVm/+bGFqiv6jE9bSH7q7Rqc+LQL5guRUq5xNpc16I2a1mfneuSP7gob7RYX2LHKNFGV
 0CmGXSwDe52x6iqF6cTdc9BtUrMZu/A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5381B3CB044
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 08:35:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68FD83CA6BB
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 08:35:04 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DD1341000485
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 08:35:03 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso47709515e9.2
 for <ltp@lists.linux.it>; Mon, 07 Apr 2025 23:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744094103; x=1744698903; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HozNZKlYpLZA2PQ9tWC50E/FktQVo2i9guvQdqUh6KE=;
 b=PeFAfN31HowPSp+48SNkcGcqoqRwTqbFdOGDIBwf6fmjvdZmoKYI00K/fI+20G+dkG
 +RhVu9kl+qIc2lsGnoCxQ6FDRLj+k798OJSW4zEza4CsgRHz8z9ztCC9QN8gxrNqQJfR
 EClF7pm+AQZ/6l6gsGz9HFD3qB2q2zTAuliB9HW3Jc3otNFrsgP2AOZZNSiOG1Co3owO
 sxfNKAp5G2le0eiVw63x81nyXYTh3Fi6kvvjRO6ofu4JnYq/qT76mr8DFaBV6MtuGBZI
 7O8b4n2z2tARmYHOAJSMHHx9MQOowBbCGWm6ZwyJHNjTjCOFpaaDqodHk3sMRDix5Dhm
 9JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744094103; x=1744698903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HozNZKlYpLZA2PQ9tWC50E/FktQVo2i9guvQdqUh6KE=;
 b=loiwOO+JqCWHMxi8YYIBCUESx5WeJ6rnPxST7EKW6OvpS3X/oB4nryMII9+JtSd1UW
 r0vJN0gS1dbaKfyxySyTe/4Z/d1X2PjXBrvzwkbATYQ2uoFqBymfH16epOQi6k3NbFeu
 4yLuqnmPeBG0X1g6p05GdHJjTxM8GQn1r3Q3u7jO9SBCL8I48Jn2Ddlmrjws5AsLF3uX
 QpfFohVzZpgeK72nQDHIOwv5H4idNmqSfj/jleh7hmovPoVQWBCzRqfv0gbdrWdhgp7N
 vhUIurvwHMiBGpXnff8IIc1NYW23DftT+nifPTI1Y6nnYNH6nY+Vk314KiqC+kPt3Bxf
 /qCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHoODrvl3hrSXinwQw+fkWcnOxi93NRSdMlTEiQ/9o8UA2iq08janX1eUSGVx1oIkAsqM=@lists.linux.it
X-Gm-Message-State: AOJu0YwDsTicozk/UI1TfXAXOMxvnqGMxxki7kbhsyoYnpCm2LWqQAXV
 urjAH2GKPoBqrGL/qAJqqRJjbfx7LxBBRv7yEVYDgwu5xkYnkjS2q0o79dI/Cuk=
X-Gm-Gg: ASbGnct/L8J0E7sLnc8b0jbquCXxnfYS/eRYDu1anXlLyh0yNtAEiuQOerEPiygdE7F
 vdfT9yvUkPZ0Bns3RBMXusGo5jV8PnxZhYt0bYNHNUF0rbdCFzAKi1VrBWct5pAvUm2PVZNEA03
 Isz/znGerPp4neZEtLOoqVO9SpGRX7QWlTJOANiVCvMlbZCkp7O4UR8wL5ae4Ntuos5a4PhDub0
 8wRlfIMiVB6ndrLAjonWKhHFYIrXOGgr8/YGbGKHrMbzMn9DulEyw5RppBgNF1RHMHTJpghKckm
 65UdKq/lltSUxNjSYFzgZGzlqeigJVktSU+8YSHtQIQ2zPAceusJ/9SYumLz+3crMbpqik8Pfbr
 etpPZLKt94bgSbfXjdNGli9MmBytDhspJ4Bm5B1rGy7n49XPbtr3jD/34m6fgKMEd96aNNO3lrm
 sFyixv79E=
X-Google-Smtp-Source: AGHT+IHal2g0Xw+saCSvE4hAhL3eeJ8p7SiYsc3xHLmc3noUIPYJYsxPKSrw5TIUvG4aIHl72gQvnw==
X-Received: by 2002:a05:600c:3489:b0:43c:f87c:24ce with SMTP id
 5b1f17b1804b1-43ecf9c77ecmr119239125e9.21.1744094103270; 
 Mon, 07 Apr 2025 23:35:03 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec36691b3sm153099795e9.34.2025.04.07.23.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 23:35:02 -0700 (PDT)
Message-ID: <bfe38d56-8ec1-4750-8f28-61dc41c83aa4@suse.com>
Date: Tue, 8 Apr 2025 08:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250407150133.115790-1-pvorel@suse.cz>
 <20250407150133.115790-3-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250407150133.115790-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/3] doc: Add sphinx to requirements.txt
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
Cc: =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 4/7/25 17:01, Petr Vorel wrote:
> Although that slightly prolongs creating virtualenv (and CI job), but
> it's probably better to handle it as the other requirements.
>
> Use the same sphinx and sphinx-rtd-theme versions as on readthedocs.org.
> That way we get doc generation tested by CI and by local build (to avoid
> incompatibility changes).
>
> Also don't install python3-sphinx via apt in CI job to keep usage the
> same as in readthedocs.org.
>
> Suggested-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes from v4:
> * Use sphinx version used on readthedocs.org (to really test in devel
>    and github CI what will be deployed).
> * Don't install sphinx in github CI (python3-sphinx package)
>
>   .github/workflows/ci-sphinx-doc.yml | 2 +-
>   doc/developers/documentation.rst    | 2 --
>   doc/requirements.txt                | 4 ++++
>   3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/.github/workflows/ci-sphinx-doc.yml b/.github/workflows/ci-sphinx-doc.yml
> index a5f9d74d1f..e77c766871 100644
> --- a/.github/workflows/ci-sphinx-doc.yml
> +++ b/.github/workflows/ci-sphinx-doc.yml
> @@ -23,7 +23,7 @@ jobs:
>         - name: Install sphinx and autotools
>           run: |
>             sudo apt update
> -          sudo apt install autoconf make python3-sphinx python3-virtualenv
> +          sudo apt install autoconf make python3-virtualenv
>   
>         - name: Run configure
>           run: |
> diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
> index 27c847e125..a303253693 100644
> --- a/doc/developers/documentation.rst
> +++ b/doc/developers/documentation.rst
> @@ -23,8 +23,6 @@ Before building, make sure you have python3 ``virtualenv`` module installed.
>       # prepare virtual environment
>       python3 -m virtualenv .venv
>       . .venv/bin/activate
> -
> -    pip install sphinx # usually packaged in distros
>       pip install -r requirements.txt
>   
>       # build documentation
> diff --git a/doc/requirements.txt b/doc/requirements.txt
> index 742fb8b4bb..6302ecd9f2 100644
> --- a/doc/requirements.txt
> +++ b/doc/requirements.txt
> @@ -1,3 +1,7 @@
> +# Use the same sphinx as on readthedocs.org. When updated, make sure
> +# sphinx-rtd-theme is compatible with sphinx.
> +sphinx==5.3.0
I'm still not 100% sure about this, since readthedocs might change the 
version and "pip install sphinx==5.3.0" would override it. But we can 
try and see how it goes in the future.
>   sphinx-rtd-theme==2.0.0
> +
>   linuxdoc==20231020
>   sphinxcontrib-spelling==7.7.0

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
