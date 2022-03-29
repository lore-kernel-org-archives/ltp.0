Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEBEC433EF
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 21:05:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D84763C9DFD
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 23:05:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B625A3C968C
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 23:04:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EDF326002FB
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 23:04:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648587895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLVHjTAw3KB8+itC9M2ZGYKcet8tWDQwT3jbUNaQqm8=;
 b=MYnnjdjoyZs8vk862qzDMnpcgbT7KaurmDSsUVTw8Qhs2qYnw4tvGgwTdzm4qJJBv83Yon
 QURVuTKGldFppwkKBNoiyCUVDRgdavS1aT9E5mIT+KPFd8/X2PGc7W/74PDmlj/8WnjzWM
 1zxyoF8Zpu5cC/fuB+mNSu65NUTwSyU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-ADsEfagfOPC0-qIVJ6L3rQ-1; Tue, 29 Mar 2022 17:04:53 -0400
X-MC-Unique: ADsEfagfOPC0-qIVJ6L3rQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80FEA38008C6;
 Tue, 29 Mar 2022 21:04:53 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 425D2401E2A;
 Tue, 29 Mar 2022 21:04:48 +0000 (UTC)
Message-ID: <d14a7c35-db49-4b7c-7951-9ad597b99831@redhat.com>
Date: Tue, 29 Mar 2022 17:04:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <20220329050351.688432-1-liwang@redhat.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20220329050351.688432-1-liwang@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=longman@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] clock_gettime04: set threshold based on the
 clock resolution
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Eirik Fuller <efuller@redhat.com>,
 Waiman Long <llong@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMy8yOS8yMiAwMTowMywgTGkgV2FuZyB3cm90ZToKPiBUaGlzIGlzIHRvIGdldCByaWQgb2Yg
dGhlIGludGVybWl0dGVudCBmYWlsdXJlcyBpbiBjbG9ja19nZXR0aW1lMDQsCj4gd2hpY2ggYXJl
IGxpa2VseSBjYXVzZWQgYnkgZGlmZmVyZW50IGNsb2NrIHRpY2sgcmF0ZXMgb24gcGxhdGZvcm1z
Lgo+IEhlcmUgZ2l2ZSB0d28gdGhyZXNob2xkcyAoaW4gbWlsbGlzZWNvbmRzKSBmb3IgY29tcGFy
aXNvbiwgb25lIGZvcgo+IENPQVJTRSBjbG9jayBhbmQgb25lIGZvciB0aGUgcmVzdC4KPgo+IEVy
cm9yIGxvZzoKPiAgICBjbG9ja19nZXR0aW1lMDQuYzoxNjM6IFRGQUlMOiBDTE9DS19SRUFMVElN
RV9DT0FSU0Uoc3lzY2FsbCB3aXRoIG9sZCBrZXJuZWwgc3BlYyk6Cj4gICAgICAgICAgRGlmZmVy
ZW5jZSBiZXR3ZWVuIHN1Y2Nlc3NpdmUgcmVhZGluZ3MgZ3JlYXRlciB0aGFuIDUgbXMgKDEpOiAx
MAo+ICAgIGNsb2NrX2dldHRpbWUwNC5jOjE2MzogVEZBSUw6IENMT0NLX01PTk9UT05JQ19DT0FS
U0UodkRTTyB3aXRoIG9sZCBrZXJuZWwgc3BlYyk6Cj4gCURpZmZlcmVuY2UgYmV0d2VlbiBzdWNj
ZXNzaXZlIHJlYWRpbmdzIGdyZWF0ZXIgdGhhbiA1IG1zICgyKTogMTAKPgo+ICBGcm9tIFdhaW1h
biBMb25nOgo+ICAgIFRoYXQgZmFpbHVyZSBoYXBwZW5zIGZvciBDTE9DS19SRUFMVElNRV9DT0FS
U0Ugd2hpY2ggaXMgYSBmYXN0ZXIgYnV0IGxlc3MKPiAgICBwcmVjaXNlIHZlcnNpb24gb2YgQ0xP
Q0tfUkVBTFRJTUUuIFRoZSB0aW1lIHJlc29sdXRpb24gaXMgYWN0dWFsbHkgYSBjbG9jawo+ICAg
IHRpY2suIFNpbmNlIGFybTY0IGhhcyBhIEhaIHJhdGUgb2YgMTAwLiBUaGF0IG1lYW5zIGVhY2gg
dGljayBpcyAxMG1zLiBTbyBhCj4gICAgQ0xPQ0tfUkVBTFRJTUVfQ09BUlNFIHRocmVzaG9sZCBv
ZiA1bXMgaXMgcHJvYmFibHkgbm90IGVub3VnaC4gSSB3b3VsZCBzYXkKPiAgICBpbiB0aGUgY2Fz
ZSBvZiBDTE9DS19SRUFMVElNRV9DT0FSU0UsIHdlIGhhdmUgdG8gaW5jcmVhc2UgdGhlIHRocmVz
aG9sZCBiYXNlZAo+ICAgIG9uIHRoZSBjbG9jayB0aWNrIHJhdGUgb2YgdGhlIHN5c3RlbS4gVGhp
cyBpcyBtb3JlIGEgdGVzdCBmYWlsdXJlIHRoYW4gaXMKPiAgICBhbiBpbmhlcmVudCBwcm9ibGVt
IGluIHRoZSBrZXJuZWwuCj4KPiBGaXhlcyAjODk4Cj4KPiBSZXBvcnRlZC1ieTogRWlyaWsgRnVs
bGVyIDxlZnVsbGVyQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5n
QHJlZGhhdC5jb20+Cj4gQ2M6IFdhaW1hbiBMb25nIDxsbG9uZ0ByZWRoYXQuY29tPgo+IENjOiBW
aXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnPgo+IC0tLQo+Cj4gTm90ZXM6Cj4g
ICAgICB2MSAtLT4gdjIKPiAgICAgICAgICAqIG1ha2UgdXNlIG9mIGNsb2NrX2dldHJlcyB0byBn
ZXQgY2xvY2sgcmVzb2x1dGlvbgo+ICAgICAgICAgICogaW52b2x2ZSBzZXBhcmF0ZSBjb2Fyc2Vf
ZGVsdGEgZm9yIENPQVJTRSBjbG9jawo+ICAgICAgICAgICogY291bnQgZGVsdGEgYXMgJ2Nsb2Nr
IHJlc29sdXRpb24gKyBlbGFwc2UgKDVtcyknCj4KPiAgIC4uLi9zeXNjYWxscy9jbG9ja19nZXR0
aW1lL2Nsb2NrX2dldHRpbWUwNC5jICAgfCAxOCArKysrKysrKysrKysrKysrLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvY2tfZ2V0dGltZS9jbG9ja19nZXR0aW1l
MDQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvY2tfZ2V0dGltZS9jbG9ja19nZXR0
aW1lMDQuYwo+IGluZGV4IGE4ZDJjNWIzOC4uYzI3OWRhNzllIDEwMDY0NAo+IC0tLSBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvY2tfZ2V0dGltZS9jbG9ja19nZXR0aW1lMDQuYwo+ICsr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvY2tfZ2V0dGltZS9jbG9ja19nZXR0aW1l
MDQuYwo+IEBAIC0zNSw3ICszNSw3IEBAIGNsb2NraWRfdCBjbGtzW10gPSB7Cj4gICB9Owo+ICAg
Cj4gICBzdGF0aWMgZ2V0dGltZV90IHB0cl92ZHNvX2dldHRpbWUsIHB0cl92ZHNvX2dldHRpbWU2
NDsKPiAtc3RhdGljIGxvbmcgbG9uZyBkZWx0YSA9IDU7Cj4gK3N0YXRpYyBsb25nIGxvbmcgZGVs
dGEsIHByZWNpc2VfZGVsdGEsIGNvYXJzZV9kZWx0YTsKPiAgIAo+ICAgc3RhdGljIGlubGluZSBp
bnQgZG9fdmRzb19nZXR0aW1lKGdldHRpbWVfdCB2ZHNvLCBjbG9ja2lkX3QgY2xrX2lkLCB2b2lk
ICp0cykKPiAgIHsKPiBAQCAtOTIsOSArOTIsMTggQEAgc3RhdGljIHN0cnVjdCB0aW1lNjRfdmFy
aWFudHMgdmFyaWFudHNbXSA9IHsKPiAgIAo+ICAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiAg
IHsKPiArCXN0cnVjdCB0aW1lc3BlYyByZXM7Cj4gKwo+ICsJY2xvY2tfZ2V0cmVzKENMT0NLX1JF
QUxUSU1FLCAmcmVzKTsKPiArCXByZWNpc2VfZGVsdGEgPSA1ICsgcmVzLnR2X25zZWMgLyAxMDAw
MDAwOwo+ICsKPiArCWNsb2NrX2dldHJlcyhDTE9DS19SRUFMVElNRV9DT0FSU0UsICZyZXMpOwo+
ICsJY29hcnNlX2RlbHRhID0gNSArIHJlcy50dl9uc2VjIC8gMTAwMDAwMDsKPiArCj4gICAJaWYg
KHRzdF9pc192aXJ0KFZJUlRfQU5ZKSkgewo+ICAgCQl0c3RfcmVzKFRJTkZPLCAiUnVubmluZyBp
biBhIHZpcnR1YWwgbWFjaGluZSwgbXVsdGlwbHkgdGhlIGRlbHRhIGJ5IDEwLiIpOwo+IC0JCWRl
bHRhICo9IDEwOwo+ICsJCXByZWNpc2VfZGVsdGEgKj0gMTA7Cj4gKwkJY29hcnNlX2RlbHRhICo9
IDEwOwo+ICAgCX0KClRoZSBwYXRjaCBsb29rcyBnb29kIGluIGdlbmVyYWwuIEhvd2V2ZXIsIG1h
eWJlIHdlIHNob3VsZCBkbyBzb21ldGhpbmcgbGlrZToKCmRpZmYgLS1naXQgYS9jbG9ja19nZXR0
aW1lMDQuYyBiL2Nsb2NrX2dldHRpbWUwNC5jCmluZGV4IGE4ZDJjNWIuLjFiYTIxOGIgMTAwNjQ0
Ci0tLSBhL2Nsb2NrX2dldHRpbWUwNC5jCisrKyBiL2Nsb2NrX2dldHRpbWUwNC5jCkBAIC05Miwx
MSArOTIsMTggQEAgc3RhdGljIHN0cnVjdCB0aW1lNjRfdmFyaWFudHMgdmFyaWFudHNbXSA9IHsK
CiDCoHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCiDCoHsKK8KgwqDCoMKgwqDCoCBkZWx0YSA9IDU7
CiDCoMKgwqDCoMKgwqDCoCBpZiAodHN0X2lzX3ZpcnQoVklSVF9BTlkpKSB7CiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdHN0X3JlcyhUSU5GTywgIlJ1bm5pbmcgaW4gYSB2aXJ0dWFs
IG1hY2hpbmUsIG11bHRpcGx5IAp0aGUgZGVsdGEgYnkgMTAuIik7CiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZGVsdGEgKj0gMTA7CiDCoMKgwqDCoMKgwqDCoCB9CgorwqDCoMKgwqDC
oMKgIGNsb2NrX2dldHJlcyhDTE9DS19SRUFMVElNRSwgJnJlcyk7CivCoMKgwqDCoMKgwqAgcHJl
Y2lzZV9kZWx0YSA9IGRlbHRhICsgcmVzLnR2X25zZWMgLyAxMDAwMDAwOworCivCoMKgwqDCoMKg
wqAgY2xvY2tfZ2V0cmVzKENMT0NLX1JFQUxUSU1FX0NPQVJTRSwgJnJlcyk7CivCoMKgwqDCoMKg
wqAgY29hcnNlX2RlbHRhID0gZGVsdGEgKyByZXMudHZfbnNlYyAvIDEwMDAwMDA7CisKIMKgwqDC
oMKgwqDCoMKgIGZpbmRfY2xvY2tfZ2V0dGltZV92ZHNvKCZwdHJfdmRzb19nZXR0aW1lLCAmcHRy
X3Zkc29fZ2V0dGltZTY0KTsKIMKgfQoKdG8gYXZvaWQgYSBjb2Fyc2VfZGVsdGEgdGhhdCBpcyB0
b28gbGFyZ2UgZm9yIHZtLgoKQ2hlZXJzLApMb25nbWFuCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
