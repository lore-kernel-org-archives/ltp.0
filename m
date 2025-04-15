Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799C0C369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744735063; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=djluhHGFDNTLJzmccBgxF6g3xn9eLfwEHiNmjMLSsfI=;
 b=XuwiySfyE8VWDrWo7PE1cffMl1szcQzfUtgnQq3E/X077lqb0vmVYeBoT0C+6ZKwi5LU/
 oozVxwg+5My2ANRjlSrwuhIwyTEH5zD/TqYolQ/gr8Gs2mPnczDaYv8OVOvyfek7V8/TplT
 LqAXcRjPURovRt51jcCj9PAL+DbA5d8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14CDE3CB91B
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 18:37:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 039AB3CA513
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:37:21 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 303BE1A008A7
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:37:21 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso63683965e9.3
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744735040; x=1745339840; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=raa+wQ/BR6lWL+kBg2FOmX+ZzR5zbiaDAZu7efnQf8I=;
 b=RUz7hwHYJ45W50z25s4yF6riWPGX3dquWDatxznSYgSINhaWCH98rqZ4UtQi0YBh+a
 LSOmv13zKwheGXDjCwDf+f5ab4kgMldW2jCrKnSfEr3IknXgDTrrE+2qAneJUkk+oaJu
 IWHnh7yJRS+r2Vj0kC2u+GfmT4Wr/sfvPAHeFMn9/LqJKiPrtASG7OHySyY54cALKZmJ
 AREIPQYi5UULR/x3gJvwfVN56+c86Ip5rN8wee6SZXsXy3OEroFYz1rZ3E5G3eo4VfZo
 xmQ6tI3u44DrrRJjUhNMBPaFZ/a44/C+tNuH/EHjw/IU0ff1V8IikR9JvG8jZStYOY2+
 /qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744735040; x=1745339840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=raa+wQ/BR6lWL+kBg2FOmX+ZzR5zbiaDAZu7efnQf8I=;
 b=alDHKK8MvaPYa8+b1+MsInUMDNaXnuMy+MNx3umgY99bTXkHCM2qiT7T5AOQoYMSrf
 UYGApWsXYBh1t0VAfe/Mh+x1LrscQhpAmFIukF8Fo8Sn833Z2PDjL6EoJiMelauCt0eC
 3GZEAiSXJVn1PCCuvQRkg9u3fQzW7He3GZ9Wog70P8tCsb1QsTG5KRfPCxHgm4573+Eg
 ATeqd0Fbaf47kgauXI3/z/2pBF06WSGzZsVKOyD3xj8zCkWM0ZrBvX3gnP/ThYEpRpD9
 eRk/zvlff5dgPGakYojc8Z1qBjEiOOglDFtL1GlEK1nUWCIxssgC/zNygQgQK0TWoCqF
 j+Pg==
X-Gm-Message-State: AOJu0YzH8Wz+fhgFDzgL56/Zq0DV6wLALD1PnvHi7fgfoFwmTZsfzptk
 VLaENTFp5ti5xMZ12yMLwKOb85Eb2yU5HKbKZdLykl/jALCmCUmGskUZAz7zglY=
X-Gm-Gg: ASbGncutnrJoX6eLeViqKbqSYJ8KGgB1wprd6gnE0guyXeTkLvE20FIBsaVx03Gh95c
 ERsUJA7/DkxDS3iesmp2mlO17mEuW8kY2WjuYm/GfijlWlkB9Olx3sN/J27Nt1gNH6vCPjakgBh
 gColH4y0ZvfwNguUBc+xwGDFF2yRjcGqBUt7Cn18XJQhY/U1J2UN75O8/t3OF5I7e8K8s4S4gkQ
 vaKIpvg1Nuw2UYLmd06l32TEvg9rXbrLjFZ//lHJgyJ/rq42H6yuqdflsWdWWJhiW6hNgFOuH0n
 bjNp85JCd/0oCJLvRgEVlRB204tdkcnM34GVgg8++zRnuxfW+2aVe5bKtiEPtbotNPhoQbbQh7i
 LmWREO1nLdSPBY87lt4i8UBX7slopZ8vvrlQNLeBHEClU3D5rUfEdeMevUlDqUnd99W0GvYfMJJ
 RBNyk=
X-Google-Smtp-Source: AGHT+IEjjmGeMr00lLMkVQLNSjjvefi/KsjkAw8vgnfkUoauL4HgWi/TG5dCBLw7+MbgA+IyJccMWw==
X-Received: by 2002:a05:6000:290d:b0:38d:badf:9df5 with SMTP id
 ffacd0b85a97d-39ee2751e1bmr167533f8f.17.1744735040616; 
 Tue, 15 Apr 2025 09:37:20 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecb20sm216332375e9.3.2025.04.15.09.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 09:37:20 -0700 (PDT)
Message-ID: <74902684-7c99-4015-aabc-bfbf2e8b866e@suse.com>
Date: Tue, 15 Apr 2025 18:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com>
 <20250415-patchwork_ci-v6-4-81e6d4184af5@suse.com>
 <Z_6KrACqq3DUs_ty@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z_6KrACqq3DUs_ty@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 4/4] ci: apply patchwork series in
 ci-docker-build workflow
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

Hi Cyril,

On 4/15/25 18:34, Cyril Hrubis wrote:
> So we create a branch for each CI run but I do not see any place where
> we get rid of it. Shouldn't we remove it after the CI run?

We run it inside a container, so there's no need to delete it. One 
container is destroyed, we destroy also the branch.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
