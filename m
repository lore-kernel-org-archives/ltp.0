Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702EECD4F5B
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 02:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779244327; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1hnFmf7lkZkUm2yXCr8Q/Z9EiJWPPyBDZxbzGNY36tE=;
 b=SDc8vaS/LZCUzC+SDh5HEzlgfNd3E6XCsHHMVGUkinBN5ZyvclrVIxaN6G/ijUUrpQXvI
 Nqf/qtJYEeBpZ4gv5VKVqVtlVOQ7S7+IobizCItsgcpP5xKHt89sYrD+2UZQvBdC9wwIDBE
 u+0iPvv3Xs+eIXnuKgDeVOyZ6cxlGBQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0E633C728E
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 04:32:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B42D33C70F0
 for <ltp@lists.linux.it>; Wed, 20 May 2026 04:31:43 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4838310001FE
 for <ltp@lists.linux.it>; Wed, 20 May 2026 04:31:43 +0200 (CEST)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2be1dd4af34so25285975ad.1
 for <ltp@lists.linux.it>; Tue, 19 May 2026 19:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779244302; cv=none;
 d=google.com; s=arc-20240605;
 b=QLw9gcYNf+PMX3oyyLCdH2wEjOLyC93qdQklQFemtjI4ELnKQP03zZNg7/3MJ6Ildv
 wZLgXel61XXi0VokpxPnp9ddPf29TVVk4wo4IKf9nuWOaPqwsKEbvJyL56ZDGdDnFGFG
 qqbBNk7wlNDShs0R5hnpLUUEWBhbd9fSwqoUcF+WymFwV9R8isvfGYMVWZtFEzAMNHbo
 /jGdVQUCDm0Znqp+XPaKnTS6ygBvl2XoY/xCxLRcbOwFGS0HjmHdBynSRPqOCmH4j+UT
 KhEWe1hgJ/xVTCCxf/1moG4RWfEnFn+vcrPQ2zAqfqZWYtmDV9hhzU7RIDY9Y9YWr4DE
 9tVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SCyE+pDvTk7tZz9al0Wncn1Sucp0tQsaesXoUUCGTnM=;
 fh=DeL8n+epdQxsfTi8Vh/tjBJoxUI2BtafQmk1xhe3s9s=;
 b=FrYot09hF+cM9sYpuAfv+fsJqmO/Dnsy04SY6g+oaCgiJ+8S3NotPTZ8/WL/Timl2X
 HGR1wP0KTNCbYRTcNTTLSRbn99PRFQkqlBdruf6cs39N6sTczsgjcJ/F3DbUG4xZBQQ7
 fF6Q4Pc4EGFZ1nvyHM8nH0iM7FKB3iDr4jdcqbELD+X43OShKpmYasmi2tJMCEn/k3Wc
 lU7LJ84hIuAsnt3n90t3pSYDE8EslHvsr0933i9c9JK+LPzxVyXGnF/Ge3tToP7xvbIt
 6/oPEPkLR/yOrlNveL4K5uOO6TrbMHk9+gqj9vApXfQhI3atRUMAW6egFsB1YnSdaart
 WjDw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779244302; x=1779849102; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCyE+pDvTk7tZz9al0Wncn1Sucp0tQsaesXoUUCGTnM=;
 b=UgEFQCWCMhaaSQ/ArQvMb0H2jyGMtsz7RqT/4t5hPSgTXIpoGQA1sJDJoA/LTZPxkh
 Qskz2+92r9pNMC7hxg3e3BJPztypzKWBtS0w8d2UNRn9ODmQJCylVswZourZkOm2j7lQ
 FOn68elFRoBrx0jkTLXh4dwnqnMWb4UM9SM8ZT5zYyZMugIcgx8eQ1FW3wJAxupBB4ET
 VzkwsnKuDOdWqGFSC1IvpYEQrawAMD0O6To/AFlnBZAaffGatVrF22DkTkv0mEDGVbEB
 UUK4dVxuc+OgjymzT022LU3nSVNyHjy3eJ/WryMP6VKJvVCV6xMcSoGxuJa/YAXD1JzR
 f3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779244302; x=1779849102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SCyE+pDvTk7tZz9al0Wncn1Sucp0tQsaesXoUUCGTnM=;
 b=A57mxh2aS0bOd+talPz8NJysQv+JfQxg3k3iDtMVk6a0UqEfAyjkdtAVzr5GKmrr96
 G/cHyLYX19iPOrfkNfAVfCLaQa7GjZ3PxfYGJk0IftdztrOmi2PtPQh0YE37mHXQ8Hu+
 N3/ufJ/7z5yMihyFNuux3no5Yv+uX0jxoti9CATf/QHV4jFYs6jqvbgB3Bjgh1zKcYeH
 IGk6V255+j5SjW7+sLqk+u/x17i9gwu9mm049J7K1mjPL4rFHq7xbwLgovwCcsRNjt3n
 IIkjVPe9jokgqBQiBXmxYMLU0U3cmPKwTlnvvfKJIWhu2n4KoxCHj0cO9xesDK+q1nXu
 mu7g==
X-Gm-Message-State: AOJu0YwVXwBZf55JFdVRHvXk7JX0aMsI4dJPGZ9ujR0xMKxwNk6gUBN6
 LBdF0aFjZrKXvGEjccSlo8olJ7Z3t9GzaxobUi39k1vuoOzFSb4kAZfuRC5z+vfF22a2U6wZL8R
 7PLHaweA95RCuN5EvVu9zhKR7sJWy+sHztiTlrDh6
X-Gm-Gg: Acq92OEkMT1s+9YNBk093ZmrvAwNarOYxpHRx+bR3+A0MRQ+b3p8P6OuyQHP9ZBPaQ3
 zjJH/J+YdM/jlTzd04m6DjAdM2bbHapgPmIUADhSOt31gVmVJfhjJNLOlHi0oacT3/3DYNgzCBa
 5iDJPWIogClDb9X7mP379i+OyaE/GsTTNz0i4pfd6zcp86G04Ee9PQcj6Vf1nvNQP/FixBIakMu
 eaI8XpNv9XOglqph94SmPCeNZp0lhxJY2UdLZd3wWSCLQdAKUKoXr1NZjATvO3WVyBSdGBJFckO
 8zVV5xWX+TGaY4OpuZ6lGM2HveriyZ4iBsYeyUzT3TTUGcA=
X-Received: by 2002:a17:903:38c7:b0:2b2:ec46:dfd4 with SMTP id
 d9443c01a7336-2bd7e8c42c1mr235971835ad.22.1779244301085; Tue, 19 May 2026
 19:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260429062650.3191021-1-wakel@google.com>
 <6a0c81fa.01f20405.13968a.5199@mx.google.com>
In-Reply-To: <6a0c81fa.01f20405.13968a.5199@mx.google.com>
Date: Wed, 20 May 2026 10:31:04 +0800
X-Gm-Features: AVHnY4IzibiHZ4qLBVSbMNYe0IV0H6rgkx5pt22wnGsE5_cFa5ugLB8VviyXPfU
Message-ID: <CAOcRiAHp=VkOgxFvOV+Rswpkv+Fv3CjOFC2n3kcDWTdpVVxn6A@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/file_attr01: Dynamically expect
 EOPNOTSUPP on tmpfs without xattr
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhhbmsgeW91IQoKCkFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+
IOaWvCAyMDI25bm0NeaciDE55pel6YCx5LqMIOS4i+WNiDExOjMw5a+r6YGT77yaCj4KPiBNZXJn
ZWQsIFRoYW5rcyEKPgo+IC0tCj4gQW5kcmVhIENlcnZlc2F0bwo+IFNVU0UgUUUgQXV0b21hdGlv
biBFbmdpbmVlciBMaW51eAo+IGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20KCgoKLS0gCkJlc3Qg
UmVnYXJkcywKV2FrZSBMaXUKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
