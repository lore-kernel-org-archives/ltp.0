Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8593AC77B7C
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751561061; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=XT2xvk6ujXR4W2esSusOXWSC0CfuKHWzRJ283m6yGGY=;
 b=RQ3C0Nd+bcMHwBO1hvgtpANC9OeofSdne481kWmG0kNdpCFmAat1E4m0p2Sd69GIB+myf
 E0j0SZqsUpdkdbCpm4AfH56s6eMgJGUwklXdcdUvlzGFXWPpdyy5TlVMD9QA8cnAaKncWvg
 4XdQKBa2zX11O2uLErHAXuLvp/wZFcU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62EE03C9AA8
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 18:44:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B040D3C940A
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 18:43:59 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9C0201400C5B
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 18:43:58 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso436355e9.0
 for <ltp@lists.linux.it>; Thu, 03 Jul 2025 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751561038; x=1752165838; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VRWfZdmetfJgFkP9OPGJOx/vBvk+jWv/uQBw3gb7aDw=;
 b=fpaG+zTitH8YF4bef7J4mfF5P3IVFcmBkwYTvPY0hmmSvfEjc3Y4ESESDDoJK88Kt5
 8RD9s7ojxCM8x5JSIgE768ma7YCyEmJvhS6Ebyl+tpQNJCrCJxk91lDOUdSkfRVQ3Rdd
 hhkSLFPnjgxj4tF85h9gl/kpBa7qISoqhEgouWfsKSJyLc+02kE6aw+qCCiWxQqPcee9
 dy6xqcy9dmH3mYEPPPapfWxwJ9u8Gm2Cdc3Hs74sIREXW6bfAD8gTKY5XSH3mt9ROZKr
 tVBBP4xhcxMWaCRbM8R0t6b7yvXy8+AS6WKWHhJkt8fPb8cZ3t1XG/oWO3hsW7xYeEEc
 xJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751561038; x=1752165838;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VRWfZdmetfJgFkP9OPGJOx/vBvk+jWv/uQBw3gb7aDw=;
 b=OqixJdhiEhWNsOgyF0jUBTlWk34XIkVFzfA7f2OGHDIsoC6Yq0CVaKHO6mFjuTmGmT
 2jNzzURIrh30RpO7sBvUJJEbjxSfx7M0NSjF1YCHxXakiCX33zh3hUhMa/PeqeH6C668
 RlqksJWfiESNGggKkdz9pITijVtfDoPs+FBM+0S5dkRlVuuWNgvNHOibrWx/edv3cwUR
 pYoHFYGQXXlYEszwVEjObNNHSdfITnWfw5sNPx+xQtu+fxjP15rKi3bd7IIYa/PSp1CA
 CCVoAIIrgmXFczX82EVjsmFCX8B6OfZZqhVBX7r75TNNLHD7mZXekv14eNvqXQ2knvE7
 01mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMrrcP6IJvuUrMiPIamKnMpXDRbdvybZN7+1UtVgaMECskEB4J95yIUyNJYQhFtJs5S0M=@lists.linux.it
X-Gm-Message-State: AOJu0YxO6JdGy+iDrqYK6c15O6Kp7NkMeWuy0mdmjr9TAazsF3gt+6X/
 uHYIzO08iait29zy0alQeXzrAgrnH7e7CVML4m+GRtJNLT39Ey6ZdDGA5mjlIVmY6IgoBbTVBkE
 cgpx87cM=
X-Gm-Gg: ASbGnctjEr6w9TKm8PL4Sg01WKjOqvv+cK2kDBS7Yuoti+Ce0IpdaX0CvPzDnfQaxe+
 L4kODoMT9dAAJfHrYThyCebOE6roFyXMEgrk6K+hmSXs64wGgmXqAhdfknhkOEKlgbazmR7sSx2
 1vs1Pb6mvFH0YF9s72vF0yAXJWwHYCs2RpauDmTmj+k7vVjgPJEbkWUVoiHP5kpuIk1LlW216oN
 AmctRyQXaqwc4z7Hxe03m15CvGqqp8DElMggjFd2s4uwyMkI3lxu5qtAFFlYUz+CDDMd9vtxTiE
 2W6dBvGPnV9ZnbJtoTdsO+nqtC9oGkBM5DP9Zhbl+rU2x+HwzygzOeZvzVOUAam4Kq8DvFsS/Bo
 NyqdOhR2BdUg90l7Q1ClLKbP6CdFSnh7Ie/n2utqU4uGZMjqhkJcf9c0K9IrG43sl/KOtFdQc27
 S9KkIDBGAdUzEybL01H0TahhW6ag==
X-Google-Smtp-Source: AGHT+IE/NCEHEn1RgvmSa2yUlZTsYMwlRihfTFnhUrPiBQ5FU9p+AkZRfidpmZ4Zi3lterVBxrClYw==
X-Received: by 2002:a05:6000:25ef:b0:3a4:f7d9:3f56 with SMTP id
 ffacd0b85a97d-3b1fdc20df2mr5166709f8f.2.1751561037965; 
 Thu, 03 Jul 2025 09:43:57 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31a9cc4a88csm2883295a91.1.2025.07.03.09.43.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 09:43:57 -0700 (PDT)
Message-ID: <c6afbc71-3842-472d-be70-efc7284ceb6d@suse.com>
Date: Thu, 3 Jul 2025 18:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250702-crash02_rewrite-v3-1-260cc6db6017@suse.com>
 <135e7656-ce26-4ac4-98e2-1982bf1c5454@suse.cz>
Content-Language: en-US
In-Reply-To: <135e7656-ce26-4ac4-98e2-1982bf1c5454@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] misc: rewrite crash02 test
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

Merged thanks!

- Andrea

On 7/3/25 4:12 PM, Martin Doucha wrote:
> Hi,
> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
