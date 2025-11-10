Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2FECCF9E3
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762792534; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=UOzJZAhN1zvf3JC0FtOCz5tNyyQB/gmc0wI2ERFbnkE=;
 b=R84K9D9jPykglytYyiGJDNvvNLIZ2UwsySt/CFZQJ2j4naWyjZENU2+H/7CpMQXaZXkvg
 aYSzO02owrAAZ9frX4XAnEeRnxMU7pBGFlsNq/3ekdPSAi3i1owsw0A3lXVcM5EaUbTeD8I
 M6hq4Bk+hO2g4faKVf4imxgO7U4BYD8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 161D03CF5DE
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 17:35:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B25B3CE1F3
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 17:35:15 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7C7B320098F
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 17:35:14 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b3c965df5so576338f8f.1
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 08:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762792514; x=1763397314; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2wZMXJCVj4VuM0qZGo5UQROtVH0xtfOQwRsI/4o2HhA=;
 b=IaiN5iFyYlyRELpswB3x68daUgQV8cA+YGF6v7qunFO3fSyW+9neiQ1GFnkApBMAJm
 8x5FyoBJX63Yco2/unGqNV4N4yfh7JG9c3OKWAldFcuR/M2f5P4ynrZMpJ6okUzr2SHk
 eazGWpwzEqlHxu207W1nLTN+biGj/VK930khUjbOUtOcU02pgbeZSXhWVFoOXEeJqOCJ
 mVaNHjDH669OG+soNmfN9KJTNRfXdHBX7hUesIXXjyDbRiLGysLy25eDNeMguqXhUfy8
 cYxRYsHGVT/aD05zorKED8fpV6EiTZRKGBccXWRDjM4i3Hx3BAuwCBuWNTueEb8XK0Nj
 HzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762792514; x=1763397314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2wZMXJCVj4VuM0qZGo5UQROtVH0xtfOQwRsI/4o2HhA=;
 b=Ag627GfO6xr1YItBj5jNI8ViIn+m4EfrRy1AU/jKbfl4pAwlXtdDOasX4SMAN64goX
 gjSCVOiGLrzQqbceA4RC6rYtWfjybkMOfXvzbJ+gD650BeKnyqr3cbeSwLY8ofJ/2GGk
 fWV5M9KkP3GI+s96RRyqRM+5QiiP8COkZ5ycC3Nubhgxoa5NL24sS+Sjz0qZDR9RyhdC
 rOub6pbzs7pNhQ9HNI2rasyYhg62XzBnokt1o1TVwbIyqqwl9AHynLo/5tydAlZQOUy2
 7ObbHf+Ou2Qpsm0nVnmfZkYBSO1AEIv3/aD/Weiln7wtj9X0WZYqub/eeVku/zQGW8Cs
 MSSg==
X-Gm-Message-State: AOJu0Ywi6hjxONhyV2ejz5B/JtEYajkceb/i/O8X9718Mnexi+i9ePNE
 KTRTFVFiHgPv6GC3/2z4fu9qJAQqCgRaNe3Yx5McrPezK1HkAJJfS/LVeykVnKrUw20=
X-Gm-Gg: ASbGncv0H3/uMSnlqQd9yU4GZKxFTl5VhYUgEfufI1UYM38JobHoGzj8X9FEH0I8OZ9
 KWM3Uwqpycbvv8AAezVe1jrKRdba0Y69TTM2p+tVuqBw6bKw8SwwMceKrsVkR1DG/w6nWira47T
 KVFRWQFgpJw0+bCu7XAa0X64ui9zC+uWpxS/wQ5NKikagBDl8x9NGeP0Rl9MsY7OPd7VoMYSN+E
 CYyI0pfnGPgIn6kuvG8D6NMChhjVoMK/2X9/oyvcsOyQFh+EwfRxvzjS5/0j7ay+I8s1waqiEIu
 RlLwzJzSvUpU5oIiC4vpTLSVgz8PFkDzbnWTzPk10AOaOGGDFQA3e7cXCmRLDTe74qeLsvz+u05
 CMefODioly73uVSZRUhQJ49Dzw1jqme+3NB5DWt7cCb/wiGpuSNGlqavkbn3xwalkoGCDG7fA34
 /ueV/XkWQL6keQwKY7jHuoutvxk4bhv6T4Ah3lAFoERg==
X-Google-Smtp-Source: AGHT+IGfEjT7IFeN0T/htZRDj41wwjJ0tyWBSy5Y4g2oE//JhGrT+ilvqL+yHUAoavijLCaHEHdF7g==
X-Received: by 2002:a5d:5847:0:b0:401:5ad1:682 with SMTP id
 ffacd0b85a97d-42b2dbefaa6mr7848100f8f.14.1762792513866; 
 Mon, 10 Nov 2025 08:35:13 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac679e06csm22847094f8f.47.2025.11.10.08.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 08:35:13 -0800 (PST)
Date: Mon, 10 Nov 2025 17:35:12 +0100
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ozezqkwm5inhawvjsllnyazxubfbgar2lnysrcxybneia2hf46@ykg77emlmdj4>
References: <20251106-b4-memcg_stress_rewrite-v2-1-a82b0f3f09ac@suse.com>
 <53jc7u4l3tu3jzwa7bg2cyulj5k4sgnwybf4jjxgsf3s57jnis@zwdhay22gefm>
 <DE2G3PP72PJX.2MJ6J2Y375ATP@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DE2G3PP72PJX.2MJ6J2Y375ATP@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] memory: rewrite memcg_stress_test into C API
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
From: =?utf-8?q?Michal_Koutn=C3=BD_via_ltp?= <ltp@lists.linux.it>
Reply-To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

(Adding LTP ML back to Cc:)

(We're now in the realm of further possible patches on top of the
rewrite.)

On Fri, Nov 07, 2025 at 01:01:56PM +0100, Andrea Cervesato <andrea.cervesato@suse.com> wrote:
> > a) starting lots of containers in parallel (and observing latencies)
> 
> How do you observe latencies in this case?

Starting point would be before mkdir and process migration,
end point after the finished migration (or after the forked child
signals readiness back to parent).

> 
> > b) running short-lived jobs repeatedly (and checking that it can run
> >    indefinitely/sufficiently long w/out accumulation of any residuals)
> 
> I guess you mean to repeat the parallel allocation multiple times for a
> certain amount of seconds/minutes, right?

I meant something like:

	job-A-1,job-A-2,...,job-A-n
	job-B-1,job-B-2,...,job-B-n
	...
	job-M-1,job-M-2,...,job-M-n

(one row is sequential, but different rows are parallel, n might be same
for each row)

Thanks,
Michal

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
