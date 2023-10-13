Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07677CDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 16:54:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8441B3CF03C
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 18:54:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C7023CAE6B
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 18:54:00 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7356F1A00CA9
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 18:53:59 +0200 (CEST)
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-457bafdc467so598081137.2
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697216038; x=1697820838; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UenrsX5MbwRjyqhnHRV6P//x8KJwOJVev+tfBEoM2w8=;
 b=hcHBx1WSn0uSi1cTeLMP8dKN2uCQxFZikXLGd0R9Vjsn9FSYAq2/RLLNXU5fHeVuS0
 MMTx5V1zYhh8axEKfB8c1w4O/Wz5JOgA1K6R9Vim9xnBQtmWGMYBGIb0uAlWcb8pOqfd
 RQaGchV/aIWyfRzeFO4PRH/EHIK+t9giQ6VbmivdV5a+T6xhwO0yIadtBrJwPihfjGzK
 8vcnuMBP199HGxpVWuJqGpOCsLukV7EW+/FBwY1M1rRamwMSFoqgB094wvtEY0/E/DuE
 WxMDo7c0gSFfHPCsTtFYCZa54EUw3V1YfeGhIxulUYkNimpPsg1++fsIaXsHMOh2z43a
 7Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216038; x=1697820838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UenrsX5MbwRjyqhnHRV6P//x8KJwOJVev+tfBEoM2w8=;
 b=EjT9NuoQ3xTvaPBkvDKxyN/V7BINkKFvYyhmbnmnqzXaHN4xD8GDZryIHYxX++9Mc7
 idPLq+AqbtjnJj/mFc9zs0XEqROp8uQt94a7JmI+RnVzSTFvJ/Y3wMybEWClZkVXAviO
 Iofhr4lPgwsl5dStbPWoITjzZOiYvGVPiPO1I/HcT/chxa91kyV0KkqEoERBqZJG4mVm
 ri/fIKJ84GLr2zbFkGgGxMv+M/EdvXixHK3Uegg/Ur7aMUWbYtv2dLpSLHZY0dEk9gBH
 YVLb4qs9F0fopisQja+LPxX6LfNZzdT1KuZDl/6obukFChrE8gbe/i7bzu1AmjJbymlA
 6fYA==
X-Gm-Message-State: AOJu0YyFhyWLqIgdqqpf140OQVQOH0P3ONTQhIL+kF4AzXmSu5yTioSV
 hHZl7f/A10R8IjT+I6ntyuzjyhuqW2rposdsb2i8Jw==
X-Google-Smtp-Source: AGHT+IGunW9nkr39/HMSnnqsy3zHfTPQi/WNUhGsD3vAyos6IbZ6NpeB21zhi0TQaHG1JoYaVVDh8N0ewI1x40B2jsE=
X-Received: by 2002:a67:e3ab:0:b0:452:5798:64bd with SMTP id
 j11-20020a67e3ab000000b00452579864bdmr21175205vsm.35.1697216038158; Fri, 13
 Oct 2023 09:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231012180030.112560642@linuxfoundation.org>
In-Reply-To: <20231012180030.112560642@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 13 Oct 2023 22:23:46 +0530
Message-ID: <CA+G9fYvB290Nt666yUC_CJi7_hfbfkFvpwhowtd9zawg41EYVg@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6.1 0/6] 6.1.58-rc1 review
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
Cc: f.fainelli@gmail.com, rwarsow@gmx.de, pavel@denx.de, conor@kernel.org,
 shuah@kernel.org, patches@lists.linux.dev, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
 srw@sladewatkins.net, patches@kernelci.org, akpm@linux-foundation.org,
 jonathanh@nvidia.com, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com, linux@roeck-us.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCAxMiBPY3QgMjAyMyBhdCAyMzozMSwgR3JlZyBLcm9haC1IYXJ0bWFuCjxncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4KPiBUaGlzIGlzIHRoZSBzdGFydCBvZiB0aGUg
c3RhYmxlIHJldmlldyBjeWNsZSBmb3IgdGhlIDYuMS41OCByZWxlYXNlLgo+IFRoZXJlIGFyZSA2
IHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMsIGFsbCB3aWxsIGJlIHBvc3RlZCBhcyBhIHJlc3BvbnNl
Cj4gdG8gdGhpcyBvbmUuICBJZiBhbnlvbmUgaGFzIGFueSBpc3N1ZXMgd2l0aCB0aGVzZSBiZWlu
ZyBhcHBsaWVkLCBwbGVhc2UKPiBsZXQgbWUga25vdy4KPgo+IFJlc3BvbnNlcyBzaG91bGQgYmUg
bWFkZSBieSBTYXQsIDE0IE9jdCAyMDIzIDE4OjAwOjIzICswMDAwLgo+IEFueXRoaW5nIHJlY2Vp
dmVkIGFmdGVyIHRoYXQgdGltZSBtaWdodCBiZSB0b28gbGF0ZS4KPgo+IFRoZSB3aG9sZSBwYXRj
aCBzZXJpZXMgY2FuIGJlIGZvdW5kIGluIG9uZSBwYXRjaCBhdDoKPiAgICAgICAgIGh0dHBzOi8v
d3d3Lmtlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC92Ni54L3N0YWJsZS1yZXZpZXcvcGF0Y2gt
Ni4xLjU4LXJjMS5nego+IG9yIGluIHRoZSBnaXQgdHJlZSBhbmQgYnJhbmNoIGF0Ogo+ICAgICAg
ICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9s
aW51eC1zdGFibGUtcmMuZ2l0IGxpbnV4LTYuMS55Cj4gYW5kIHRoZSBkaWZmc3RhdCBjYW4gYmUg
Zm91bmQgYmVsb3cuCj4KPiB0aGFua3MsCj4KPiBncmVnIGstaAoKClJlc3VsdHMgZnJvbSBMaW5h
cm/igJlzIHRlc3QgZmFybS4KTm8gcmVncmVzc2lvbnMgb24gYXJtNjQsIGFybSwgeDg2XzY0LCBh
bmQgaTM4Ni4KClRlc3RlZC1ieTogTGludXggS2VybmVsIEZ1bmN0aW9uYWwgVGVzdGluZyA8bGtm
dEBsaW5hcm8ub3JnPgoKTk9URToKRm9sbG93aW5nIExUUCBkaW8gYW5kIGh1Z2V0bGIgdGVzdCBj
YXNlcyBhcmUgYmFjayB0byBQQVNTIHN0YXR1cy4KCkZpeGVzIGNvbXBhcmVkIHdpdGggbGFzdCBy
ZWxlYXNlLgoqIGJjbTI3MTEtcnBpLTQtYiwgbHRwLWRpbwogIC0gZGlvMDEKICAtIGRpbzAyCiAg
LSBkaW8wMwogIC0gZGlvMDUKICAtIGRpbzA2CiAgLSBkaW8wNwogIC0gZGlvMDgKICAtIGRpbzA5
CiAgLSBkaW8xMQoKKiBiY20yNzExLXJwaS00LWIsIGx0cC1odWdldGxiCiAgLSBodWdlbW1hcDEx
CgoKIyMgQnVpbGQKKiBrZXJuZWw6IDYuMS41OC1yYzEKKiBnaXQ6IGh0dHBzOi8vZ2l0bGFiLmNv
bS9MaW5hcm8vbGtmdC9taXJyb3JzL3N0YWJsZS9saW51eC1zdGFibGUtcmMKKiBnaXQgYnJhbmNo
OiBsaW51eC02LjEueQoqIGdpdCBjb21taXQ6IDNmZTYxZGQxNTVhYzQ4ZDE2NDJmNWNhYzE3YmQ0
MWE5MmVmNTg1YjcKKiBnaXQgZGVzY3JpYmU6IHY2LjEuNTctNy1nM2ZlNjFkZDE1NWFjCiogdGVz
dCBkZXRhaWxzOgpodHRwczovL3FhLXJlcG9ydHMubGluYXJvLm9yZy9sa2Z0L2xpbnV4LXN0YWJs
ZS1yYy1saW51eC02LjEueS9idWlsZC92Ni4xLjU3LTctZzNmZTYxZGQxNTVhYwoKIyMgVGVzdCBS
ZWdyZXNzaW9ucyAoY29tcGFyZWQgdG8gdjYuMS41NykKCiMjIE1ldHJpYyBSZWdyZXNzaW9ucyAo
Y29tcGFyZWQgdG8gdjYuMS41NykKCiMjIFRlc3QgRml4ZXMgKGNvbXBhcmVkIHRvIHY2LjEuNTcp
CiogYmNtMjcxMS1ycGktNC1iLCBsdHAtZGlvCiAgLSBkaW8wMQogIC0gZGlvMDIKICAtIGRpbzAz
CiAgLSBkaW8wNQogIC0gZGlvMDYKICAtIGRpbzA3CiAgLSBkaW8wOAogIC0gZGlvMDkKICAtIGRp
bzExCgoqIGJjbTI3MTEtcnBpLTQtYiwgbHRwLWh1Z2V0bGIKICAtIGh1Z2VtbWFwMTEKCiMjIE1l
dHJpYyBGaXhlcyAoY29tcGFyZWQgdG8gdjYuMS41NykKCiMjIFRlc3QgcmVzdWx0IHN1bW1hcnkK
dG90YWw6IDExNDcyNSwgcGFzczogOTcwMTAsIGZhaWw6IDIzMjAsIHNraXA6IDE1MjQwLCB4ZmFp
bDogMTU1CgojIyBCdWlsZCBTdW1tYXJ5CiogYXJjOiA1IHRvdGFsLCA1IHBhc3NlZCwgMCBmYWls
ZWQKKiBhcm06IDE0OSB0b3RhbCwgMTQ5IHBhc3NlZCwgMCBmYWlsZWQKKiBhcm02NDogNTMgdG90
YWwsIDUyIHBhc3NlZCwgMSBmYWlsZWQKKiBpMzg2OiA0MSB0b3RhbCwgMzkgcGFzc2VkLCAyIGZh
aWxlZAoqIG1pcHM6IDI5IHRvdGFsLCAyNyBwYXNzZWQsIDIgZmFpbGVkCiogcGFyaXNjOiA0IHRv
dGFsLCA0IHBhc3NlZCwgMCBmYWlsZWQKKiBwb3dlcnBjOiAzOCB0b3RhbCwgMzYgcGFzc2VkLCAy
IGZhaWxlZAoqIHJpc2N2OiAxNiB0b3RhbCwgMTUgcGFzc2VkLCAxIGZhaWxlZAoqIHMzOTA6IDE2
IHRvdGFsLCAxNiBwYXNzZWQsIDAgZmFpbGVkCiogc2g6IDEyIHRvdGFsLCAxMCBwYXNzZWQsIDIg
ZmFpbGVkCiogc3BhcmM6IDggdG90YWwsIDggcGFzc2VkLCAwIGZhaWxlZAoqIHg4Nl82NDogNDYg
dG90YWwsIDQ2IHBhc3NlZCwgMCBmYWlsZWQKCiMjIFRlc3Qgc3VpdGVzIHN1bW1hcnkKKiBib290
Cioga3NlbGZ0ZXN0LWFuZHJvaWQKKiBrc2VsZnRlc3QtYXJtNjQKKiBrc2VsZnRlc3QtYnJlYWtw
b2ludHMKKiBrc2VsZnRlc3QtY2FwYWJpbGl0aWVzCioga3NlbGZ0ZXN0LWNncm91cAoqIGtzZWxm
dGVzdC1jbG9uZTMKKiBrc2VsZnRlc3QtY29yZQoqIGtzZWxmdGVzdC1jcHUtaG90cGx1ZwoqIGtz
ZWxmdGVzdC1jcHVmcmVxCioga3NlbGZ0ZXN0LWRyaXZlcnMtZG1hLWJ1ZgoqIGtzZWxmdGVzdC1l
Zml2YXJmcwoqIGtzZWxmdGVzdC1leGVjCioga3NlbGZ0ZXN0LWZpbGVzeXN0ZW1zCioga3NlbGZ0
ZXN0LWZpbGVzeXN0ZW1zLWJpbmRlcmZzCioga3NlbGZ0ZXN0LWZpbGVzeXN0ZW1zLWVwb2xsCiog
a3NlbGZ0ZXN0LWZpcm13YXJlCioga3NlbGZ0ZXN0LWZwdQoqIGtzZWxmdGVzdC1mdHJhY2UKKiBr
c2VsZnRlc3QtZnV0ZXgKKiBrc2VsZnRlc3QtZ3BpbwoqIGtzZWxmdGVzdC1pbnRlbF9wc3RhdGUK
KiBrc2VsZnRlc3QtaXBjCioga3NlbGZ0ZXN0LWlyCioga3NlbGZ0ZXN0LWtjbXAKKiBrc2VsZnRl
c3Qta2V4ZWMKKiBrc2VsZnRlc3Qta3ZtCioga3NlbGZ0ZXN0LWxpYgoqIGtzZWxmdGVzdC1tZW1i
YXJyaWVyCioga3NlbGZ0ZXN0LW1lbWZkCioga3NlbGZ0ZXN0LW1lbW9yeS1ob3RwbHVnCioga3Nl
bGZ0ZXN0LW1pbmNvcmUKKiBrc2VsZnRlc3QtbW91bnQKKiBrc2VsZnRlc3QtbXF1ZXVlCioga3Nl
bGZ0ZXN0LW5ldAoqIGtzZWxmdGVzdC1uZXQtZm9yd2FyZGluZwoqIGtzZWxmdGVzdC1uZXQtbXB0
Y3AKKiBrc2VsZnRlc3QtbmV0ZmlsdGVyCioga3NlbGZ0ZXN0LW5zZnMKKiBrc2VsZnRlc3Qtb3Bl
bmF0MgoqIGtzZWxmdGVzdC1waWRfbmFtZXNwYWNlCioga3NlbGZ0ZXN0LXBpZGZkCioga3NlbGZ0
ZXN0LXByb2MKKiBrc2VsZnRlc3QtcHN0b3JlCioga3NlbGZ0ZXN0LXB0cmFjZQoqIGtzZWxmdGVz
dC1yc2VxCioga3NlbGZ0ZXN0LXJ0YwoqIGtzZWxmdGVzdC1zZWNjb21wCioga3NlbGZ0ZXN0LXNp
Z2FsdHN0YWNrCioga3NlbGZ0ZXN0LXNpemUKKiBrc2VsZnRlc3Qtc3BsaWNlCioga3NlbGZ0ZXN0
LXN0YXRpY19rZXlzCioga3NlbGZ0ZXN0LXN5bmMKKiBrc2VsZnRlc3Qtc3lzY3RsCioga3NlbGZ0
ZXN0LXRjLXRlc3RpbmcKKiBrc2VsZnRlc3QtdGltZW5zCioga3NlbGZ0ZXN0LXRtcGZzCioga3Nl
bGZ0ZXN0LXRwbTIKKiBrc2VsZnRlc3QtdXNlcgoqIGtzZWxmdGVzdC11c2VyX2V2ZW50cwoqIGtz
ZWxmdGVzdC12RFNPCioga3NlbGZ0ZXN0LXZtCioga3NlbGZ0ZXN0LXdhdGNoZG9nCioga3NlbGZ0
ZXN0LXg4NgoqIGtzZWxmdGVzdC16cmFtCioga3VuaXQKKiBrdm0tdW5pdC10ZXN0cwoqIGxpYmdw
aW9kCiogbG9nLXBhcnNlci1ib290CiogbG9nLXBhcnNlci10ZXN0CiogbHRwLWNhcF9ib3VuZHMK
KiBsdHAtY29tbWFuZHMKKiBsdHAtY29udGFpbmVycwoqIGx0cC1jb250cm9sbGVycwoqIGx0cC1j
cHVob3RwbHVnCiogbHRwLWNyeXB0bwoqIGx0cC1jdmUKKiBsdHAtZGlvCiogbHRwLWZjbnRsLWxv
Y2t0ZXN0cwoqIGx0cC1maWxlY2FwcwoqIGx0cC1mcwoqIGx0cC1mc19iaW5kCiogbHRwLWZzX3Bl
cm1zX3NpbXBsZQoqIGx0cC1mc3gKKiBsdHAtaHVnZXRsYgoqIGx0cC1pbwoqIGx0cC1pcGMKKiBs
dHAtbWF0aAoqIGx0cC1tbQoqIGx0cC1ucHRsCiogbHRwLXB0eQoqIGx0cC1zY2hlZAoqIGx0cC1z
ZWN1cmViaXRzCiogbHRwLXNtb2tlCiogbHRwLXN5c2NhbGxzCiogbHRwLXRyYWNpbmcKKiBuZXR3
b3JrLWJhc2ljLXRlc3RzCiogcGVyZgoqIHJjdXRvcnR1cmUKKiB2NGwyLWNvbXBsaWFuY2UKKiB2
NGwyLWNvbXBsaWFuY2lhbmNlCgotLQpMaW5hcm8gTEtGVApodHRwczovL2xrZnQubGluYXJvLm9y
ZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
