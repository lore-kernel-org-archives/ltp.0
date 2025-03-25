Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F363C35FFC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 08:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742891760; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=vZgZ7rjUeiWCQjexc9AIYxfp7yCddlaC/yQxqCrRYUw=;
 b=qmWhUz33/MRabShPkMgVJzKzpAUVEq6V+/tF/fPS6oTHN6dWEHw7Az1RUedC36dXBsxaz
 +e92Qe2sH90J1HFagdMJa/zK2IuwAjpQzLMjDFjpLbEQ5Xaczre0vdyaEkjJxfKhYGLAPg5
 gdwzvtdQADQc492RpB2w81VN+l3YSnU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D651F3C98D0
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 09:36:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7CAF3C04FF
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 09:35:39 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 01FC06014E4
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 09:35:37 +0100 (CET)
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2823980f8f.0
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742891737; x=1743496537; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L+gPQjvHx4HECNktP4cyar0UfSKYlPQt0IybEiZWAv8=;
 b=N53uM7f2Dyj3R7yYHqgW3zQifKODijBcsKn98DQqxMkseidnXbVU53c+fxOK8GSl7W
 G96F0bT5MPxiV8HtE9rHYk0u0Dfn68wRQKEip0uQtNVevUPM72fTVTwf/SlA7dMkf5Xw
 VsEEOHFyKLZ7FIAdg9pWTdqqApCtzdUSQYADxsMXL4dxBz2vo+Sobd8xeoU7G8PEYyfO
 1oLdV6vn8uIyuPLXnBbXiFwcrAKpixHXF/PHdRc8JuP+1uudCZfNTdcJjgnAQ7BpXwlB
 qMEDOirvnoZU6ZJB1TDOwSLEOm3413aoHsycRxeGdZP90udlel+QIiZ7Dfp3ZTkhCuAO
 IyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742891737; x=1743496537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L+gPQjvHx4HECNktP4cyar0UfSKYlPQt0IybEiZWAv8=;
 b=ZPzlCvqfK2K6WgzMlWmX+K1h8Zg7gehl03yiLOxIS3dgVpkmJjd0XoNwp//7Ah2unk
 1oIty/oP6bPEbN79oY7MmsgZdfAqaiMbSCUryqyxGuid0VMLBBUnHpcv0954TIfGajHH
 StKBQ/8DTyn+1Y/XHabIpTuVV2U+YFcgnlHptFNnGv7jgKxguY+RT5ob4Xu8xnsoVOjT
 7ibV8TiJXW3sCArg4THRpDRfotIe7XXkonAHCHmhr0YTw7UuB6kBAylNI3mUMrHenm1j
 HP9rBx/UfnP4GXhtFIPxrI4aVeoxVYuYa7t9oOG07yXTM0orQTf4f8LQLWg3YRtt7LbK
 OY4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfbm1y1dqE29qvph85GCx8dDtZJqiyW4uYsK/rpH5PNV/oJWihQpH8RoZHaEQ8Gb7kEv8=@lists.linux.it
X-Gm-Message-State: AOJu0YwH1t9ghKki+YrFMH6Ch1RGds99rW5hiYsCcU694HPhEjJFJvy+
 Sg4m6JPtQc8b3DjoDHBenSL8sVWIeCgr+SO0yBoG/QFKHwj27BXcaMObbl9rJMw=
X-Gm-Gg: ASbGncujz+ery3rlohniaX78lSoWaZVM+oQs+Qy6E5lF+RFum8DqnIxaDwnmoXCM2B4
 mPMYpPqj/vhRWYFtsNF1ExsAB+RaFldVfc26m9DOB0Z6K7uZ0PjQnwb4khgarB9Ot9fbgwsWFQd
 vQTPOfg3502/FhbnWWgVtlC/I1dPImvahUZqqabvBYp8PugryGzIMrRWOUEBJKL3zuFTzTkgm10
 9rUT9/jYOVN7Ees0F13v+kBH63HdksXWjAmwZjJ53RAjZtcIc37SjVAqyivD+8SJCcSuL9AmQ+L
 TPOkN8OuIQksDt9PbdUs6CRxBJ0tf7ldbqvO4n3fM3efsWHR9DzxlmQ=
X-Google-Smtp-Source: AGHT+IFLLZwF5N5u1zLYaqUb4xsq9MubHD6hyPv50FunMg07K7JMmztGY9h44P/D5qW1/t1/HVW+cg==
X-Received: by 2002:a05:6000:1448:b0:390:f0ff:2c1c with SMTP id
 ffacd0b85a97d-3997f911fd6mr14816802f8f.18.1742891737347; 
 Tue, 25 Mar 2025 01:35:37 -0700 (PDT)
Received: from [10.232.133.75] ([88.128.90.56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39abdaf0c0bsm8663011f8f.63.2025.03.25.01.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 01:35:37 -0700 (PDT)
Message-ID: <4c07a227-8fb6-4a9a-b664-d75d726a3d39@suse.com>
Date: Tue, 25 Mar 2025 09:35:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250324234016.367228-1-pvorel@suse.cz>
 <20250324234016.367228-3-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250324234016.367228-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] doc/Makefile: Allow to create and use .venv
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

Hi,

On 3/25/25 00:40, Petr Vorel wrote:
> This is an optional target (not run by default).
> If .venv exists, it's used in other targets.
>
> This helps to use virtualenv for development, but avoid using it by
> default (readthedoc uses container with virtualenv, creating it would be
> waste of time).
>
> Add 'distclean' target which removes also .venv/ directory.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes since v2:
> * Add distclean in "doc/Makefile: Allow to create and use .venv"
>
>   doc/Makefile | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/doc/Makefile b/doc/Makefile
> index 3c5682ad00..3b8265d88e 100644
> --- a/doc/Makefile
> +++ b/doc/Makefile
> @@ -5,15 +5,30 @@ top_srcdir		?= ..
>   
>   include $(top_srcdir)/include/mk/env_pre.mk
>   
> +PYTHON := python3
> +VENV_DIR := .venv
> +VENV_CMD := . $(VENV_DIR)/bin/activate
This will cut off all shells not supporting "activate" script, such as 
fish or csh.
Quite possible this Makefile would work only on CI, since developers 
often customize their own shells, unless you override VENV_CMD. And, in 
that case, virtualenv creation is 1 command away and it makes this 
Makefile feature superfluous.
> +RUN_VENV := if [ -d $(VENV_DIR) ]; then $(VENV_CMD); fi
> +
> +# install sphinx only if needed
> +INSTALL_SPHINX := $(shell $(PYTHON) -c "import sphinx" 2>/dev/null && echo ":" || echo "pip install sphinx")
This can be added to requirements.txt, there's no need to handle it in 
Makefile.
> +
> +$(VENV_DIR):
"setup" stage is more clear than using virtualenv directory name.
> +	$(PYTHON) -m virtualenv $(VENV_DIR)
> +	$(VENV_CMD) && pip install -r requirements.txt && $(INSTALL_SPHINX)
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
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
