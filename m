Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13FAD2B921
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 13:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730811599; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=wGB0py1KbVuV+yc6clMXa5aQ1EsujlvhJeR2PMdLa6A=;
 b=m46qCiad0Px/iVsAR90c50RTgjyREz1BB/sCSOp2oV2g9NsblpfG1BZpHfj8E3AW12aeX
 QUWLEYnOH5gaCYADBOGnEt6P5Jpdc+qkdqpsGhpDi5VXh4FAXQKfWJr6/x0uYOMUw/A44wz
 JNSxeqZgCVvctEIN7TGvU1LtCAj9xM4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EA463D21DE
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 13:59:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A4553CE325
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 13:59:39 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BE11111E8979
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 13:59:37 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43159c9f617so42856225e9.2
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 04:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730811577; x=1731416377; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HOJMxpMreZfY3aZYclKPg1hLx8L7qCpumID3z2+QEU=;
 b=GmBtLv2/p5I/OxmlgD/EIV2q6sJ+vf6fO7YUOozogwf0tfqt2g+TQxhfz9QAotwJsY
 YiG0VKubHGiwdkSCk5cW13ssBuPJhTD0SO/WgNjujJectos4vN3z996zlU5JIZPI2XaF
 u1EXopcbKhAXEu70kEWCytxNaW8iQprWh92AptOt9k+MpxBA8j9xts9q9ybdXU0ApNDw
 hnUTGNMgnrXlvqQKVRK9Go1hy2/Zgqs4EzwW6jaZfgehvr1lFr4QtGxI+95upt+lQ5z7
 vrup7zlvc0lJfnKUQFCR3lNUhGUw66jLMl8dJsaL9rzhMfp//wcTy9fhjXo6BH7D9k8N
 lQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811577; x=1731416377;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6HOJMxpMreZfY3aZYclKPg1hLx8L7qCpumID3z2+QEU=;
 b=xUmIOkr0+sLE4mTPlMqoVIH3J5qd9z+BkQjQDzJX1OrvoG7c/pVHy+GwAOuoRy9AyL
 AbmEDAf3ecq3cW+q/FP5+TPKNBXYUt5rIAiL4TNsR2mcTvk+3HUrXwBwjUtdTf8JrNS/
 oKum4Of99QaZNhLm96KU4aiqKxxbNsr6lh3R8jyArf1j8PQBperEmmEkLhJlfrpYFQxT
 csTDqIreWeAV4qXw9eFf7mipGzDipFTDTZLePjqwHD9VK3GwGhGDXY71WEeU4P1UMffT
 F7dkZD3oc3RoKXJ12cZy3UZXQxCltKajRmleFAcjYFd0s6eGonyvtrchZEd3eYvQT/2F
 w06w==
X-Gm-Message-State: AOJu0YyZLKpp47S2uNpBTqRyjsqlbZ38reNp+ZxXiQXTV1rZ/ZmyZo8e
 7U02a8E8x0UK81kWJ4GuX4BFafjNTDGv+KY6WPhsiayTjQkvyg6Cc9Q4AgrjeGs=
X-Google-Smtp-Source: AGHT+IGFNq2flqM7YTLPDAbAOyReyRkD5HxnqrCrNSffrVSWWasFup98oAILSjc6qDkZuTXVUwWP9g==
X-Received: by 2002:a05:600c:500a:b0:431:561b:b32a with SMTP id
 5b1f17b1804b1-4319acb8ce7mr319378815e9.19.1730811576925; 
 Tue, 05 Nov 2024 04:59:36 -0800 (PST)
Received: from [10.232.133.32] ([88.128.90.60])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e7f33sm217248535e9.6.2024.11.05.04.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 04:59:36 -0800 (PST)
Message-ID: <a5e05496-76c0-432c-8779-84ab573a8b7d@suse.com>
Date: Tue, 5 Nov 2024 13:59:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
 <20241105-landlock_network-v2-1-d58791487919@suse.com>
 <CAEemH2fCcYOzMhFHhQKL_=sPK1Q_RZp6H+jWW-BGuJEc7Xv1Yg@mail.gmail.com>
 <CAEemH2fTYRM_OC8szbFtByrdB_u9yGTKzMLhMKT077mmML00qg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2fTYRM_OC8szbFtByrdB_u9yGTKzMLhMKT077mmML00qg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/4] Fallback landlock network support
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgpPbiAxMS81LzI0IDEzOjQyLCBMaSBXYW5nIHdyb3RlOgo+IE9yLCBhbm90aGVyIHdh
eSBpcyBqdXN0IHRvIGRlZmluZSB0aGUgbGF0ZXN0IEFCSSB2ZXJzaW9uIGluIAo+IGxhcGkvbGFu
ZGxvY2suaCwKPiBidXQgb25seSBkZWZpbmUgdGhlIHRlc3RlZCBBQkkgdmVyc2lvbiBpbiBhIHNp
bmdsZSB0ZXN0LCBlLmcuCj4gbGFuZGxvY2swMS5jIHVzZWQgbGFuZGxvY2tfcnVsZXNldF9hdHRy
X2FiaTEsIHNvIHRoaXMgd29uJ3QgbWFrZSBwZW9wbGUKPiBjb25mdXNlZCB3aGVuIHJlYWRpbmcg
dGhlIHRlc3QgY29kZSwgdGhleSBrbm93cyB0aGUgbGFuZGxvY2swMSBpcyBvbmx5Cj4gdGVzdCBh
YmkxIGFuZCBkb24ndCBuZWVkIHRvIGNhcmUgYWJvdXQgdGhpbmdzIGluICdsYXBpL2xhbmRsb2Nr
LmgnLCBXRFlUPwo+CkRvIHlvdSBtZWFuIGxpa2UgaGF2aW5nIGEgY29tcGxldGUgc3RydWN0IHdo
aWNoIGlzIHBhc3NlZCB0byBhIGhlbHBlciwgCnRha2luZyBgbGFuZGxvY2tfY3JlYXRlX3J1bGVz
ZXRgICsgQUJJIHZlcnNpb24gYW5kIGdlbmVyYXRpbmcgb3V0IApydWxlc2V0IElEID8KClNvbWV0
aGluZyBsaWtlOgoKc3RydWN0IHRzdF9sYW5kbG9ja19ydWxlc2V0X2F0dHIgewogwqDCoMKgIHVp
bnQ2NF90IGhhbmRsZWRfYWNjZXNzX2ZzOwogwqDCoMKgIHVpbnQ2NF90IGhhbmRsZWRfYWNjZXNz
X25ldDsKIMKgwqDCoCB1aW50NjRfdCBzY29wZWQ7Cn07CgppbnQgdHN0X2xhbmRsb2NrX2NyZWF0
ZV9ydWxlc2V0KGludCB2ZXJzaW9uLCBzdHJ1Y3QgCnRzdF9sYW5kbG9ja19ydWxlc2V0X2F0dHIg
KmF0dHIpIHsKIMKgwqDCoCBzdHJ1Y3QgbGFuZGxvY2tfcnVsZXNldF9hdHRyIGlubmVyX2F0dHI7
CiDCoMKgwqAgY29weV9ydWxlc2V0KGF0dHIsICZpbm5lcl9hdHRyKTsKCiDCoMKgwqAgcmV0dXJu
IGxhbmRsb2NrX2NyZWF0ZV9ydWxlc2V0KCZpbm5lcl9hdHRyLCBzaXplb2Yoc3RydWN0IApsYW5k
bG9ja19ydWxlc2V0X2F0dHIpLCAwKTsKfQoKSW4gdGhpcyB3YXkgaXQgY291bGQgd29yaywgYnV0
IHdlIGxvb3NlIGd1YXJkZWQgYnVmZmVycyB3aGljaCBhcmUgcGFzc2VkIAp0byB0aGUgc3lzY2Fs
bCBhbmQgbWlnaHQgYmUgdXNlZnVsIGR1cmluZyBkZWJ1Z2dpbmcuIEluIHRoaXMgY2FzZSB3ZSAK
c2hvdWxkIHVzZSB0c3RfYnVmZmVyc19hbGxvYygpLiBAQ3lyaWwgd2hhdCBkbyB5b3UgdGhpbms/
CgpBbmRyZWEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
