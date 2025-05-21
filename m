Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E1FC54756
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 02:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747792890; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=iosHyuWG4S4GvV2+pYuvlbaaZr5paflKZBBgSBLuKFg=;
 b=byFpMLJzL5uB8KEknpulufWtfs8ez7NDXpf77MT7rqg/5v4L4e15WfPjR8RHnGPRmbQqb
 va6fjWnZM63FT/ObcJMpPeynf40AfqTuEUcJKE9xUiPs7ElFEE1PxPBLSPntKR2Ou+2AJxW
 blG7W/+1dhvG+iSl+Ipp+0qkrWZomT4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 993CD3CC7B5
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 04:01:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC2393CC15D
 for <ltp@lists.linux.it>; Wed, 21 May 2025 04:01:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6687C602744
 for <ltp@lists.linux.it>; Wed, 21 May 2025 04:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747792865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOATx+xyoNKj0+evtuYPZfUaf50nX1YBCv1zlOGQXsc=;
 b=eJ6GO/Ryv3gLEu31A1GeSCNIpurWU5KcWCwD7RpXqeLOWI5ZY+TgNhc9Lq3HZ29c3eSPKN
 uZ/2qrJkMMuUYE+oOORXszzBoriOaWbTe7UP1/4Ses+6/rKywIa9S/YoJgnFHNxRf4jTzX
 TtVsWhU+vh+gJ6SywuUffdRjpdbzrAE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-X2OclBeKMaa8K8xp6ywWJg-1; Tue, 20 May 2025 22:01:03 -0400
X-MC-Unique: X2OclBeKMaa8K8xp6ywWJg-1
X-Mimecast-MFC-AGG-ID: X2OclBeKMaa8K8xp6ywWJg_1747792862
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22aa75e6653so44912845ad.0
 for <ltp@lists.linux.it>; Tue, 20 May 2025 19:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747792861; x=1748397661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nOATx+xyoNKj0+evtuYPZfUaf50nX1YBCv1zlOGQXsc=;
 b=A4lb0rmDozs0fVIbzKUoVHkOfZGstZzbCIjyO+gyGWDvx8pGrNSlXmXYV0tIPg5I7T
 jC8WbotwGNLKS5yXzctDjA5GG+Yxphl1k9Hk2Md6ksxSHkdjSAIidIL49kawfUVZcfny
 F3SdRtkt5KWfByBWS2ctHin65Tq/AI4yrmjRvnMDCYb7lVefBZhjNPCcyGKA55aHbOlb
 y2vWX5HARHpcYvKzT25+XDeA04NAh2423CNbTivQQ24rgawsfgyNmbL90+hnswYy3H7o
 m2Ze/2Ci3qmsP8/itRrb5BgFHAhOAihqwF8BWP5fdxgMB+tq8OqrEpjfH5oEq0QPnPRU
 AOQw==
X-Gm-Message-State: AOJu0YyAQkPEPLgjsXwYc7PIQXv9IJLun2ijarp1xiU7oYxtitTJ0dVi
 olCjGhWGPK8n2ZydrEgHgh5K89jH/Kc0FFxeqBn4/O0Z+2DSEx4FaeQDjn96/0S6MuFv+SDVxoJ
 nmiL87JF6NsGVWY/rv6hRXBdXr8AAV0ToyfLWI7gjRRK3Pr+xyINXd4wadopZnXW8E2VHZe+kZk
 Y8lCwVw4tL+bxoveUz6WmDCmq1Bj4=
X-Gm-Gg: ASbGnctAFXHbunPwNgXL196GHnjYnVBBqOn11fv8D6euKEGe/wPyeS2u+b5RDS8Z7Ql
 xhXt5Pt1vYuFXR7Lgory62WXms7R9lVsQ3Tzhpv11QZolsYjTnBjtRlJh5/4PSEPgqJAYXg==
X-Received: by 2002:a17:903:4b4b:b0:22d:c605:a30c with SMTP id
 d9443c01a7336-231d43d5532mr290527125ad.11.1747792860644; 
 Tue, 20 May 2025 19:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5cs1rtN2cHiYyvwNOU0b2/Y8Gc5N9OIXcOslsK31PG5B+MMEKrqfp7oOjlS26AMvduhn7xxsJYxfJBV06nv4=
X-Received: by 2002:a17:903:4b4b:b0:22d:c605:a30c with SMTP id
 d9443c01a7336-231d43d5532mr290526755ad.11.1747792860186; Tue, 20 May 2025
 19:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <5964b0f9-e422-46b9-bab1-04e699e2f5f6@oracle.com>
 <CAEemH2e7+2o=rM3sCoDVXgepjWessmtX9FOgHa15Ue7uFLwUSg@mail.gmail.com>
 <e20262e4-6df1-4b26-ae43-da6c8b3bcc6d@oracle.com>
In-Reply-To: <e20262e4-6df1-4b26-ae43-da6c8b3bcc6d@oracle.com>
Date: Wed, 21 May 2025 10:00:48 +0800
X-Gm-Features: AX0GCFt-0Gn6Eg5E4dBF-eQrBSo-5fDMh00BywDqsX6ShZ0999jYFRDl9l84NJE
Message-ID: <CAEemH2eYbE076mjEGNGmABywH6vrTauGJzuO98cibcw=6yp-iA@mail.gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V8ETorMttQdj_MzAIC2VI8Bu1uSIhpfHHp-sC7xPR8I_1747792862
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] latest ltp not building on RHEL 9.6 ?
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXkgMjAsIDIwMjUgYXQgMTE6MTbigK9QTSBDaHVjayBMZXZlciA8Y2h1Y2subGV2
ZXJAb3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBPbiA1LzE5LzI1IDg6MzggUE0sIExpIFdhbmcgd3Jv
dGU6Cj4gPiBPbiBUdWUsIE1heSAyMCwgMjAyNSBhdCAyOjQw4oCvQU0gQ2h1Y2sgTGV2ZXIgdmlh
IGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPiA+Pgo+ID4+IEhpIC0KPiA+Pgo+ID4+
IE15IGRhaWx5IENJIGJ1aWxkcyBsdHAgYW5kIHJ1bnMgaXQgYWdhaW5zdCBteSBuZnNkLXRlc3Rp
bmcgYnJhbmNoLgo+ID4+IEZvciB0aGUgcGFzdCB3ZWVrIG9yIHNvLCB0aGUgbHRwIGJ1aWxkIGZh
aWxzIHdpdGg6Cj4gPj4KPiA+PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gY3ZlLTIwMTctMTY5Mzku
YzoyODoKPiA+PiAuLi8uLi9pbmNsdWRlL2xhcGkvc2NoZWQuaDoxODo4OiBlcnJvcjogcmVkZWZp
bml0aW9uIG9mIOKAmHN0cnVjdCBzY2hlZF9hdHRy4oCZCj4gPj4gICAgMTggfCBzdHJ1Y3Qgc2No
ZWRfYXR0ciB7Cj4gPj4gICAgICAgfCAgICAgICAgXn5+fn5+fn5+fgo+ID4+IEluIGZpbGUgaW5j
bHVkZWQgZnJvbSAvdXNyL2luY2x1ZGUvYml0cy9zY2hlZC5oOjYwLAo+ID4+ICAgICAgICAgICAg
ICAgICAgZnJvbSAvdXNyL2luY2x1ZGUvc2NoZWQuaDo0MywKPiA+PiAgICAgICAgICAgICAgICAg
IGZyb20gLi4vLi4vaW5jbHVkZS9sYXBpL3NjaGVkLmg6MTAsCj4gPj4gICAgICAgICAgICAgICAg
ICBmcm9tIGN2ZS0yMDE3LTE2OTM5LmM6Mjg6Cj4gPj4gL3Vzci9pbmNsdWRlL2xpbnV4L3NjaGVk
L3R5cGVzLmg6MTAyOjg6IG5vdGU6IG9yaWdpbmFsbHkgZGVmaW5lZCBoZXJlCj4gPj4gICAxMDIg
fCBzdHJ1Y3Qgc2NoZWRfYXR0ciB7Cj4gPj4gICAgICAgfCAgICAgICAgXn5+fn5+fn5+fgo+ID4+
Cj4gPj4gVGhlIHRlc3QgcnVubmVyIGlzIGEgUkhFTCA5LjYgZ3Vlc3QuIEkgZG9uJ3Qgc2VlIGFu
eSByZWNlbnQgY2hhbmdlcyB0bwo+ID4+IGx0cCBpbiB0aGlzIGFyZWEsIHNvIHBlcmhhcHMgOS42
IG1vZGlmaWVkIC91c3IvaW5jbHVkZS9saW51eC9zY2hlZC5oID8KPiA+Cj4gPiBJIHNhdyB0aGF0
IExUUCBoYXMgYWxyZWFkeSBoYW5kbGUgdGhhdCBjb25mbGljdCBpbiBsYXBpIGhlYWRlciBmaWxl
LCBpbiBjb21taXQKPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRw
L2NvbW1pdC9jNDg3MDBkOGNkYmU2ZDBkNzhmZGE2ZTZjYzY1ODk3MjQ2NGI1Y2NkCj4gPgo+ID4g
Q2FuIHlvdSBwcm92aWRlIHRoZSB2ZXJzaW9uIG9mIHlvdXIga2VybmVsLWhlYWRlciBhbmQgZ2xp
YmM/Cj4gPgo+ID4gZS5nLgo+ID4gJCBycG0gLXFmIC91c3IvaW5jbHVkZS9saW51eC9zY2hlZC90
eXBlcy5oCj4gPgo+ID4gJCBycG0gLXFmIC91c3IvaW5jbHVkZS9iaXRzL3NjaGVkLmgKPgo+IEhp
IQo+Cj4gSSB0ZXN0IHJlY2VudCBrZXJuZWxzIGluIHRoaXMgc2V0LXVwLCBzbyBJIGluY2x1ZGVk
IHRoZSBvdXRwdXQgb2YKPiAidW5hbWUiIGluIGNhc2UgdGhhdCBpcyByZWxldmFudC4KPgo+IFtr
ZGV2b3BzQGx0cC1ub3RpZnkgfl0kIHVuYW1lIC1yCj4gNi4xNS4wLXJjNi1nNzI3ODU2OTc0MGY2
Cj4gW2tkZXZvcHNAbHRwLW5vdGlmeSB+XSQgcnBtIC1xZiAvdXNyL2luY2x1ZGUvbGludXgvc2No
ZWQvdHlwZXMuaAo+IGtlcm5lbC1oZWFkZXJzLTUuMTQuMC01NzAuMTcuMS5lbDlfNi54ODZfNjQK
PiBba2Rldm9wc0BsdHAtbm90aWZ5IH5dJCBycG0gLXFmIC91c3IvaW5jbHVkZS9iaXRzL3NjaGVk
LmgKPiBnbGliYy1oZWFkZXJzLTIuMzQtMTY4LmVsOV82LjE0Lng4Nl82NAo+IFtrZGV2b3BzQGx0
cC1ub3RpZnkgfl0kIGNhdCAvZXRjL3JlZGhhdC1yZWxlYXNlCj4gUmVkIEhhdCBFbnRlcnByaXNl
IExpbnV4IHJlbGVhc2UgOS42IChQbG93KQo+IFtrZGV2b3BzQGx0cC1ub3RpZnkgfl0kCj4KPiBJ
IGd1ZXNzIG9uZSB0aGluZyBJIG1pZ2h0IHRyeSBpcyBydW5uaW5nIHRoZSBsdHAgYnVpbGQgb24g
YSBzdG9jawo+IFJIRUwgOS42IGtlcm5lbC4gSSdtIG5vdCBzdXJlIGlmIHRoZSB0ZXN0IHdvcmtm
bG93IHJlcGxhY2VzIHRoZQo+IGtlcm5lbCBoZWFkZXJzIHVuZGVyIC91c3IvaW5jbHVkZS4KCgpU
aGF0J3Mgd2VpcmQsIEkgd2Fzbid0IGFibGUgdG8gcmVwcm9kdWNlIHRoaXMgb24gdGhlIHNhbWUg
ZW52LgpZb3VyIHRlc3Qgc3lzdGVtIG1heSBiZSBwb2xsdXRlZCB3aXRoIG5ldyBrZXJuZWwgaGVh
ZGVycy4KCkFuZCwgeW91IG1pZ2h0IG5lZWQgdG8gbWFudWFsbHkgY2hlY2sgdGhlIHN0cnVjdCBz
Y2hlZF9hdHRyCmluIGJvdGggIC91c3IvaW5jbHVkZS9iaXRzL3NjaGVkLmggYW5kIC91c3IvaW5j
bHVkZS9saW51eC9zY2hlZC90eXBlcy5oCnRvIHNlZSBpZiBzb21ldGhpbmcgZGlmZmVyZW50LgoK
IyBjYXQgL3Vzci9pbmNsdWRlL2JpdHMvc2NoZWQuaAouLi4KIDU0IC8qIFVzZSAiIiB0byB3b3Jr
IGFyb3VuZCBpbmNvcnJlY3QgbWFjcm8gZXhwYW5zaW9uIG9mIHRoZQogNTUgICAgX19oYXNfaW5j
bHVkZSBhcmd1bWVudCAoR0NDIFBSIDgwMDA1KS4gICovCiA1NiAjIGlmZGVmIF9faGFzX2luY2x1
ZGUKIDU3ICMgIGlmIF9faGFzX2luY2x1ZGUgKCJsaW51eC9zY2hlZC90eXBlcy5oIikKIDU4IC8q
IFNvbWUgb2xkZXIgTGludXggdmVyc2lvbnMgZGVmaW5lZCBzY2hlZF9wYXJhbSBpbgo8bGludXgv
c2NoZWQvdHlwZXMuaD4uICAqLwogNTkgIyAgIGRlZmluZSBzY2hlZF9wYXJhbSBfX2dsaWJjX21h
c2tfc2NoZWRfcGFyYW0KIDYwICMgICBpbmNsdWRlIDxsaW51eC9zY2hlZC90eXBlcy5oPgogNjEg
IyAgIHVuZGVmIHNjaGVkX3BhcmFtCiA2MiAjICBlbmRpZgogNjMgIyBlbmRpZgogNjQgIyBpZm5k
ZWYgU0NIRURfQVRUUl9TSVpFX1ZFUjAKIDY1ICMgIGluY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CiA2
NiAjICBkZWZpbmUgU0NIRURfQVRUUl9TSVpFX1ZFUjAgNDgKIDY3ICMgIGRlZmluZSBTQ0hFRF9B
VFRSX1NJWkVfVkVSMSA1NgogNjggc3RydWN0IHNjaGVkX2F0dHIKIDY5IHsKIDcwICAgX191MzIg
c2l6ZTsKIDcxICAgX191MzIgc2NoZWRfcG9saWN5OwogNzIgICBfX3U2NCBzY2hlZF9mbGFnczsK
IDczICAgX19zMzIgc2NoZWRfbmljZTsKIDc0ICAgX191MzIgc2NoZWRfcHJpb3JpdHk7CiA3NSAg
IF9fdTY0IHNjaGVkX3J1bnRpbWU7CiA3NiAgIF9fdTY0IHNjaGVkX2RlYWRsaW5lOwogNzcgICBf
X3U2NCBzY2hlZF9wZXJpb2Q7CiA3OCAgIF9fdTMyIHNjaGVkX3V0aWxfbWluOwogNzkgICBfX3Uz
MiBzY2hlZF91dGlsX21heDsKIDgwICAgLyogQWRkaXRpb25hbCBmaWVsZHMgbWF5IGJlIGFkZGVk
IGF0IHRoZSBlbmQuICAqLwogODEgfTsKIDgyICMgZW5kaWYgLyogIVNDSEVEX0FUVFJfU0laRV9W
RVIwICovCgoKIyBjYXQgL3Vzci9pbmNsdWRlL2xpbnV4L3NjaGVkL3R5cGVzLmgKLi4uCgojZGVm
aW5lIFNDSEVEX0FUVFJfU0laRV9WRVIwIDQ4IC8qIHNpemVvZiBmaXJzdCBwdWJsaXNoZWQgc3Ry
dWN0ICovCiNkZWZpbmUgU0NIRURfQVRUUl9TSVpFX1ZFUjEgNTYgLyogYWRkOiB1dGlsX3ttaW4s
bWF4fSAqLwoKc3RydWN0IHNjaGVkX2F0dHIgewpfX3UzMiBzaXplOwoKX191MzIgc2NoZWRfcG9s
aWN5OwpfX3U2NCBzY2hlZF9mbGFnczsKCi8qIFNDSEVEX05PUk1BTCwgU0NIRURfQkFUQ0ggKi8K
X19zMzIgc2NoZWRfbmljZTsKCi8qIFNDSEVEX0ZJRk8sIFNDSEVEX1JSICovCl9fdTMyIHNjaGVk
X3ByaW9yaXR5OwoKLyogU0NIRURfREVBRExJTkUgKi8KX191NjQgc2NoZWRfcnVudGltZTsKX191
NjQgc2NoZWRfZGVhZGxpbmU7Cl9fdTY0IHNjaGVkX3BlcmlvZDsKCi8qIFV0aWxpemF0aW9uIGhp
bnRzICovCl9fdTMyIHNjaGVkX3V0aWxfbWluOwpfX3UzMiBzY2hlZF91dGlsX21heDsKCn07CgoK
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gdGVzdCByZXN1bHQgb24gbXkgY2xlYW4gOS42IC0t
LS0tLS0tLS0tLS0tLS0tLS0tCgojIGNhdCAvZXRjL3JlZGhhdC1yZWxlYXNlClJlZCBIYXQgRW50
ZXJwcmlzZSBMaW51eCByZWxlYXNlIDkuNiAoUGxvdykKCiMgdW5hbWUgLXIKNS4xNC4wLTU3MC4x
Ny4xLmVsOV82Lng4Nl82NAoKIyBycG0gLXFmIC91c3IvaW5jbHVkZS9saW51eC9zY2hlZC90eXBl
cy5oCmtlcm5lbC1oZWFkZXJzLTUuMTQuMC01NzAuMTcuMS5lbDlfNi54ODZfNjQKCiMgcnBtIC1x
ZiAvdXNyL2luY2x1ZGUvYml0cy9zY2hlZC5oCmdsaWJjLWhlYWRlcnMtMi4zNC0xNjguZWw5XzYu
MTQueDg2XzY0CgoKIyBWPTEgbWFrZQpnY2MgLUkuLi8uLi9pbmNsdWRlIC1JLi4vLi4vaW5jbHVk
ZSAtSS4uLy4uL2luY2x1ZGUvb2xkLyAtV2Zvcm1hdAotV2Vycm9yPWZvcm1hdC1zZWN1cml0eSAt
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uCi1XZXJyb3I9cmV0dXJuLXR5cGUg
LWZuby1jb21tb24gLWcgLU8yIC1mbm8tc3RyaWN0LWFsaWFzaW5nIC1waXBlCi1XYWxsIC1XIC1X
b2xkLXN0eWxlLWRlZmluaXRpb24gLXN0ZD1nbnU5OSAtRF9HTlVfU09VUkNFIC1MLi4vLi4vbGli
CmN2ZS0yMDE3LTE2OTM5LmMgIC1sbHRwIC1vIGN2ZS0yMDE3LTE2OTM5CgojIGVjaG8gJD8KMAoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
