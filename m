Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4D1C369AB
	for <ltp@archiver.kernel.org>; Thu, 24 Apr 2025 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745493552; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=1xb7JWkvcIjYpfW/KWToNQG/Hhn+x21tcrI3rBazWck=;
 b=Nr2myq45EsNVJr8DBFBD3ZEXO2jn4qIbMj8qoeSqJ2DK1TLxHPnvHGw6hRkQ3WX3YBSFX
 RjRIRZXoAXyfUQy8BIOjKsPC02VIgzQP5PYwYdfbDCJ91aAmderelfnPvId7rBTdfUxu89p
 xVilRb9XIMKAbKc62yq7JH3YZi6uqfY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9581E3CB319
	for <ltp@archiver.kernel.org>; Thu, 24 Apr 2025 13:19:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADE683CB2D0
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 13:18:50 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9527010007BD
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 13:18:49 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso5924675e9.3
 for <ltp@lists.linux.it>; Thu, 24 Apr 2025 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745493529; x=1746098329; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mf0EEKL/XtyY1dPbo/2UwvIF28TNpVXG7GwvSg3cgP8=;
 b=g22WRupps954VHGLYHZo6xf8Kn2Q2G8PARnQ+fnuzm2YyIIvTL1GY+nP8UDAV1tXUw
 5S6Puohwf8IRkqr9G0h+ueZdQRHWwP8Z27SNXltcckNH0MwVQyBs4WOam6DAJtb+cTml
 w+QTaWoPuhdpphb5EjwAG5h+3DVIle4cmyGD81ZO4WcAnFUkk50qdpABsGqfTIRFtyw2
 rKrYE0De27XXLD0i4pBUb/rhvWbuRQiQDVDS6G6wjlL3bcS6j3vNcvB33XIa7+86uZJd
 Lc4310eq0Y5whif87P9+wgDqHn9cW+t2VcSFSf3beIthQtbuFEuLX5HQXgjmyj5dpVPf
 7Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745493529; x=1746098329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mf0EEKL/XtyY1dPbo/2UwvIF28TNpVXG7GwvSg3cgP8=;
 b=MyD/gdygvNJWIULwqYOy9VXBqSsOERT9jfLbZy5ZHMT0TaPTcQ2dmX0w2p8RwxDu60
 Md6crWPBjW89ynxUlnSHmOGbla9m2B4Ls9HiW/6Q/C5phTZ+7P3rnIhs8hkrIFdksFx/
 J6ta8Jkg1z23jvPYESjV93eEe2P61FO1PtK2G+LVyNmQj1xkkqCl5a5z8MhVqDQzmSCa
 HK0ZQmqt7sO7Sc+HMNO8nhCjM9bpOalaxynou4KWUyr0wmCMarj7zuK3QlOvkSWalHhW
 bSVlQdVdiXcn2uia6GFa9R2jXlZysk4lUuom1p0CUW+ZXccB2TdSqFa9t2ACwHO+FkUz
 aLLA==
X-Gm-Message-State: AOJu0Yw7HBqKD618GEQI0QXOOgG+Ezcbh/oBEqfS07N8fFTMHpjwKhi6
 MA9TJrs55A/Ug9ytTHA8tmNAfQEgiu03FdvJI1mBBSoPpiqsgYlkIiRzjTAHDOo=
X-Gm-Gg: ASbGnctHhOIpFcSOMEXSbUoDciAiszF3+n8ES4rk+rOihVAMLT9cajMaP9s14VTNID8
 3o3l+jGtESpzsgGOx4Qphm7vForb5pTJ8UWfuP1zhaqk3+NXHfvcEMUDa0UiMnz+Oxg+U/BcTVb
 S7cPcog0cdLQ6ovxFBZYklhID060YyngqP1N8QoxIEi+TXDzolT+w4LDUWaSZIgNg6YNVGtTnVY
 lSIBvyga7g9QzhY9Vv8TNecL89/lk5xHjGgb/0yviZE6URtkARKplSg7ljwr7+ql4WCnci9XPbT
 0LB2ZS13/js0uUCQPMO9et2KuP5c/nLrFnaKlPIjhb92VTOxsQ==
X-Google-Smtp-Source: AGHT+IH7wftDG/6ojw/LMczqhWCoc+MDs2HwMA1HOEjuKKymCfJLfR9vBtDxws/gAiTKcjcvltkanw==
X-Received: by 2002:a05:600c:4e52:b0:43d:26e3:f2f6 with SMTP id
 5b1f17b1804b1-4409bd052a1mr19072615e9.5.1745493529039; 
 Thu, 24 Apr 2025 04:18:49 -0700 (PDT)
Received: from [10.232.133.71] ([88.128.90.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29bf7csm18650645e9.4.2025.04.24.04.18.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 04:18:48 -0700 (PDT)
Message-ID: <1368c2fa-7e0f-49d3-b04a-e13020ae2512@suse.com>
Date: Thu, 24 Apr 2025 13:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250424-fix_ci_results_pipeline-v1-1-f880fe011b89@suse.com>
 <20250424103331.GA1075853@pevik>
Content-Language: en-US
In-Reply-To: <20250424103331.GA1075853@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: fix results being sent while patchwork.sh
 exit 1
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

Merged with suggested Fixes tag.

- Andrea

On 4/24/25 12:33, Petr Vorel wrote:
> Hi Andrea,
>
>> -                [ $? -eq 0 ] && exit 1
>> +                [ $? -eq 0 ] || exit 1
> Thanks for a quick fix!
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Please add also:
>
> Fixes: d8348be27b ("ci: add patchwork communication script")
> Reported-by: Li Wang <liwang@redhat.com>
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
