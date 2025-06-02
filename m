Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0466BC54FB3
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 16:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748883073; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=1PiZZn9nJWJRZGt8ZEhPYxUJzEhmlfKEibUxKJlK6IQ=;
 b=SldB6/F3H/ZYNM8/g1M7o7m2RC9+eeWllYY+BdlTqzEQHFBdcp/GmoXf02+vPZII8BzM3
 E5P5oTuAx4r3j12u0OQdQEznelTuXuHDTEFG3CzplQ9x/x1LqH3QEWXwjsYQJfeHmicZjuU
 kkFefkkVi9uW2T/J++EJLBE/o1QH5fc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69EDC3C9D93
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 18:51:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CF503C9879
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:50:52 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1A7811A00990
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:50:52 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-442ea341570so32342155e9.1
 for <ltp@lists.linux.it>; Mon, 02 Jun 2025 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748883051; x=1749487851; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mTeOzRgIc1ZiwFqLdF+zIQKMX6s5kwJz5Ioe/mhmDG8=;
 b=IRtB/lbxqjtR9++lZjQQdsExRdPqpaq3lhT+/ukdeZI8MpjH/w8d5g6mUdCgmAhGUL
 LirsOFADFiMs4cLWLSTi+7477/8rzua4oqH9aw2RzeVrdeQuNnV0rnJPaKsgtGaSBek2
 RoHM+K4NAfUoY/19OgMXJr2f+zXL0yiHGrJLE/G0aetMWrO+WoWUr96mNu5ntm5RsYM/
 DmSM41qTb1wJFBs0z0aSgYDpp/TpMoEd0rOjxF40fLfw2IdNLk8nH2DjVlhmXpVm0qps
 N6t75GhaJAxvSoJF9qLY+uqju4GfOAYeS2fcAQGKDUVUMCK4ovjwig+SNwmZLb5CFdz8
 vxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748883051; x=1749487851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mTeOzRgIc1ZiwFqLdF+zIQKMX6s5kwJz5Ioe/mhmDG8=;
 b=Pa8falsoOMSoyGMVrEx2TXijyqiaDa9ismHDOyJBE6s4HdMaObbZ5H3eXS/WCcweVx
 7jM1Qi+K2hcYXLaOMzvNy35iU4+aG5sOMomYy7GJYbI6md07J3uk6MQRFwtGyDCVkax+
 ZulsRPVYIyR6B6Q3+70ymY6JY6cOWvWAx0s1xc/LBIU9V0VYqLqnFxQT2ge1UZ26UDCS
 3pePUlTCTooLoMU08wyY1/+Qlfbi5q/suarSLxHrcPSflEeI2gaDHI9AnGAuwmWlJNsO
 hh0OsE0NvE0BLOe2PIEtbtdPxPSCySxXAVhhjrIzG2fBYjK+0JgjOWmTeA+JLOj5SF23
 KOBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0GH+9GTBXi3vwN6tQsTK1OGOCMjSIWWgXDB7fX7OaJsv0dTZqeoLZJjQArInHk6pbvLg=@lists.linux.it
X-Gm-Message-State: AOJu0YweHtQlKPWu/qmG4hfUpItcCA4fFOvQzC/QMzZ6ZdveAcCAHuOf
 ntNToy14Vx8PzD1NIBmbUff5wmggpJmg4DHvA+GU9F5GKAqkUfCQsDM8/VgQUXhBgHi7a55Z1Hm
 49D0Y
X-Gm-Gg: ASbGncsd9MayiyVsN7zdLmqRO631yvmAbD5VeJEEQKGEdNJDSKsqRoSFbWle6/wgliZ
 V5eUS9LF7eHfHomDFrrdEOIz7ZfZBTf7O69H0Vm7VrXDKZ5vXQf7i+6dwwiYtoCleGhGlXzH7pq
 TYWF9JvYOdv6JutoKMe0Jib+yKlIcdmOnPn/sSle9lPYujHlHHAkFLZLZho7T6fewMA9CnVZ9dV
 HPrXA6LAqd49BHZV1B5lfeA0kih0S3uKte9c+XJGRri0ZPCclteKCr1J8xydl7rIsmrWzF5+WlO
 gmPoMpPvribZKHNU1jkMIz6vRrzxQCF7o61jRIHTKx4GRL6ar57711c33SqbkfyclqX1iVZ086c
 tTYrf9g96KMk1QR8iD+OEM/58yK9EvmmhwCS4m4QKSJb5vDcelb3TGTeKq0wMK762McK8/pJFWY
 2gYljT19cdkvkJeExI7qc0wH0V
X-Google-Smtp-Source: AGHT+IHT6KccB5/l5uHuh59fYkN7xFQPbEqaLgLaRca7LT7MiCIjs6FzwGEtoVAg+2+OHnPaKPpBpA==
X-Received: by 2002:a05:600c:4e44:b0:441:b3eb:570a with SMTP id
 5b1f17b1804b1-450d882b3c3mr123490215e9.2.1748883051529; 
 Mon, 02 Jun 2025 09:50:51 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa249esm133750995e9.13.2025.06.02.09.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 09:50:51 -0700 (PDT)
Message-ID: <1273a893-2266-415d-a557-01b274374b3d@suse.com>
Date: Mon, 2 Jun 2025 18:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250602141919.329370-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250602141919.329370-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] Remove kdump testsuite
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
Cc: automated-testing@lists.yoctoproject.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Yes please :-) Always up to remove legacy stuff. Thanks!

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
