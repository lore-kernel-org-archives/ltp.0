Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8559C7115C
	for <ltp@archiver.kernel.org>; Wed, 25 Jun 2025 08:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750841173; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=euOJxLPca0OyR/tGC/WJ5h0jrhS/gO/xFgMeGmC7vAg=;
 b=SIWBBFd6/J2McNn9r3XLerdUEFX/asV1JW3ozXKXdDpxzQIVjXXEpK5rxwYMBehHp1YIC
 mQzVi3lIHoxFcwqAidtcO2rFVksXtBk0cJi0LDAGjNMYQJeZELFuq3bYdd+hVlpPXmc/da2
 1ED04yz84VG5zuJfN82voIvJwy0+zFg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2725E3CCAC0
	for <ltp@archiver.kernel.org>; Wed, 25 Jun 2025 10:46:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 472A03CCAC0
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 10:45:52 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5473A600B9C
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 10:45:51 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453608ed113so55280795e9.0
 for <ltp@lists.linux.it>; Wed, 25 Jun 2025 01:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750841151; x=1751445951; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qQhKqsigHBrH6hD1XTBDo5NmDt/JHXdTOE6pZESIJEA=;
 b=Nj2HtB559e9RvYGCgkUCV9Aq4iiGMueu9MLMiZ24+GXbSD4Fgbc/wrSUDNleGXU689
 8HZOKrI7T0ne02vQfke0vNfLdKaBADsJygcjrqSow6uMPNUXnIh/d0avuhgEfwhSCTl/
 NtzKcquZ6nFKwH3Mktcg9PozbLuKNFqIj3LzFZ5YGKcG2/tFCV0wpdNOxXADk34N1IOq
 +m5L5iU4jtDXKf7ogfwxkmVG6Q291kQWMh2JjZ7IscrvKaqjwrpCCWmzWzsdcr0KAilk
 3yoHbFEtv0B7c1GkqomSZK44VcWjR0S/Vbik4tL+n6rt548CheAjrJAc4yCuuZd7uv5T
 sUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750841151; x=1751445951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qQhKqsigHBrH6hD1XTBDo5NmDt/JHXdTOE6pZESIJEA=;
 b=qrKTdUOmNgH1Eejw0otvatkZ4HyGB2vGP2jE2VafMiouv0yK9cnoH90FsiprCNL8tq
 g3+54MDgxPt0Indp1F6LNtLs3Jf0RJFxfmFDkdVlXwQTtWjVOgL7LkkW9FHD7X4SiDUX
 Eo8UamAr3PwhcQnEkMge2Jj4LvPgnaR3sIs84mT0PRcDwaBeZKFn+bXHWbqBUwrmWqR1
 QgeL2hvDY8sFbnjHDlXMNmQYzTQIgGtYIgoYv3RYQ7w6krvJeaHJwbK2gQvrpV4ve/e8
 SDQHdSRTSyFg5gubDOXmC13XteODfVJ+r3Kw8DAYNY9J4xo8tV7RT6+AIvroqb/RrVjj
 Dkkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8lSA4I52J4enkx/BxKvHuLeOT+5A3TMmdglftzdJ3qe6keYlZJ5pTMRXKLZT2/Kzl4tQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yzh9Cv7wA0HqZmpWWranguduDdrmO7W06f3Sa5XNDm1y5y/Puyz
 lVJwqxikBWBGR/owu/BQLgb+h0m47Fp1rGKoWIW2OFSxIl430zfKMYDZ4ZwpuFJoQnKB7SIweba
 piNn/ltg=
X-Gm-Gg: ASbGncuaV3sUsHJwK9CVy0zJwOURiro+wanM6Y5B5TUwuRyTmKqZn9LNhsn51I61CRz
 gGWUWuW+hk16wvEkR6V3k5C5WpRkZBip9L0kTXq8HBbIXaZndEpHuor4xYSaCP9F/nlx659JViy
 ki8pZgRKrxsfHtW2Xen5HA0RSMZm66EgXrODMflpmEe5nFhT4TzeDxUbVaj6KlW+nRafyp5Tzq0
 kK+dQnTcNJTsZUnw3/+wUD+quofkYoFCNBqVbyuhKGJSEzT/GX0pDBBs8BuIW2HmS9zOx3e60bS
 EkafkZy63vpb/aePsi6pvQkA+dAypafLezr5FQpqaR0yTKt2rL+PXnIAZWst9qVNUU1QCiEqtqX
 oxAvOP4z+SN6uNXNr/ubuBU5YVCCRCWodFIJbZXa+J+sANVnzwqG9CkQydGwusblw0CPKESAy6L
 Lo7Sf9gIi28gnfF5YUCUSpbjEzpRDGPV2BhXfS
X-Google-Smtp-Source: AGHT+IF7Ns9JXx5d8X+RqM0kAXjudlsZyLOYxkixZlB5D/e13lEmbdU9Wb89Z4WpHtUHTTBgsa6u+w==
X-Received: by 2002:a05:6000:400b:b0:3a5:2ec5:35a3 with SMTP id
 ffacd0b85a97d-3a6ed64b5bbmr1635051f8f.45.1750841150734; 
 Wed, 25 Jun 2025 01:45:50 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8114697sm4046764f8f.98.2025.06.25.01.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 01:45:50 -0700 (PDT)
Message-ID: <0ac5230a-6030-4abf-b2ed-5fcbea4e72d7@suse.com>
Date: Wed, 25 Jun 2025 10:45:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20250624151918.32145-1-mdoucha@suse.cz>
Content-Language: en-US
In-Reply-To: <20250624151918.32145-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] open13: Convert to new API
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

Merged thanks!

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
