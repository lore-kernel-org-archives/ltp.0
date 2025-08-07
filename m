Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96436C87FCF
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 11:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754565968; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=BviUOabEFR+RqlANPLvEDDtBD2LUnZSSUXwiuapSPGQ=;
 b=GrtnSFQA+LYmnWzm6g1Egtf75kTL19qWXZoxDNwxwAkLoflY8sn0GAxAbvh5S8M8ZfTve
 ABS6dOScValEcGNZ9IP43d139YoOmQhldzczQKMT0N/maMhZGVOtPzC4NlSYH11WqYOKLLs
 +XErEw5ITP03r3hmt0TfDh8gSntLEkc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADA7C3C99A9
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 13:26:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 909B43C9970
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 13:25:47 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93293600541
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 13:25:46 +0200 (CEST)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60c9d8a169bso1508753a12.1
 for <ltp@lists.linux.it>; Thu, 07 Aug 2025 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754565946; x=1755170746; darn=lists.linux.it;
 h=in-reply-to:content-language:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhWQVKPev69Vg3LNBTsG4JZGOFSvmhEYXMzSTcxqHeA=;
 b=P8KhwG8Ors9YNkMDEFBKd+Xzz5+f2z5AP4JKNvM5gpJZQVhU+UJOs4c+xLU9/mme+n
 YOi/RINRb6Mt6bsAhywyjCi6W+SxMTKGnxnW//qzuj4qXfMTasJxT17F5kxC/fsCnLRj
 hYaGWpgW80IyRT6vuQTeTsb8rMPbXDPc0/pWcQNcB0AuvMqeD/YzoN4mzmVP7K+/QCGo
 GA8E/vPPEMxsTjlhCFqbtmRPYuZPc34wEVb5c8uWCWLkn7pMkEdV6AE0TCVWz3PqhI0O
 KnIP+CPA2mze/s7Y+rYVcg1KFkXZwVvpK9EKxSPp0B3O/9Babf7lnr/LZjEYeux6hPfQ
 P6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754565946; x=1755170746;
 h=in-reply-to:content-language:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qhWQVKPev69Vg3LNBTsG4JZGOFSvmhEYXMzSTcxqHeA=;
 b=k1Yvr2srRud8XH11gSNCBSRy3IfknC66c1tS+hkca1fj6KqvKpiZSetwsxbUvWkkFd
 sv5mdsvgS2PTeiYSYzziqy+iTaiwywhfDA9U/udD5JnqTt56PoMXLxo4vzi7FRd29yqy
 C+PNhOQKHUFn40RsDhujY9bd1EKxPmTP62wwuXEjR8RnCcf9ZdO+E4J3ruR7m0toNJPl
 FsOBOYQjE99rmGtO4ZJN79Axw901m35nOJY32lliUJn29Ig3R8gmcd6DdBh7fiHXUwM9
 40DfNz7oxcHEZmB/5jMyEU+CuF1/7F5MiVrNTsMGXZCgldoNILeBbOVFy03//nw+pakl
 59fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9UAHvp0xyQkMPbqrNz9qYS4rCFw3xNGM/q6ioCyaBet5/2sTrxPpC8S8TolMW6y2ao6A=@lists.linux.it
X-Gm-Message-State: AOJu0YwAJ/IlIWAA2ipgM3hAfDIjz09N2rJKw+AwwOLsSdzQzRkrJ3eg
 k5DNY4cZTMfLU176rsYgPdwIMhhM/KGcsxEI96AtA+VcQGvnaG6KiO8oRhYs9gRELZw=
X-Gm-Gg: ASbGncsoXzZANITowyYFG/pyri6l3aYGLkitgMbf4Ex9YRq1PEh5GqLunUNMFFbz0Au
 ISQ/OgbbGqJTlvs04+f4FBuqyA7yGdVSpu6B0jNBejwBOSEfUj+GTeQBRykXMz4gEM9i/8ToJ9l
 9cRH/8CAX+D7MkfrA2vwrxFnHeVN963oXrh2D250p+boIlHEidJJww4t8eeVvVgeM44lhbWD845
 qzo66Xw8ImdAEk518LvEIvRYkDJr8Ye44DzgoHY+tCKVSe85c6VSLGKxnQVUj0gO8KEnYO9AcAS
 M+4zq/MicBpW43QK0qljMuBNkZWUg1kRoM2FMfc9w6NQy9TmYvCtpfuNPIjZxivI6RcDso3b9OG
 ii3beKrKUbzgDLDuepkVZkY/++PJRfBaXmw==
X-Google-Smtp-Source: AGHT+IERQ5C03hZePv+2exqa4kyUT8cCNKtYSY0hKhrNgSfOyuqjIzYSbgd5atbgY9BoGkR7ZW7R6g==
X-Received: by 2002:a17:907:9806:b0:add:fe17:e970 with SMTP id
 a640c23a62f3a-af992aa34c9mr560230266b.14.1754565945849; 
 Thu, 07 Aug 2025 04:25:45 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.217.151])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a0a3b58sm1288654266b.58.2025.08.07.04.25.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 04:25:45 -0700 (PDT)
Message-ID: <f4e3e9c0-4801-4345-b02f-0336735516a8@suse.com>
Date: Thu, 7 Aug 2025 13:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250806-conversions-lchown-v2-0-345590fefaae@suse.com>
 <20250806-conversions-lchown-v2-3-345590fefaae@suse.com>
 <f43c5015-fe20-485e-b3d1-23377e8c6afd@suse.com>
Content-Language: en-US
In-Reply-To: <f43c5015-fe20-485e-b3d1-23377e8c6afd@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 3/4] syscalls: lchown02: Convert to new API
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

Ck9uIDgvNy8yNSAxOjE4IFBNLCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+Cj4gSGkhCj4KPiBP
biA4LzYvMjUgMTE6MDcgUE0sIFJpY2FyZG8gQi4gTWFybGnDqHJlIHZpYSBsdHAgd3JvdGU6Cj4+
IC0KPj4gLXN0YXRpYyBzdHJ1Y3QgdGVzdF9jYXNlX3QgdGVzdF9jYXNlc1tdID0gewo+PiAtCXtT
RklMRTEsICJQcm9jZXNzIGlzIG5vdCBvd25lci9yb290IiwgRVBFUk0sIHNldHVwX2VwZXJtfSwK
Pj4gLQl7U0ZJTEUyLCAiU2VhcmNoIHBlcm1pc3Npb24gZGVuaWVkIiwgRUFDQ0VTLCBzZXR1cF9l
YWNjZXN9LAo+PiAtCXtOVUxMLCAiVW5hY2Nlc3NpYmxlIGFkZHJlc3Mgc3BhY2UiLCBFRkFVTFQs
IHNldHVwX2VmYXVsdH0sCj4+IC0Je3BhdGgsICJQYXRobmFtZSB0b28gbG9uZyIsIEVOQU1FVE9P
TE9ORywgc2V0dXBfbG9uZ3BhdGh9LAo+Cj4gVGhpcyBpcyB3ZWlyZCwgd2Ugc3VwcG9zZWQgdG8g
cGFzcyBhIHBhdGggdGhhdCBpcyB0b28gbG9uZyAoSSBndWVzcyAKPiBiaWdnZXIgdGhhbiBQQVRI
X01BWCksIGJ1dCB3ZSBhcmUgcGFzc2luZyBOVUxMIGFuZCBvYnRhaW5pbmcgdGhlIHNhbWUgCj4g
ZXJyb3IuIEl0IHNob3VsZCBmYWlsIHdpdGggRUlOVkFML0VOT0VOVCBJIGd1ZXNzLi4uCj4KPiBA
Q3lyaWwgV0RZVCA/IEl0IHNvdW5kcyBsaWtlIGEga2VybmVsIGVycm9yIHRvIG1lLgo+Cj4gLSBB
bmRyZWEKClNvcnJ5IGZvciBwaW5naW5nIHlvdSBDeXJpbCwgSSBkaWRuJ3Qgbm90aWNlIHRoZSBz
ZXR1cCgpIHN0YXRlbWVudC4gWW91IApjYW4gaWdub3JlIHRoZSBzdGF0ZW1lbnQgYWJvdmUuCgpX
ZSBkb24ndCBuZWVkIHRvIGRvIHRoYXQgaW4gc2V0dXAoKS4gV2UgY2FuIGRlZmluZSBtb3JlIHRz
dF9idWZmZXJzLCAKZWFjaCBvbmUgd2l0aCBhIHNwZWNpZmljIHNpemUgYW5kIGFscmVhZHkgaW5p
dGlhbGl6ZWQuIEF0IHRoYXQgcG9pbnQsIAoqcGF0aG5hbWUgd291bGQgYmUgKipwYXRobmFtZSBh
bmQgd2UgcGFzcyB0aGUgcG9pbnRlciB0byB0aGUgc3RyaW5nIApjb250YWluaW5nIGJhZCBkYXRh
LgoKLSBBbmRyZWEKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
