Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47494C4345F
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 08:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712910880; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=RCp3V+rKy8U45Podkl049DSX4WhRSu75QrfU1BNEjaI=;
 b=bDx3/zlIOZAi/8nps+5B88/KZmGyeSC5sw2A2Jd+YN/J37+RZpq18kJcoEet7euKe89Oe
 i2CFhip2+HtGG0btDy6+6ez5YYSXHGOOnDVLfFTzAW66zSFFO09f6jkYbQxVf9yYDHh/Qq5
 PTq7rSm/AeZzL5RnAnq8u57/aNAgec8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FA023CF8AE
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 10:34:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0824D3CF865
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 10:34:17 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7404C1A0D309
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 10:34:16 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-417d14c3411so7290715e9.2
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1712910856; x=1713515656; darn=lists.linux.it;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahG3FTmi0TqS5xZFeqLCRMqwION/YZwDCxh3VTSeBSI=;
 b=ZUeO6j2yBkDzR+NVZrfrsDM5nEA+293tU62HVCgAUqVWXe+UkNrLPxipfv7asXWfPh
 Uz49BtC7WLm8VhfYHUsqIXLoLKwxM45QKF5W+2XzW3SmBCRQlvvEVkT8KhQe37xvT22t
 uG6jz6tiPfiKhMCjNPNzCs4GVbQMqEnbYH9tUeN6Nv4WMEz+1WoMS0EXslvYZ6kIJwV7
 WLlBR+uaLqAqor4WqizK8hBQXnIDdGlaX18sSgIn4I9yrpmsByH1gAyAsrcIJUzSTO/G
 qVAoyQWGvZZM92kuE6Yq/MjPAkY0bIBMOARUmepZgDbD/KiiG2G6OugdPAFgh0y+agvf
 Pz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712910856; x=1713515656;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ahG3FTmi0TqS5xZFeqLCRMqwION/YZwDCxh3VTSeBSI=;
 b=MvuHRfV6BD/xT8hVYdt6vUzTT2LU9DRAoSnNXUJ//9mnQyoBjmDAW0RtsfwHJZyG+F
 o22uSx7UgFYD+6ws9jo/oqSo1W49iiOpR0ZX/Rhqdgi9kcgNh+AC6wWLqahPjWu7Uo53
 Sm6FJY7z+TK6IOZ5kHyTpxlDL5H/rdGtf9gmFwaE92+16lIqgC+oaoUhcFDjQKRsvjAX
 cjpnu2C9OYXlhpwxrvkzZuOIRL8TWUVnbPB2tiDeNK2zRv+Gze6PQBJbWxcPQyoS6IXM
 1earNLUbitXCK2uSbFziarADpgryTspTgn6Yc6YIxVUh6ubCR5V5JkaUMpqBLF9Uc6u0
 KZTA==
X-Gm-Message-State: AOJu0YxZbfy22OIhOCMZ1fTko+TN0Gjin6zPxWx0h3EsGqIo/B/5+/54
 K3mvJo/Q33/HjsaBvvUiDpIzuxkoakdN6bmECO0Nu1qHi6R4JyAifjHFwV0Gr04=
X-Google-Smtp-Source: AGHT+IEyRDTDldo+zSZZpPs/SaHPxq9fikyQ7tixmWo2OPp0VnE2RHTi9IMfVsHZfsb+1fhrsqMyjQ==
X-Received: by 2002:a05:600c:34ce:b0:416:9ba1:b244 with SMTP id
 d14-20020a05600c34ce00b004169ba1b244mr1705332wmq.13.1712910855791; 
 Fri, 12 Apr 2024 01:34:15 -0700 (PDT)
Received: from [10.232.133.111] ([88.128.88.50])
 by smtp.gmail.com with ESMTPSA id
 l35-20020a05600c1d2300b004161af729f4sm4993387wms.31.2024.04.12.01.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 01:34:15 -0700 (PDT)
Message-ID: <8f9af233-4614-4f34-97fd-dd6728e6d893@suse.com>
Date: Fri, 12 Apr 2024 10:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Li Wang <liwang@redhat.com>, Petr Vorel <pvorel@suse.cz>
References: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
 <CAEemH2eDT6gN3hw=Lz2qgnwFnnHmNYai9tqbKduSkcWfNjpERQ@mail.gmail.com>
 <20240410101225.GA187895@pevik>
 <CAEemH2e7GAQmdkcu0p3p=4Hequ4nck2+ECeSfMYpXSpvKhqsDg@mail.gmail.com>
In-Reply-To: <CAEemH2e7GAQmdkcu0p3p=4Hequ4nck2+ECeSfMYpXSpvKhqsDg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] New LTP documentation!
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpPbiA0LzExLzI0IDExOjAwLCBMaSBXYW5nIHdyb3RlOgo+IEhpIFBldHIsCj4KPiBPbiBX
ZWQsIEFwciAxMCwgMjAyNCBhdCA2OjEy4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gICAgIEhpIGFsbCwKPgo+ICAgICA+IEhpIEFuZHJlYSwKPgo+ICAgICA+IE9u
IE1vbiwgTWFyIDE4LCAyMDI0IGF0IDg6NDHigK9QTSBBbmRyZWEgQ2VydmVzYXRvIHZpYSBsdHAK
PiAgICAgPGx0cEBsaXN0cy5saW51eC5pdD4KPiAgICAgPiB3cm90ZToKPgo+ICAgICA+ID4gSGVs
bG8gZXZlcnlvbmUsCj4KPiAgICAgPiA+IGFzIGFscmVhZHkgbWVudGlvbmVkIGluIHRoZSBtb250
aGx5IExUUCBtZWV0aW5nLCBMaW51eCBUZXN0Cj4gICAgIFByb2plY3QKPiAgICAgPiA+IGxhY2tz
IG9mIGEgbmljZSBhbmQgY2xlYW4gZG9jdW1lbnRhdGlvbiB0aGF0IGNhbiBiZSBlYXNpbHkKPiAg
ICAgYWNjZXNzZWQgYnkKPiAgICAgPiA+IHVzZXJzLCBkZXZlbG9wZXJzIGFuZCBtYWludGFpbmVy
cy4KPiAgICAgPiA+IFRoZSBjdXJyZW50IExUUCBkb2N1bWVudGF0aW9uIGlzIGFsc28gbm90IG1h
dGNoaW5nIHdpdGggb3VyCj4gICAgIGV4cGVjdGFuY3kKPiAgICAgPiA+IHRvd2FyZHMgdGhlIGVu
dGlyZSBwcm9qZWN0LCB3aGljaCBpcyBoYXMgYmVlbiBoZWF2aWx5Cj4gICAgIHJlZmFjdG9yZWQg
YW5kIGl0Cj4gICAgID4gPiBoYXMgY2hhbmdlZCBpbiB0aGUgcGFzdCB5ZWFycywgcHJvdmlkaW5n
IGEgaGlnaGVyIHF1YWxpdHkgY29kZQo+ICAgICBhbmQgbmV3Cj4gICAgID4gPiB0ZXN0aW5nIGZl
YXR1cmVzLgo+Cj4gICAgID4gPiBGb3IgdGhpcyByZWFzb25zLCB3ZSB0aGluayBpdCdzIHRpbWUg
dG8gbW92ZSBmb3J3YXJkIGFuZCB0byBzdGFydAo+ICAgICA+ID4gd29ya2luZyBvbiBkb2N1bWVu
dGF0aW9uLCBoZWxwaW5nIHBlb3BsZSB0byB1c2UsIHRvIGRldmVsb3AgYW5kIHRvCj4gICAgID4g
PiBtYWludGFpbiBMVFAgaW4gYW4gZWFzaWVyIHdheSwgaW5jcmVhc2luZyBxdWFsaXR5IG9mIHRo
ZQo+ICAgICBvdmVyYWxsIHByb2plY3QKPiAgICAgPiA+IGFuZCB0byBjYWxsIG1vcmUgZGV2ZWxv
cGVycyBpbiB0aGUgY29tbXVuaXR5Lgo+Cj4gICAgID4gPiBJIHN0YXJ0ZWQgdG8gd29yayBvbiBk
b2N1bWVudGF0aW9uIHJlZmFjdG9yaW5nLCByZS1vcmdhbml6aW5nIHRoZQo+ICAgICA+ID4gb3Zl
cmFsbCBzdHJ1Y3R1cmUuIFRoZSBmaXJzdCBwcm90b3R5cGUgY2FuIGJlIGZvdW5kIGhlcmU6Cj4K
PiAgICAgPiA+IGh0dHBzOi8vbHRwLWFjZXJ2LnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9pbmRl
eC5odG1sCj4KPgo+ICAgICA+IExvb2tzIGdyZWF0ISBUaGFua3MgZm9yIGJyaW5naW5nIHRoaXMu
Cj4KPiAgICAgPiBBbmQgSSBqdXN0IHRyaWVkIHRoYXQgdGhlIGxhdGVzdCBMVFAgY29tcGlsZWQg
JiBleGVjdXRlZCBzdWNjZWVkIG9uCj4gICAgID4gUkhFTC03LjkuCj4gICAgID4gQ2FuIHlvdSB1
cGRhdGUgdGhlICJPbGRlc3QgdGVzdGVkIGRpc3RyaWJ1dGlvbnMiIFsxXSBwYXJ0IGJ5IGFkZGlu
ZzoKPgo+ICAgICA+wqAgwqBSSEVMLTcuOSBNYWlwbyAoRGlzdHJvKcKgIDMuMTAgKGtlcm5lbCnC
oCA0LjguNShnY2MpCj4gICAgIDIuMTcoZ2xpYmMpwqAgLShjbGFuZykKPgo+ICAgICBBbHRob3Vn
aCBpbiB0aGUgb3JpZ2luYWwgZG9jcywgdGhlIHRhYmxlIHdhcyBub3QgdW5kZXIgc2VjdGlvbgo+
ICAgICAiQnVpbGQgdGVzdGluZwo+ICAgICB3aXRoIEdpdEh1YiBBY3Rpb25zIiwgSSBhc3N1bWVk
IGl0J3MgY2xlYXIgd2UgdGFsayBhYm91dCBHaXRIdWIKPiAgICAgQWN0aW9ucyB0ZXN0aW5nLgo+
ICAgICBUaGF0J3Mgd2h5IEkgcHV0IHRoZXJlIG9ubHkgZGlzdHJvcyB3ZSBhY3R1YWxseSBoYXZl
IGluCj4gICAgIC5naXRodWIvd29ya2Zsb3dzL2NpLnltbAo+ICAgICBhbmQgbm90IGUuZy4gU0xF
MTItU1AyIHdoaWNoIHdlIHRlc3Qgd2l0aCBsYXRlc3QgTFRQIHJlbGVhc2UuCj4KPiAgICAgSSBh
Y3R1YWxseSBmaW5kIHVzZWZ1bCB0byBzdGFuZCB3aGljaCBkaXN0cm9zIHdlIHRlc3QgcHJpdmF0
ZWx5LAo+ICAgICBidXQgdGhpcyBpbmZvCj4gICAgIHNob3VsZCBiZSBvYnZpb3VzIChlaXRoZXIg
YWRkIGEgY29sdW1uICJDSSIsIHdoZXJlIHdvdWxkIGJlCj4gICAgICJHaXRIdWIgQWN0aW9ucyIg
b3IKPiAgICAgIlJIRUwgcHJpdmF0ZSBDSSIgb3Igd2hhdGV2ZXIuCj4KPgo+Cj4gICAgIEBMaSBB
bmRyZWEgcHV0IHRoZXJlIGFzIG5ldyBpbmZvOiAiTWluaW1hbCBzdXBwb3J0ZWQga2VybmVsCj4g
ICAgIHZlcnNpb24gaXMgMy4xMC4iCj4gICAgIHdoaWNoIGlzIG5vdCBpbiBvbGQgZG9jcy4gRG8g
eW91IHJlYWxseSB0ZXN0IFJIRUwtNy45ICgzLjEwIGJhc2VkKQo+ICAgICB3aXRoIHRoZQo+ICAg
ICBsYXRlc3QgTFRQIHJlbGVhc2U/Cj4KPgo+IFllcywgSSBkaWQgYnV0IG9ubHkgY2hlY2tlZCBv
biBSSEVMLTcuOSB3aXRoIHg4Nl82NCBhbmQgczM5MHgKPiAoY29tcGlsZSAmIGV4ZWN1dGlvbiB3
ZWxsKSBsYXN0IHRpbWUuCj4KPiBBZnRlciByZWJ1aWxkaW5nIHRoZSBsYXRlc3QgYnJhbmNoIG9u
IGFsbCBhcmNoZXMsIEkgZm91bmQgdGhlIHJlc3QgCj4gYXJjaGVzwqBoYXZlCj4gcHJvYmxlbXMg
aW4gY29tcGlsaW5nIChmb3JnaXZlIG1lIGNhcmVsZXNzIGxhc3QgdGltZSkuCj4KPiBOb3cgSSBh
bSBoZXNpdGFudCB0byBmaXggdGhlIGVycm9yIG9yIHJhaXNlIHRoZSBiYXNlbGluZSB0byBSSEVM
OC4zLgo+IChJIHRhbGtlZCB0byBjb2xsZWFndWVzIGFuZCBnb3QgdG8ga25vdyB0aGV5IGFsd2F5
cyBjaG9zZSB0byB1c2UgZml4ZWQgCj4gdmVyc2lvbnMgb2YgTFRQIHdoZW4gPD1SSEVMOC4yKS4K
Pgo+Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIyAzLjEwLjAtMTEzNi5lbDcucHBjNjRsZQo+
Cj4gIyBnbGliYy0yLjE3LTMxNi5lbDcucHBjNjRsZQo+Cj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9t
IC91c3IvaW5jbHVkZS90ZXJtaW9zLmg6NDA6MCwKPiAgICAgICAgICAgICAgICAgICBmcm9tIC91
c3IvaW5jbHVkZS9iaXRzL2lvY3RsLXR5cGVzLmg6NSwKPiAgICAgICAgICAgICAgICAgICBmcm9t
IC91c3IvaW5jbHVkZS9zeXMvaW9jdGwuaDoyOSwKPiAgICAgICAgICAgICAgICAgICBmcm9tIC4u
Ly4uLy4uLy4uL2luY2x1ZGUvbGFwaS9pb2N0bC5oOjExLAo+ICAgICAgICAgICAgICAgICAgIGZy
b20gaW9jdGwwMi5jOjMxOgo+IC91c3IvaW5jbHVkZS9iaXRzL3Rlcm1pb3MuaDozMzo4OiBlcnJv
cjogcmVkZWZpbml0aW9uIG9mIOKAmHN0cnVjdCB0ZXJtaW9z4oCZCj4gICBzdHJ1Y3QgdGVybWlv
cyB7Cj4gICAgICAgICAgXgo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBpb2N0bDAyLmM6Mjk6MDoK
PiAvdXNyL2luY2x1ZGUvYXNtL3Rlcm1iaXRzLmg6MjI6ODogbm90ZTogb3JpZ2luYWxseSBkZWZp
bmVkIGhlcmUKPiAgIHN0cnVjdCB0ZXJtaW9zIHsKPiAgICAgICAgICBeCj4KPgo+ICAgICBAWWFu
ZyBYdSBJIGZvdW5kIHlvdSByZW1vdmVkIGZhbGxiYWNrcyB1cCB0byBrZXJuZWwgMy4xMDoKPgo+
ICAgICAwNmFkYTAzMjkgKCJSZW1vdmUgb2xkIGtlcm5lbCB2ZXJzaW9uIGNoZWNrIHdoZW4gdXNp
bmcgbWluX2t2ZXIKPiAgICAgdW5kZXIgMy4xMCIpCj4gICAgIDg2MmQ5NGM0NSAoIlJlbW92ZSBv
bGQga2VybmVsIHZlcnNpb24gY2hlY2sgd2hlbiB1c2luZyB0c3Rfa3ZlcmNtcAo+ICAgICB1bmRl
ciAzLjEwIikKPiAgICAgOTcxODI4YzAwICgic2hlbGw6IFJlbW92ZSBvbGQga2VybmVsIHZlcnNp
b24gY2hlY2sgYmVsb3cgMy4xMCIpCj4KPiAgICAgSG9wZWZ1bGx5IEkgaGF2ZW4ndCBvdmVybG9v
ayBhbnl0aGluZy4KPgo+ICAgICBAQW5kcmVhOiBBbHNvLCBJIHdvdWxkIHByZWZlciB0byBwdXQg
YmFjayBwYXJhZ3JhcGggIjEuIEJ1aWxkCj4gICAgIHRlc3Rpbmcgd2l0aAo+ICAgICBHaXRIdWIg
QWN0aW9ucyIuIEknbGwgc2VuZCBhIHBhdGNoLCB0byBmb3JjZSBteXNlbGYgdG8gbGVhcm4KPiAg
ICAgYnVpbGRpbmcgbmV3IGRvY3MuCj4KRmVlbCBmcmVlLCBJIHRoaW5rIGl0J3MgYSBnb29kIGlk
ZWEuIEF0IHRoZSBtb21lbnQgdGhlcmUncyBqdXN0IGEgc2hvcnQgCmNvbW1lbnQgYWJvdXQgR2l0
aHViIGFjdGlvbnMgaGVyZToKCmh0dHBzOi8vbGludXgtdGVzdC1wcm9qZWN0LnJlYWR0aGVkb2Nz
LmlvL2VuL2xhdGVzdC9kZXZlbG9wZXJzL3dyaXRpbmdfdGVzdHMuaHRtbCN0ZXN0aW5nLWJ1aWxk
cy13aXRoLWdpdGh1Yi1hY3Rpb25zCgoKPgo+ICAgICBLaW5kIHJlZ2FyZHMsCj4gICAgIFBldHIK
Pgo+ICAgICA+IFsxXQo+ICAgICBodHRwczovL2x0cC1hY2Vydi5yZWFkdGhlZG9jcy5pby9lbi9s
YXRlc3QvdXNlcnMvc3VwcG9ydGVkX3N5c3RlbXMuaHRtbAo+Cj4KPgo+IC0tIAo+IFJlZ2FyZHMs
Cj4gTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
