Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCFEC3600C
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743167136; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=SEm8mtB15xIUUO94smITnp5zy0SZTG5FuT1mdEY3l1Q=;
 b=Z2sznmlOtPXyFHstrjksDjLZEwgthN1lisfDlyKoWKh2g7yMJNUYYtPhvvbyqm7FzwOoO
 37Ocw8+5CAdiPKPPEH7Po5Zyb+U0uFJDl42+qQ85vi7fq5Yz+V1xsLSrv1rjmgpsO7zUC96
 KusgaBql/Lv7HEjG74eTrh2cLo7mOaE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 559073CA494
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 14:05:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 821583C264E
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 14:05:14 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C1C981A009AA
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 14:05:13 +0100 (CET)
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so12109705e9.2
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743167113; x=1743771913; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9hp5Si1HpWyn4uNX8ir0JmGhCpztl4QFUaoCbINrPZ8=;
 b=TX/YGEE1ZezieFCGxUPYlO9/xZ+lf3VX+NyJSzoPwVy/tGSpFOMxnZTrKo34bW5uBL
 RljF+cyEjb45daZM4GlHUIGO6yXv3Ncf4ybBHasUIdAWr9ZZ0VjwQMUPEhL+3pYQRMk0
 Or/M7ITmRs1wHTq5GPHKmbutNGVkkRpejh//t7DArMd1M+pAHEfN5dpk/84lbHYekeX5
 9R974uUWtYgw8K0vaOd6gYoOy3GpEM/skbFTBgdsPqdSS5bhm4oOdbXUxpF7Th7ZyVZy
 ceMlnxgoRlgwQSxvbaMUIeyZkzg8dX2ttA8X0HWDaP/SjqYWF7HH60r2Gc5ps9IxI1ew
 QyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167113; x=1743771913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9hp5Si1HpWyn4uNX8ir0JmGhCpztl4QFUaoCbINrPZ8=;
 b=ezFwiAXFv8lMKu4Xp+rf9lZfnV1HDsLbh3B6W6IpG0G9bJWXygtCljyafbSg2jPfeJ
 6SrOynGu0melrgdVnBCWWcv3oA255DqkdHMWTHsZuWUWhhOzZB6iScEEtMg38iOOGk9F
 fY0azytNL2OHhzZTKQO4J1JkD1pq0JnAG43s6rNlr5IXUNULWrmeU1ElhASij+yqe6YI
 U5lFFlSLs8OvO+JtELLVIlBgfKE5DaRoWF+HtpBbQHzrFu9cCstnYs6iB/Z1ntoz8DYm
 Jj450GSTbqD79gb1gb2bGkYXTj7e7NEZ4gzO4s7MZTAHv8op1OS2Bh+Rk0ApqEZWpKGZ
 CSAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8y3ydzoc5pjW2LORG/Fc4cm90VPT/BIu4T9fVpdBFNHwbVJ9GOrxQvyDB4WLe1AZ+MXo=@lists.linux.it
X-Gm-Message-State: AOJu0Yw5xK+TJNj726P4O41wW7EEIkGhccqMy8tUAeND05RNdwn9Vk4z
 jZzJfATjBUn2JBIhjglv+mXkzc5hi2haAAVjCLSoZFztQ08Z42CPXh/9QYsrdiAjPKEZGUDcvGS
 UNS8dCwlV
X-Gm-Gg: ASbGnctGDR9IJrvp/8ioMxwj2nQ/7Mblc+u4Wouq74G2plKzdeb4rJhQXKntSjYlPcs
 gZf51YypdixXt6CuEfddicinChEdYJB1hnL3hv4EQ79u6Smrw4A/KoR7oNGPjM7EzxjHb/Ppw8w
 VodrkCjK5LD+kAB9WAYWe4vbA7mW12q+q6rGsh26ec0ybW6kGYvgUVAwaDZu3IJZxrqgq/Q5OaH
 rJF3OdgA25/zxTjdiG9fOmwCxKEQmI27/sYL0feuH7KM5G9s/kZ+MtEDJ0CdBFHXE3cnTI+JoyB
 EPQfe74kr2dxED6lrbTDQoFnjIbwjTqcqstgOk9NIdGqlwVE/VIQgPziBsg4R0+cEa1uOSjdWrK
 5sMLH6I15DTHhkBEKoIxeV71N0kZQcbpZOMEiX8JomZwbTrZLMVfHjO89MY8tKPVOvzhSYsnU2r
 2zUMIztqA=
X-Google-Smtp-Source: AGHT+IGrsF72l8CitBBCgUArQmMqKACaYZ7dcgQS5bfaSn5wA7VpsvknQM69Gr8YlRE9lcAjpQg98g==
X-Received: by 2002:a05:600c:1d9e:b0:43d:609:b305 with SMTP id
 5b1f17b1804b1-43d84fb435amr81477145e9.17.1743167112518; 
 Fri, 28 Mar 2025 06:05:12 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d900013afsm27143235e9.36.2025.03.28.06.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 06:05:11 -0700 (PDT)
Message-ID: <58bb7954-319e-4d56-a321-da66a6974c1e@suse.com>
Date: Fri, 28 Mar 2025 14:05:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-4-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250328095747.169011-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/5] doc/Makefile: Allow to create and use .venv
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

Hi,

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 3/28/25 10:57, Petr Vorel wrote:
> Add 'setup' target (alias to '.venv') to create virtualenv directory.
> This is an optional target (not run by default).
> If .venv exists, it's used in other targets, activation supports only
> fish and bash/zsh (known shells used by LTP developers, csh/tcsh is
> ignored atm).
>
> This helps to use virtualenv for development, but avoid using it by
> default (readthedoc uses container with virtualenv, creating it would be
> waste of time).
>
> Add 'distclean' target which removes also .venv/ directory.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes in v4:
> * Add setup (alias to .venv)
> * Move sphinx to requirements.txt (therefore remove handling in Makefile)
> * Add support also for fish (csh/tcsh ignored, supporting: fish, bash/zsh)
>
>   doc/Makefile | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/doc/Makefile b/doc/Makefile
> index 3c5682ad00..2062d6e935 100644
> --- a/doc/Makefile
> +++ b/doc/Makefile
> @@ -5,15 +5,33 @@ top_srcdir		?= ..
>   
>   include $(top_srcdir)/include/mk/env_pre.mk
>   
> +PYTHON := python3
> +VENV_DIR := .venv
> +
> +# only fish and bash/zsh supported
> +VENV_CMD := if [ "x${FISH_VERSION}" != "x" ]; then . $(VENV_DIR)/bin/activate.fish; else . $(VENV_DIR)/bin/activate; fi
> +
> +RUN_VENV := if [ -d $(VENV_DIR) ]; then $(VENV_CMD); fi
> +
> +$(VENV_DIR):
> +	$(PYTHON) -m virtualenv $(VENV_DIR)
> +	$(VENV_CMD) && pip install -r requirements.txt
> +
> +.PHONY: setup
> +setup: $(VENV_DIR)
> +
>   ${abs_top_builddir}/metadata/ltp.json:
>   	$(MAKE) -C ${abs_top_builddir}/metadata
>   
>   all: ${abs_top_builddir}/metadata/ltp.json
> -	sphinx-build -b html . html
> +	$(RUN_VENV); sphinx-build -b html . html
>   
>   spelling:
> -	sphinx-build -b spelling -d build/doctree . build/spelling
> +	$(RUN_VENV); sphinx-build -b spelling -d build/doctree . build/spelling
>   
>   clean:
>   	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
>   		${abs_top_builddir}/metadata/ltp.json
> +
> +distclean: clean
> +	rm -rf $(VENV_DIR)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
