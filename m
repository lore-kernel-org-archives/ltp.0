Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187CEEB7EB2
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772617811; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Fm8hznIo2bkf6dvVFX+s5c6g0zQ5M5KmQFLkpJI3gbQ=;
 b=qGMP4QMQ70g6t0q7cS3qBM1ktP53VUAkfSjocGOZ8yuX81AgkfaDVgBGrSCncj+kxk34H
 4I7CJQgnB0OZhOa2qRpTdMWx/mTy2tLd936MhLiUPzBOk17wTRclOBihp4paVAiM1f5bfhQ
 lAU/45TC68rdi422551gfQG5GDoQ8Xk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BF833DAC03
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 10:50:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DDEC3C5398
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 10:49:46 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 026B21000150
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 10:49:45 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso49773175e9.0
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 01:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772617785; x=1773222585; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=aVGZHEP86WE2gKvm2ngRLqeHDph87+Ru/NK4hIsbWNM=;
 b=NYY0vl1aJnTg5noZY3i0tMFc+g4F6HOmOr4EonuufhDvJv0rJ4//7V1hIsK4notF6A
 0Zob2VrzW4pA7gVNDNAYWE+UR0IYd+54Azd3Jd7eRzTthPAVApOEdzdRURAWNR/NO0wL
 8AkmGARrI5hAbloFoZEdZzCIfb5wJuu+QYmsIWQ7ytCt/n25P9e/0IQioc44eKLQD5q/
 mfuyjWWWGCxRLlbnnoPJx7BeUbj67XIOsS8wxa2pjGCmuyspOBtLHJOU4SCQyIHouQKb
 2ltJXba7CYjbFy9Kbq3MAdb3EbbwGuy9yQHn9DfEA9axdoskgHUeE6CUKwJozrw3BY/I
 vBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772617785; x=1773222585;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVGZHEP86WE2gKvm2ngRLqeHDph87+Ru/NK4hIsbWNM=;
 b=eegoBl8GtSJr2Ixbyalc7TqYmBc+WjiFiD8enl0Zk53rljdqaiiPjNpPU8l11TTuj1
 MjrUjsHvYM2d1mvQoty07GavzRui59A0rbUMLnPCEPLmk/dFqd0u2t0mohsNH4TaWdkH
 EAQIFirsCQxOwbHrpik40Y68U9R19sxOqsQFBZq8Gw8NVGUthbbJV3ImI4s/3+fL2CMZ
 IM/TzDwdFD8rCqhqvdzvFrod+BiAVnUvfROMq3CMB8zN+72sIXAv1m1pRC2uqZqvGxgi
 KWZmxOOOM4GL0AVi/VTDXGcXA+eoTVhCsRqGKB8RUNa+lq5P57Rffvevtte8/IE3JrlW
 ZwIw==
X-Gm-Message-State: AOJu0Yx6VZBQ4mDfmF+NVjlo5PX7FEppOktT+Zkgj81KedHfAHZHS+2S
 UJVjm7CrweEnYkP89vD8u3u9SqOMI8NR46DBppRhAveVOFWx8hSVzoaijQVUjqc/wyA=
X-Gm-Gg: ATEYQzylrCGBk4sRpn2/CNyX0SowFwAOLD08tf1u6NYjmHL0eYfJ7XVQlbd38FQbGDn
 9DQRqnohkifrsN8Ys059SzCdiKBkLxxegaob9ClyvkGiTeHEwm2L6bNILazh1EScdyAWtzcpz1g
 HJoo/wnWUmU7hpRwRGbPhJxiZgbk9SpytsRenW3GDfMiGSJ9AgHdZihPThqeaPvh9inrI/M3roI
 UlAUHbAvDuzfOORKrKxd+1yOoCdfgaJ5h8auagiC1FmEB1gt6Ir9w0OwJrXMjD6WTYuC6tK9EgF
 vAggl2VwGSoEzdiGaxjj4dd9/yMj3mviCFHz5I3eeC3sPiBxgM49YPzAUcNMCAlriJvK7e63Uzb
 /ixqb/jsaEXroiGwf8QWdkXaXYlPDX/h1HysnBBruvzlygKB1QIQx0aR7motyct3EDKqdeexDpB
 TRl9ILvMKK7JBjOX3Adyp9sIPqWyim3RReTNqtbc4Wwz9+krC43sjLOLveeno5bQ6OmSAmh/pWe
 5KqPsreIdCUsJ6QFgzYFjCnzMbCVnLwrkA=
X-Received: by 2002:a05:600c:8105:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-4851983bf08mr20111605e9.6.1772617785336; 
 Wed, 04 Mar 2026 01:49:45 -0800 (PST)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851884224fsm38677685e9.4.2026.03.04.01.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 01:49:44 -0800 (PST)
Message-ID: <69a80038.050a0220.3816e.9f0f@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>,
 "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <aZcCrH2i_KFhonAG@yuki.lan>
Date: Wed, 04 Mar 2026 09:49:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] Add safe macros for stream testing suite
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> 
> Newly added safe macros shouldn't add the cleanup_fn parameter, that is
> kept only in the legacy macros that are stil used in the old library
> tests.

The problem is that I don't know how to approach it, since the header is
correct, but we also have tso_safe_stdio.h and there's a mix of old
implementations/new implementations mixing together into tst_kernel.c.

I'm a bit puzzled. The point would be to move evrything in the new API,
including the core library.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
