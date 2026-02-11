Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51153EB597B
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 08:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770799441; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=fkst94MgdzSR2Bm0HVUnH7r35Q/f+o5XeIhLrWGrUs8=;
 b=Qh5DiCq2sc98dWKfnA+iA06tZZDl3k+b+hrifD/fwZShPaJF6LVVhsNRnlcd5kQ8Lkh+j
 RHX4gteM19Mj/iIkZ68vf1xTiJGqkKuujkFd8TNcZqXhTgMNkw2YPmPcyiWhqA4hVtrtmEx
 ncCNJL+LFowGBx+mRDd0wVtwSEFQKGs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E31A93CCBC9
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 09:44:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 494D73CCACE
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 09:43:37 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 52D63600A44
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 09:43:36 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso15140555e9.2
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 00:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770799416; x=1771404216; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hye2QS7BRxGTwC3PBdsR59gdZHLJaXu/fJ73kScVPeI=;
 b=eLj49jqXtOtGIDD8gH77mqKimIMCQiuGxDI1NatY9p8JP/x4Z8CO+N6MOW1ef4yDJR
 a8GIkZIB7MhchVEFJUyYo2NFiRRfF8CQQU9l67uV2EYUEVjNcHtD0e311K8vbFMmoTq3
 vxoUBRIErMaytYzqjR1ZzrELy7bsxuIwVwZ9GvWtbA+jK/UpxqmVkn3tjYvtwULAD3Fc
 dP9f47LWTsC/M6NuSwVLVI1qEFoVq0qhn9fpPrJPhkfgTjo/FIIBAjJM7WLSZGHUsKze
 ROZKXmYnObIJlYYIsZD2fBl/t4IVFUAaS/KtWAyeg9hcWOrAojWZNvPT7nqPy0/LHXX/
 3XMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770799416; x=1771404216;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hye2QS7BRxGTwC3PBdsR59gdZHLJaXu/fJ73kScVPeI=;
 b=dnLV5xjDCwiJcTtMPKcFzSbcKEx9R5dD/tOP11esyZ4ofeFflZO25iQ1Hopa+3ZBIt
 PYHbWIzOuqQHJ/nSZ8jku7PjC3fZxwEDn6v4Zci/ITLQ6QJfDhD1LmKX9Sx6caHA5A9L
 KmMh0w+pL+VPkOEiAyxkfy0bCaw0cT1piaEThK29JTw0KfxHtXhg5nqJyvM/D3a9wtzh
 umGfUhXt2hSSvs7nmCaNM6jwFDFOCXjQ94e0AS9WdV3+FauJgQ3j3uXfvhfKWJC/DDlc
 n1M+lDkHvVGH7zQ3pjOuIijKgapyJpmNOGZfN7Mq1Y1nx14HS+LE+HqIWHWFA+PpCQ2K
 mbdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0M63JtXdvS0CNUKkXqu7H7uKjsc1jiOf7EKnllRnQ78dFH+HovfcYauk0JIogFCHuOCA=@lists.linux.it
X-Gm-Message-State: AOJu0Yx+pC8jANGm0m4iGwyCWAO51UEo8rXa4hfNTDS1T0aLMsyVDnlv
 6OvJAv4b40smcEhf1EbGZZ1ZbjQJrKPhem78cickyGPY13aY3ZPT/mmPh2hEMYh5nOpSv6f3XIU
 bXXpz3KY=
X-Gm-Gg: AZuq6aK8uEDfdcNZvrj2ewnbN2wZZ9lAmojwajqqNmFw52uZ+TpYMgmlXLf/JCBg0MG
 ncbIMS2sD2PqNSBBHWyfS6nSkzr26deOsiTsXJOm96E6f/1ZLCV/e3UZ1/IrSwVYh4RDl9ipViX
 CmOzPl7NyEfPw9nl0vxehekKQGCn585W0sHioyobL/gVlG+wvSVo4cd50AuMU52YHkyQNXBctMa
 qukoN/oRUUTB+mzkoWzZgPDPNT8BXR7saN/Inyfl5QvwuPGFWC8/jTPZKZZmwXAv6hRfncLkaox
 kZrRrCtedIEd4Yc89eyYTxHnYTagcfZB6AYX+tkFLq1RGIAZoKeusfb44fZCxU2cn385XH3VS5h
 N9GlCXzvjD9CyRfRvqjDZhAr15V24XnaGuGS7hWAxyRlClghkuliuNKqXDHjUD1MAj9TPCiVFs8
 cnaMjRYCX9nPIcAGGMgUe7I+xkD7GnPF39/08LynDW5T2W3UO7clnMozrrQ3A6GaXDQAkT6MKGo
 CS3rJjg03mtfy7aEQWA4zOl6sCMww==
X-Received: by 2002:a05:600c:8489:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-48320229cdamr267090395e9.35.1770799415642; 
 Wed, 11 Feb 2026 00:43:35 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835ba65470sm17813715e9.8.2026.02.11.00.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 00:43:35 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 11 Feb 2026 09:43:34 +0100
Message-Id: <DGC004SO49C6.LWOJO8CM24XW@suse.com>
To: "Stephen Bertram" <sbertram@redhat.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260209234418.2810671-1-sbertram@redhat.com>
In-Reply-To: <20260209234418.2810671-1-sbertram@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mq_timedreceive01: fails sometimes with EEXIST.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
