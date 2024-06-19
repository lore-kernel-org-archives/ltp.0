Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B174C27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 15:50:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0B453D0DD4
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 17:50:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12FAC3D0B3E
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 17:50:21 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=sandeen@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C492F20723E
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 17:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718812218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bca52+KHJpYXad3d6s5t9DXJS072JLebI7oVilD5KVE=;
 b=FMPefbQdSW6NMihYT5SfPxlB/LhWUgNS8i79HhVCET9BnqRFu/atgr0talHuUEm6w5OEc8
 4vYwxPgRMsjHuTR+L+nPrPAJtyk/yFF0wILXteRIWjy3ZRfupg9EodfrLwbfn0gt+9PorC
 A0nBoZbKNxjeR5LooHOCyJg4+Sc1YgA=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-VvmJfYC9PemGtXQl9PkUdw-1; Wed, 19 Jun 2024 11:50:17 -0400
X-MC-Unique: VvmJfYC9PemGtXQl9PkUdw-1
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3762363a522so6189055ab.1
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 08:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718812216; x=1719417016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bca52+KHJpYXad3d6s5t9DXJS072JLebI7oVilD5KVE=;
 b=Kr3O/nqCbRwJtVmD121dI2QUg3lE+E3V7NQBm5MT+pWP2ul+fojNrmBXTN5nDhq6E+
 FELXWVyMmEx/+DVY3FjH8n7TqtBwYhugDsUILVpccr2rXkxAw8swVq/rZlgvNN+3yJMJ
 or08qGcYHEqyGmtUuvMdEzjlrb/4s/VYFb+wQI0LMMyFRgF3JMWBzPB80vQGo1JlKzP+
 FitxT/Lw8Emj8hm+CMZv8TJe5sSYCzQv/RpLECJOUuQmKWdpFXwVUmEPKqtAL6+HhhYZ
 q50DrkP4/3DaBBi7VzTyEVEL8HlM/DE3dH0OZMmF6xjVOT+wPyogD5mkVOnoG9Sy5Dfl
 VvGg==
X-Gm-Message-State: AOJu0Yza/eyhUjAaxlaeqBnRWPJS74gN5z1+FojjjGFlmO5e/d5wFn4y
 LtVRPTqWq+Mv7ENT/dLVBsWOHisdvF8T3LPCSxODrWJB7gjJXlmzFWB3NtY3KhBOopqWc4V3Oc5
 Wu46pzVLCAggA6Bw5P8/TRjHjPfMW2zVZ/vPkB2/VXELFyOnm
X-Received: by 2002:a05:6e02:1a09:b0:375:c473:4a78 with SMTP id
 e9e14a558f8ab-3761d6f1e8bmr29238105ab.23.1718812216497; 
 Wed, 19 Jun 2024 08:50:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWU+e/0QED9sYApsPJcJHWfCz30zKTwOAJIMKvSPRsQmg91cgdYoAtJuz30ijOikL77Qcnyw==
X-Received: by 2002:a05:6e02:1a09:b0:375:c473:4a78 with SMTP id
 e9e14a558f8ab-3761d6f1e8bmr29237915ab.23.1718812216105; 
 Wed, 19 Jun 2024 08:50:16 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375d866e36asm27249415ab.5.2024.06.19.08.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 08:50:15 -0700 (PDT)
Message-ID: <7aeebecc-d5ef-4eea-a4e5-ddbfa411ee1e@redhat.com>
Date: Wed, 19 Jun 2024 10:50:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Petr Vorel <pvorel@suse.cz>,
 Zirong Lang <zlang@redhat.com>, Boyang Xue <bxue@redhat.com>
References: <20240617053436.301336-1-liwang@redhat.com>
 <20240619092704.GA428912@pevik>
 <CAEemH2d=m3qAJkiv86B+L+iTc5qc+phGn+GO=kEe_fGOXxEMLQ@mail.gmail.com>
 <CAEemH2fH6tX9obxcVS6XJLcMvAvOz-JPe6wWoQdv26x8GAx2rQ@mail.gmail.com>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <CAEemH2fH6tX9obxcVS6XJLcMvAvOz-JPe6wWoQdv26x8GAx2rQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: Add _GNU_SOURCE for struct
 fs_quota_statv check
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
Cc: linux-xfs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gNi8xOS8yNCA3OjA4IEFNLCBMaSBXYW5nIHdyb3RlOgo+IGNjwqBFcmljIFNhbmRlZW4gPHNh
bmRlZW5AcmVkaGF0LmNvbSA8bWFpbHRvOnNhbmRlZW5AcmVkaGF0LmNvbT4+IHdobyBpcyB0aGUg
YXV0aG9ywqBvZjoKCklmIGFkZGluZyBfR05VX1NPVVJDRSB0byB0aGUgTFRQIGNvbmZpZ3VyZS5h
YyBmaXhlcyB0aGUgcHJvYmxlbSwKSSBoYXZlIG5vIGNvbmNlcm5zIGFib3V0IHRoYXQuCgpIb3dl
dmVyLCBJIGFsc28gc2VudCBhIHBhdGNoIHRvIGZpeCB4ZnNwcm9ncyAtIGhhdmluZyB0aGlzIHdy
YXBwZXIgaW4gdGhlCmhlYWRlciBpcyByZWFsbHkgdW5uZWNlc3NhcnksIGFuZCB3aWxsIGxpa2Vs
eSBjYXVzZSBwcm9ibGVtcyBmb3Igb3RoZXJzCmFzIHdlbGwsIHNvIEkganVzdCBwcm9wb3NlZCBy
ZW1vdmluZyBpdC4KCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXhmcy9iZTdmMDg0NS01
ZDVmLTRhZjUtOWNhOS0zZTQzNzBiNDdkOTdAc2FuZGVlbi5uZXQvCiAKKFRoaXMgcHJvYmxlbSBv
bmx5IHJlY2VudGx5IHNob3dlZCB1cCBkdWUgdG8gb3RoZXIgY2hhbmdlcywgc2VlIHRoZSBleHBs
YW5hdGlvbgppbiB0aGUgbGluayBhYm92ZSkKClRoYW5rcywKLUVyaWMKCj4gY29tbWl0IDlkNjAy
M2E4NTZhMWM0Zjg0NDE1ZGZmNTliMGQ1NDU5Y2M4NzY4ZGIKPiBBdXRob3I6IEVyaWMgU2FuZGVl
biA8c2FuZGVlbkByZWRoYXQuY29tIDxtYWlsdG86c2FuZGVlbkByZWRoYXQuY29tPj4KPiBEYXRl
OiDCoCBUaHUgRmViIDI3IDE1OjA1OjQ4IDIwMjAgLTA1MDAKPiAKPiDCoCDCoCBsaWJ4ZnM6IHVz
ZSBGQUxMT0NfRkxfWkVST19SQU5HRSBpbiBsaWJ4ZnNfZGV2aWNlX3plcm8KPiAKPiBPbiBXZWQs
IEp1biAxOSwgMjAyNCBhdCA4OjA14oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20gPG1h
aWx0bzpsaXdhbmdAcmVkaGF0LmNvbT4+IHdyb3RlOgo+IAo+ICAgICBIaSBQZXRyLCBYRlMtRXhw
ZXJ0cywKPiAKPiAgICAgT24gV2VkLCBKdW4gMTksIDIwMjQgYXQgNToyN+KAr1BNIFBldHIgVm9y
ZWwgPHB2b3JlbEBzdXNlLmN6IDxtYWlsdG86cHZvcmVsQHN1c2UuY3o+PiB3cm90ZToKPiAKPiAg
ICAgICAgIEhpIExpLAo+IAo+ICAgICAgICAgPiBUaGVzZSBjaGFuZ2VzIGhlbHAgZW5zdXJlIHRo
YXQgdGhlIG5lY2Vzc2FyeSBmZWF0dXJlcyBhbmQgZGVmaW5pdGlvbnMKPiAgICAgICAgID4gYXJl
IGF2YWlsYWJsZSBkdXJpbmcgdGhlIGNvbmZpZ3VyYXRpb24gcHJvY2VzcywgcHJldmVudGluZyBw
b3RlbnRpYWwKPiAgICAgICAgID4gaXNzdWVzIHJlbGF0ZWQgdG8gbWlzc2luZyBvciBpbmNvbXBh
dGlibGUgZGVmaW5pdGlvbnMuIFRoaXMgc2hvdWxkCj4gICAgICAgICA+IHJlc29sdmUgdGhlIGNv
bXBpbGF0aW9uIGVycm9yIHJlbGF0ZWQgdG8gc3RydWN0IGZzX3F1b3RhX3N0YXR2Ogo+IAo+ICAg
ICAgICAgPsKgIC91c3IvaW5jbHVkZS94ZnMveHFtLmg6MTY3Ojg6IGVycm9yOiByZWRlZmluaXRp
b24gb2Yg4oCYc3RydWN0IGZzX3FmaWxlc3RhdHbigJkKPiAKPiAgICAgICAgIEkgd29uZGVyIGhv
dyBfR05VX1NPVVJDRSBpbmZsdWVuY2VzIGFueSBYRlMgaGVhZGVyPwo+ICAgICAgICAgSSBoYXZl
bid0IGZvdW5kIGFueXRoaW5nIGluICg8eGZzLyouaD4pIG9yIGluIDxzeXMvcXVvdGEuaD4KPiAK
PiAKPiAgICAgV2l0aCBpbnN0YWxsaW5nIGEgbmV3ZXIgeGZzcHJvZ3MtZGV2IHBhY2thZ2Ugb24g
UkhFTCwgd2UgZ290wqBhIHByb2JsZW0KPiAgICAgaW4gY29uZmlndXJpbmfCoG91ciBMVFAgdGVz
dC4KPiAKPiAgICAgQWNjb3JkaW5nIHRvIHRoZSBpbmNsdXNpb24gcmVsYXRpb25zaGlwOiAieGZz
L3hxbS5oIiAtPiAieGZzL3hmcy5oIiAtPiAieGZzL2xpbnV4LmgiLgo+ICAgICBUaGUgbGludXgu
aCBoZWFkZXIgaW50cm9kdWNlcyBhbiBpbmxpbmVkIGZ1bmN0aW9uIHRoYXQgbmVlZHMgJ19HTlVf
U09VUkNFJyBhbmQgPGZjbmN0bC5oPi4KPiAKPiAgICAgJCBnaXQgY2xvbmUgaHR0cHM6Ly9rZXJu
ZWwuZ29vZ2xlc291cmNlLmNvbS9wdWIvc2NtL2ZzL3hmcy94ZnNwcm9ncy1kZXYgPGh0dHBzOi8v
a2VybmVsLmdvb2dsZXNvdXJjZS5jb20vcHViL3NjbS9mcy94ZnMveGZzcHJvZ3MtZGV2Pgo+ICAg
ICAkIGNkIHhmc3Byb2dzLWRldi8KPiAgICAgJCBnaXQgZGVzY3JpYmUgLS1jb250YWlucyA5ZDYw
MjNhODU2YTFjNGY4NDQxNWRmZjU5YjBkNTQ1OWNjODc2OGRiCj4gICAgIHY1LjUuMC1yYzF+MzkK
PiAKPiAgICAgI2lmIGRlZmluZWQoRkFMTE9DX0ZMX1pFUk9fUkFOR0UpCj4gICAgIHN0YXRpYyBp
bmxpbmUgaW50Cj4gICAgIHBsYXRmb3JtX3plcm9fcmFuZ2UoCj4gICAgIMKgIMKgIMKgIMKgIGlu
dMKgIMKgIMKgIMKgIGZkLAo+ICAgICDCoCDCoCDCoCDCoCB4ZnNfb2ZmX3TCoCDCoCDCoCDCoCBz
dGFydCwKPiAgICAgwqAgwqAgwqAgwqAgc2l6ZV90wqAgwqAgwqAgwqAgbGVuKQo+ICAgICB7Cj4g
ICAgIMKgIMKgIMKgIMKgIGludCByZXQ7Cj4gCj4gICAgIMKgIMKgIMKgIMKgIHJldCA9IGZhbGxv
Y2F0ZShmZCwgRkFMTE9DX0ZMX1pFUk9fUkFOR0UsIHN0YXJ0LCBsZW4pOwo+ICAgICDCoCDCoCDC
oCDCoCBpZiAoIXJldCkKPiAgICAgwqAgwqAgwqAgwqAgcmV0dXJuIDA7Cj4gICAgIMKgIMKgIMKg
IMKgIHJldHVybiAtZXJybm87Cj4gICAgIH0KPiAgICAgI2Vsc2UKPiAgICAgI2RlZmluZSBwbGF0
Zm9ybV96ZXJvX3JhbmdlKGZkLCBzLCBsKSAoLUVPUE5PVFNVUFApCj4gICAgICNlbmRpZgo+IAo+
IAo+ICAgICBNeSB0ZXN0IHZlcnNpb24gaXMgYmFzZWQgb24gNi41IHNvIGNvbnRhaW5zIHRoZSBp
bmxpbmVkIGZ1bmN0aW9uIHRvIGJ1aWxkLgo+IAo+ICAgICAjIHJwbSAtcWYgL3Vzci9pbmNsdWRl
L3hmcy94cW0uaAo+ICAgICB4ZnNwcm9ncy1kZXZlbC02LjUuMC0zLmVsMTAueDg2XzY0Cj4gCj4g
ICAgIMKgCj4gCj4gICAgICAgICBJIGtub3cgdGhhdCBzb21lIHF1b3RhY3RsMFsyM10uYyBkZWZp
bmUgX0dOVV9TT1VSQ0UsIGJ1dCBpdCdzIGludGVyZXN0aW5nIHRoYXQKPiAgICAgICAgIHRoaXMg
aW5mbHVlbmNlIHRoZSBoZWFkZXIuIEFsc28sIHdoaWNoIFJIRUwgKG9yIHdoYXRldmVyIGRpc3Ry
bykgdmVyc2lvbiBoYXMKPiAgICAgICAgIHRoaXMgcHJvYmxlbT8KPiAKPiAKPiAgICAgVGhlIGVy
cm9yIG9jY3VycmVkICh3aXRoIGluc3RhbGwgeGZzcHJvZ3MtZGV2ZWwpIGR1cmluZyB0aGUgY29u
ZmlndXJlIHNjcmlwdAo+ICAgICBjaGVja2luZyBzdHJ1Y3QgZnNfcXVvdGFfc3RhdHYuIEl0IGZh
aWxlZCB0byBjb21waWxlwqBjb25mdGVzdC5jIGFuZCByZXBvcnQKPiAgICAgc3VjaCBlcnJvcnM6
Cj4gCj4gICAgIGNvbmZpZ3VyZTo1Njk3OiBjaGVja2luZyBmb3Igc3RydWN0IGZzX3F1b3RhX3N0
YXR2Cj4gICAgIGNvbmZpZ3VyZTo1Njk3OiBnY2MgLWMgLWcgLU8yIMKgY29uZnRlc3QuYyA+JjUK
PiAgICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS94ZnMveGZzLmg6OSwKPiAg
ICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcm9tIC91c3IvaW5jbHVkZS94ZnMveHFtLmg6
OSwKPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcm9tIGNvbmZ0ZXN0LmM6MTM4Ogo+
ICAgICAvdXNyL2luY2x1ZGUveGZzL2xpbnV4Lmg6IEluIGZ1bmN0aW9uICdwbGF0Zm9ybV96ZXJv
X3JhbmdlJzoKPiAgICAgL3Vzci9pbmNsdWRlL3hmcy9saW51eC5oOjE4ODoxNTogZXJyb3I6IGlt
cGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdmYWxsb2NhdGUnIFstV2ltcGxpY2l0LWZ1
bmN0aW9uLWRlY2xhcmF0aW9uXQo+ICAgICDCoCAxODggfCDCoCDCoCDCoCDCoCByZXQgPSBmYWxs
b2NhdGUoZmQsIEZBTExPQ19GTF9aRVJPX1JBTkdFLCBzdGFydCwgbGVuKTsKPiAgICAgwqAgwqAg
wqAgfCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBefn5+fn5+fn4KPiAgICAgY29uZmlndXJlOjU2OTc6
ICQ/ID0gMQo+ICAgICDCoAo+ICAgICBJdCBzaW1pbGFybHkgdG8gdGhlIGFib3ZlIHF1b3RhY3Rs
MDcgcGF0Y2hmaXgsIHNvIGFkZGluZyAnI2RlZmluZSBfR05VX1NPVVJDRScKPiAgICAgaXNhY3R1
YWxseSBmb3JtYWtpbmcgdGhlIGZhbGxvY2F0ZSgpaGFwcHkuCj4gCj4gICAgIE9yLCBhbm90aGVy
IHdheSBpcyB0aGUgY2hhbmdlIG1hZGUgaW4gInhmc3Byb2dzLWRldi9pbmNsdWRlL2xpbnV4Lmgi
IG90aGVyd2lzZSB3ZSBjYW4ndAo+ICAgICBjb25maWd1cmUgb3VyIExUUCBjb3JyZWN0bHkuCj4g
Cj4gCj4gICAgIC0tIAo+ICAgICBSZWdhcmRzLAo+ICAgICBMaSBXYW5nCj4gCj4gCj4gCj4gLS0g
Cj4gUmVnYXJkcywKPiBMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
