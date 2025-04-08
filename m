Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED0DC369A2
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744126478; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : content-type : content-transfer-encoding :
 sender : from; bh=P7PMAxx3V6KuAFagyBuoRJvSsUYk0cV1lhw9fWkvs3w=;
 b=QPFzYNWSkwwxxISRP55C34bIxWwf6oFz0JK03yegxY1tPoPv0x+oACI/D3Q/cDcyS8Gxr
 /oiXvg5S4ph9Db1u6QAcMCF7W/sPR6ShWERwAFS/NAplfq561bd7ooDtx0jrPDbsU5AQFIJ
 DYwzdNErdB37Y4G3l046qmNj8lwCSJY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CE393CB3C9
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 17:34:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id E53983CB379
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 17:34:15 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with UTF8SMTPS id 2A8141A00E40
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 17:34:14 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so3390890f8f.1
 for <ltp@lists.linux.it>; Tue, 08 Apr 2025 08:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744126453; x=1744731253;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VlEIbPB0oS2+ndk4EynCA0YzgDv3gUx4tNkF6d/+B2s=;
 b=quQnXTUGJQuNp3GXMv4UbOVb1Fg/a4XJGGzde73KH/EM8L1uClcUotnx+VsM4ikNpf
 /fwCopPTxnj9IZzVn1bejU5SHBsWo52i4fb3c6vV1n13qcWqL1gg/ZmLpWbTtz3PHS66
 zEKRAIyP5+xoqbCi/DnQAvc0plZs0XUT6G5YTUG3DAA0z/Muc7p2wjwAI13D/uNeqXIn
 IqpSjq51Qc+y/Jt+E44cBtt8PqTDtK1GEDDG1u1OhURDI1bo5yJ0DTVTJ6kAXgpW0202
 cdUpRwsmiQIIfpOtmo3bms3e1qd2Tej5vk1Q7MSDa2VtrN7FcP39L/jnjmPSyUOh3sO0
 h/Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfd4ykTSLQIEK9SOX/iUgzXqWJ+1mYjAuf2+iat+EDKfXSFrNj3+5/7G+kWba6jg/Zwzg=@lists.linux.it
X-Gm-Message-State: AOJu0Yw2DdfjyHDna5eIrOzLhoSDebNEDuiHNak1Dq1mqwOWMc8FSBFz
 XwOraFUF5pN2RudvOpj6RMMbBJ3cpR8T+dXCu/ZV7ig9SwiGmFnns52EvzrToqOfa30/cs94SUX
 /
X-Gm-Gg: ASbGncucSVkT2gJ5Jl3CbP7JJijW+RZUkjK01ODaI37yWJXZnXSx8SMknNxXTA2FJGe
 tQAvhkqRaBj4RxpNIWYXGRWev4w0aEIm3x2h6VGbBhaNr1USfRS8z2/DbTFBbbX+ZmipmuRGg/N
 b9ZGujLmDXKcnnxpQo3H244eESgjyxW6rY0j4AnaFbrfZ9bT92eEt2nep8CZSHA3NjDZ65V15n3
 Me133viwthdvzXeiKWE0jarJJ/T8n3NRw1EcXck+65vYQu13acKMWnvZKQ7tAhy08o7fjL9ftMz
 NcyutXD9d/WlMaBCz8i2EE4k6wl3BQE9E20RLIT51boI
X-Google-Smtp-Source: AGHT+IHvLKP+M7BFdEz9+sgjLExnIjSBK9zcHaiOdk+2IJvy9ww0Sr1ztwJ3uoa7kmYl19aQGgzSig==
X-Received: by 2002:a5d:584c:0:b0:391:ab2:9e71 with SMTP id
 ffacd0b85a97d-39d6fc29654mr10183672f8f.20.1744126453447; 
 Tue, 08 Apr 2025 08:34:13 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0e2f6asm10702068b3a.165.2025.04.08.08.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 08:34:12 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 08 Apr 2025 12:34:08 -0300
Message-Id: <D91D850OFM7I.2P5YPKY3FWCG8@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250408114432.220841-1-pvorel@suse.cz>
In-Reply-To: <20250408114432.220841-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] sphinx: Update to 7.2.6, python 3.12,
 ubuntu-24.04
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Tue Apr 8, 2025 at 8:44 AM -03, Petr Vorel wrote:
> Update sphinx to 7.2.6, python 3.12. This requires to update
> .readthedocs.yml to use ubuntu-24.04 [1], because keep in sync sphinx in
> readthedocs with with the one for local development and github CI.
> Raising python makes sense, as development is usually done on newer
> distros, we were still using old python 3.6.
>
> This fixes the problem on local development trying to run older sphinx
> 5.3 on python 3.13 requires to use imghdr, which was removed from
> standard library (alternatively we'd need to install it from pip via
> adding standard-imghdr into requirements.txt).
>
> [1] https://about.readthedocs.com/blog/2024/06/ubuntu-24-04/
>
> Fixes: b900b790e9 ("doc: Add sphinx to requirements.txt")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> first, I'm sorry for a regression. I tested all the previous versions
> carefully even locally, but in the end the final variant I obviously
> omit to test.
>
> Tested:
> https://app.readthedocs.org/projects/linux-test-project/builds/27784588/
>
> Alternatively, we could keep old distros and just add standard-imghdr
> (without version) to doc/requirements.txt. But sooner or later we will
> need to upgrade thus I'm sending this version.
>
> Kind regards,
> Petr
>
>  .readthedocs.yml     | 4 ++--
>  doc/requirements.txt | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/.readthedocs.yml b/.readthedocs.yml
> index 5434ef49d6..51825da77f 100644
> --- a/.readthedocs.yml
> +++ b/.readthedocs.yml
> @@ -1,9 +1,9 @@
>  version: 2
>  
>  build:
> -  os: "ubuntu-22.04"
> +  os: "ubuntu-24.04"
>    tools:
> -    python: "3.6"
> +    python: "3.12"

Can you please update the docs?

https://github.com/linux-test-project/ltp/blob/master/doc/developers/documentation.rst?plain=1#L36

Thanks,
-	Ricardo.


>    apt_packages:
>      - autoconf
>      - enchant-2
> diff --git a/doc/requirements.txt b/doc/requirements.txt
> index 6302ecd9f2..1b9a984547 100644
> --- a/doc/requirements.txt
> +++ b/doc/requirements.txt
> @@ -1,6 +1,6 @@
>  # Use the same sphinx as on readthedocs.org. When updated, make sure
>  # sphinx-rtd-theme is compatible with sphinx.
> -sphinx==5.3.0
> +sphinx==7.2.6
>  sphinx-rtd-theme==2.0.0
>  
>  linuxdoc==20231020


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
