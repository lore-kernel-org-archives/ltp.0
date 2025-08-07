Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04712C87FCF
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 11:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754566159; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=2fKnrhz2mr+ilOT9Y4aK/vDs1uaOJEk4a8p/bi4w6g0=;
 b=HxxILrYK/Ge/9mCKNPFgd0UBGgpc+7qSiKM7Drs0V56WTys3BWWRhOCFPqVsTahoDiKsp
 Q4p6or/ZCIlJ7iUQ0U8oSzajr2l2FJ9G6qAdPxNjB+1i8WvrHZyeY4tKhBndeXguCefMt9f
 o0Jmoxr1YxbDA9njbSFuH/oDIjdlU/g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B0803C9A6D
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 13:29:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D6663C9970
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 13:28:57 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BA2331000414
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 13:28:56 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-615378b42ecso1705326a12.0
 for <ltp@lists.linux.it>; Thu, 07 Aug 2025 04:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754566136; x=1755170936; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=eC6XIL3pKsDbpJ6txho5e4B8Q9ewKxW5sMfwAuZd+IM=;
 b=FRnCx7d/NyDhltgvOvVdkOJzVgv8ZPVW3g3R2NEXsoWVNJI9q3r2Rk+szViCQnxnQo
 p5i7bIZoAJag8CF8r9b9U0v+H6io2JSkzs8G8BH5gUTa3BYYpZb3k7qNYcsuZm4fnwcw
 /KqQoJyYtGvk9maPs5ZKA+vPTYpMquQn3al8HV+LqoYOac8imVpmsLP63pvmUu6NyG5a
 KY+U10ns0XU+/ibLdbOsAEoT9OLS46S8L4G+/iczeQ78PBlmJHPQFj4P+qPEfrlnZ+PE
 sNQFMiXDB2AzpPTbfHyCG2Zd+R3z49IAkvLsFoxrT/LxwS6qVhOHGb3n05X8rLpQVMXB
 fmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754566136; x=1755170936;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eC6XIL3pKsDbpJ6txho5e4B8Q9ewKxW5sMfwAuZd+IM=;
 b=QR8QPx33PnhUHKIMhBJjdJpSI0ZzKxljtcRtKwLg1lcmh8B7P5l+0rfjSVKWOvXUQG
 S+MCVSufWPazavUjc6NPPS5UqMGcFo55kymANwhlk+4KgoeMhTTbdmZD/GuSe46LNitk
 eyClTH5TpvTpl9JG/p38ysXfDxdLAl9mYAOakO1cWRJuVxGU4fC0kWF8ScWKw8kammTF
 sNjqJ84tfZKCOFangUvRexOdfWSU78C7iyQB21jNLDu76q6D7oHSqzNKQ40cDcp6p2fe
 vCe7iU5aWDL1MlmX1el24ZJFsfhTW2m5jApeDxuOT+Ye7jI87Wf5u32KacLgDVQdp0kc
 Mhuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1LC81WPRF4nsqzwHuPEali5Emz7W0yMkds7gM/G3eZuv0nPSwN01rluPnMXuyigbbTrk=@lists.linux.it
X-Gm-Message-State: AOJu0Yy/lZQYN5sEuNFI/tZqnNt4051o0GKO0Z70EjotzXLe13NVX5uL
 Wdhr+J/PP3/FekSMNG9wYa3ougaHSpj2/aTw09JMqlVAyLdMqf/MDjll/R5ELb+qulzY7BxTrLg
 nY4zJ
X-Gm-Gg: ASbGncu8sl3dBPGLWSU+DQR3lEPNn+4brx6WYfr2y8mEzZk1CblrgKgcgQ4nyx12ZS3
 NrzK9/FIEf38wnjJb2AT1ZX+iSF4cAZADuwi0Z3NJyJA5XVAOLSO67aNVoyKDOz6VEj+b2wl+Tg
 NvKXO5RwQ7aFyz6bxAOPwKW1X/RYuKkqqf/SZ3PiIbvZN34kVZDcwb1PDddJ5bXdgHqPNK0VUVC
 E8w8BSGitmi0PRBwfAG6GrNviLQStTVZ5sVvheqTBQYGE+wXTTI7ZKb586KIRwPWKaclBJwb3UY
 SChKNje7zwufzrgpsidLQACtEQIt//4wtQeL6M54709BElwH5WJHAVl46kW8Nl2+EOUBF5Xg4RD
 wfm9nFGR3HVzG6YdwPml/ox1NCXqUYtGLNg==
X-Google-Smtp-Source: AGHT+IEmZXGe5QDLscSq6rFfmpR0cuTD1UZMa0QDsVp/07rU9bIedFu+do+fTvYpzv+h6a1dDL8UaA==
X-Received: by 2002:a17:907:94cc:b0:af9:35f0:7a0f with SMTP id
 a640c23a62f3a-af992ba66afmr554617466b.28.1754566136117; 
 Thu, 07 Aug 2025 04:28:56 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.217.151])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a91141e9sm11559178a12.58.2025.08.07.04.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 04:28:55 -0700 (PDT)
Message-ID: <b47cde7e-9be0-4bae-8682-ad41fc2cd62a@suse.com>
Date: Thu, 7 Aug 2025 13:28:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250806-conversions-lchown-v2-0-345590fefaae@suse.com>
 <20250806-conversions-lchown-v2-4-345590fefaae@suse.com>
Content-Language: en-US
In-Reply-To: <20250806-conversions-lchown-v2-4-345590fefaae@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 4/4] syscalls: lchown03: Convert to new API
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiA4LzYvMjUgMTE6MDcgUE0sIFJpY2FyZG8gQi4gTWFybGnDqHJlIHZpYSBsdHAgd3Jv
dGU6Cj4gICBzdGF0aWMgc3RydWN0IHRlc3RfY2FzZV90IHsKPiAgIAljaGFyICpwYXRobmFtZTsK
PiArCWNoYXIgKmRlc2M7Cj4gICAJaW50IGV4cF9lcnJubzsKPiAgIH0gdGVzdF9jYXNlc1tdID0g
ewo+IC0Je3Rlc3RfZWxvb3AsIEVMT09QfSwKPiAtCXtURVNUX0VST0ZTLCBFUk9GU30sCj4gKwl7
IE5VTEwsICJUb28gbWFueSBzeW1saW5rcyIsIEVMT09QIH0sCgpIZXJlIHRoZSBzYW1lIG9mIGxj
aG93bjAyOiB3ZSBjYW4gaGF2ZSBhICoqcGF0aG5hbWUgYW5kIGluaXRpYWxpemUgdGhlIApwb2lu
dGVyIHRvIHRoZSBzdHJpbmcgaW5pdGlhbGl6ZWQgaW5zaWRlIC5idWZzLgpUYWtlIHNvbWUgb3Ro
ZXIgdGVzdHMgYXMgcmVmZXJlbmNlIHRvIHVuZGVyc3RhbmQgZXhhY3RseSB3aGF0IEkgbWVhbi4g
CkZvciBpbnN0YW5jZSwgYWNjZXNzMDQuCgotIEFuZHJlYQoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
