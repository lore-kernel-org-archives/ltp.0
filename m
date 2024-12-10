Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4235CE7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 08:48:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C9843E62B4
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 09:48:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EEDB3E62B4
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 09:48:33 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 499481183001
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 09:48:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733820509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jk5A99mpeviCd9NRJKkJzepCUWQQ6By6uCibkT1XlbU=;
 b=bIQu7VTXzxNkjNMl5Dnp/YSmK2XuEC4fxSD6MxBYosNIkbAny3c9VPyjH3ShyRlrEstcz5
 CsevWEHKkplRdSaKjvr860Gq1/fQvhCx0PZpEo/NwJ5NmMuYkBJLEz9PXSdYCKl8IjPY+V
 mUNRbf6PHmGo3c4k+H+p9Nm8OqE4JnU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-MP_GqvE8O8yiXofqH3bkNA-1; Tue, 10 Dec 2024 03:48:27 -0500
X-MC-Unique: MP_GqvE8O8yiXofqH3bkNA-1
X-Mimecast-MFC-AGG-ID: MP_GqvE8O8yiXofqH3bkNA
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2efa0eb9cfeso1948544a91.0
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 00:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733820506; x=1734425306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jk5A99mpeviCd9NRJKkJzepCUWQQ6By6uCibkT1XlbU=;
 b=um5qmk8k1iHX6ApYfXY6M+goBZ/eeajyJYrrrmEURUjiYEbrdJZV44jnjnxXKVeZ+5
 DBhasfrf9mNDahxXv2qEbbjTUMytu9tl7y8PQjHScDHiAGpJTFlh3ySgcOuGmEOAemf4
 XU1w28JsIWnCaiEH27mRSvBj3n1HpeM8OveuTJeIMliIPz4WcgpP3YQXrdnpRrKXQEbK
 QSRLYM/J1tnQhIYTqwrIMp2G/OSB0Q57c7DiuMTqi7m8s7cpW+2NZHzwEA9+irxNE1dO
 W5/Z2yDk4HZthdkUolAJVoyCma4lH2CLd/YtJHP1mZgLIh3Vi6kCF973Lx6vNvrrBw87
 e6OQ==
X-Gm-Message-State: AOJu0Yz30ZogKWLeLECle7gsgsdUKNakkfFNHLdjpMny7cUoWzXt+s+n
 fdIJwRZ0o1T4XwSno2dCxR2VCBDMTN0rGS1+BFjdRUeweAtd9Q2eOTdtraSJeaR1KRbMtxUxN/y
 DfO33oNTPMKnnxKCI5fcjs4RC9/PTlVt/pJ15vU4x60AzT0/6RgT77fF4RXECxuH79KFrOc850k
 ZykKP/vW2Uw2hCNY9zajKc4tA=
X-Gm-Gg: ASbGncuaxQN47G5D6OtyHRm50sdZASUh4jNq1vn+SZs1wOOrsw4O4qeCKzyvn/d16cm
 P6FmZaeWGPg0nFaKFMZ62e6dz93YG9dCn8Uie
X-Received: by 2002:a17:90a:c301:b0:2ee:823e:39c4 with SMTP id
 98e67ed59e1d1-2efd5a974a6mr4539917a91.7.1733820506404; 
 Tue, 10 Dec 2024 00:48:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjsv3spNOPpF/Ja6oYxK3yxN54Y3ytPdeEU5OXf89TiD/PG87Meu4Md7Ib8EabnDUgxrTs7UglEfhfb1YwPMg=
X-Received: by 2002:a17:90a:c301:b0:2ee:823e:39c4 with SMTP id
 98e67ed59e1d1-2efd5a974a6mr4539887a91.7.1733820505828; Tue, 10 Dec 2024
 00:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20241207085754.159597-1-liwang@redhat.com>
 <Z1b4YRIly1R1DtBS@yuki.lan>
In-Reply-To: <Z1b4YRIly1R1DtBS@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Tue, 10 Dec 2024 16:48:13 +0800
Message-ID: <CAEemH2eRBRWjPMYnHLGAx7N_0NSRrKpTO6krFEJPr12iiDcDKQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GwCdWmyjWioP8gpr5sOnVUqbQdtGCDUAVPCahv5ZHJE_1733820506
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [Patch V2] lib: multiply the max_runtime if detect kernel
 debug options
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBEZWMgOSwgMjAyNCBhdCAxMDowMuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiArLyoKPiA+ICsgKiBMaXN0IG9mIGRlYnVnLWtlcm5l
bCBjb25maWcgb3B0aW9ucyB0aGF0IG1heSBkZWdyYWRlIHBlcmZvcm1hbmNlCj4gd2hlbiBlbmFi
bGVkLgo+ID4gKyAqLwo+ID4gK3N0YXRpYyBjb25zdCBjaGFyICogY29uc3QgdHN0X2tjb25mX2Rl
YnVnX29wdGlvbnNbXVsyXSA9IHsKPiA+ICsgICAgIHsiQ09ORklHX1BST1ZFX0xPQ0tJTkc9eSIs
IE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdfTE9DS0RFUD15IiwgTlVMTH0sCj4gPiArICAgICB7
IkNPTkZJR19ERUJVR19TUElOTE9DSz15IiwgTlVMTH0sCj4gPiArICAgICB7IkNPTkZJR19ERUJV
R19SVF9NVVRFWEVTPXkiLCBOVUxMfSwKPiA+ICsgICAgIHsiQ09ORklHX0RFQlVHX01VVEVYRVM9
eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdfREVCVUdfUEFHRUFMTE9DPXkiLCBOVUxMfSwK
PiA+ICsgICAgIHsiQ09ORklHX0tBU0FOPXkiLCBOVUxMfSwKPiA+ICsgICAgIHsiQ09ORklHX1NM
VUJfUkNVX0RFQlVHPXkiLCBOVUxMfSwKPiA+ICsgICAgIHsiQ09ORklHX1RSQUNFX0lSUUZMQUdT
PXkiLCBOVUxMfSwKPiA+ICsgICAgIHsiQ09ORklHX0xBVEVOQ1lUT1A9eSIsIE5VTEx9LAo+ID4g
KyAgICAgeyJDT05GSUdfREVCVUdfTkVUPXkiLCBOVUxMfSwKPiA+ICsgICAgIHsiQ09ORklHX0VY
VDRfREVCVUc9eSIsIE5VTEx9LAo+ID4gKyAgICAgeyJDT05GSUdfUVVPVEFfREVCVUc9eSIsIE5V
TEx9LAo+ID4gKyAgICAgeyJDT05GSUdfRkFVTFRfSU5KRUNUSU9OPXkiLCBOVUxMfSwKPiA+ICsg
ICAgIHsiQ09ORklHX0RFQlVHX09CSkVDVFM9eSIsIE5VTEx9LAo+ID4gKyAgICAge05VTEwsIE5V
TEx9Cj4gPiArfTsKPiA+ICsKPiA+ICtpbnQgdHN0X2FueV9rY29uZmlnX2RlYnVnX2VuYWJsZWQo
dm9pZCk7Cj4gPiArCj4gPiAgI2VuZGlmICAgICAgIC8qIFRTVF9LQ09ORklHX0hfXyAqLwo+ID4g
ZGlmZiAtLWdpdCBhL2xpYi90c3Rfa2NvbmZpZy5jIGIvbGliL3RzdF9rY29uZmlnLmMKPiA+IGlu
ZGV4IDZkNmIxZGExOC4uYTk5MTQ3YTYyIDEwMDY0NAo+ID4gLS0tIGEvbGliL3RzdF9rY29uZmln
LmMKPiA+ICsrKyBiL2xpYi90c3Rfa2NvbmZpZy5jCj4gPiBAQCAtNjMxLDMgKzYzMSwxNyBAQCB2
b2lkIHRzdF9rY21kbGluZV9wYXJzZShzdHJ1Y3QgdHN0X2tjbWRsaW5lX3Zhcgo+IHBhcmFtc1td
LCBzaXplX3QgcGFyYW1zX2xlbikKPiA+Cj4gPiAgICAgICBTQUZFX0ZDTE9TRShmKTsKPiA+ICB9
Cj4gPiArCj4gPiAraW50IHRzdF9hbnlfa2NvbmZpZ19kZWJ1Z19lbmFibGVkKHZvaWQpCj4gPiAr
ewo+ID4gKyAgICAgaW50IGk7Cj4gPiArCj4gPiArICAgICBmb3IgKGkgPSAwOyB0c3Rfa2NvbmZf
ZGVidWdfb3B0aW9uc1tpXVswXSAhPSBOVUxMOyBpKyspIHsKPiA+ICsgICAgICAgICAgICAgaWYo
IXRzdF9rY29uZmlnX2NoZWNrKHRzdF9rY29uZl9kZWJ1Z19vcHRpb25zW2ldKSkgewo+Cj4gSSBz
dXBwb3NlIHRoYXQgdXNpbmcgdHN0X2tjb25maWdfY2hlY2soKSBoZXJlIGhhcyBhIGZldyBmbGF3
cy4KPgo+IEZpcnN0IG9mIGFsbCB3ZSBhcmUgcGFzc2luZyBpdCBvbmUgYnkgb25lLCB3aGljaCBt
ZWFucyB0aGF0IHdlIGFyZQo+IHBhcnNpbmcgdGhlIC5jb25maWcgb3ZlciBhbmQgb3Zlci4gQWxz
byB0aGUgdHN0X2tjb25maWdfY2hlY2soKSBpcwo+IHRhaWxvcmVkIHRvIGEgc3BlY2lhbCB1c2Vj
YXNlIHdoZXJlIGVhY2ggb2YgdGhlIHN0cmluZ3MgaXMgdHJlYXRlZCBhcyBhbgo+IGV4cHJlc3Np
b24sIHdoaWNoIGlzIHNsb3dlci4gQW5kIGxhc3RseSBidXQgbm90IGxlYXN0IHdpbGwgYWxzbyBw
cmludAo+IHRoZSAiQ29uc3RyYWludCAnJXMnIG5vdCBzYXRpc2ZpZWQiIGxpbmUgZm9yIGVhY2gg
b3B0aW9uIHRoYXQgaXMgbm90IHNldC4KPgo+IFdlIGFscmVhZHkgaGF2ZSB0aGUgdHN0X2tjb25m
aWdfdmFyIHN0cnVjdHVyZSBhbmQgdHN0X2tjb25maWdfcmVhZCgpIHNvCj4gaXQgd291bGQgbWFr
ZSBtb3JlIHNlbnNlIHRvIHVzZSB0aGUgc2ltcGxlIGludGVyZmFjZSBhczoKPgo+IHN0YXRpYyBz
dHJ1Y3QgdHN0X2tjb25maWdfdmFyIGRlYnVnX2tjb25maWdzW10gPSB7Cj4gICAgICAgICBUU1Rf
S0NPTkZJR19JTklUKCJDT05GSUdfUFJPVkVfTE9DS0lORyIpLAo+ICAgICAgICAgLi4uCj4gfTsK
PgoKVGhpcyBpcyBhIGdvb2Qgc3VnZ2VzdGlvbiwgYW5kIGJlc2lkZXMsIGFzIEkgdGFsa2VkIHdp
dGggUGV0ciB0aGF0IEkKd291bGQgbW9yZSBsaWtlIHRvIG5hbWUgaXQgInNsb3dfa2NvbmZpZ3Mi
IGJ1dCBub3QgImRlYnVnIiBwcmVmaXgsCmJlY2F1c2UgdGhlIGtlcm5lbCBjb25maWd1cmVzIGlz
IGN1c3RvbWl6ZWQgYW5kIG1heWJlIGp1c3QgZW5hYmxlZApwYXJ0bHkgb24gc2VsZi1idWlsZCBr
ZXJuZWwuCgogICAgICAgaWYgKHRzdF9oYXNfc2xvd19rY29uZmlnKCkpCiAgICAgICAgICAgICAg
IG1heF9ydW50aW1lICo9IDQ7CgpBbmQgSSBhZ3JlZSBhbGwgdGhlIHJlc3QgY29tbWVudHMuCgoK
PiBBbmQgdGhlbiBsb29wIG92ZXIgdGhlIHJlc3VsdHMgYXM6Cj4KPiAgICAgICAgIGludCBpc19k
ZWJ1Z19rZXJuZWwgPSAwOwo+Cj4gICAgICAgICB0c3Rfa2NvbmZpZ19yZWFkKGRlYnVnX2tjb25m
aWdzLCBBUlJBWV9TSVpFKGRlYnVnX2tjb25maWdzKSk7Cj4KPiAgICAgICAgIGZvciAoaSA9IDA7
IGkgPCBBUlJBWV9TSVpFKGRlYnVnX2tjb25maWdzKTsgaSsrKSB7Cj4gICAgICAgICAgICAgICAg
IGlmIChkZWJ1Z19rY29uZmlnc1tpXS5jaG9pY2UgPT0gJ3knKSB7Cj4gICAgICAgICAgICAgICAg
ICAgICAgICAgdHN0X3JlcyhUSU5GTywKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICIlcyBrZXJuZWwgZGVidWcgb3B0aW9uIGRldGVjdGVkIiwKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRlYnVnX2tjb25maWdzW2ldLmlkKTsKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlzX2RlYnVnX2tlcm5lbCA9IDE7Cj4gICAgICAgICAgICAgICAgIH0KPiAg
ICAgICAgIH0KPgo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJEZXRl
Y3RlZCBrZXJuZWwgZGVidWcgb3B0aW9ucy4KPiBMaWtlbHkgcnVubmluZyBvbiBhIGRlYnVnIGtl
cm5lbCIpOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAxOwo+ID4gKyAgICAgICAg
ICAgICB9Cj4gPiArICAgICB9Cj4gPiArICAgICByZXR1cm4gMDsKPiA+ICt9Cj4gPiBkaWZmIC0t
Z2l0IGEvbGliL3RzdF90ZXN0LmMgYi9saWIvdHN0X3Rlc3QuYwo+ID4gaW5kZXggOGRiNTU0ZGVh
Li4wMGFjOGY0ZjMgMTAwNjQ0Cj4gPiAtLS0gYS9saWIvdHN0X3Rlc3QuYwo+ID4gKysrIGIvbGli
L3RzdF90ZXN0LmMKPiA+IEBAIC01NTUsNiArNTU1LDkgQEAgc3RhdGljIGludCBtdWx0aXBseV9y
dW50aW1lKGludCBtYXhfcnVudGltZSkKPiA+Cj4gPiAgICAgICBwYXJzZV9tdWwoJnJ1bnRpbWVf
bXVsLCAiTFRQX1JVTlRJTUVfTVVMIiwgMC4wMDk5LCAxMDApOwo+ID4KPiA+ICsgICAgIGlmICh0
c3RfYW55X2tjb25maWdfZGVidWdfZW5hYmxlZCgpKQo+ID4gKyAgICAgICAgICAgICBtYXhfcnVu
dGltZSAqPSA0Owo+ID4gKwo+ID4gICAgICAgcmV0dXJuIG1heF9ydW50aW1lICogcnVudGltZV9t
dWw7Cj4gPiAgfQo+ID4KPiA+IC0tCj4gPiAyLjQ3LjAKPiA+Cj4KPiAtLQo+IEN5cmlsIEhydWJp
cwo+IGNocnViaXNAc3VzZS5jego+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
