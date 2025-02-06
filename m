Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF22C02198
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738853983; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=m62hbNrvId53rUdMBw7ivmRfrQKGTgPmQjlw1Z1tE78=;
 b=U0KBwQgErKqcLENvJTKAvcjG9OjZfxElz3jGsGxutex8uI1EG6YG2x/jcC3bRhHxc6qzA
 44PzvmBN+P1uEz/44D51EZjhUjHIDS1fJOp1SC5EzTiTjaU3V9bjV6bEfIlkj+gdP5uvQrr
 zwx6q2pxOz2CVoh3YB/2tWgmztKnE9Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FC693C9296
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:59:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98DA33C91BA
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:59:21 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D167262C67A
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:59:20 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so10077855e9.1
 for <ltp@lists.linux.it>; Thu, 06 Feb 2025 06:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738853960; x=1739458760; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ITXsgD2vKTEBLkkaUvlr1jXEarrCNW2IhcU2ySB820E=;
 b=cFiAzbSQ/vwHjhRmd0Q50JNt18oKNat4q87XeIO9vowdwoSwGsIenNJy6P9wak6Lno
 DxeXjFa/AasNF1MQCr5CFr7K0+Gm26qAkAc5YAh4hBoG7mwLwhiy2G38UPIP/uhjcwN2
 d77cT8nckilfb+lW9ZBJ7hjDtUtzM3Mt3l1HK0aEHWrtnH7wW40hTxej26XH/AIZP2Pq
 k8VTGhX60bk/vNY50b1VeTqVrs5SW1oxY9UdCqgej4gES4QgeoOTCY+5nQuW5uKoVP32
 SQtnm+R83SkJRtH0WfnWLMU0YwqPUF8u++wa5JZVDfDjaXv1D9njMeoEd+IXxIa/TD/z
 lNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738853960; x=1739458760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ITXsgD2vKTEBLkkaUvlr1jXEarrCNW2IhcU2ySB820E=;
 b=b8sxoGX6hDDyieSNDRnOGBWsdtUoMrLX+Wd9p58qLuqXsovggezvSUtC8xFYQCf4jf
 ZR3fj238KbQ/nI2UcZspAGzjA6Zps8dtoO9r6WExe7eYSy/a2W8qvTyNIQ+hPRg9ssVh
 66KT4tPWlc0fluLxqms0g2yTq759AqZ3I+rJKW72aw5R8XF3qSrBIB82hSPMyTDLkCg3
 gNa0VO/TzCicdm3dXad9AkLIvY4bt77KA9HiHSxzDN9h6lFnA0zMlAvaHC1MXq4/tDpd
 XUOtzn55CVr31Qu1LXupzkNH5c/msoDzVtl9pm0ougiv7MtmaKUHT+pHeflBef5ZO3gH
 tn1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZEew2Q6iIO491GHupqQwHEmCcnGmlUaoWf9PMvFZ0XaR1Cp+hrR+qEG5W9eJXEtxZwZk=@lists.linux.it
X-Gm-Message-State: AOJu0YxVGvkZT/j1n95jyzCYOe3IL6Mqzgmdl056EGcb22s8e8nK7eKu
 ISPGOYJmzYJ/EWF9VRtOY9NsCcFBVc+XEwdwh+nwcE3DFK9PyZOIX6brduSNHdY=
X-Gm-Gg: ASbGncvWGNJqWBBEXMtgfpR4w/7DiK483Fg+sTWGC4v07gtXK2PNuljzePGQsslG2SQ
 TqO72f1Y+JqlYTTSmZV2AsJi+dRccIWERFAAyPrV1+ed+vpYozQsKMcxPkCleKohTN4GLizwxtm
 a2I1QisBbwNsrh8Sfu2HdwBqlFUECWErM3Hh/rwYVCE64lx+z9twNmuyDcddYH0Bg3eg1zAfVTR
 LnsucEmNNI9jW4Ret2MzmxkFFGmOsa1vALVs0RrFPMqIRTpdCOh4lvW/JqpvMknxLs1zAGe+9K6
 EMYJ7jiV5pdfzxx5+OLEMPUfkZFRKgc1WE+3DYeFcpqxVVGPhF++GDcTOwfGDAnmM2jWgBMvoSo
 4JhwOIG1Hi47EamHOF+MgwPpnsrt6NJfWkI3Ej2i+eMad/KTzfd8=
X-Google-Smtp-Source: AGHT+IFoWF5m7hg7bGTOPjBQRJ7dx/3P30qr8t5d+QiDM61qX9jd45zMezoYlNzEFobvJyG2BGNLpw==
X-Received: by 2002:a05:6000:4020:b0:385:f6de:6266 with SMTP id
 ffacd0b85a97d-38db48d1788mr5559966f8f.24.1738853960260; 
 Thu, 06 Feb 2025 06:59:20 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd7f081sm1969088f8f.58.2025.02.06.06.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 06:59:19 -0800 (PST)
Message-ID: <3032b376-8f7a-4b1c-8422-f5a61e59b680@suse.com>
Date: Thu, 6 Feb 2025 15:59:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250206143421.1571918-1-pvorel@suse.cz>
 <20250206143421.1571918-4-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250206143421.1571918-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/7] doc/Makefile: Improve make targets
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

On 2/6/25 15:34, Petr Vorel wrote:
> * add _static/syscalls.rst into clean target)
> * add targets:
>    - .venv
>    - distclean target (for .venv)
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   doc/Makefile | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/doc/Makefile b/doc/Makefile
> index e536e95db6..0f67721ef5 100644
> --- a/doc/Makefile
> +++ b/doc/Makefile
> @@ -1,8 +1,20 @@
> -all:
> -	sphinx-build -b html . html
> +PYTHON := python3
> +
> +# install sphinx only if needed
> +INSTALL_SPHINX := $(shell $(PYTHON) -c "import sphinx" 2>/dev/null && echo "true" || echo "pip install sphinx")
> +
> +.venv:
> +	$(PYTHON) -m virtualenv .venv
> +	. .venv/bin/activate && pip install -r requirements.txt && $(INSTALL_SPHINX)
> +
> +all: .venv
> +	. .venv/bin/activate && sphinx-build -b html . html
>   
The reason why we didn't have virtualenv dependency in the makefie is 
that every distro has their own python packages as well.

virtualenv requires pip, but it's not strictly needed. For example, that 
could be don't inside a container for development reasons and the venv 
activation wouldn't be possible.

I would suggest to keep the previous version, without the virtualenv 
dependency for this reason.

>   spelling:
> -	sphinx-build -b spelling -d build/doctree . build/spelling
> +	. .venv/bin/activate && sphinx-build -b spelling -d build/doctree . build/spelling
>   
>   clean:
> -	rm -rf html/
> +	rm -rf html/ _static/syscalls.rst
Good idea, maybe also _static/tests.rst since we added it.
> +
> +distclean: clean
> +	rm -rf .venv/
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
