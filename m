Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC51CCAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 13:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758634105; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=NT1aCpeg6S17+KSXzK3HKVXEUileKWAjdUGbER04ZU4=;
 b=Su0YCNnTyz/N+isLYRfS3rcSHjuQn7KS7FZjUtpJ5Pz5Ho2yg7uU5aj0a61HNMk5WdoMz
 aGeyBNDrglUozxWBOYwfaCFgo9lCVFJIvLdvueDIt7jl8UdGOfp4j04sqyCMeYrJ6XW5pjh
 d61m/Rp+mbjB1zH2Lvx2tRWN8zVI8PE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34C9B3CDEBE
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 15:28:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3B863C2566
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 15:28:03 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1609C6008D4
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 15:28:03 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b03fa5c5a89so808450766b.2
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 06:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758634082; x=1759238882; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g2ytLt4ya89YgSIixUbuNVW4syTqO4o7/lQfNXoVqns=;
 b=TT3L54M1U6a0NVwUNiZuhfySEC9ERC7Cud7PsmxsHEsK10XNbCxbw16XQqDzJBGQvf
 wmxgDIHi4N/qnqd9Dan+urWg54IuotiPNGoyAjbWgumqnlqUGG+kCW5j89In24bXFb/I
 8uXbfMc83D4mQAMO560gO6BYTepU8+EKxznbd1zyoqrTRyPV7OixhHZ5RldpjcrspYZC
 RrVWN1+YdvUobIPEWoui07Qr88WiPV3JIyctcc2k+KwmYjPcmofZHmstAXVg/crR96Kw
 OQElNeGQGuEWdPy04D349WHNjx0zBztqh6kov9VCf/mT9iim+bN5GplhU3LR6GWoXudh
 id0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758634082; x=1759238882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g2ytLt4ya89YgSIixUbuNVW4syTqO4o7/lQfNXoVqns=;
 b=E12Q2ewo5E5wZsBa4XXqSr81sAvgTv4xU3jJjtD6HcGVSzgRvy60c+CtQE/p866R+P
 w4G3NquCbpOBysIxucH9Z608n2jG2hWwFvX+R+I9P7RNQUlVB/cFCs+skYopTHogw1nP
 aatTQNOudeNyfjDVDRHR6sRKrMzPpHr8aurnUBR3PBJDZ2x1L7W2R5hTt5VzXbZZ4YZc
 jBaEPVUvVzXqPSAw0/QH56hImP3mpfWi1XqmA3WI/6aJlZTMXRS+7ocHRoKdQRJTkHh1
 u5wcmkzBqDr7Bo2oM+eL389FN1b460wvaz+dx+eZkRdyMIwt9RpVL8Ppc6eSkrkwSxmK
 k3WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl9wGMeR/u03jmrVmKqUj3rtqRUulyOZyX8XHmfWQJGZGBdbWgmf1VFkWCLoH+KjNy1Ns=@lists.linux.it
X-Gm-Message-State: AOJu0YwoCm8/6wyrceU5Q+XmSt85TPVP6rytd/NGhBqQS9jFGX9FIUN5
 E5O7k2u0AQfzxdyTJSpBfdI8rU5KP74RVRIMWOjhuGA68+ozkEwDodpXHZXsmK0ZPlM=
X-Gm-Gg: ASbGncv8Ytk5w6fsoVGV7ygQFCyYxDOEQLYjtaelwksFWTohH/X2Wlbl3QwGJ3Or9JN
 ReRHozy2EztsUBULtwwMnXBefCjJAWgBFOaRw37u9xMxRZVSLGzAb/LBpko7+hXQIJ1598Ew3dq
 fLHyPf9l8L6MLjSFWwFCO1Gx9qD+7YnLoEQfv2pyiZEn/Rnp4K38WzHQR83o/bWb3Ix05MHUGC1
 EIGQ6P+8Ams87Mndto0tXjuoMqurySH/3YDxxjTCJurOUcEn8Gkko2qB0DGZYoaZFcrT/6FqPlg
 Fq39UoWs06fa4RQGPpPOfI4dUUEMZ+0QUj4KEfzZBQkPJKwF6wudekyMECxAyrFLCrc8oHNl62z
 LZlPeigcwAZXF0w9uxtOEzdiDZKA8jVvhBA==
X-Google-Smtp-Source: AGHT+IEKI/IVOXkYgq2dm16hV8xLNm2thAizwJriSRaqdNRDtRrrI9RtMST1KX8m7ropRQ5oEAsN/g==
X-Received: by 2002:a17:907:3f29:b0:b0d:416e:2892 with SMTP id
 a640c23a62f3a-b302ae300c1mr251966566b.32.1758634082396; 
 Tue, 23 Sep 2025 06:28:02 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2ac72dbe92sm608835066b.111.2025.09.23.06.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 06:28:02 -0700 (PDT)
Message-ID: <cf70fa4e-bb16-4db9-9137-820caf04f545@suse.com>
Date: Tue, 23 Sep 2025 15:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250923-cve-2025-21756-v2-0-3bb1a6363123@suse.com>
 <20250923-cve-2025-21756-v2-2-3bb1a6363123@suse.com>
 <aNKKtXeaxoAfTsT8@yuki.lan> <87878992-ee9a-48a3-93a5-7e38bcd65bc1@suse.com>
 <aNKPrUbjC3-oftGI@yuki.lan>
Content-Language: en-US
In-Reply-To: <aNKPrUbjC3-oftGI@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] cve: add test reproducer for cve-2025-21756
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


On 9/23/25 2:16 PM, Cyril Hrubis wrote:
> Hi!
>>> So this generally works all the way back to the oldest LTP supported
>>> kernel? I would expect that we would need an EINVAL check here.
>> AF_VSOCK were defined in 3.10 (d021c344051a VSOCK: Introduce VM
>> Sockets), so I guess we are pretty safe.
> Ack.
>
>> Should I merge it after the Review-by, or we should wait for the release?
> As long as it passes the compilation CI I would be inclined to take it
> in. The pros is that we get one more CVE reproducer and the cons are
> that we add one buggy test, it shouldn't break more than that.
>
> However that should be the last non-fix before the release.
>
Merged thanks!

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
