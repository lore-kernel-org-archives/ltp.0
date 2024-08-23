Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5A7C531DC
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 12:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724414469; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=H1AX0GQ/BjnoiKszs5Ezw2BI19r0XEyjwKdRKk2NbHg=;
 b=PqmfZLjTTKn/Lh+mZcUEjtDVapTEjb+zPS0MAvpKHdh8lySuy2fvBzK570Ibx4wKOBdb3
 pfDuvrWgDMiXxe1GUemXIeDbBHyVwfLUppwpE4N/cTpP3nO+mg+lPjwrxXXwVL0m3emR6UX
 y1mNJGeJF3+HlEOilJIjGgylq73q89Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D91AA3D2332
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 14:01:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75BC23CF762
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 14:00:50 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BFF5A60274B
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 14:00:48 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-371aa511609so904900f8f.1
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1724414448; x=1725019248; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ReK1PcepjLq7SZX4/eBNaQg9OzMVFiLW60qjjoOBOB4=;
 b=UCbnAs8HZ7jmmZENCmVzyyEAYMo3H7VI3llAHgLoIJMyB1rQHe8PI9eVBCjK1m46lD
 ZEQnvvxG0AS71cPcQZ3nqyEDBqgeSP39t0ZfpwVDQ7Rqt6cLuImj/3w8VOZFH6+9CMJ+
 myDVNMXdrUf0LTfwDMWj7ttOHrVZakc7txgAl4+SeZjLtzrOZgz1lxchaJ4tGAhnt8D1
 beROBYrPcXN9GTr7vpog+dPOjznzcWvs2JL4ODZ/kTzRbOKYNSoTbydMyrLAoaE13UK2
 smdZaHWdUmqweQ1rJzsY7FAT/+NaqoR7bsN55i7P9W7Qdlyv0rr9JfWlYx1tMubV2+DV
 oFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724414448; x=1725019248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ReK1PcepjLq7SZX4/eBNaQg9OzMVFiLW60qjjoOBOB4=;
 b=B6Gv28Dd+GC8Yos58wNrzM5SycVWRvxz9/V3NghtcZNnyRmAcQiP69EoYzQpDNnVM0
 z1TeOfZYH+U0s5exDuOoVpsxsMvEhL/mk7OjR1Sd3zUZe9Qr8EepePXEkVdmNFbAabIz
 pPTjWynL9ZwePGywgN/MZw3qI7MvvbbVnWn1c9VZM552TDELGWHz5e6fll1cpx/JnuRD
 RM1z/BmRHreoMMXYh7QPpPaxenFoidJeAHvV3wmHE6rlDBfdGvqCqrfHcd4reZ7sjgRL
 pn+222VJ/FayFkZI0I2cB0WdZxDNPTnorTwLUTOahJ/LQ1AdqmxEfgMg5T/uo0CaM3bj
 B7pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg9+IRsCGGtAnVjcVprBfnifdkS+azscmg4YbtO5NtHnaulAFRNyJgulKczQLkay/+ZTE=@lists.linux.it
X-Gm-Message-State: AOJu0YzetnPchlfbffcx+klV8hLXqrbLbv07sMBb628qZ1AyuPbBo1z5
 vcowRt1MXRvudiBLnstoh3fBdH9JQ2Yzgw4E0t4MoJ4l9wJYeEyiF3tzCZVV6P4=
X-Google-Smtp-Source: AGHT+IHx3fVywYSvoIwvMbMJQb9fVjdW9rUGKJJwjSTdSyTMzBThvCbAzQUZyPsWuAsFm6SmjUsb/g==
X-Received: by 2002:a5d:490d:0:b0:367:94b8:1df1 with SMTP id
 ffacd0b85a97d-373118fba19mr1251531f8f.55.1724414447362; 
 Fri, 23 Aug 2024 05:00:47 -0700 (PDT)
Received: from [10.232.133.86] ([88.128.88.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f2ca516sm249785666b.87.2024.08.23.05.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2024 05:00:47 -0700 (PDT)
Message-ID: <b57b7fc4-e3c2-4aa7-8037-a27906d25091@suse.com>
Date: Fri, 23 Aug 2024 14:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240823114217.1261861-1-pvorel@suse.cz>
 <20240823114217.1261861-2-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240823114217.1261861-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ci/debian: Simplify dependencies installation
 / removal
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

Thanks Petr for simplifying the ci process!

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Andrea

On 8/23/24 13:42, Petr Vorel wrote:
> 1) Use asciidoc-base instead of asciidoc for both installation and
>     removal (it contains the asciidoc binary, asciidoc is a metapackage,
>     thus removing it would not remove the asciidoc binary).
>
> 2) asciidoc-base asciidoc-dblatex and ruby-asciidoctor-pdf are available
>     on all current not yet EOL versions (from buster (oldoldstable) to
>     trixie (testing)), thus it can be safely used without '|| true' fallback.
>
> 3) asciidoctor contains the asciidoctor binary and have ruby-asciidoctor
>     (ruby asciidoc library) as a dependency. It can be used instead.
>
> 4) Remove also ruby-asciidoctor-pdf. It should be removed in flow
>     asciidoc => ruby-asciidoctor => ruby-asciidoctor-pdf, but explicit
>     remove is more obvious.
>
> 5) Don't try to install libc6 (it's an obvious base package, it cannot
>     be removed). But it's not working on Ubuntu 18.04 LTS (Bionic Beaver)
>     (package not there yet).
>
> This also unifies packages, which is a preparation for a next commit.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   ci/debian.minimal.sh | 5 +++--
>   ci/debian.sh         | 6 +++---
>   2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/ci/debian.minimal.sh b/ci/debian.minimal.sh
> index 0584192721..2ccd161c46 100755
> --- a/ci/debian.minimal.sh
> +++ b/ci/debian.minimal.sh
> @@ -5,7 +5,7 @@
>   apt="apt remove -y"
>   
>   $apt \
> -	asciidoc \
> +	asciidoc-base \
>   	asciidoctor \
>   	libacl1-dev \
>   	libaio-dev \
> @@ -16,4 +16,5 @@ $apt \
>   	libsepol-dev \
>   	libssl-dev
>   
> -$apt asciidoc-base ruby-asciidoctor || true
> +# Missing on Ubuntu 18.04 LTS (Bionic Beaver)
> +$apt ruby-asciidoctor-pdf || true
> diff --git a/ci/debian.sh b/ci/debian.sh
> index 63cf242d2a..c413ef457b 100755
> --- a/ci/debian.sh
> +++ b/ci/debian.sh
> @@ -15,7 +15,8 @@ apt="apt install -y --no-install-recommends"
>   
>   $apt \
>   	acl-dev \
> -	asciidoc \
> +	asciidoc-base \
> +	asciidoc-dblatex \
>   	asciidoctor \
>   	autoconf \
>   	automake \
> @@ -29,7 +30,6 @@ $apt \
>   	libacl1-dev \
>   	libaio-dev \
>   	libcap-dev \
> -	libc6 \
>   	libc6-dev \
>   	libjson-perl \
>   	libkeyutils-dev \
> @@ -43,7 +43,7 @@ $apt \
>   	lsb-release \
>   	pkg-config
>   
> +# Missing on Ubuntu 18.04 LTS (Bionic Beaver)
>   $apt ruby-asciidoctor-pdf || true
> -$apt asciidoc-dblatex || true
>   
>   df -hT

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
