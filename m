Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258B1CD54A9
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 08:43:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 437D23CE456
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 10:43:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D6903CA70E
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 10:43:30 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4BFE71400985
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 10:43:30 +0200 (CEST)
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7a7d7283fe5so1681726241.0
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695113009; x=1695717809; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7XikjWd3jwDbO28i8wYpygIPE/xIN558cD7Z/sU1GI=;
 b=IGkrgAf3ldfvOtL5rYc4ccg7feIUolHfseYUqwT9b2MJehBO/kJ41Kt8iWtFs6au42
 it2FprNKqUJfEstgQWYf1x0b3+cjXlz2CuSrtX1bOqhVFAgsAij/LLQyuuF0hsnCILcD
 IVS9yoDlCuEajY45r1YiMoElQnUVD8LMm1kW1zGIJ9pPaPLQFjtv7+Oszxkf0HKdlaN/
 s1FDSTHFO2LCNPXZ3JtmW8RaSz01lEOLCT6tsbhpcIb50jPyTgak6eXxA3ErOgc9wM21
 zD5eHx90wPcGiS+3DG5EiCTrk5j9AhBRg85oVLZuBTy7R9+y6cg7xAHN3V0Lao1LMIny
 AsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695113009; x=1695717809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7XikjWd3jwDbO28i8wYpygIPE/xIN558cD7Z/sU1GI=;
 b=RAP8xnSomS5q776ppIghopDhFB/KhG5tdy5w7wlVMmv3oFLEOyKeZSAxCS2F5vKAAi
 buvSt/ErNJK1h8zXqsSQy3aBvR4o1PQ0cQtWN8tma7IR0dW4wrhc5nl2zpabQvkpZT2G
 XJX5BeYebD531z6ZJ7xRaXE9KTg0sqpbOiY/oZZZQk4MUR+c+YCCgpDmGdrYqpE80Sp5
 qjMh67ymg+3a3AQDASx2uN9yad5gzg3KbPih/pKHAfzZeGyLVDivizpgb3wOb+GUAdpa
 /uuy0yMexCya9SZvYF/ROgI77idBapauWJIhjR6pBamIADe0hiF0xejuMbewuguPeEAy
 jVvw==
X-Gm-Message-State: AOJu0YyJ+B2tDcZHdTKnCmKrTlzaXF8smTnFSrXd2Sva/Na7R0M2bE1P
 lVYhWoYt5xgl6qdxOQ69sMOVZkroz7SPi6Mn/LM=
X-Google-Smtp-Source: AGHT+IEA2AHn2sZDufX/u73qRXw+p3X79qC9hLOanykfA+/LaMJ3rW8wL179S0KG55Jcb6xkEveQzUbC9hBjqGLDb4s=
X-Received: by 2002:a1f:c684:0:b0:493:8019:ea65 with SMTP id
 w126-20020a1fc684000000b004938019ea65mr6227078vkf.6.1695113008811; Tue, 19
 Sep 2023 01:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
In-Reply-To: <202309191018.68ec87d7-oliver.sang@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 19 Sep 2023 11:43:17 +0300
Message-ID: <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBTZXAgMTksIDIwMjMgYXQgNTo0N+KAr0FNIGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2
ZXIuc2FuZ0BpbnRlbC5jb20+IHdyb3RlOgo+Cj4KPgo+IEhlbGxvLAo+Cj4ga2VybmVsIHRlc3Qg
cm9ib3Qgbm90aWNlZCAibHRwLnJlYWRhaGVhZDAxLmZhaWwiIG9uOgo+Cj4gY29tbWl0OiBmNDlh
MjBjOTkyZDdmZWQxNmUwNGM0Y2ZhNDBlOWYyOGYxOGY4MWY3ICgiW1BBVENIXSB2ZnM6IGZpeCBy
ZWFkYWhlYWQoMikgb24gYmxvY2sgZGV2aWNlcyIpCj4gdXJsOiBodHRwczovL2dpdGh1Yi5jb20v
aW50ZWwtbGFiLWxrcC9saW51eC9jb21taXRzL1JldWJlbi1IYXdraW5zL3Zmcy1maXgtcmVhZGFo
ZWFkLTItb24tYmxvY2stZGV2aWNlcy8yMDIzMDkwOS0xMjQzNDkKPiBiYXNlOiBodHRwczovL2dp
dC5rZXJuZWwub3JnL2NnaXQvbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQgMzJi
ZjQzZTRlZmRiODdlMGY3ZTkwYmEzODgzZTA3Yjg1MjIzMjJhZAo+IHBhdGNoIGxpbms6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDkwOTA0MzgwNi4zNTM5LTEtcmV1YmVuaHdrQGdt
YWlsLmNvbS8KPiBwYXRjaCBzdWJqZWN0OiBbUEFUQ0hdIHZmczogZml4IHJlYWRhaGVhZCgyKSBv
biBibG9jayBkZXZpY2VzCj4KPiBpbiB0ZXN0Y2FzZTogbHRwCj4gdmVyc2lvbjogbHRwLXg4Nl82
NC0xNGMxZjc2LTFfMjAyMzA3MTUKPiB3aXRoIGZvbGxvd2luZyBwYXJhbWV0ZXJzOgo+Cj4gICAg
ICAgICBkaXNrOiAxSERECj4gICAgICAgICBmczogZXh0NAo+ICAgICAgICAgdGVzdDogc3lzY2Fs
bHMtMDAvcmVhZGFoZWFkMDEKPgo+Cj4KPiBjb21waWxlcjogZ2NjLTEyCj4gdGVzdCBtYWNoaW5l
OiA0IHRocmVhZHMgMSBzb2NrZXRzIEludGVsKFIpIENvcmUoVE0pIGkzLTMyMjAgQ1BVIEAgMy4z
MEdIeiAoSXZ5IEJyaWRnZSkgd2l0aCA4RyBtZW1vcnkKPgo+IChwbGVhc2UgcmVmZXIgdG8gYXR0
YWNoZWQgZG1lc2cva21zZyBmb3IgZW50aXJlIGxvZy9iYWNrdHJhY2UpCj4KPgo+Cj4KPiBJZiB5
b3UgZml4IHRoZSBpc3N1ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVz
dCBhIG5ldyB2ZXJzaW9uIG9mCj4gdGhlIHNhbWUgcGF0Y2gvY29tbWl0KSwga2luZGx5IGFkZCBm
b2xsb3dpbmcgdGFncwo+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIu
c2FuZ0BpbnRlbC5jb20+Cj4gfCBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWxr
cC8yMDIzMDkxOTEwMTguNjhlYzg3ZDctb2xpdmVyLnNhbmdAaW50ZWwuY29tCj4KPgo+Cj4gQ09N
TUFORDogICAgL2xrcC9iZW5jaG1hcmtzL2x0cC9iaW4vbHRwLXBhbiAgIC1lIC1TICAgLWEgMzkx
NyAgICAgLW4gMzkxNyAtcCAtZiAvZnMvc2RiMi90bXBkaXIvbHRwLVI4QnFodHN2NXQvYWxsdGVz
dHMgLWwgL2xrcC9iZW5jaG1hcmtzL2x0cC9yZXN1bHRzL0xUUF9SVU5fT04tMjAyM18wOV8xMy0y
MGhfMTdtXzUzcy5sb2cgIC1DIC9sa3AvYmVuY2htYXJrcy9sdHAvb3V0cHV0L0xUUF9SVU5fT04t
MjAyM18wOV8xMy0yMGhfMTdtXzUzcy5mYWlsZWQgLVQgL2xrcC9iZW5jaG1hcmtzL2x0cC9vdXRw
dXQvTFRQX1JVTl9PTi0yMDIzXzA5XzEzLTIwaF8xN21fNTNzLnRjb25mCj4gTE9HIEZpbGU6IC9s
a3AvYmVuY2htYXJrcy9sdHAvcmVzdWx0cy9MVFBfUlVOX09OLTIwMjNfMDlfMTMtMjBoXzE3bV81
M3MubG9nCj4gRkFJTEVEIENPTU1BTkQgRmlsZTogL2xrcC9iZW5jaG1hcmtzL2x0cC9vdXRwdXQv
TFRQX1JVTl9PTi0yMDIzXzA5XzEzLTIwaF8xN21fNTNzLmZhaWxlZAo+IFRDT05GIENPTU1BTkQg
RmlsZTogL2xrcC9iZW5jaG1hcmtzL2x0cC9vdXRwdXQvTFRQX1JVTl9PTi0yMDIzXzA5XzEzLTIw
aF8xN21fNTNzLnRjb25mCj4gUnVubmluZyB0ZXN0cy4uLi4uLi4KPiA8PDx0ZXN0X3N0YXJ0Pj4+
Cj4gdGFnPXJlYWRhaGVhZDAxIHN0aW1lPTE2OTQ2MzYyNzQKPiBjbWRsaW5lPSJyZWFkYWhlYWQw
MSIKPiBjb250YWN0cz0iIgo+IGFuYWx5c2lzPWV4aXQKPiA8PDx0ZXN0X291dHB1dD4+Pgo+IHRz
dF90ZXN0LmM6MTU1ODogVElORk86IFRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMm0gMzBzCj4gcmVh
ZGFoZWFkMDEuYzozNjogVElORk86IHRlc3RfYmFkX2ZkIC0xCj4gcmVhZGFoZWFkMDEuYzozNzog
VFBBU1M6IHJlYWRhaGVhZCgtMSwgMCwgZ2V0cGFnZXNpemUoKSkgOiBFQkFERiAoOSkKPiByZWFk
YWhlYWQwMS5jOjM5OiBUSU5GTzogdGVzdF9iYWRfZmQgT19XUk9OTFkKPiByZWFkYWhlYWQwMS5j
OjQ1OiBUUEFTUzogcmVhZGFoZWFkKGZkLCAwLCBnZXRwYWdlc2l6ZSgpKSA6IEVCQURGICg5KQo+
IHJlYWRhaGVhZDAxLmM6NTQ6IFRJTkZPOiB0ZXN0X2ludmFsaWRfZmQgcGlwZQo+IHJlYWRhaGVh
ZDAxLmM6NTY6IFRQQVNTOiByZWFkYWhlYWQoZmRbMF0sIDAsIGdldHBhZ2VzaXplKCkpIDogRUlO
VkFMICgyMikKPiByZWFkYWhlYWQwMS5jOjYwOiBUSU5GTzogdGVzdF9pbnZhbGlkX2ZkIHNvY2tl
dAo+IHJlYWRhaGVhZDAxLmM6NjI6IFRGQUlMOiByZWFkYWhlYWQoZmRbMF0sIDAsIGdldHBhZ2Vz
aXplKCkpIHN1Y2NlZWRlZAo+CgpSZXViZW4sCgpUaGlzIHJlcG9ydCBpcyBvbiBhbiBvbGQgdmVy
c2lvbiBvZiB5b3VyIHBhdGNoLgpIb3dldmVyOgoxLiBMVFAgdGVzdCByZWFkYWhlYWQwMSB3aWxs
IG5lZWQgdG8gYmUgZml4ZWQgdG8gYWNjZXB0IGFsc28gRVNQSVBFCjIuIEkgYW0gc3VycHJpc2Vk
IHRoYXQgd2l0aCB0aGUgb2xkIHBhdGNoIHJlYWRhaGVhZCBvbiBzb2NrZXQgZGlkIG5vdAogICAg
ZmFpbC4gRG9lcyBzb2NrZXQgaGF2ZSBhb3BzPwoKUGxlYXNlIHRyeSB0byBydW4gTFRQIHRlc3Qg
cmVhZGFoZWFkMDEgb24gdGhlIHBhdGNoIHRoYXQgQ2hyaXN0aWFuIHF1ZXVlZAphbmQgc2VlIGhv
dyBpdCBiZWhhdmVzIGFuZCBpZiBhbnl0aGluZyBuZWVkcyB0byBiZSBmaXhlZCB3cnQgc29ja2V0
cy4KClRoYW5rcywKQW1pci4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
