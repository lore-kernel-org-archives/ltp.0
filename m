Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC97C43602
	for <ltp@archiver.kernel.org>; Sun,  5 Jul 2026 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783277146; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=RvsClwYHQb2Z94fUX0OVnH8Y1sAnFtAWlL8+ll0Rl+s=;
 b=kvayglHG/rdflHoMCNsyQXHoq9z9kRBdO0PY20cOMHq/oHljoFC14P7cvURhpBJgEeYVH
 C+2D/ZYV6XSJBrmpzakohd1hkKaothelHAMN2mh7zuW0aVCU7KGAcz9dvvzX18wjkhrUe7n
 ogIlyIWu1Q7SZo+xEQKqCEzGBf/pFLM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C6903E2FAF
	for <ltp@archiver.kernel.org>; Sun,  5 Jul 2026 20:45:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA6963CC968
 for <ltp@lists.linux.it>; Sun,  5 Jul 2026 20:45:25 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 669FC200248
 for <ltp@lists.linux.it>; Sun,  5 Jul 2026 20:45:25 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so16660735e9.1
 for <ltp@lists.linux.it>; Sun, 05 Jul 2026 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783277125; x=1783881925; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DcHkyqFXT1xe36fvKxDKnxC6Rfqa1aykIxuEQiZgWLA=;
 b=W7wQawyexgbaGZwbfEQd+E+7qZO6IVugppnOj0QKgfBX/qb/uMl45JkDR6Gq76fFu2
 wOlaFwwyN3q3CZFtZ28Smt72A3QbWkYU8duAYCxbhvKEEujE1Q90JBhskMfawVKo/ipU
 0eK4e0GLYjmqnfF0VjvCGgWrIYtFlj3b3Wdv4OAV79g9lxPectX0U2opTZ4H1tmmJasV
 6DEs4NPeP7QoRhD2G6mh1K9P85cdiA19RnH09Z0aSY0F98Qu536TV096hSYFNL+NNvu8
 h9kssOxlaGtc+o4T74jpbALSOZW5NG7lQUaVe/SuDQgiT8SCj0Pindx0TYtrRt8awgg7
 Kj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783277125; x=1783881925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DcHkyqFXT1xe36fvKxDKnxC6Rfqa1aykIxuEQiZgWLA=;
 b=T4yVG4QHOlohBvvLJhb6mMwfb0CIK0EEbOWsHGl0ZYThBW+bDxA719s19R2YVyqlLo
 tGjRJx9Trxv5pyjCEMMCgn57Vq3LYF8e3CaW/6AtOcqDRQ7iui6QqJTJ+aGjcgGtpus1
 yQ0EmTaWlAgrwIQd4qv65KJHQiL12638wGy3RWb+ssLnehFvhtVychNvQ+PtSaCJcIpQ
 paxtOhKX7DKLbIS2lOzPVmOR2OkIEo3jWD3bJHXfX27BDspZqpTgGKeTBuqino0ehpvc
 uVQ7sE04fW0GXSGyesLyJUSwoXgR0ZddddVvfSoUVkbn49MyRnxJd2QG+ecWMQ1z9dIX
 ftZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmGAaK2/SEx/wasvzDEeOcH5bz+UjBf/oGXPx4soBLE/Iapix6uUECXJ6SKDlqc/lZ/+M=@lists.linux.it
X-Gm-Message-State: AOJu0YzM9uZjPdfRxoBJQ3EW3+Tx7PgJ9cN+rFIJQjZrLFrRcKTTDStr
 qXX1RQTaQn6k1KfVJat/hNHr0S3axJ/Xr5zYveUT2a8flrJh8l6ZqoKOElot6YF+F+GTFd/v6YJ
 OkiCXbWQ=
X-Gm-Gg: AfdE7ck5IgqFWbxBk8Vpl5vx+GzL2arUMENJe1WKk87XmEmo2eLFgulCTFwVSj+wWuQ
 sF9VKhm1GuJj26//G/7SElakSl8a5EXf30e+jjK0xVyQf2EvqmjdyrC8VvsJCL6slA4aSuvsVp8
 +jZjWwUb95KDcluD3HMl1L8wfyQhKf/kksPXxJnErXYe9k+QMU1VkP8Lx79mN0jSV3+W9Zpeo16
 +NDSCDKwqvy/Gi923mrUgssF4C36YVDKmcXx4/ikY4AINvJhCbkXAdoqMw79oRCxsJykMUv7pN3
 sKuYEl9vxIV2W63DuAjQKmnO9OIWWiToCMWT5/tOaGwGuYpGpGjh7YGoYEzPvBCAMLIgqDbC3Nj
 293RFVzr72b9UR6DrK6yM4QvDgOmzzkfvAxqLgWlnURAG9dIIWvHXTVcAIeUNejkKMQcOPNftAJ
 1B5Jqnmoy6mxbbZBBA9gYdUS3U6INhkQ==
X-Received: by 2002:a05:600c:3e8c:b0:493:a5da:e5d2 with SMTP id
 5b1f17b1804b1-493d11f8082mr82158695e9.26.1783277124645; 
 Sun, 05 Jul 2026 11:45:24 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce03fa1sm215294195e9.11.2026.07.05.11.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 11:45:24 -0700 (PDT)
Message-ID: <0603be3a-0bc9-426a-99c4-2b9d5df97ba9@suse.com>
Date: Sun, 5 Jul 2026 20:45:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>
References: <20260703015745.20728-1-wegao@suse.com>
 <20260703125958.21260-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20260703125958.21260-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] statx/statx04: Skip vfat and exfat filesystems
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

Hi,

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Regards,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
