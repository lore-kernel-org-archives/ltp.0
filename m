Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69182C021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 10:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740045835; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=buoJbV/bibbNSxBRrnFic73ygQSFz3GNbkiEwfhCVAY=;
 b=VqSWFNM6vjPGuvC3ekblfdm3uKy3zSpwxe3e75ZTklAtgaKPoqOE/1Sz8aI4+e0XPPtLl
 5ZQidKG8tmx+6j3ZbMZLOgPKQJFfG9hWhv5a0VAI3kbammLGmdNNgF0Pi6NYD+bk0UwBcGw
 xTUfUy6EMY4emsvIzRDmEvXIa34Btfw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B96953C6643
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 11:03:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C8153C0FCF
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 11:03:34 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6F3BB6067C6
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 11:03:33 +0100 (CET)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5dec996069aso1152544a12.2
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 02:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740045813; x=1740650613; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ffIa7OEVg/Mbh2XWir7MyXS1DYCf4EeGdsHBIMb8ehA=;
 b=OoZVgotKE0ChSNj5WG+cAF1crrWaVvFMhtjmaU0ZfFtiTbxn4a4fk5VdR/t8tHsRns
 upaL4/y0xBXC4WQhmd+ZQjw5pzozW++NE+c4Z+hpZdJbAEcO9Rnxbjpp9AaAwViQJ0f3
 PcfALcmn7aR9YC8UZgS9I4Q9AJX3YI6aKUhoRxhgEbrnTxoJRaGIgPzznntHcySz7rLI
 wZ84fr9W3lYCYy2fsX/8j6p+8QE5iEoMnyQv+1aWIX/IaKVZ2Xjd6lF0/mAKRdHTfI0J
 9pQlD+muSGOTGdC5dCf0+N61nviJTvnaTrajh7rJq5uW1eFOWZvne21EugLDo2Ka4O4e
 uo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740045813; x=1740650613;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ffIa7OEVg/Mbh2XWir7MyXS1DYCf4EeGdsHBIMb8ehA=;
 b=BsNtU7Ty+u0DRPuwIj33RnujX6kheyGV1UmsP4uvzVDPRK0IZSUV8sfnzVX3QScWRU
 8/WOUP/1puw95vl+rX7qPP/vNyPEnCvKjqc+BgiGWZBofnsPOBOk/LLWEfhD+1uN+9ko
 FtMzRNSRnH1i5kYtMy0L2xPvRtPmR91YA80ZkHKeHIIDZEMQiRJUzN3boHJ/So26RNY/
 GujACTbP4EJkh/qO3A/SzIJ3XdG5KDwT08n9Iy/elgIwdV+6Lc2gb4lqYthpR8LJYQFd
 rtddUZIsVbVpMrPSjVNixixduxlWnREOeOU3rNhELfmu+aw8k1jPr+9beR8i7IfqDtjd
 lZfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTu9HQs4XICD9+iWYUJJN2yYtyz2vK1CyV4yxRNtMSPxnDBGq/tRpYPJNHOg5ZSTa104I=@lists.linux.it
X-Gm-Message-State: AOJu0Yy+LtaKhPx67JOb6EyefIxcBBTADMboL+uZ61AEaKbVKBiVxSFI
 OfHd2kGGWZrJRHVr08XrKl6OuKUXjRBM4YdWgY6bhNgYx4dBQAhCyurozrcS0U8l4lwimgl6SeO
 W
X-Gm-Gg: ASbGncufunFdKqAG8NLzFBTFuoQCSqRtoRxDv5GYBQHaXC4elGAd3ksTwXDWo2SU/2s
 zF1MPGZxIwcEMMEpi8pOTiuQwJbAeT8RqvMe8vM2Dr4ZANk8GcrThmxg66QcxXxXUKo8tgo8rOT
 17TWbLRAFqh9b5bP6bXtmSTWl/gpaPkRih2IljvCUzJumEOd7gOL8S40D9WCukZ0k7GmXt7sttE
 XZottCoqdlrutolqXst4LmPRB7OZQk5S666H3clspmK2YjvwaJzX/PH329Bfcw+Ij6tYsrmzrpz
 yNti5WkOFoOCV+dyUAQMhlxMmXvdezPot0tMyRdA+w2k+JE0JZn2Du5YyQBvSOiKNRAJD5NLKZM
 zS2F2YypVdz41sx97VL1YfsxXOtmeqBz6SySPh+zDp0xfz8MdjR0=
X-Google-Smtp-Source: AGHT+IFht/+CUCtycsuuzz1P9fzDLFO/LcLHjIMB1M2N96LpNp/R9hUfY//v0s200yDvxJYQNrcqOQ==
X-Received: by 2002:a17:907:72ce:b0:a9e:b2da:b4a3 with SMTP id
 a640c23a62f3a-abbcd0658dcmr821659166b.42.1740045812673; 
 Thu, 20 Feb 2025 02:03:32 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb945da4a1sm818959766b.132.2025.02.20.02.03.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 02:03:32 -0800 (PST)
Message-ID: <94414a1e-2c20-4f5b-9c63-9e7939bd9852@suse.com>
Date: Thu, 20 Feb 2025 11:03:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
References: <20250219100027.1049238-1-maxj.fnst@fujitsu.com>
 <1d1bed1c-0537-47a8-ac68-1b108453e8c2@suse.com>
 <TY3PR01MB120711C04E10541E612CFFA55E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
 <2827355b-0e34-4db2-968e-cae1aa54ae0f@suse.com>
 <TY3PR01MB12071554D05FFE6ADC60A5C75E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <TY3PR01MB12071554D05FFE6ADC60A5C75E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] ioctl08: Fix comment indentation to fit RST format
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

Thanks,

I pushed all patches about RST updates.

Best regards,
Andrea Cervesato

On 2/20/25 10:39, Xinjian Ma (Fujitsu) wrote:
>
> Hi Andrea
>
>   * Bullet points are enough, since ordered ones are a sequence of
>     steps, typical of algorithms.
>
> I have re-sent related patches and used bullet point lists for them. PTAL.
>
> Best regards
>
> Ma
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
