Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8443BC369BA
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 07:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744789812; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=u8JklNpQmlGe8lNmrmD7LOIV5JYpGuiTvr7JXKEBgxE=;
 b=KfVIwZRr5nWBbbAkU0n9hbEOZjpdKIynmASacVxcexWxPhcbhFkboC/jksqC47qgNhONb
 9IEkootJT6q+WtcUpib1yQRsIaYCwCEa0lyxQeorf5cDJIVa44irjKYZkTFjDJhM2UKbqT6
 P4MD/WfQ61y31Fz4jfdOgLE73oX8Slw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A1973CB955
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 09:50:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFC9C3CA82E
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 09:49:50 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CADA214001FC
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 09:49:49 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso32935405e9.0
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744789789; x=1745394589; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l6ZKPFwjqaftVS0AkZ1o3IW018Mmv5nu9Hn+h23Bogg=;
 b=GtV9OKCanVBkg2ClP6ZGrv8fzxMO6uPicdlXk9hSThBoWrlncZyvm85JLeVCwKGMCE
 oHy+cWVgULQZzE82wk8Fq4X57Mk0ftgo38b5UONRizskB7RpHI4Cv3pGrCFpjhuP8rzz
 S+NFnBhocDSx6ehFu1iBCG2HmrmgSdXJGH5heCBAvEmeJXypxPFrK9d4IUrfksqbVoN4
 kzRVQycyNyarQ4HwdB/r31mnf4Mu591aH8oiBHAGETHg+w2nYha7dJRLW+Ui//X3QTAa
 Fc1yQFo0ECS++pzNDixD+ijgyMbepBegQ56diUW77qhZNpqqHAtV0gyfme8cTKq6p2hO
 NzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744789789; x=1745394589;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l6ZKPFwjqaftVS0AkZ1o3IW018Mmv5nu9Hn+h23Bogg=;
 b=mJMK15Nx2craxCCAW8Q7Uis+RxLKIs2Qln3XWGjgst0lTe/UvqE3Ns3cjAm/aiyV6N
 Pxt7NYkFi2nEjIUlzXjLaImYpxxPUoknYaOPt4VjPQ8mUZDKUfhm1MnYvOJ5ZUP+tKVJ
 RHKV1m4hqzA0GnPflxmSzAytndzI5bIgtzeRQ5fUurafnEM642yJmXs/GHpVPRG4nKfz
 S3ldbEsMe4KBBxdB79sVrG0dgJataKIBqXsNgevoECfa3tpEhC8vJ50x/+13BIBZdygI
 vT3xhM2S7SCqGhCKUMCkOakKh+uwkvtollZpSXypQ40yb0SVyZMNqGEKud4/EkqwmSB1
 GBnw==
X-Gm-Message-State: AOJu0YzQcYgbRug1z77LbflVOwWlg137Bzaj1XoRdryBHaHEVLCmVjSv
 AkQcYq99i8xDQHcqAooCgz4f4NL2D9JjLekHBSlUL48Grw5sBoI5HrGxzOORjlY6QLDC1YtfjTW
 V
X-Gm-Gg: ASbGncu1166x5vfRoYkaufOWXhNpKopKDa4OLALUWBDGBjPEih612+s8OYStsEX34sx
 pAnCXZKLNZyRburtiHzbib25zP5hcNOITM4JyIJRVJXwEe3HR1Kd5p4DnHHj7jh2vLiYvElgoDk
 wIvwqfzUCyg5X3OG5MjZvZY9xssdt1CPSTgEg8LgOw+Zr09+M1z+YzqrKxHIBqu28wACfQ8iQND
 IjqquFNGu9zWSCyNodxqOQfxfTk8eJlQzc2U7bBLOoa7gvtBAoX5WHqM3Gam5xkyGt6Md+BhQrq
 1O734KtJEpGz8o16okj9IYkeMMO7Hc6w/HyxeHCw/8s9xYi5/szElcLH6gxYZnNnD6PDsj2XXxS
 T1OOmQ8v12Cz2XORk3Z6tI1O6smG4LDyszCHB5K1Pi6G5O3fVm8/wPvF7h1IMbDqjlkj0aQynqD
 m+4NI=
X-Google-Smtp-Source: AGHT+IFWgwwPQs9c0IFyyeqyKr4rbQH5v/geJhVSLc0qD0ivcVMo1jmaZt2NkwZjgLF3fvi7m5i60w==
X-Received: by 2002:a05:6000:71d:b0:397:3900:ef8c with SMTP id
 ffacd0b85a97d-39ee5b36247mr681116f8f.35.1744789789206; 
 Wed, 16 Apr 2025 00:49:49 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96400dsm16608489f8f.11.2025.04.16.00.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 00:49:48 -0700 (PDT)
Message-ID: <0594eaac-8276-4b8e-b505-923d3ea5613f@suse.com>
Date: Wed, 16 Apr 2025 09:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
 <20250415-patchwork_ci-v7-2-bc0b9adca971@suse.com>
 <20250415173535.GA520691@pevik>
Content-Language: en-US
In-Reply-To: <20250415173535.GA520691@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] ci: add patchwork communication script
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 4/15/25 19:35, Petr Vorel wrote:
> (Deliberately test with bash to demonstrate local behaves oddly not even in dash
> or 'busybox sh' but even with bash. And yes, given how many errors we caught
> with this script and generate_arch.sh and generate_syscalls.sh due shell strange
> syntax and behavior makes me wonder if we really want to use shell scripts for
> anything longer than 5 lines.)
>
> Kind regards,
> Petr

Not a big deal, the script is really simple anyway. But I will put on 
TODO list the conversion of this script to python 3.x.
Thanks for helping with shell scripting.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
