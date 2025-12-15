Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F352D78771
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766151450; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=/Q9arvI40BEY+LePR9MLWX596deEp8EgvoZIkQ0Kfag=;
 b=TqeuYE5W0ANH7OCUc5T4THxipaGC86dF30y5XeeQFlKQp7hE3NKdyO7ncAmPo45SfSQsO
 VyjChvplBq4rraDZ0mDQcTD9rPpyqkOuDYqhRFazHF0d5/0khaRd3PPrEYVPE2V8OuOeA6L
 v7mBfZwgUNecgKTwTGLpg8vylLMGqB8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C4053D053D
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 14:37:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF57F3CA9BB
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 11:21:54 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 72BAE1A005E2
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 11:21:52 +0100 (CET)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A63F43FC34
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 10:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765794071;
 bh=VqaKlQYb9lrbrkbA0Dvula2Fs3i4EdFYVsp2r60G/yc=;
 h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To;
 b=EKinB9BINOscWNWpSDmGlvfDbrqPjSPoKuHCDGv8XqG/QLbs08VMJkCVv9Tc9e3P2
 Bh250n6Qthj872Nm0PXtG1XmQIZqSArb6PXl5qy16i3QHUi/nwKOUOug5RqM/WM015
 JYja1Ix62snJGkBQG9YjBBgY95ni6HfcPDPzc1fR/tefX5IkNJGRK9JBa9Od+a4BdX
 cHSDyKVSW4gXd0EbryIYrJbojC6OghHJd50NdiPSs2UYlhpwcrI/FheCTTMQW9hb4W
 ZHObOBeywqzO1MHMHzSeLJY7hfCuzQb7rstbDxHk3uCRalhKNLBILSg+RqOfI1iGoZ
 UQk8+fVYUdH2dY3awd1jEYDnU84P7S5PY60KOzKmpJyTEltlckin9xkWNGZ4WRjHwt
 wFpVAEedomjfOdLWZ6nz/yGJMKeffV3zah1+Z+oNDNVa3IBm3CRwtABaQbP52m3b/y
 bq9tIIJS7ep4hhkmQROSi3/7wU/bCgcJMdeHh5pshJNCQ2lwnJ6hRTWno+gBGd07Bz
 1s/iBUGQA1dK3CD89X4eq0f+bIKipUWz2nRGIjDL/5PZ8mcKeRALJN4MeDNpZtgUCa
 xwntXQxW4ItcjlEHbm6paL6M5IfcseiKh8EqIJOKvBdQOg9r+CeuEOakcLAbxpmeaC
 fQrMQ/LytbLehbIobudGB7R4=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so22533915e9.0
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 02:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765794031; x=1766398831;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VqaKlQYb9lrbrkbA0Dvula2Fs3i4EdFYVsp2r60G/yc=;
 b=pL2IzU3n/+oXQ35eAPJpT6xRx1jiuQsIGUEewN9nS9RygaZjpiPp9B01hwZxVimrTe
 52VtYtRvVXP6HYcDk5bo2gLamvPUBIkavxezlRF1LV9TLQRbnOL2T1sjySqLSVDVl0/v
 xwZXLWK24I0ztUHBWdXaBWneBe4reQTRPpm69lYjUyzAU2ypR7LjKYjqHLKam8/wo6Pz
 nr1Uby7VYVesMbHA6QIl6J5noPpNPrVwkXbMiQyqA6kspyXNyASmsTTTNJqIR3sE2K7K
 W2C7KPlusA9R73MgeCvwBe9ziNSQBUxgKVfHf4nltBil6fJDzkm6cQwQvLLwm1/FfboR
 rjJw==
X-Gm-Message-State: AOJu0YyLZuKQRkMNA9X9hz39wswjOiUF/ea4yM0EoFY6a9535f3/17UK
 dDn92xXTNrvzMCjO3UNibv/A1t3V6vEAxA1MCgiI6Ac/4SQHr5UZ6CIlf+XW9tX2MesEeC0a4Oi
 aHJj1qK3pyNYT+4th0MHdEmmRh7phDLeEcxNZ7BVCyzhexMkQatItxhTY+gbCiLMlOnA/
X-Gm-Gg: AY/fxX4rxTaCyQ9l50dfyL09U/k4PuZaWqrprXOuCA/JGX+FoLXIGfhJkDhBJb42/Ln
 twtbRhRQZd1C2JzhvQD54hVk/RJEcG1D+wlI0BFgSeZ6+1cuurCrOPDHqqd4iTR082pzIcZVi7J
 65ttQKdoIUmBJ7MO7dCrz2ZDZylvvcFPDrCbRFhGJICkOsHczcoAWrJPQtAvNeJiv72bIRLxqgo
 hLT7Zw9oYGSVu+St6iVSo7zEya7g/PRh883etod1axnikHryOKU7DD/Ynv5HleRbTSi8oxG+BDg
 wsLgbktV/Z91wHu/W7myVUwtnh8aR+c705aOJxcYG9gm/8ZEII+UN6j3Wg35yAz7q4LHtmoOcwc
 r6SLtENglxY94MUicbWGORZqMRAUXPX6xO8FmweU=
X-Received: by 2002:a05:600c:c168:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-47a8f1c217cmr114374345e9.9.1765794030927; 
 Mon, 15 Dec 2025 02:20:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJvNt0rdWFmHWJLpNHWkEo3aMpxwfN5FQ5g0nfP25UJJeRkjUBG3jTBXIGfPppUe+EjhrJjQ==
X-Received: by 2002:a05:600c:c168:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-47a8f1c217cmr114373875e9.9.1765794030136; 
 Mon, 15 Dec 2025 02:20:30 -0800 (PST)
Received: from ?IPV6:2001:67c:1560:8007::aac:c224?
 ([2001:67c:1560:8007::aac:c224]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f6f118esm69247365e9.3.2025.12.15.02.20.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 02:20:29 -0800 (PST)
Message-ID: <c8ec1f73-1593-4ab1-9bb0-e72be0c18a6b@canonical.com>
Date: Mon, 15 Dec 2025 21:20:23 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20251214060640.41555-1-changwei.zou@canonical.com>
 <20251215075922.GA233529@pevik>
Content-Language: en-US
In-Reply-To: <20251215075922.GA233529@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 19 Dec 2025 14:36:46 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] splice07: require kernel version 5.10
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
From: Changwei Zou via ltp <ltp@lists.linux.it>
Reply-To: Changwei Zou <changwei.zou@canonical.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKVGhlIGZpeCB3YXMgaW50ZW5kZWQgdG8gYXZvaWQgcnVubmluZyBzcGxpY2UwNyBv
biBvbGRlciBrZXJuZWxzLgpIb3dldmVyLCB5b3UgYXJlIHJpZ2h0IOKAlCB0aGF0IHdvdWxkIGhp
ZGUgdGhlIGZhY3QgdGhhdCB0aG9zZSBrZXJuZWxzIGFyZSAKYnVnZ3kuCkkgY291bGRu4oCZdCBh
Z3JlZSB3aXRoIHlvdSBtb3JlLgpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB0aGUgZGV0YWlsZWQg
aW5mb3JtYXRpb24uCktpbmQgcmVnYXJkcywKQ2hhbmd3ZWkKCgpPbiAxMi8xNS8yNSAxODo1OSwg
UGV0ciBWb3JlbCB3cm90ZToKPiBIaSBDaGFuZ3dlaSwKPgo+PiBPbiBMaW51eCBrZXJuZWwgNS45
LCB0aGUgc3BsaWNlMDcgdGVzdCBmYWlscyBhcyBmb2xsb3dzOgo+PiAgICBSdW5uaW5nIHRlc3Rz
Li4uLi4uLgo+PiAgICB0c3RfZmQuYzoyNjA6IFRDT05GOiBTa2lwcGluZyBtZW1mZCBzZWNyZXQ6
IEVOT1NZUyAoMzgpCj4+ICAgIHNwbGljZTA3LmM6NjQ6IFRJTkZPOiBkaXJlY3RvcnkgLT4gLi4u
Cj4+ICAgIHNwbGljZTA3LmM6NTY6IFRQQVNTOiBzcGxpY2UoKSBvbiBkaXJlY3RvcnkgLT4gZmls
ZSA6IEVJTlZBTCAoMjIpCj4+ICAgIHNwbGljZTA3LmM6NTY6IFRQQVNTOiBzcGxpY2UoKSBvbiBk
aXJlY3RvcnkgLT4gT19QQVRIIGZpbGUgOiBFQkFERiAoOSkKPj4gICAgc3BsaWNlMDcuYzo1Njog
VFBBU1M6IHNwbGljZSgpIG9uIGRpcmVjdG9yeSAtPiBkaXJlY3RvcnkgOiBFQkFERiAoOSkKPj4g
ICAgc3BsaWNlMDcuYzo1NjogVFBBU1M6IHNwbGljZSgpIG9uIGRpcmVjdG9yeSAtPiAvZGV2L3pl
cm8gOiBFQkFERiAoOSkKPj4gICAgc3BsaWNlMDcuYzo1NjogVFBBU1M6IHNwbGljZSgpIG9uIGRp
cmVjdG9yeSAtPiAvcHJvYy9zZWxmL21hcHMgOiBFQkFERiAoOSkKPj4gICAgc3BsaWNlMDcuYzo1
NjogVFBBU1M6IHNwbGljZSgpIG9uIGRpcmVjdG9yeSAtPiBwaXBlIHJlYWQgZW5kIDogRUJBREYg
KDkpCj4+ICAgIHNwbGljZTA3LmM6NTY6IFRGQUlMOiBzcGxpY2UoKSBvbiBkaXJlY3RvcnkgLT4g
cGlwZSB3cml0ZSBlbmQgZXhwZWN0ZWQgRUJBREYsIEVJTlZBTDogRUlTRElSICgyMSkKPj4gICAg
Li4uCj4+ICAgIHNwbGljZTA3LmM6NjQ6IFRJTkZPOiBwaXBlIHJlYWQgZW5kIC0+IC4uLgo+PiAg
ICBzcGxpY2UwNy5jOjU2OiBUUEFTUzogc3BsaWNlKCkgb24gcGlwZSByZWFkIGVuZCAtPiBPX1BB
VEggZmlsZSA6IEVCQURGICg5KQo+PiAgICBzcGxpY2UwNy5jOjU2OiBUUEFTUzogc3BsaWNlKCkg
b24gcGlwZSByZWFkIGVuZCAtPiBkaXJlY3RvcnkgOiBFQkFERiAoOSkKPj4gICAgc3BsaWNlMDcu
Yzo1NjogVFBBU1M6IHNwbGljZSgpIG9uIHBpcGUgcmVhZCBlbmQgLT4gL2Rldi96ZXJvIDogRUJB
REYgKDkpCj4+ICAgIHNwbGljZTA3LmM6NTY6IFRQQVNTOiBzcGxpY2UoKSBvbiBwaXBlIHJlYWQg
ZW5kIC0+IC9wcm9jL3NlbGYvbWFwcyA6IEVCQURGICg5KQo+PiAgICBzcGxpY2UwNy5jOjU2OiBU
UEFTUzogc3BsaWNlKCkgb24gcGlwZSByZWFkIGVuZCAtPiBwaXBlIHJlYWQgZW5kIDogRUJBREYg
KDkpCj4+ICAgIFRlc3QgdGltZW91dGVkLCBzZW5kaW5nIFNJR0tJTEwhCj4+ICAgIHRzdF90ZXN0
LmM6MTkxODogVElORk86IElmIHlvdSBhcmUgcnVubmluZyBvbiBzbG93IG1hY2hpbmUsIHRyeSBl
eHBvcnRpbmcgTFRQX1RJTUVPVVRfTVVMID4gMQo+PiAgICB0c3RfdGVzdC5jOjE5MjA6IFRCUk9L
OiBUZXN0IGtpbGxlZCEgKHRpbWVvdXQ/KQo+PiAgICBTdW1tYXJ5Ogo+PiAgICBwYXNzZWQgICAx
MjEKPj4gICAgZmFpbGVkICAgMQo+PiAgICBicm9rZW4gICAxCj4+ICAgIHNraXBwZWQgIDUKPj4g
ICAgd2FybmluZ3MgMAo+PiAgICBJTkZPOiBsdHAtcGFuIHJlcG9ydGVkIHNvbWUgdGVzdHMgRkFJ
TAo+PiAgICBMVFAgVmVyc2lvbjogMjAyNTA5MzAtNjAtZ2I0NDZkZDRlZAo+PiBUaGlzIHRlc3Qg
cGFzc2VzIG9uIGtlcm5lbCB2ZXJzaW9ucyA1LjEwIGFuZCBsYXRlci4KPiBJTUhPIHRoaXMgaXMg
d3JvbmcuIE9sZGVyIGtlcm5lbHMgYXJlIGJyb2tlbiwgYW5kIHRoaXMgd291bGQgaGlkZSB0aGV5
IGFyZQo+IGJ1Z2d5LiBUaGF0J3MgdGhlIHJlYXNvbiB3aHkgdGhlIHJlbGF0ZWQgaXNzdWUgd2Fz
IGNsb3NlZCBbMV0uCj4gVGhlIGNvcnJlY3Qgd2F5IGluIGlkZWFsIHdvcmxkIHdvdWxkIGJlIHRv
IGZpeCB0aGUga2VybmVsIChidXQgdGhhdCB3b3VsZAo+IHJlcXVpcmUgbm9udHJpdmlhbCBiYWNr
cG9ydHMpLgo+Cj4gRllJIHdlIGhhdmUgcnVsZSAiRG8gbm90IHdvcmsgYXJvdW5kIGtlcm5lbCBi
dWdzIiAodGhlIGRvYyBpcyBub3QgeWV0Cj4gbWVyZ2VkIFsyXSwgYnV0IHdpbGwgYmUgc29vbiB0
byBiZSB2aXNpYmxlIGluIGRvY3MgWzNdKSBhbmQgdGhpcyB3b3VsZCB2aW9sYXRlCj4gaXQuCj4K
PiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gWzFdaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRl
c3QtcHJvamVjdC9sdHAvaXNzdWVzLzExNTYKPiBbMl1odHRwczovL2xvcmUua2VybmVsLm9yZy9s
dHAvMjAyNTEyMDkxMjAyNDYuMTg0MzUtMS1jaHJ1YmlzQHN1c2UuY3ovCj4gWzNdaHR0cHM6Ly9s
aW51eC10ZXN0LXByb2plY3QucmVhZHRoZWRvY3MuaW8vCj4KPj4gU2lnbmVkLW9mZi1ieTogQ2hh
bmd3ZWkgWm91PGNoYW5nd2VpLnpvdUBjYW5vbmljYWwuY29tPgo+PiAtLS0KPj4gICB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3NwbGljZS9zcGxpY2UwNy5jIHwgMSArCj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL3NwbGljZS9zcGxpY2UwNy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zcGxp
Y2Uvc3BsaWNlMDcuYwo+PiBpbmRleCBjNzUwYTE0YmYuLjEwMjA2NTE0ZiAxMDA2NDQKPj4gLS0t
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zcGxpY2Uvc3BsaWNlMDcuYwo+PiArKysgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NwbGljZS9zcGxpY2UwNy5jCj4+IEBAIC02OSw0ICs2
OSw1IEBAIHN0YXRpYyB2b2lkIHZlcmlmeV9zcGxpY2Uodm9pZCkKPj4gICBzdGF0aWMgc3RydWN0
IHRzdF90ZXN0IHRlc3QgPSB7Cj4+ICAgCS50ZXN0X2FsbCA9IHZlcmlmeV9zcGxpY2UsCj4+ICsJ
Lm1pbl9rdmVyID0gIjUuMTAiLAo+PiAgIH07CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
