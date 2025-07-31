Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E34BC87FCA
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753982009; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=uTfXBOV0kU98LedbHTFu6yz44DIUTLcTY2JSZqfh45A=;
 b=Wc5/Ng7Gj4SVW9+is4UVoSfEawXqlIMSqlM2t4sVJA3zBqVwfhteapUWJYkOBNLLayQI1
 Pf5eQ40dGmAg8Sl9V3EhmjO4LWqdPRkH2YECGv1TL6YpFLimcf3+S7Q0rHFNfT7zzRcp61r
 HB6lHzGD7FOfYbIRxtY0pqe1TOFOpmw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4A1D3CC23C
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 19:13:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F5023CB93E
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 19:13:10 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 93C13200AEB
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 19:13:09 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b7910123a0so1161628f8f.1
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 10:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753981989; x=1754586789; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xZFSvuGMX+KyIIhcb83F0wQiNrfaVDiDvNRX9TpX3Lk=;
 b=a05yLLKcsCmbv/SFal9Cw7Exc0rNjXhBeattSHmHg+FrCTJb7OilxIx5GaQR8rwalr
 hpYzTnBlcy3IAgIEMDkYzE9ccRNfW5aEqB8xCBnBA8yZy1ZU/cW+j8rJ0UFfb9LkEOE6
 wi+xrGD/8FKtQ0WmSsHHwAjWgp/3Bd79LpVTaiMlboJvGXzDENowkoFBUZ1iNWdJj0S5
 sSuR97c2LlooV8W4T9oUC3CmGMmavQUnBerwZe+OJKHSzQz8ZjkjQLNvh3z5hQdup8Xg
 1wzuuYo6rCc1FtDl3eJfv7NczpJ6EIzQKhtGeCwf9DnL7w9FBDTuNtTuqucjdhiido5q
 gBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753981989; x=1754586789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xZFSvuGMX+KyIIhcb83F0wQiNrfaVDiDvNRX9TpX3Lk=;
 b=r+YccWIbMRA0RU50SH0HxdvfqOEDHYCXdwQxq3GHxqLTdZAeu6LSw3vNvX8MEjE9mm
 KZSYkYI29szyJEw2CEaCck1weiVnmhtem5Sd15VHMGhjRZ9aDmwqn/1tF0fSUCS3Gt32
 pD2MSnZo9RExRymxYyTj4eHOZDPHtHcPMDan+V5FI/sNxerhD1EzP0aLxpu9iFOZ6h8i
 lCvmE6Yu31DoX2jHCUscJix550zatFIiHZ48Xc9iVHqCV3nhkxbPpQuAe53UGQ245ECE
 nAICLHLpKQ62moB5C/7kudFfZYJ4+9VKK+CBtfbgx18cf8nWaK2WIZ6wfMIXKp9gjaif
 mh0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBIwOhkSFRdpGn3i0t0YYDByUUO27AeZJwfCpBvpQrCHDNGA1/ItQ3ONdKElOGONz6lCE=@lists.linux.it
X-Gm-Message-State: AOJu0YyCR3OCw/scoUHgSw/xw/p4duurrkm3Sm6UKAbeQkFjEHZ8LgEl
 mpk/M8CGKUvI6MGqMTkBMgyW7cOswVjR8eOIDCEPIImEpI6AciESP3wWvpfHl8kSNRLgFpFeim6
 c65NJDAw=
X-Gm-Gg: ASbGncs6TlTOljT+zTTaDpmUjPEpHQ6tvwKl8+J1EC3RBmDsJ6w7jJwkeOvTCOU3bzN
 krTmfyya8quqY9omspPyIGyHpI8Mz9isRMcbH9gN+h5gXwf3Waf9ex7UPMd/8VHtkiVtOn2p6Nm
 8mVuN3orIGIulM9ICGRLol2HMzyCrFuUcutybvsaAqqU1qXFEpyUE2+0mDycZTfQkQRfQpZRZAk
 XMxBZVhclEBH7U/lGJUfhZFiKc1HGYo3ZLeNK234XT/gxVBv4KS1FQx+uK9Mw+N1G29EFsYobcd
 WKSxmzX5GjYSxYymkobUTMXhh3icbq/1LL/WK5aSrSDEn/ReylKKnPbW5NVoN/aSTGaO6v+Rk1T
 5Ok6UtYkvAncDkTLfI7jvMYtznqW2T7vIsBDiTkMixvGO
X-Google-Smtp-Source: AGHT+IE0AWER8oCVKzPvtbORX3sl9yt/ygaMi19WbYIwAku3BveMgIHnrnaqujZZolCRjATrAwzj8Q==
X-Received: by 2002:a05:6000:2288:b0:3b7:8fc4:2f62 with SMTP id
 ffacd0b85a97d-3b79501edc6mr6422053f8f.33.1753981988943; 
 Thu, 31 Jul 2025 10:13:08 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.222.116])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8ac5c34sm22496935ad.188.2025.07.31.10.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 10:13:08 -0700 (PDT)
Message-ID: <1e4bbd5b-1b45-4658-b437-6e79ea110ed9@suse.com>
Date: Thu, 31 Jul 2025 19:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20250731143358.1035685-1-wegao@suse.com>
 <20250801002918.1751299-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250801002918.1751299-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mount08.c: Check EACCES error when test under
 selinux enabled in enforce mode
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

Merged, thanks!

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
