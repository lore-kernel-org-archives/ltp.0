Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DD6C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748345350; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=WJm+sH4hrDr91hc/DY5AFmBzeN+KSofZiAQOqIODDtc=;
 b=dzupA6U4qW4wnry83oPsY5wCQ3s883aJIXe3VYy1Zf6+eDFZWScicbK27nFOV4xhNOCYr
 3nXOsX7SSCxnodLv3kYvzleMPNnLTtU3lOGTx6YY+YdIQ1/4lC+1J/Kd4+AnYcGWKrh2vOC
 zZ2R7DYcQwS5beLgkdHM/d1aZ42XUxg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D092F3C58A4
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 13:29:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 810753C0487
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:28:49 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B3EB51A0042E
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:28:48 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4c4e6a0ccso2434852f8f.3
 for <ltp@lists.linux.it>; Tue, 27 May 2025 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748345328; x=1748950128; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z+FETO94jtoKt/neHw0bMKHAYELwd1kI3c6hYFtTIr8=;
 b=dWFuAYlSrB9g5nbSNERdlXpHkwPRJV7cjQbyuizfYYEbNsSQiZM+x8FgajvGiQAYOY
 ehXeksXuCZJ5a71fBsUqmI/rsaxtIZGxKysPHxWOcHR+Y5NcODGSBJoSl7qz6G85lSuK
 c+ELxeUC1bNNO9Ex7noD0IC3TEAdOe3brECwzfoLd8P9t04+ZH0n2gZD0uqSqABQf7rI
 6SVPRN29T33VwtZsG9jvqlF22nz5bQ2zxktk9xHte2VEZFA//BmagcX2vlRo1ilOpug2
 t1XtJFaB50TXQw/PjzUgvIVZb8vF9pIv/leSpEyYJosRhczPjLh/fm9kqnDPdGgX8HSg
 THJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748345328; x=1748950128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+FETO94jtoKt/neHw0bMKHAYELwd1kI3c6hYFtTIr8=;
 b=Mc1Af+d5bp9w5rAR8tJvP0JTuKN9ZpwUPPTZ0aO2Wcnsw8pc+nXtLe33b4X21r6XOs
 8WlIsbjAZLGWYt4QXWw83c04jxnmENftTxYahpqMAzxY+eLLahxfgZRR3VzxbaTBO3TI
 mt7hLTwe/TrkVpJkb2mTUrT1l3HFE4fKu3szL/CcFcONnaC3y/LcVZkBMbXJND6ceJH9
 pdcqmlOkOvmRxrot+XjjfWPzHlhFuzhKDGKMMXJUtKxha52YhokdStEKE1V0GLcHDlE1
 JW9noMAB71dhK5ABnFNlPg6mmgx1l0C0tRHrji0F0eRiNyzGie1kW214PPlpnsQ+Necb
 OXJg==
X-Gm-Message-State: AOJu0YzL4Y0xy8WMSCC9uALUg/5nXkl+voTP/8+YaWxjsXU7ldBzCnv0
 X0uOGTyH/o04KQ+VCorlcS3Mko92hQl3D/sljIbK1oKk9Z9MRixDD7HBm8WKM9ZtQc0JXUL18XL
 2uTI5mFs=
X-Gm-Gg: ASbGncvb3qDOUTmbAIXhGYFE27qpkTsHOXm4wYLI00P+vEa0I7qGIW77RLH+Q/xy0Sp
 ao09wocrXPcYbtfD2Dkiiy7/lyp9YiAafafR9mq/9L9PaESpdufR8E8ql6451q0huEhxVrSUE/4
 xsbd6ysjGUvZ8Z83a/lWA9UL1YwykmTyJZjD1Z2RN4b8EYigdAkkz1eNB31Rptw0xfhG97s6N/6
 fPFY6ZMen44E6sHt9e4NoCAMirH7hb6DW+nd7qoen1VDiqiDne4wfkoe52bW3FaIClfxcr1Xxsn
 RDhq/DhI/87tFke+jueJC6E0u86mNquVlxSklDQJ28uoyQep/7r/JFrXVANCvg+PvmuqQjek
X-Google-Smtp-Source: AGHT+IEqjTpWfvWdanodUc4VYET7eJJ17R9rND1j+tpu/AD13CjYTpit8MKRY5lKS0HDCzGwX51/yw==
X-Received: by 2002:adf:a3c1:0:b0:3a3:6af1:cc88 with SMTP id
 ffacd0b85a97d-3a4cb49df92mr7413120f8f.46.1748345328184; 
 Tue, 27 May 2025 04:28:48 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74618d72897sm2778185b3a.169.2025.05.27.04.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 04:28:47 -0700 (PDT)
Message-ID: <3f1d0ecb-2d7a-4879-a009-2ad078b22802@suse.com>
Date: Tue, 27 May 2025 13:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>
References: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
 <aDWfrkuuohllNO27@yuki.lan>
Content-Language: en-US
In-Reply-To: <aDWfrkuuohllNO27@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Reduce .runtime for Long-Running Tests ?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gNS8yNy8yNSAxMzoxOSwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+IFRoaXMgaXMgZXhhY3RseSB0
aGUgcmVhc29uIHdoeSBJIHdhbnQgdG8gaGF2ZSBxdWVyaWVzIG9uIG1ldGFkYXRhCj4gYXZhaWxh
YmxlIGluIGtpcmssIGUuZy4gImZpbHRlciBvdXQgYWxsIHRlc3RzIHRoYXQgaGF2ZSBydW50aW1l
ID4KPiAkc29tZV9jb25zdGFudCIuCkl0J3MgYWxyZWFkeSB0aGVyZSBhbmQgaXQncyBjYWxsZWQg
Im1heF9ydW50aW1lIi4gV2Ugb25seSBtaXNzIHRvIApjb252ZXJ0IGFsbCBvbGQgdGVzdHMgaW50
byBuZXcgTFRQIEFQSToKCiQgLi9raXJrIC0tZnJhbWV3b3JrPWhlbHAKLS1mcmFtZXdvcmsgb3B0
aW9uIHN1cHBvcnRzIHRoZSBmb2xsb3dpbmcgc3ludGF4OgoKPG5hbWU+OjxwYXJhbTE+PTx2YWx1
ZTE+OjxwYXJhbTI+PTx2YWx1ZTI+Oi4uCgpTdXBwb3J0ZWQgcGx1Z2luczogfCBsdHAgfAoKbHRw
IGNvbmZpZ3VyYXRpb246CiDCoMKgwqAgcm9vdDogTFRQIGluc3RhbGwgZm9sZGVyCiDCoMKgwqAg
bWF4X3J1bnRpbWU6IGZpbHRlciBvdXQgYWxsIHRlc3RzIGFib3ZlIHRoaXMgdGltZSB2YWx1ZQoK
LSBBbmRyZWEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
