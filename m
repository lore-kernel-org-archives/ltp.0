Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB9CC5AC67
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 10:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786443048; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=1M28pVPYTwJH9GfDG6+YXsRE/dDAuK+chI61fCxYk4Q=;
 b=fPifEhCrlz7fh2jdnUFJzIeTkmg2C4k2yAGmh+jVq4vwo255MMp5iow5r+q3xbBqv8FjP
 h/JFtr+wmR9QrzvPSng2Ru+iWDAzgCTzNAPSXwOBRq+IpWZ/0409quBtRfJ3oswUM/zoa+/
 rHiNX5Z6eGTnaqSdues5rmhmj3/5f6g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 804563CE9EB
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 12:10:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4425B3CB92A
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 12:10:29 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9C247200063
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 12:10:28 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso12259365e9.3
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786443028; x=1787047828; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mGeIULRuNW2OOkfJaOdOYCb4cP0qB5BnAz0Ms2DgbC8=;
 b=b1ZWH/6rJQxdLU623xH4ZvvYMXyyYwB05Q7xf5UjKiS3/5vxOPzGsm/wZE3q5bk8sm
 4YVGukZHBtNmb58oMZSvcKc7p04IDQU63QzNrWIC2AHfl8T9QHsetp0oIqFVGAhzu6k0
 uc+XbT+FmclQOy9suxbKRPi1J/In2eQ3iy4LbSgKkDXS/Ll1Us29ckqtbWBUJLMDcmkP
 RvI5zm9Jl1Deu0fhVCsAzzugR+TEj497yQoG8DYC7ddMmlfhDRsS/TOIcN1jcBajm+3I
 JiNv63Hbr/dLfadD1MPYCtzHGTafKkfHSxrWJCaz2cEfHIdGMHm2aUAHgLElKzc8a/fa
 Gqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786443028; x=1787047828;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mGeIULRuNW2OOkfJaOdOYCb4cP0qB5BnAz0Ms2DgbC8=;
 b=cNKFKkOqgGKioqvC+d2uoe6tG7UQyW9xffKz20KRk/UMzUrL7AtW7yMitvyg37nYnX
 RY3aN+aZxOd2bVZrhv5B+10KWSoAr3qV3NPpCyKt0mj0fXEgq63nX3/xBaWpYb9G1BNS
 NWLmDlMtCFJucWd+8eRdvwR8TWFHrV7tZ/Ov39gDxpnqYsg0W/Lg+NF4pDZC5qJ+i/aK
 UsZtnNW+ushww8xevKTuBD80qGHxIiOtE5giZ2o7IRumxXVk+wc3KPbdt2uyc+OlN7zF
 LqQdcEY1rJuXB9eawT93I0Y58a+Tf7L1Q4FUB7d1H+PY3hxzEvLJsdEvyG5t1leEdFyk
 FPqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzBM78lqDlGaOhxVzTNSEw+58PYruENXGzEXU3teGQprbRhHPUYCp7Pl7Bmni5pG+kQRs=@lists.linux.it
X-Gm-Message-State: AOJu0YzHPechdtfDBinuic8mFZODtEq8qz6PJgiEnMajpi/kVQg7Qa3H
 uqt5FFz14tf1+C6YDpZXoZ7ZYff3Tu1c4SvxkellBBfMzbONsdlO86NQSrgVkAPfvxc=
X-Gm-Gg: AR+sD11SlqrzQQWQfM1dKdiI5f3cHsKAOS2eFc9q0BirYoi4Z+K3WeGLIQHLVrNg3Xv
 eB1HuehkeiqONIDwiAn2DN0DHIj9R3+fSPWPlOzp2EVIxEvuigngHYXDVxb7k5Z/QzOw00E2ZwX
 Itx4dTzlmUNOq/UamCX82jyxOPrENhGLDZvQ+ZCIRoXG2++hBfUK1QYtipcc/Ed3nUxIHDcmJnc
 84p2pW0GDV66cr6dVBJadX6IPZ4fmyaoqHQR/YfM6eE4KqsHqOYVqCibqkW0fC3avGgiA1eMvkJ
 IM572ZRB1DeHcW1ouLyIS0oHIXjwOLxl2Y78NLm2q8CkUmM1r+0DV0FgpZG+zMajNka0hTOIN2h
 OOfX6esCQkj9CUix/miLn43E5hYfqumntPOQ+Ax+KOthrGbkvrsrymWGMHkeJzzvghtElyM1U8l
 S66xQEzQxB1sKLA8JWLezU5zhjEgL+OVgb912jRCbOTdMtzDjS0b48vwz8GhjhpJuQzziMPFlT3
 9QDhA==
X-Received: by 2002:a05:600c:4695:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-499784604f0mr29173815e9.11.1786443027752; 
 Tue, 11 Aug 2026 03:10:27 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788a6cdfsm22694315e9.6.2026.08.11.03.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 03:10:27 -0700 (PDT)
Message-ID: <20eb207a-ed57-4ffd-a115-0f46c76d80c7@suse.com>
Date: Tue, 11 Aug 2026 12:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-8-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20260810160048.1040517-8-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 7/7] lib: Add 2 basic tests for .min_kver &&
 .max_kver
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>
for whole series.

Thanks,
Avinesh


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
