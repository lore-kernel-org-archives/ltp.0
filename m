Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1E0C5AD7B
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786365099; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=cVKnOCOqrlRMh1m+s2nhV83kz012G/1xm+4ro+5gPdQ=;
 b=mcVFBk/njic9ihxyARP0E/LBeV0m39w3PxuPNge2c1SdmkG6YCW192+JvDkqUjMESsx2l
 dcBqlhcpP8HQfF3kN9n7ZCtLuA1PqlvD+0z1pyxkfRCDZ/AkFqTiEiRrXmQGvRty/SC6Xf/
 2olu6F3MXmTGPG7l3tiIDBJCVH7TQ7c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B6133CEE34
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 14:31:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F02233CE356
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 14:31:18 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A1B3C600681
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 14:31:17 +0200 (CEST)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66899fe9077so2755202d50.1
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 05:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786365076; cv=none;
 d=google.com; s=arc-20260327;
 b=FByLLd7JS9yLsPoZ498LnsLU9Ful/l17gVFt6MwkI755LyrEe6ULB12LMIqvxswklC
 n7zvH5t9JFlugJPTyFgyGfbf3kZ8KUX7371twmuPQswBZEaxB970tzntnXZIpQibK+pr
 6b2LjYrYtYi7nhwrbJmKHpSfacPmQmkU2wczS/aHf7LkKYyuOahMaEw16otsWjwEfHVW
 1pCjtGgY5266UgrvXx7mi461b9Yuq46Dy8ZnPcSwt2Kr7TcJmUEzKhutj01AZkvP3qhL
 z1icFnUOzt9D4sd3zzWYAuIjxe5cjT3niri8JVw61W/HvBydE+iUuNcDKR76jReSdUye
 3Blg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+PELgB/0+F8+3zyjKybn3FHRyqyVXm4AQSOyWPeYm7M=;
 fh=eKpxfEIyDGws53ds/LPOPT8uxSw14gAoFytuBFWJG2s=;
 b=pDBrPLRS75ZB0bHuFuTgHO4nmjgeczeu0hiO7Vd3yKGhnZVDeZlh3n7I88Mx7edNyU
 cHuGCQGgHou6/ALJzxEXTfWMovqQi4JoT8DLy8N5wbh5Ehh8WcqI9c/+IjP2i+4Tn5wp
 dXmPp4TV7qCNyk5+m6N7HSYWootmhfYBl6OcyrgTlts3RDC0L3zC/q8RT3qBTzcL8qF0
 hBKsr/cpffsoxuY9NhQPzIa+b4+De5V+62lijENb34R77m2Cj8AcVUHeSbQ4ka17FQeG
 r0X9nzxgFW5iJ9HUkEHqHzbE1HVsv3Qp2fvNZTA+YC12mgKgerm1cIENsbX6aGnY//Zf
 vWeg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786365076; x=1786969876; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+PELgB/0+F8+3zyjKybn3FHRyqyVXm4AQSOyWPeYm7M=;
 b=rqDS/t8/wKbEeRzE4UufDs/INT9KCwMPEn14L675tdgbJtGG4ucLsfSluQiqVr8+2d
 sPePHDtrBPDmZXxiw18Rt4JrjWbtFPncWNqXymf7IAHNpf9W+ARRQp5y3F0pnREZVkTK
 XgCyjP2XA/6RSlKPudLMT8RMsjogw6AvuEwxqLRggUUYFpAmo2hKn/FHNa5uXEs7Yg+n
 Z0hHOfuTh+kAiM9ylX8CvZ9QdORJ76hWULPBxFfE5xrZDxYruGpVQcDMk5/Il6XGakbw
 y77js6gcP6AuAxZKRf2y2Z5wXJKLHk+0As8OI73YKglwkc77DES8wgdGi7rrPiXVv29Q
 jPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786365076; x=1786969876;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+PELgB/0+F8+3zyjKybn3FHRyqyVXm4AQSOyWPeYm7M=;
 b=P9l2PLrdXNuDG6aYWpzY7JMDLHsHoyifsy5hhe6qQ/rXY8in9HY/gaMJtnBCFTmi68
 XNujnFcHbFdD3th/Bhpm8XfLqXYIcA+1Xpz6hIoEyKqtkX2y2s6qOHrIf74lv0h1FRFY
 YISL2W1QiKr4oqBBjxbUalNJgEUxkhuLIWOS8HxBvjqM8YUc++bDf9EMdbXE/qx4U3CF
 bA/jzTuRugKNtIkNyQLJRlpxETtcgN/YN+hK1oC2oVHdkE9iHk7hGQRGPMlqYOHG9io/
 gRXgq03ccely+rSEiLTuEj3HXKZwNJ750J3QryIGW5hxWcanCk1eaXRCT4uRqLAv25gB
 9A/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RonG8iWa9iqpGAwSF1mluVJq8ntD282APGF+bs4/7BPPbBzA6muBfOrOmbByZC2FxV9zAU=@lists.linux.it
X-Gm-Message-State: AOJu0YyHZiW00zKCbNRgjYwDsgp3svKxYnSJEA44fB2i/FR0H48AoRU6
 zuQcf/zuJAmX36rT1VR9XEx4S+pYtynbFPE2t/1jXgBcsMbV8CDuoYjnmLDiL7/i8HeEq8X2ivo
 w7bAo8+E/LzHOcvajnTpgcjKq9lA41ufNeI+STlnR
X-Gm-Gg: AR+sD105IRaKk9l/S1tiJVAGrFvC6YFOdUqNlk8bQT0vY7l5/XP+G5+oOc6+KXLJ5/u
 J0Oj+FdkAfd1hX742sPmldSbr/f3qpAYLxL6H0wD4ggBGs+aXyErIwKzhvd6HwdEzejqzF+96hL
 wKi2cCRebh1kerr3Hn0qvPjU0FgheweyRDzNwxIxqmwEJzeVemUCVYfxlnSJ3jR6assSXQYYmti
 YW3wP+SQi8/ybbqZfMc1N+Gf5LPMmvO/t/kdDfO1GVIZ0IcTbsDH78WQn7ZQqvyBhWOgxfy/Qc6
 nYwBD4XJV/h7pL35A0ajtjIdlN3wiSng/YMIC3KWyuj3+VgTSvUyaWGS3myI9YFHC9OyIGxX2zR
 ASvwQOzU=
X-Received: by 2002:a05:690e:350:b0:664:c81c:d1 with SMTP id
 956f58d0204a3-66ad7260ab5mr8963987d50.45.1786365075525; Mon, 10 Aug 2026
 05:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260807110541.8702-1-linuxtestproject.agent@gmail.com>
 <20260807234935.3248935-1-wakel@google.com> <anmjiYgCDToNhlxI@linux.dev>
In-Reply-To: <anmjiYgCDToNhlxI@linux.dev>
Date: Mon, 10 Aug 2026 20:30:37 +0800
X-Gm-Features: AUfX_mwe_lBKRux_hZ2nKDvg5jfUWUn3MbgFu73mn_Gxo-PXrPE29HX5GyGkV3U
Message-ID: <CAOcRiAEB_j15kaZFoSPqCM_Ht1p6u-NiQR7dBbA_ePGQmXxUEQ@mail.gmail.com>
To: Wake Liu <wakel@google.com>, Andrea Cervesato <andrea.cervesato@suse.com>,
 ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] lib: Use backoff polling to wait for loop
 device nodes
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

R290IGl0LCB0aGFua3MhISEKCgpPbiBNb24sIEF1ZyAxMCwgMjAyNiBhdCA2OjEw4oCvUE0gTGkg
V2FuZyA8bGkud2FuZ0BsaW51eC5kZXY+IHdyb3RlOgo+Cj4gSGkgV2FrZSwgQWxsLAo+Cj4gSSBo
YXZlIG1lcmdlZCB2NiB0byBrZWVwIHRoaW5ncyB0aWR5LiBUaGFua3MhCj4KPiAtLQo+IFJlZ2Fy
ZHMsCj4gTGkgV2FuZwoKCgotLSAKQmVzdCBSZWdhcmRzLApXYWtlIExpdQoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
