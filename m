Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D4C3ABB2
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 08:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726475166; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=UPM5YuxL/hBjrkdeNzkAkwy2U14Gjw0UkzRelFzIlMk=;
 b=MKAmy0VKPDfoWABCzguB5A1B9rT2SE1KH7Mvvb7UN0yENVfiK2PCsQlForlDdItqM2rNe
 PVVrxwShvqOixAXk6bXJbg9XyMbk0da2WwoBw/WBL+VPGZC0ggDgHn2Yz6U4jroOLMytak8
 QKPiuJDcDsVOncn+EuKn/HH+QyT/kp0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F77C3C2BA2
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 10:26:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E08A3C05FC
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 10:25:44 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9ACD614000E8
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 10:25:43 +0200 (CEST)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f75c0b78fbso43076361fa.1
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 01:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726475142; x=1727079942; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YbKe6DE5ABT+qS9A/vjpWnZ0f82pxKOkTi18+xyvPiA=;
 b=aTn8UTX0srlqcAx++TNbO4Yk+/3lDwF6lQw8SlWOFh52UTMPm3vprGFMAJSYwj2PGf
 6HHEVy/qpnQo4s57LlPbQCx7z3qDAIl/O0QalHN32KGvL6pNjYs7JgKvtJSA1YtleLJj
 wWMkMyh6lBJpEbNvCIaqlzKwZUUy0sNZ6q81WTu3myp+aCDYXuGOR2joZQH90N9dpH6d
 YAVCIsurw6NAxrxeyg1x5pwIX1wvCNb5A1QOT+hq6HqVN05uT6/uvVKJfNyNvVlisSzx
 vS0ELOe+zr9d7xJ0fg/CzJI3CnEk5EqppSBib/OCcVPZRPGw79maabpJ6R4aWgOutOVY
 +sXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726475142; x=1727079942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YbKe6DE5ABT+qS9A/vjpWnZ0f82pxKOkTi18+xyvPiA=;
 b=sVdWzxE4ySV7pv5vhccb7I+lE87GxZhNpP0Zt7JwiAu5QX5o05nz5V0UKHybqVfETh
 7xoWb8CjKGOsZgy5XCW1meyYarAH/fFHQV6yrdZlM3dVe5f6vHItw3z+4W+heIndI55r
 Pb5sGfNK2pl4uaOpC/g3bA6AKd64HxKb9PWZuq0xoqCdn4+gwKTloVqkxAjvG2MlTsA9
 958+U6Ww+iufcgx2wBmf8C4Aus0iR2Ky8ZUbJ43VKn++qCNkQXy5ccv4suQWaWO2lDY+
 aiWi98EN2DKwfI9dV7bZ8ltjlDBapq9SXBGlglDtMbM9hC8eMYMMOKCZWm8f0OjH96Q3
 1VsA==
X-Gm-Message-State: AOJu0YzyfYsxLG+W0LmCIjlI74UFofSaU1nXCVLiewzaCz6s0pzdZz47
 V8mv/v8S/CKLuKbz0FtIg89TsVhn8oONrBaQ7PuY8HDStHdOZ0H26rlPGm+oKc+kyKUNxhV6L4+
 +l8s=
X-Google-Smtp-Source: AGHT+IEBGBIFcCBrUbFF1ukPsqRnNgqBrUbVh5UTcWG0ZhECDr0Ll76tA6qa6qoZtiwEOxC5Ra2Y8A==
X-Received: by 2002:a2e:4a0a:0:b0:2f6:649e:bf5c with SMTP id
 38308e7fff4ca-2f787dc9dbdmr58852321fa.17.1726475142363; 
 Mon, 16 Sep 2024 01:25:42 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944b7e369sm3276017b3a.131.2024.09.16.01.25.40
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2024 01:25:41 -0700 (PDT)
Message-ID: <589a4157-1799-4dc2-8686-e123296712c9@suse.com>
Date: Mon, 16 Sep 2024 10:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <ZtWLSQSSqmh0tn13@yuki.lan> <ZufqsLiVuMG_TqQN@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZufqsLiVuMG_TqQN@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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

Hi Cyril,

feel free to ignore process_mrelease patch, which now requires a couple 
of feedbacks. All the patches which were required from my side have been 
merged.

Andrea

On 9/16/24 10:22, Cyril Hrubis wrote:
> Hi!
> This is a last call, if you have a patch that should be reviewed before
> the release, bring it up now. I will continue with patch review for a
> day or two and then freeze the git for the pre-release testing.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
