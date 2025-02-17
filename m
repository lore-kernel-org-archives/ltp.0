Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5832C021A0
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 07:26:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10D7D3C9BC8
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 08:26:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3561D3C931E
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 08:25:45 +0100 (CET)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4C549613392
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 08:25:44 +0100 (CET)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5205d9da0d7so1060887e0c.2
 for <ltp@lists.linux.it>; Sun, 16 Feb 2025 23:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739777143; x=1740381943; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6S26YdbgNoTQN01NLVT40+IrNkoopbvz9Rb8CNQkOc=;
 b=XBpS7kg5hwT5/uH8PnbMMeJD2V02BQco4pwog8X3g3tg7VODgUk2vib7SZF1a+IoaO
 g2s1UDsT047V0RJW1WZ6bFM4nw6jRcxE/B+/myoLCPpCoIDQSqn22KNjA5tRx/bSCxdA
 xUNXkE0olZaWudkxyfMy1zzd4Si9jvfE7mXZWVbUQIlzdUyNvHUUR5st4+vh2xJrcngM
 /6bJoZvZXUcUD5c7R2c35V0C894dXtoT0OF4cfP0mguXHqw3i2gfHtMMGJes1tz/g028
 i2rK2S1zDoN3mrRAvHd93VHaydyfiQ6c6aNLHJmt2baceoF48biPjKFGVtkkJ05r6Az+
 +dMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739777143; x=1740381943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6S26YdbgNoTQN01NLVT40+IrNkoopbvz9Rb8CNQkOc=;
 b=Bj5bDSrapYpIXtrNXZ41ZsudRlrhWdKw5Y6qCxBAGq2teXrB1JPoxVhjnzHO2FhNOA
 OVC4irw3QoIkNx5Sxp/PQD9HwhtGqNajPbw1Kq0UWwW2KMSjJK+jfFLME1s7yCpMLYHw
 gVJ0qFXcIyeNvtxC+pESF/TGqgNAJELaVlQm08YhTdCTSwXKwbgfp7HCxawO/3y0XKHJ
 ZjcFAiQhCEbIZktqQe9NhxYCY9gfv2ugENRf/CFQE/NdmzfKtK2PrWFABaHafPcES5O5
 yvPzJtykpkfQUcbWq7nSaLZHwb334tB8eoMN3fbqg52bK0RWr7L6L2bhA+IONbPom/yR
 HNPw==
X-Gm-Message-State: AOJu0Yzebnz83ryVNJ15sWBZebd0v/9tPw7jMv2dtM5regV4Na3+UmYG
 YUvr5ENXJp2EPNqBY7aXFcOEdCk0bCUt1GqZQFDv/B4tgnAknzOMlrtf6SnHNvIW9bg65sXPQio
 +rUPw93T9jMqQS4BXibm5zBLIOD+NQJz90PE5q00s
X-Gm-Gg: ASbGnctMNHvFfWhM/cgwyLpdMIoBposJzkTvP+dI0vK8A6wI7nADC95h45H58kqPQRk
 EPMTkv9Vx5AOgOPII91eLK6q7+aX/+tWTlETYPo0NwehkVgMUTIhY5kHFzvIsEh/OyCs+UWGD4g
 ==
X-Google-Smtp-Source: AGHT+IE5kuEAqaCM99m0DHQdZ2Gr0UTgbjW3JeCe1vr9p+rj9qFTXHbeINtb/r4n7U9GUAjZlR8MlghusdhllRE2m28=
X-Received: by 2002:a05:6122:506:b0:50a:c70b:9453 with SMTP id
 71dfb90a1353d-5209de6718cmr2578543e0c.10.1739777142857; Sun, 16 Feb 2025
 23:25:42 -0800 (PST)
MIME-Version: 1.0
References: <22b831c6-4a7c-4393-a840-d0b00512acbb.jinguojie.jgj@alibaba-inc.com>
 <4ae915b4-0be1-4ea6-b59e-50c9a960c558.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYT=RRPEUQ8WydQWeQkB02xO5=EJd=gqOTXB1F5OUWj9HQ@mail.gmail.com>
In-Reply-To: <CA+B+MYT=RRPEUQ8WydQWeQkB02xO5=EJd=gqOTXB1F5OUWj9HQ@mail.gmail.com>
From: Jin Guojie <guojie.jin@gmail.com>
Date: Mon, 17 Feb 2025 15:25:31 +0800
X-Gm-Features: AWEUYZlju86iQ5BDNqs6bBZr50aayjJ0AJlXpgGQ2hf5UyUMhJN4sf4A4jOY8pU
Message-ID: <CA+B+MYRjJjmSxZscaFTtrPXGW2RNOyah4F__82UfN41MER+e_A@mail.gmail.com>
To: ltp@lists.linux.it, Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] controllers: skip test when cgroup v2 is loaded
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGkgV2FuZywKClRoaXMgcGF0Y2ggZml4ZXMgdGhlIGp1ZGdtZW50IG9mIGNvbnRyb2xsZXJz
IGluIHRoZSBjZ3JvdXAgdjIgc3lzdGVtCmFuZCBpbXByb3ZlcyB0aGUgZXJyb3IgbWVzc2FnZS4K
VGhpcyBpcyB0aGUgc2Vjb25kIHZlcnNpb24gSSd2ZSBtYWRlLgpXb3VsZCB5b3UgcGxlYXNlIHJl
dmlldyBpdD8KClJlZ2FyZHMsCkppbgoKT24gVGh1LCBEZWMgMTksIDIwMjQgYXQgMjozNuKAr1BN
IEppbiBHdW9qaWUgPGd1b2ppZS5qaW5AZ21haWwuY29tPiB3cm90ZToKPgo+IFYyOgo+ICogQ29y
cmVjdGlvbiBvZiBjb21tZW50cwo+Cj4gVjE6Cj4gKiBJbml0aWFsIGNoZWNrIGZvciBjZ3JvdXAg
djIKPgo+IFdoZW4gcnVubmluZyAiY29udHJvbGxlcnMiIGNhc2Ugb24gc29tZSBuZXdlciBMaW51
eCBkaXN0cmlidXRpb25zLCB0aGVyZQo+IHdpbGwgYmUgMTAgRVJST1IgbWVzc2FnZXMgZHVyaW5n
IHRoZSBzZXR1cCBwaGFzZSwgYW5kIHNldmVyYWwgVEZBSUwKPiByZXN1bHRzIGF0IHRoZSBlbmQu
Cj4KPiBDdXJyZW50ICJjb250cm9sbGVycyIgY2FzZXMgb25seSBpbXBsZW1lbnQgdGVzdHMgZm9y
IGNncm91cCB2MSBmaWxlIGludGVyZmFjZS4KPiBJdCdzIGJldHRlciB0byBza2lwIHRoZSB0ZXN0
IGFmdGVyIGNoZWNraW5nIHRoYXQgdjIgaGllcmFyY2h5IGhhcwo+IGFscmVhZHkgYmVlbiBsb2Fk
ZWQuCj4KPiBbMV0gaHR0cHM6Ly9saXN0cy5saW51eC5pdC9waXBlcm1haWwvbHRwLzIwMjQtRGVj
ZW1iZXIvMDQxMDgyLmh0bWwKPgo+IFNpZ25lZC1vZmYtYnk6IEppbiBHdW9qaWUgPGd1b2ppZS5q
aW5AZ21haWwuY29tPgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL3Rlc3Rf
Y29udHJvbGxlcnMuc2ggfCA5ICsrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy90ZXN0
X2NvbnRyb2xsZXJzLnNoCj4gYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL3Rlc3RfY29u
dHJvbGxlcnMuc2gKPiBpbmRleCA3YWE5NzRmZjIuLjBiNjczODdlYyAxMDA3NTUKPiAtLS0gYS90
ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL3Rlc3RfY29udHJvbGxlcnMuc2gKPiArKysgYi90
ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL3Rlc3RfY29udHJvbGxlcnMuc2gKPiBAQCAtMzcs
NiArMzcsMTUgQEAKPiAgIwo+ICAgICAgICAgICAgIwo+ICAjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjCj4KPiArIyBDdXJyZW50bHkgb25seSBjZ3JvdXAgdjEgaW50ZXJmYWNlIGNhbiBiZSB0ZXN0
ZWQuCj4gKyMgV2hlbiB0aGUgdjIgaGllcmFyY2h5IGlzIGFscmVhZHkgbG9hZGVkIGluIHRoZSBz
eXN0ZW0sIHNraXAgdGhlIHRlc3QuCj4gK21vdW50IHwgZ3JlcCAgIiB0eXBlIGNncm91cDIgIiAm
Pi9kZXYvbnVsbAo+ICtpZiBbICQ/ID09IDAgXQo+ICt0aGVuCj4gKyAgICAgICB0c3RfYnJrbSBU
Q09ORiAiIiAidGVzdF9jb250cm9sbGVycy5zaDogVjEgY29udHJvbGxlcgo+IHJlcXVpcmVkLCBi
dXQgbW91bnRlZCBvbiBWMiIKPiArICAgICAgIGV4aXQgMzIKPiArZmkKPiArCj4gIGlmIFsgLWYg
L3Byb2MvY2dyb3VwcyBdCj4gIHRoZW4KPiAgICAgICAgIENQVV9DT05UUk9MTEVSPWBncmVwIC13
IGNwdSAvcHJvYy9jZ3JvdXBzIHwgY3V0IC1mMWA7Cj4gLS0KPiAyLjM0LjEKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
