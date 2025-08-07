Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03446C87FDA
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 11:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754565545; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=bFIbNAqlva1eQ+xjHSzqfhNKQn21VEVGiL0QUAEK/QE=;
 b=G8NmVGk2C8bu8ZIXl/9v7q9wcz8Mmda04moAsKn4Pb6Vt4hmb/NB0NHO69tqL/WuiKlrA
 Z1riHgCzTaQ0Vtqph43OV+loYtDu5dHfNBAwMAmuDmmf3maUTM2pOsuSpCmpBgWkocanmjQ
 ztEhb/r4hWg/Fv0jI0yEBUO4V4DjCnc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 409A43C742E
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 13:19:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7AFE3C742E
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 13:18:44 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EF41B60083E
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 13:18:43 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-617c40825c9so971658a12.2
 for <ltp@lists.linux.it>; Thu, 07 Aug 2025 04:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754565523; x=1755170323; darn=lists.linux.it;
 h=in-reply-to:cc:from:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HT9EMdP8hTeO+e25M5j5CewMvN4c5Z0wML/kho98bEo=;
 b=DxPN9EuAEwjxuP5ujnF6vYpB/9L1lIQcLtWdrCjP6r8UdYJGBX1AddW9aWvBvXqCrf
 3KVh8uJRMwO7Lzc8slvj0hIrys6W8wjnyELefqWe7WKnxc/cT+Opin2a0FFfn5+cTmj9
 cyK/f44NLUsgoIYgP8QLAYiGmbJsR18CPtBw7pyPYsL7FdBmuhteN+p01o75jqBZcDRr
 FVoLpsTW5rNbxNpEU8/7ANnftoM2KtxSEYZU845yZIKi1bkT3rPnyy9CL2xjNKdyXhps
 1XaT+26tTXm9jBVZOz/ncDiXsKH5dbGJs4zt9/QwtyDumhOyY+nIdP5tOOEAMyyCutEE
 jaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754565523; x=1755170323;
 h=in-reply-to:cc:from:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HT9EMdP8hTeO+e25M5j5CewMvN4c5Z0wML/kho98bEo=;
 b=mihpwNL0ZvZyaJOxWyF2SOtOqQmbH7jLwu7Cb9GqxYUUA05rSET1XYXeYSmXcrvu6k
 pNxdqnKTXO4h3E8VT6av2tu1JgvqXxTDRFM9uSSL2PWf+57QGNaFxYUigkwlJxUh+t2x
 8USfc/e4cEcvnt52eriVDkj5VapYr9fzI9d8gV9qNJKRairmZsDa735jLO4rMKXv6qg5
 Zh+W4/venHNRu1G59eeU/RNGTcLRkaP344FHKIj/hBNdeT6u4PsT59hof22n9JkLqUur
 Te5Oz0sQw/9MnP7WaGk6i0ZViZjyPioGWpiI2EuQpW3nU9v3NGchbCHARWah1TjfJ1le
 TCdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV12xHBwUbBh40I5kwf0MZA9BrcnMYB0JZi0lFy6yBxGBllPW06izUNoLP9SdDWySxKOIg=@lists.linux.it
X-Gm-Message-State: AOJu0YwoIMdzWNrfy+Fu2COQpLlz/a3LxPrkYazVpBix2rHiCoRPWCPp
 lMbYh/fYpYPx1L3ry8l88+G4WvaN7jDdQl5vSuZr3m6zHftdc2NbVRIYssBXAQhwC30=
X-Gm-Gg: ASbGncsqzzRixN3wTYBql5jt0TMcV1GknuvEGlM28864uqrM4zJAfGU8F7xWzcCpiRA
 LQNFOWzR9WdBomSE7hDU755/ReggQqskZvKoiiZHIlDcwlUIGnhXIyhVlapdVnZpc7to42cKHLH
 nXkFNXhXvA2ApVhgkirKvMS7jTKPhUXny1a9rEWs669wl68FeXoVtWOLblmzYsEYk1k0N44E3dn
 QKWQ+WdEmXVoyO1qGGxbDZavBhc3gJ3dwCxoD6oTw47tKnN/Ca81907n7BPfhiKVTYAukuVdDrl
 GwXELAPCD7MfaPZE7XPIBn9ZhLsEhmyTmjfG7N6oLdCdXf7kiBBcZUAV4XPFAB1c3oIEnX9SgT9
 BdnpWYDGXrGxGlzkrcK1NeRtUvlbM8Dfvk5o0nyeRmLsq
X-Google-Smtp-Source: AGHT+IFqoNmf5iZqxYgY+ajL1lRgbiatMGbMuHpJp3h+LFqRm7050eVf+7n1mIC9gC/pMPqjMICQjQ==
X-Received: by 2002:a05:6402:4412:b0:615:608a:e188 with SMTP id
 4fb4d7f45d1cf-61797e2193cmr6062401a12.25.1754565523237; 
 Thu, 07 Aug 2025 04:18:43 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.217.151])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8fe82a7sm11632613a12.30.2025.08.07.04.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 04:18:42 -0700 (PDT)
Message-ID: <f43c5015-fe20-485e-b3d1-23377e8c6afd@suse.com>
Date: Thu, 7 Aug 2025 13:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250806-conversions-lchown-v2-0-345590fefaae@suse.com>
 <20250806-conversions-lchown-v2-3-345590fefaae@suse.com>
Content-Language: en-US
In-Reply-To: <20250806-conversions-lchown-v2-3-345590fefaae@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
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

SGkhCgpPbiA4LzYvMjUgMTE6MDcgUE0sIFJpY2FyZG8gQi4gTWFybGnDqHJlIHZpYSBsdHAgd3Jv
dGU6Cj4gLQo+IC1zdGF0aWMgc3RydWN0IHRlc3RfY2FzZV90IHRlc3RfY2FzZXNbXSA9IHsKPiAt
CXtTRklMRTEsICJQcm9jZXNzIGlzIG5vdCBvd25lci9yb290IiwgRVBFUk0sIHNldHVwX2VwZXJt
fSwKPiAtCXtTRklMRTIsICJTZWFyY2ggcGVybWlzc2lvbiBkZW5pZWQiLCBFQUNDRVMsIHNldHVw
X2VhY2Nlc30sCj4gLQl7TlVMTCwgIlVuYWNjZXNzaWJsZSBhZGRyZXNzIHNwYWNlIiwgRUZBVUxU
LCBzZXR1cF9lZmF1bHR9LAo+IC0Je3BhdGgsICJQYXRobmFtZSB0b28gbG9uZyIsIEVOQU1FVE9P
TE9ORywgc2V0dXBfbG9uZ3BhdGh9LAoKVGhpcyBpcyB3ZWlyZCwgd2Ugc3VwcG9zZWQgdG8gcGFz
cyBhIHBhdGggdGhhdCBpcyB0b28gbG9uZyAoSSBndWVzcyAKYmlnZ2VyIHRoYW4gUEFUSF9NQVgp
LCBidXQgd2UgYXJlIHBhc3NpbmcgTlVMTCBhbmQgb2J0YWluaW5nIHRoZSBzYW1lIAplcnJvci4g
SXQgc2hvdWxkIGZhaWwgd2l0aCBFSU5WQUwvRU5PRU5UIEkgZ3Vlc3MuLi4KCkBDeXJpbCBXRFlU
ID8gSXQgc291bmRzIGxpa2UgYSBrZXJuZWwgZXJyb3IgdG8gbWUuCgotIEFuZHJlYQoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
