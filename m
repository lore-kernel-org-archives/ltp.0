Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B8CC8302F
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 12:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751287842; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=aGWr81CCztKah0izVsqurAZ5XRBBDTXzNkblkZ3CE8k=;
 b=JhyQyqK9lC9OH6uCTqscMUr1d1eIv4Ak3Ndw3/VNzvOXiGLmQdUXGczBCKVfxoOfEC2r3
 QBHb5+RbylmGgSnKbl8mIcfPGxnu4WDI4KMZXSc381kjJbSOYYBwgr3OLSMNqZ6ovThPnJj
 0Fp4iLYuM9dV9vli1Dl0UsrhnWYXrzI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF9293C5911
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 14:50:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DABB33C559D
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 14:50:21 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E9A731000B61
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 14:50:20 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so2513956f8f.1
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 05:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751287820; x=1751892620; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yYNQKl9XBuwDjVgmnFvZ7jf75YXqi2znh/isXCCQHWs=;
 b=YeWmGtPzcfVJXbP4GAXTSmJJgxR9zs/e9dt8Scy10vjUsu86V/sIw02qJNkDNglmAh
 fZMwx00gl3aXvEs9+LXY1Dg+WXauJe+8jwk5Qa9+ZuOmdvPV9jsvu8WJkWBfkSXSO4qM
 wFbC6KoNdQORmAyCx3Lge5Y5QrFWoLy5pradPG3m8RSWVLzt3DLqCtMGX28iFFtg93F/
 YgUyNwrUHPyo928GSGw2hNrdXbNFEdCtQb7/9hrIxEK+slisGaKGYQk4Nc5Rl+DT+4xE
 51ZPl47DrrbWpsp1nuRW0NLyC2C8cuZW4p4MB42Z1A8bZfsGvSugOC7H/IF3Tsq23BuI
 ai0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751287820; x=1751892620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yYNQKl9XBuwDjVgmnFvZ7jf75YXqi2znh/isXCCQHWs=;
 b=BiCO+TlkuSgrObTuZnIJt9hOUZZDCr/9zSluWrg72LUl2Xy88PMt8Q/X2j0QQDHG9Y
 c0qjM7teGsJgtbmE26ceHfFyizZKP3BNd4lNx3ifoMiGjaWNVMmUeZ9RHiWDOnd5KiSK
 3rhDq/ykRYMvSGGNHEnHxSSR5LWknrcy9g+83OhXA/cf+EOqigVg9AiusBlLS7JTk6od
 mVtwMKvYJhBfm4Ofe4PJi0gE5NQN1t6cjiUDAlC0USBUEw4BLN+mBSd+QnxO0k9cAyVL
 XIIqZbNDbDGtr789+Bof3iqNF2XJi3f6upu5JNWdqUmWztwp1yv0fyAAS+4LJjf6pl8D
 odvQ==
X-Gm-Message-State: AOJu0YwhTnlybWkUUsBM98bQhATpceWrmRKg3o9Nni7i83OoI2zfBQ67
 tXE6l3RHxhMzjx/+YmLsJyQZDhK/dF8q9xHl6Gdu8Z03RS5SprZ+vI57gvBilQviTOo=
X-Gm-Gg: ASbGncu04BXlmBklz5eD2tCNUN9/pfcpofwMFrkEXI0p80Uo0IKa3VS+VrAyaBx+vIe
 TrUKTFAHuDC8a1bXwT+PiR5smbfmb+LpAiYKFOboQlYpbRJGJhCmfRdCdzSTWXkm37uwy4/rR0z
 eu17VLADKTXxR4qFZEvZidYUMMKeY/+n9ai3gVk0MK6lNlNhoGdRxxdC5Jgb2cKRFbKUuDd+jcx
 BdaEtp05YRMpAXR0D/OyHEZERAiELIvXmq+5M5UpNpy8S4cyIGQDTuR1tTey8ZldvtnC0eCVL9E
 7s0/v/AunRJ66vcx2HniWeKJWiTgSfoXYXf6LFVawYKF+thpyBhN2iSc9FEJWmMN3kQn0mSG
X-Google-Smtp-Source: AGHT+IEKet4kme1hn7Ofwkss3rAAiHIVz0x+0ZE87xm2wOcCosoOYFYZcJitmBW7a16TgciSeAxa7w==
X-Received: by 2002:a05:6000:65c:b0:3a4:f7e6:284b with SMTP id
 ffacd0b85a97d-3a8fdb2ac5dmr12053594f8f.10.1751287820130; 
 Mon, 30 Jun 2025 05:50:20 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2f1b1asm80644025ad.68.2025.06.30.05.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 05:50:19 -0700 (PDT)
Message-ID: <df64c1e1-79bb-4fb8-8360-cc9d0e85e774@suse.com>
Date: Mon, 30 Jun 2025 14:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
 <20250626-ioctl_pidfd_suite-v1-5-165b9abf0296@suse.com>
 <aF5q3GYpIvqI82bZ@yuki.lan>
Content-Language: en-US
In-Reply-To: <aF5q3GYpIvqI82bZ@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] Add ioctl_pidfd03 test
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

Hi!

On 6/27/25 11:56 AM, Cyril Hrubis wrote:
> If I'm reading the kernel code correctly, we should get the same result
> even before the pid was waited for, so we may as well do this check
> twice, once before the WAITPID() and once after the WAITPID().
In this case, ESRCH is obtained only when info->mask == 0 __after__ 
child has been reaped.
If child has not completed, we obtain the same result of the 
ioctl_pidfd02 check before waitpid().

- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
