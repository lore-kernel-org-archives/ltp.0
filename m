Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E4BCA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 11:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754997479; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=5mTZJxcBVNF8hZdpBdPzc6zXS1tG0IvO4elC58NLt1s=;
 b=PgxqXA2zfJj5kof3252u0exe3HRBs/hOC1MyvN9Gg20Gh+eSzD0achySGX5Cu+xPFpDpC
 1c/eP5qf5sGsuxLLY4ukL4sZIIioYkFAvBBru6FMF2wTtI5FIGN5JGanEZMhDs3oq232JVg
 vuSZ1Rcp9YgrLtgu+XUDv8OvLaOpUsE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18CB63CB376
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 13:17:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76F0A3C06B5
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 13:17:38 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E28EF1400445
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 13:17:37 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b913b7dbe3so205959f8f.1
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 04:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754997457; x=1755602257; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5s59DAA9xVPvFS4bj0vv+HGSVEQM/LpxIU/g2wCqv7Q=;
 b=T8sR0ZOicQ2YjUHmAYmzXCX6gMdp75W4CSOokKGfWRepWxKSq2YawmOk+7M9PMeVlT
 AIJJqEYCateHtTFlQMVPYJjD31qowEFM3QknwMsX11bY3al4l0KSiTFIhWTVUwQ8iM0V
 a60zio+Gr0zsr/6xNEtuuPN7shaPjrWUkjGYeFL0Agu4bI+ug3ENZl7HuwnQEU4wiyLu
 /gr+dWWD8Is3EbDzukqU/tqB/9VutMUK0c7ib/GBEeizoN0tnOkJI3Nt2NSWbwJgQoPP
 HNT33feDM0BDEVRUcDEMIBpV2BIP2JyTu5E06KVCT9eZ5BkgnRFk+xQ2F2m7OAmUkrPX
 i47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754997457; x=1755602257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5s59DAA9xVPvFS4bj0vv+HGSVEQM/LpxIU/g2wCqv7Q=;
 b=dy6ieKf8D0D+DPelNDNpsiMdZAQf3AF3xmNS0hjFCz5eJ6v/N64Gotm5r4lumS5052
 eDskoA36OTTco6AiyvK+fw4MXrSzcCdTuho6KSlE8zt4n2qVFwL7Fa3xSsk4xfezppFl
 EXY0s1jqvtgGxqq+csteNZAqYZkaC94TiRTuCgt/JcGgu3fbGPNwx/OKy0pwhwHyna9m
 OlqwMGIf00gR2k1AYab5xuf/h3L/SMrDSBGkeAv3xCw7VGW4nK8/1W1hsIKR/YI/ihrs
 a40ELJxzTgUJJxjM455C0qk7gxHNCEkliEEUdz2oIr19dR8sbPM2v5FVzXUkRhpwA1Zv
 Dp6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx3TzeYyX+G9uTTf2TKBwbZJAZB1gKdpECwdT4zMJNhRsbbEIfVsJYiQexpDyWK+65TXg=@lists.linux.it
X-Gm-Message-State: AOJu0YyFdKp4q+5a3Pe0m6/AINBu42zU/bXLugR3e4GSMgoOsf/Djjlk
 HoKiqNw+urZZuTbJV3RDcBfQHC8dIr0w2Qqs/cyUvqMqzF/2X1Zd8+u5c5NXiu42zqo=
X-Gm-Gg: ASbGnctt3mROgtL6O+g8Dt+JuTzcR9T37D52/V4HtA+EgoAEq4cNwPV4/DlrtZyXqmm
 oz+iKEVpJwg98AbQ7+7r2KYPpGjr8dWahO7n3pXXh6jVCu62UFsyGpyqNFi/G6HlKWXGV7mp66f
 NIeOol4yrl9LmQcarWk29VVzOTf9oHs+uQzN3L14PWQ1/oMJxRQrJJLnBSy9Rx2xHXCqyonzYEp
 VKt2lzp/dscoBYD1Mdiyf4ONy+pH7Q5tlzwSWZxy/p5mPdN1+pzA1uxTvamfyjdwi7UcaU8EVbq
 7qgKUssE/2IYN/r8xpnDSqfVudM68wTzeWCJuADcIqd7aOCwJ6g+wJUA/qg4Ilaubv8dT4IAlKZ
 FjaSKEjDtktms5F57GXqQwlMvi3fSjrlfm54nvBhow3dT
X-Google-Smtp-Source: AGHT+IEVa1q1twHJmHR+XrTeP/QbeDZbBfXUyRmur5NWwAdSZcrtgy8rqc2YNGHqIaO1r8dwe9xT9w==
X-Received: by 2002:a05:6000:2f85:b0:3b7:895c:1562 with SMTP id
 ffacd0b85a97d-3b90092e002mr12408284f8f.11.1754997457134; 
 Tue, 12 Aug 2025 04:17:37 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.217.151])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e587d378sm290187315e9.23.2025.08.12.04.17.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 04:17:36 -0700 (PDT)
Message-ID: <7f617dbd-d7f9-40d2-be7e-7cead5982e4b@suse.com>
Date: Tue, 12 Aug 2025 13:17:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
 <20250812105127.GB835467@pevik>
 <8a13181b-5fbc-4a10-9904-24fd26cb1ebe@suse.com> <aJsiE1HmAup1doOf@yuki.lan>
Content-Language: en-US
In-Reply-To: <aJsiE1HmAup1doOf@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve: add CVE-2025-38236 test
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


On 8/12/25 1:14 PM, Cyril Hrubis wrote:
> Hi!
>> We need to set a timeout for recv(), otherwise it will stuck on systems
>> which are not bugged.
> Or just pass MSG_DONTWAIT to the recv()?
>
This is a good idea. I will add this

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
