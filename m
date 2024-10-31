Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AD0D6B6A7
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 12:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730377581; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=6aQp22s4dthFSyB5vK4gXHSo0GQjpKqA6Rq36iwJriU=;
 b=KD1VaONUQKQcvYPFGR7Hq77rnRxIIn9jsN3xXNud9zJjSX3vEBmXc4WEgo4b0+EhdzDvy
 VnKuaozK5+nBl6M39ON+DJCLC4N8oQSEVGXtagbYL6/vu5x0rLslloeaf+MuNUVGkZDLs4w
 1mZURKwRQP48ba933D7qZ0CUCDqkGL0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96B443CBFBD
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 13:26:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 968E73CBF9B
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 13:26:00 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D42CE1400B73
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 13:25:59 +0100 (CET)
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so7614125e9.0
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 05:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730377559; x=1730982359; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZAJJTUIBqVvTmkYVKHexGGswliEU30X3ebVTLo6lzkk=;
 b=LRn7pgFnyErKYs2X4nmCHGd4unvfgsJ54+oOK2Fo8ebyVEkwc8gKKLs/XYWAMpPOyR
 WPlVE01ejqf2Q0usYq4QJQTmVRy0/dGBZc4CB431rgekm1OjV+7zZaEtIbUuzRjHiBTm
 65VQRaqdH1RgLt50rqS9XO+3YLKR82npD0PKLsgnDn0t/hAyCCPc2hO10cV69ofnzqhn
 pjFam+Pm0lJu7oDZoSL1N17J1RuiAzKZ9xNuNYeG23g2DA4T8i5y7DvjmPgXUmy5flPG
 94O8FZS8RYpVaPWtLfwpFkGe7BwMa6NRD8WdNheR+oL0MkbS+aTgT119ISP8013idsll
 JYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730377559; x=1730982359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZAJJTUIBqVvTmkYVKHexGGswliEU30X3ebVTLo6lzkk=;
 b=bVcdkdZUEfd6UuTJpJYCwI+mBsvP6HUoJlVsm/N8Bn5KdEiwLytxr+aWPMzo2IuCM8
 pXqaVt7sLr+MN3PjRhI24jIQxGLCzgCacO6HP/DfdkFD+bVBpgJXq+zK/kx+U3/CiVC2
 KdB26bA/uxw8nWxEDwON2uQjt66auC9qADQhnH5VO+BmHDGgDlidz5nSHqchNRkxWtkQ
 Im2+Vr3eTnMY8ZtjANR8okD84w/GOw59fVlX9SGnYURXOflOZ6foEnnK+afLh8R5ilKI
 YJbbZ05JSXqz5U7ae1/A8Na5G3dh+9ge8H27kchBnna6GI+ywfJPFbeFJ6PC75yA2kNZ
 tvkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw9ym+6wRkM6v1KsibA0PnPJmXuDIX/YLwB9VHRH2uuZP5uvwibPDrdtiIew8ErTXpZ+E=@lists.linux.it
X-Gm-Message-State: AOJu0Yw/cXaJ9FGFP1COUzUYfIO0ijlf8HMQ22hwZSQpP84bTfjBEnnD
 bebPJReS105368Hu+hNq1iDwGGmC4SDTRJLtj4Fr1KA/8bHB9s0VFGCNq6dEpTo=
X-Google-Smtp-Source: AGHT+IEozjVNpQLCeUVrH9+U374GcTtKMwL92CuB+gok2DePkv2aajVSIWFM2d/0k1hBXwY+VvGDMg==
X-Received: by 2002:a05:600c:5115:b0:431:58b3:affa with SMTP id
 5b1f17b1804b1-4327b6f94bcmr29462335e9.9.1730377559217; 
 Thu, 31 Oct 2024 05:25:59 -0700 (PDT)
Received: from ?IPV6:2a00:20:6047:3333:1b05:5290:eb22:1d88?
 ([2a00:20:6047:3333:1b05:5290:eb22:1d88])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e94cdsm24312465e9.28.2024.10.31.05.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 05:25:58 -0700 (PDT)
Message-ID: <c5891339-a6b2-41a7-bafe-cff5453336d5@suse.com>
Date: Thu, 31 Oct 2024 13:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com>
 <20241031-generate_syscalls-v6-1-1ad86a33ce2d@suse.com>
 <20241031094927.GB995052@pevik> <ZyNbzFs39LOOLgV7@yuki.lan>
 <20241031111715.GA1002312@pevik> <ZyN17nqduNGtCtMZ@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZyN17nqduNGtCtMZ@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] Refactor regen.sh script to generate
 syscalls
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

On 10/31/24 13:19, Cyril Hrubis wrote:
> Hi!
>> Looking it's broken on Debian any version I suspect
>> include/lapi/syscalls/generate_syscalls.sh works differently on dash.
>> But it works on ash. Maybe it's not a shell syntax but some dependency.
> That is strange, I checked with dash here as well, no differencies. But
> I did so only for the generate_syscalls.sh script. If you tested the
> whole patchset together it's the code that generates the *.in files that
> differs.
>
Yes it's strange. Check v7 which introduces `/bin/sh -eux`. The CI 
passes without issues: https://github.com/acerv/ltp/actions/runs/11611080151

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
