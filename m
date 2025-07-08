Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEDBC83F0F
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 08:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751965187; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=keikFGcwCj+nKCtBF5AbfLGBCQfXkbeCFPPq9M2UYMw=;
 b=HBf9Glp1etWECnYKRUaeVw+FbmJKEdmp0Td+8eRarPLHLpGDEHnN63PDMaJjrnJ3iyRUy
 QGHkwh4ku88xf0ChNzfgoKHSPCDDYb2mKhxDTA0JVpuhsDLUZO/5uruG1P6X3CkiDg4pfc2
 lBg/Lu4+Cv+1wIcjMuzPBRSkzPMPb1o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 066FE3CA1EC
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 10:59:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78E383C94BC
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 10:59:25 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 72F253D75CA5
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 10:59:24 +0200 (CEST)
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso35803135e9.0
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751965164; x=1752569964; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SWox9S5X4PiBvZfIWMyx+xiep7PkYnonXGZN4iUY+ZA=;
 b=FDVGZGboAdaxGtHo20bMzb4rzxWmfvq0fzwmMxSYBc2DpBhY/NT1NMspMSjWGQIhDi
 Rb6wDl/RoAM12l9NI6LoGeN1ZQZD9xeyWs7dye65hLuV348SFG47mtZyPK96nII8+zy2
 3XgFIjrsxtjBzZEhNIppTaNTgQEuIsAbCiOSmAeycX2jwSLoBqDri0VJYnDT28zIiuY3
 lHvsVu98SxHcwhFsCfXAAdHTAlzUuXI9f/4iaMQlxyq/Wc/+lCRV979WrXURhYEFPv6V
 hNhORIyI1aXA6Y/JwsGjKouNnPzchfsUa3ci3nko5szUl0xtzH+p/2az76YxlOAXlReB
 9OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751965164; x=1752569964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SWox9S5X4PiBvZfIWMyx+xiep7PkYnonXGZN4iUY+ZA=;
 b=J0ZwSPYM5xwoFE9HydPHvajQ9rfl6CtmbVtGsinA3OST2df7jM3sSLukT8uBG6Rrpk
 U6t6MAevJx79ATrn8iHWgbRSg/Ik3u7UwB76oosWqRUIxbUAqZJPHZdR9XV9vi6hqNqL
 gUIA7ynBUHQjWTytmRo1+NNsrFZuJL083Gqkt9qMuG7hvclvrfiizbN7GbvB/wYNOYGY
 s7zSCpbPHV0nQAO0LIpo3KxGipdoR3iqA++8vdlU4M7g/sOZOldzK8/5S4PMh5vvdUiG
 7YgYWc/KGGWP1vM3g0CNDiBNXUjeXSz0ZyMV0VRJe9UhGMHO97H2zkkH3QptC6pj5N3k
 nGjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW13GJwadhogCYNURYAoKOUnclamTd2tnwis2x+L9hT3JMhgxIB3mZUtwtBAeVcQ2YpCfY=@lists.linux.it
X-Gm-Message-State: AOJu0Yxw7g3LYWXo4yfzW9o231PM6nqQypduI2mXzIJSsj8l+7p5AY9A
 7FuyO+1rqZfhPeYpV6w8+7ZlVo2iVfEIaVVzNmL5YAlQVjaD6ZpvR7p2KgQQPXVdZaHBdJxXTte
 ivMWvfal5/534
X-Gm-Gg: ASbGnctW2Ng8y1tC16TiW4ia1c4MfLOa5+FNqvpuaIbToX3eC13SGWBc1JNvwBVcouI
 bod6YvlRrIJSG6/IRsdkybo04Je/VRvaUbHZKE02TOe9nxoKW1HcrWQH0sJ5AjyFAEoRsxGa+87
 a0Vf4cbYoXR6fW6L4RyAOKBPRzh8S4hKYhu59r3rK6y+SO1shMNrWnTNXp/nFGBpI16rkkxSDqF
 Uo21e2KFRJBBQInuK9nhOquOh2v8SqdzWP0ofqMdieu3CtpT7nbaYlxuC8B0lKa5xQQGniH71pq
 LcRhIeIyRKnU84AMbk14adUtjxmP48xjHpfOo/LRNEZRd49aBHBwUIXFiZKRIjfHGYWi59JK/XA
 AUzjLM2ebsfP5YU91W5AJW7Y+dLDf+VvRyITeKDYfmFtvGBSY1QHXOlIgGZQfBy5fFEeFAQqh+k
 jvrsYEHFnfr76qe1Baw1FmGV//gw==
X-Google-Smtp-Source: AGHT+IHW/RyW5Kc9eA/xeQZhb/IOg/uaz/02zLt+ApKBrOq0cRGWwfUq9X0/o49inZhyhcMOskvQMw==
X-Received: by 2002:a05:6000:481c:b0:3b4:9ade:4e8a with SMTP id
 ffacd0b85a97d-3b5de12a3ecmr1665280f8f.21.1751965163649; 
 Tue, 08 Jul 2025 01:59:23 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285c90esm12574584f8f.91.2025.07.08.01.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 01:59:23 -0700 (PDT)
Message-ID: <c5247046-97ab-4d21-aacc-e4018ed4a366@suse.com>
Date: Tue, 8 Jul 2025 10:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@redhat.com>, ltp@lists.linux.it
References: <20250708055950.m25zfqyfr4n4qkcm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
In-Reply-To: <20250708055950.m25zfqyfr4n4qkcm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Bug report] kirk can't run ltp's fs_readonly
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

Hi!

fixed by https://github.com/linux-test-project/kirk/pull/61

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
