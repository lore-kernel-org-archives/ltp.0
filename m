Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982F7C3600C
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 06:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744094010; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=nL65MrEf/IG4aNuyVsPcM0cGwr0GEJVljqx4kZ3NzP8=;
 b=T0Hf/jMEA6dXyIpQNP6saglJlrH+gm0x8DGNK5QbmKGVxaVRJ1ZIqFd0i88R1ZET6gO12
 +k27VHGmU+j+KAtiqox5mWn+ZajFN93qBph/TsRHyR6ljL/qxlsnLWPLKyEOZIMY3sq1/xR
 4OatsdShUJeSLXQYW8IOV+mK7yZFTyI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79E5C3CB366
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 08:33:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2C1A3CA6BB
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 08:33:08 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 00B6E200398
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 08:33:06 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so26234945e9.1
 for <ltp@lists.linux.it>; Mon, 07 Apr 2025 23:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744093985; x=1744698785; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dCWZP90vK21XxEg5Dw3cnCA4ERoyFGITAZYN2TqcgC0=;
 b=YRVs/l/OeZC5C2/v9Y47zB4or8y1U0Z6Qobx9EXvPmhmYYn0NATJagyTB93+23KNZg
 4UwKbmErmccss6OD1MqWa7+Ey37KAPtSZbdROjU0lwhl8J68V+6PW0HgzZ1/qzhmgP5u
 G3xZ2fNgUjitXRBFrce66snQLOQN6UaI1kLLRnPiT1mGEHyYh7vVp6w2Evop8tq3+AUi
 if1mXsUTNtH4ipCuS8ubZsiNTVffkqFOGm2pLTaQqCGBhDzk0uRN9s2r9uFMQNkF/X7I
 jhPfUv0PMAhERs5/PZWoa7AgTL0GTh4I2TJwrqzsItH0xgM5rcj/aGpLd6k37mfVGfN9
 ZtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744093985; x=1744698785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dCWZP90vK21XxEg5Dw3cnCA4ERoyFGITAZYN2TqcgC0=;
 b=ToRHR8Xo5Dk1QkvXZI6+uDMNbldTVnnSWLaeh4CW1yHUoKggCKTGCWJ9flPo5HblZl
 4TZhqTJArpHn6kJFg5KhOMKjw1xMUf/W0/78x4ybV2qi39FxxsfL7sNb3TifNKXRngVG
 iZnmzJ2TizLX/nViuA8AYaNP93OsBu+1+JmFkUpaswckph/1Lm/y8nlIEf4m29256ScM
 ULNPksevh4pqMunalmK9MUHKpoRtC2PHbTmoJQRT2B4UB8042gZ7ZYWBoMOzBcvPkEA2
 PqDrG6snwLd8pxKDGcQHAzVqILS5dAAz9Mus+Jj6Q0wvZizCnORiWaKka5nGUhYFVQuh
 D8lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlVO85tw12Yu4POqvIzIgVdJTvJkFAYCDPqwyWXMRtEznprVaD1HAnd/GcNWVufl9OQJ0=@lists.linux.it
X-Gm-Message-State: AOJu0YxH9R2dyJvsF27Xv72MPItHuoPcbZyjcbdaPjM+BiggZllhEVK1
 G3UDkcBxn/Lp2goRrhJovq2C9JxkKp55HLKwcSVsi3MR5A4w4Qs7nNqv3Z1l6u0=
X-Gm-Gg: ASbGnctpa527vAOLVU0vGkhg328Nf2iH/Sf2wkkIJPbkF3RuvtSQinBfMOKjJzY60NG
 ApzqQ+Fd7Pib5LuWFYH45DtBtAVLid93JkIX8nKHUPIl5HO0zrxkzquXRoQ7gH527GrV9H5dP8q
 GJK2xolvk2oHj2LPl8h7a1ehyJUImRUVoMIGN3TxWV6xSapGpqrgA7fgcO8CyOuCL7o72U6Y7uk
 U0lel/8BGt6U3ppOxKbASl4FpukuXoLLEfq0s7lJamKJ/B8jcZz5DkO7P251YAm3aLylkaiRC9s
 k4T/ZFxYpvptR3f24GRRkmw7ncou77j2tVe4wUuu25hgHSN6orwupi+w7tgCOjov/HHgwDZmC40
 zWSmsHqt464SqabmRCKQ6p+e5WS8I7NQDy/3K5WusTDy26euUyoLy7IP5hDlKJxInJ5AhI5m+pc
 /5oa/DxHQ=
X-Google-Smtp-Source: AGHT+IHnX+MV0SjlM08jbpxXLuJn9OMFmCtSISEUe5xoIphv+JdGOND8zu+kRwRkSLxrR86O3UE3gQ==
X-Received: by 2002:a05:600c:3505:b0:43d:cc9:b0a3 with SMTP id
 5b1f17b1804b1-43ecf9fed8fmr103595425e9.22.1744093985330; 
 Mon, 07 Apr 2025 23:33:05 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a75fcsm148945955e9.11.2025.04.07.23.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 23:33:04 -0700 (PDT)
Message-ID: <a2197905-94b2-4f84-a19a-fb26b2ff65f4@suse.com>
Date: Tue, 8 Apr 2025 08:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250407150133.115790-1-pvorel@suse.cz>
 <20250407150133.115790-4-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250407150133.115790-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/3] doc/Makefile: Allow to create and use .venv
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

Hi Petr,

some comments below.

On 4/7/25 17:01, Petr Vorel wrote:
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
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> * The same as v4
>
> NOTE: doc/Makefile should be rewritten to use generic_leaf_target.mk,
> then integration to the top level Makefile will not be a hack).
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
I had to think carefully about this, but I think you are right. It's 
better not to over-complicate this and to support other shells but bash.
make command can override environment variables, so it's better to use 
that feature instead of complicating Makefile that can be really messy 
when adding new features.
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

The rest looks fine.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
