Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6048C83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753269454; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=/n97aEpFjfFvmNXoEqOiEupTncvpIbat0i9Ux57O+hM=;
 b=Fz+LVK7h0ju2C1nQM+VmNbung5AsDi647Baf3AwiD2hQnDcP+6w4ebWnzVIu7F8Dwnp8h
 Ob6pOFPjTvLahKPx62g/rWGQgNsdYINJ5UbelGfmK0NLxa/SMSGxY3D6k9B8pySwpzZBO2K
 OCyx6cstjEPnXPBmTo3ueVYWZBPF2Pw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EE653CCD67
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 13:17:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECF1C3CCD39
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 13:17:13 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BE35A600434
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 13:17:12 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4563a57f947so4180585e9.1
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753269432; x=1753874232; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=986Lt21r7hNkvfG1+833QIwt4AxCOtW+bL98xHDIi0M=;
 b=H5PWjrBl+eamWVhw6a1IUkEfxsN6Gx6rOHG8hEEn8fF24Ky83Wo3NIiMcNsWiBLSTq
 GMLiZKCeb/EgTPpl/ObItFqj1NKV0TaziQf1xriIRtxcunFLfljSFmic0s1skuGymr79
 V0CdqtZ9Dijek2Z5G8ll9b63PB3ovFC7k0SiyNPuOSfv7xs5ntIowP5yU9J38E/awK0x
 tNlBh8U2bYAdhl37OsGGB04CaeTO7NPtXK3EASVa9EEF5nOKVxmSr8r37yZbOTEs62SL
 AtnrZyHuhCMy+wh6a6RehMSssXmOZ3WqjljiwE+k90re8W9264/sgiZR0pUUzSazADUq
 5dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753269432; x=1753874232;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=986Lt21r7hNkvfG1+833QIwt4AxCOtW+bL98xHDIi0M=;
 b=inMFyeEF4R6IKvWgtmRIj9AMZ3dJZSMaPdM4k8//JXsOwcPv3KLH33lZuRngsH6wuI
 ycLOiXRSEb1K45+mHt6TVykuUW7zBPE0TJFCgDnZradt2b9lPGABVABKYXb2Mzc1NUku
 47tfQj8EqCShnGMuOdY4qu6trUBazJ10GAPc87W0tomeInkVhzHMsDI7r2aMVKPUI3Lz
 695VwyjnB5FeQCqClJjjgyD75dOnNfTSNtWX7hlp/s+uwkxS0mEAWdlN0Dr0tE6xiOBE
 7jvIEzXj7XTtGFZF7nhK04VjKDcAs2hP08iJkqf64bBkSrpM1oE3Ed9yidE4z+ncDOg5
 w1Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeMxq9hw/Q7mlxk9yuFoSmwEaKcnNMFmmTsfM1sxKa8F+MjUGvgpaa7vwR9MYEl4Kd7Y4=@lists.linux.it
X-Gm-Message-State: AOJu0YyiFb1rPVJTrC78Su4pHBwCD8a8ZYqwaQ/JxGydyv9bbdc9PEas
 B8H7AKqu/c9gyQBH3qVw0287Nt+kbIIUjPRPFzdmFh5VqvBSw5cxw2zAZOsVvudl5kY=
X-Gm-Gg: ASbGncsAw/x8EzWQsJCkb4r8d383ESLlMnjtqxoGmI5+k6Fype3nlNos3uyqZ80u4pH
 lXnfE/Gnu9BJriqhTk7Ly8jtgV2fNRyBvF4fTBSt9V9mXYCBWfS7jWKfWRc5Nh026fCdhqM9lxe
 IBO4UortTQRa+dr6njlm+V27kK1qMMTzE1EChUVbcuJHm9ZJ2u7ndgf7Go6DiFda/LbYxicXYrA
 c+W/DEwzRwGKwiS63+bUfx7P1sbEPG5jza2g2b3fmDlaQTejJiKDlZzTcmZO5Hs/WjfUQ+zQ83v
 xrYXzWya4iFf4p0qmuCmUjIAAovT0hw+ak4QcoGrhTcQ0C+29NC9IHBwKgFNeJERb/iiQHtjjaI
 89m9pbqa7i9ehkguZgbWHb1KKROz83CLJPyk9ES5vkUC/V3w2QRb/jG3e+Hr2GbXnbxbcQloacJ
 eOEZ56u6TpiHWMh1F36f6DlGTOE8fDDk9z4HI0fo6VHIYbn0hNIFLpRRpgPeNApQ==
X-Google-Smtp-Source: AGHT+IECLSyw7bMKguojt+wysSUgH00umz6D/3l3bjh2kCrDPgwSMyF5ocEunqh+YQdMnRQa0v9qlA==
X-Received: by 2002:a05:6000:4022:b0:3a5:8934:4959 with SMTP id
 ffacd0b85a97d-3b7634fa724mr4987547f8f.27.1753269432031; 
 Wed, 23 Jul 2025 04:17:12 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm94772525ad.18.2025.07.23.04.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 04:17:11 -0700 (PDT)
Message-ID: <54a9a8ba-4d1e-4476-81f5-dceaadc8a82a@suse.com>
Date: Wed, 23 Jul 2025 13:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Petr Vorel <pvorel@suse.cz>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
 <CAEjxPJ6WQRrfAnMtDzvUxYL6smYbKpDQNGp6rxs4dZ=DxC3M9A@mail.gmail.com>
 <CAEjxPJ7gbWRWgbrLv+1xE0dJUq+c9UpNzYUgyis2f8gmJUo1wQ@mail.gmail.com>
 <20250722134246.GA84869@pevik>
 <CAEjxPJ66s+UsDXAbgewkA+h3Djq31FMb6pBF2NSZiV7LCH_Jmg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEjxPJ66s+UsDXAbgewkA+h3Djq31FMb6pBF2NSZiV7LCH_Jmg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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

On 7/22/25 3:48 PM, Stephen Smalley wrote:
> I guess my only question here is whether the tests all require SELinux
> to be enforcing or if some of them are just exercising SELinux
> functionality that would also pass when permissive. And whether you
> care about testing that case.

Hi Stephen,

this particular reproducer doesn't need more than knowing a LSM is up 
and running, so we can trigger the bug on listxattr.
In our case, we chosen SELinux because it's popular and this approach is 
more practical than checking every single LSM implementation in the 
system, verifying if it's enabled or not, no matter SELinux is 
configured in permissive or enforcing mode.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
