Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DEEC36000
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 14:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742568151; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=T52xAcBnpSKy9itX0CyYOHRV+v8iNHXx5L3Fbub9wEA=;
 b=gf40mKsbDWmZ+ZFF4wwitwciGy0V2W0E6e8ObFacQ1mti1Um7LhylB8SaxyPib+PGvysn
 EDrZeVBYF8XtYyfeKbWIb+okO+wSyvzBS36lwGfOocLrVtO0zDpe/oSolzv97RCaLyOPXvK
 1iSAFGKZv3h76zL06dxQKaycUk3kCIc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 588CC3CACE3
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 15:42:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 893813C0E24
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 15:42:10 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5E282600643
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 15:42:09 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so1157932f8f.3
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742568129; x=1743172929; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7LaMVNR/Ej0s8Gq/WpAQVKLCT/IngW0Us+TLlLmJhXk=;
 b=hG5P1CaIOUpKdjE9OA0NMaGh49B714h8fkA/789OBLjic9Wt4fpLHP3VR3cljHDAly
 HXj0N00Iwr6uw2JfkyXcjNvKKQG/Pc+GmWsB+7BMySWpeX3HoLpt7SYoIQPcrBDr4YoR
 errIYWmklsJZjbctcdKMgrnAkdzGWqmrLqqzcC5MwI4AiuQnmhBT1qfT5VdeU59CnrQ5
 wcCb9aS9oZYq8BEsv2oh6loh6K5Xf7ZhoZYz7k8eSW3UYvmrXwcjThdCLygzycqHd1+K
 HvlUBpV77O5zbYEXyXCWhN8O6nOOMuA5t+XYyx5Ig3BpdHR0CjvGmG2IOtsbErXaS0qB
 EnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742568129; x=1743172929;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7LaMVNR/Ej0s8Gq/WpAQVKLCT/IngW0Us+TLlLmJhXk=;
 b=VuXitmsbzqRKHixe5BSqwRoWMWm4VEPkaSjRkMEBO0X2URL/1nF558vtjZQWEaq32D
 y9VFYKrnPFS5g7XxZlNT7t7Ta5Isr/Oa7DsJhR/hYuaFLk8ThoA9nJzLC9AzYWsLOX/h
 noNbIiizKv2Ic4TEZLqUo0XmIFzUyg4+E4swim6rRQ2LAHxpR9htpXiDK9kR4dxi2SY8
 /pkgxjvXmQxrrdtILD5lSH/i6Wx7Hi0vP0n47w+mAZ5I4VYPZ6UygJP316HtqrE8LM17
 Jm8zwgwfVFmnDJ7szZKrBm8dB6W7zW8wcJBHfSBjlgjJ5VJ+E/l8OmSg2wlF7KcRf8bw
 dR+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWleLxWDhaNhZ6z8KnB/2S8N3JWYl7wdFWh86YrpVJTuz6eGEpF28q2WZtqEPhOLC+Cw8Q=@lists.linux.it
X-Gm-Message-State: AOJu0YwB6WVkA02MGmANo3l+BwuttcqoiIGTabvJU+BtNl7CoJy/ld6r
 LsMktYR7wTMjWXmiVdIDzWPt3tOceUc2lpogqdMbSwSKU9ceD0FtiTJQv2iwj4cL8td3aRh2bSP
 vcGGQzA==
X-Gm-Gg: ASbGncuOvRdqEQ9MnAFfkNmmBAMCbJKYI5WqVHa9zelVnsiI4f+QUaly2eoKoAgMraD
 5v3Cus8nCSvthtXcFJFVEqLYdmYnf0Q7zZBWFT1ZyM2TYPKIi60U97vXYY/o4cPPubpfa6jL52p
 SSsBxKwmyI4uzf20S/1cMwdMybrdupwXV0PstTpaSJA1P7GQUYUoSuz5KoTUr2Z1zKDaIWEwaaX
 1oikOmGHk16//OVS1dfn5RKwhFbolmcS2ViRv4IasmGkTkeEt2PU5REX+/CTisHnAWWUn0zH5Jg
 ZvqiISYttN4E+sMxZOPczRsXTzs9DVwUwS1wea3W/r4sp96iizap/58ffPU4Ie9T3M5T3eVSbNf
 OBQU3/+spp1Rgm8nc0MDAjCAeTgxE0J0v8kP15+6HIUHIza/nt3iW9ZCn76zxWaCBurCusa2sTq
 kKskjJC4U=
X-Google-Smtp-Source: AGHT+IGxoAUc5RGJq3KccPi6FFKdN2OMJtzsUST/qbk14ZMabSpD1+CKPSDGnJKmrLuNGDWrnQNxUQ==
X-Received: by 2002:a5d:64cc:0:b0:390:f0ff:2bf8 with SMTP id
 ffacd0b85a97d-3997f8f6555mr3860805f8f.10.1742568128736; 
 Fri, 21 Mar 2025 07:42:08 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9eff79sm2548350f8f.95.2025.03.21.07.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 07:42:08 -0700 (PDT)
Message-ID: <d8691df7-353a-43ac-b4fb-c15f156174c7@suse.com>
Date: Fri, 21 Mar 2025 15:42:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rbm@suse.com, Linux Test Project <ltp@lists.linux.it>
References: <20250321-conversions-mknod-v2-1-c9c27bde5b07@suse.com>
Content-Language: en-US
In-Reply-To: <20250321-conversions-mknod-v2-1-c9c27bde5b07@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/mknod03: Convert to new API
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

Hi Ricardo,

On 3/21/25 11:00, Ricardo B. Marliere via ltp wrote:
> -		/*
> -		 * Skip S_ISGID check
> -		 * 0fa3ecd87848 ("Fix up non-directory creation in SGID directories")
> -		 * clears S_ISGID for files created by non-group members
> -		 */
> +	SAFE_SETGID(nobody_gid);
> +	SAFE_SETREUID(-1, nobody_uid);
I have the feeling that setting gid/uid for the current process doesn't 
make much sense now,
because we are only testing if mknod() is correctly setting set-group-ID 
bit according to its parent folder.
Once we setup the parent folder, we should already have the right result 
at the end if mknod() works properly.

I will leave the rest of the review to @Petr Vorel :-)

The rest LGTM.

Kind regards,
Andrea Cervesato



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
