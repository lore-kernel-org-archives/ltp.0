Return-Path: <SRS0=SXDC=PJ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F155C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 07:55:36 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B117860F6E
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 07:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B117860F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE7BE3C55B1
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 09:55:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46B023C5024
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 09:55:24 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 416D310006C0
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 09:55:23 +0200 (CEST)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8F2C13FFFE
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 07:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1634802922;
 bh=fHBzV6i1AJTYGjGMFhSXxp21sCqqL4qSZ5dd9ZooGEQ=;
 h=From:To:Cc:References:Subject:Message-ID:Date:MIME-Version:
 In-Reply-To:Content-Type;
 b=ELfDzTlE9zh2Y75yqVwcqpMYAWr8hJ60LUXMBVR3uFE9wwCqlO4GWK1Pz1k7euAbZ
 JGVeoWr4olfl5ElJOpJbRkVjMONqo2HIJ1fqVSoeX8xN9TFNSJOhD+y3uhPdFtT/JP
 Vh6oKQii31g4/+Nz3ML74qJRFgR2UsaS8PM4Y0ArcQn6uhAq5N3Y5m4KGeCV1EU86s
 3KBrQoQ/NgcZYkq4D22sI6y1h8KibPICBNF89BT/MKMAVQ+1kC7X1ucbq2FYVVKFQO
 5dTYK65sbR35mjTvHxt+zkDJn9olKmO/pYZbl81l9Mjqw6fTuLIjSQ1neOyMCHpYve
 9eLoWy2apTyIw==
Received: by mail-lf1-f72.google.com with SMTP id
 x7-20020a056512130700b003fd1a7424a8so4285283lfu.5
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 00:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:references:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fHBzV6i1AJTYGjGMFhSXxp21sCqqL4qSZ5dd9ZooGEQ=;
 b=3YKF2xwZ795yFTvwwfoCaAQAF0oz7LD+3hLJ4wh4z7Bty8dl76k8LTYmwF9CgBlbuc
 rDHpYGCAwn33mvaup0zYfV+zLYrO279Y82CMh7nQr8JCtvOAEqCXKb2VkrB810cqU4cI
 ++FiFgrn0zbwrlA7xtF/8vwJHanJdtgGZmeRDRoK+91ToryBAnCDe4UebOROLwis/QPZ
 BxyJMTetES9TW1XwPX/le6tmbTcZo+k1uJ4UdYbTqmBEhKmF7CHbWRg3NJtcnxggzY1+
 kAqlS/eZBEft/owB7yyDQEMToxNApin0GxTkJW/9X1FP9uRkLg0gqxWKfYj0RyCW8BZ4
 QdUw==
X-Gm-Message-State: AOAM533UBN9PajUYIYO2WSZnr+MzPVMlldWB0HFOqOo4jYPoF6WshNyb
 t5JuLoLj/xYxaMzaDG0sgIx9lLSdrtvABHReANYQRXMbI2JlLE+OPFT8lLclO2Qv/+4wdMHWGFs
 PvdmSXyCea85XW8C4Feu9wY18Hbxs
X-Received: by 2002:a05:651c:1103:: with SMTP id
 d3mr4382591ljo.368.1634802921792; 
 Thu, 21 Oct 2021 00:55:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIJ/UhyPLRfXc22hURX29GMQZIdlceU71OFztUCzUOmwIW/mQFooC2I+Y2ETQzXNy7t2AI5A==
X-Received: by 2002:a05:651c:1103:: with SMTP id
 d3mr4382565ljo.368.1634802921584; 
 Thu, 21 Oct 2021 00:55:21 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id b23sm389860lff.148.2021.10.21.00.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Oct 2021 00:55:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: Li Wang <liwang@redhat.com>
References: <20211020091353.90731-1-krzysztof.kozlowski@canonical.com>
 <CAEemH2cPDbcekuQ=j9SmoUFQ1e-LRLzFqKSOd2_bXELTSmus=A@mail.gmail.com>
 <2866a54f-ebee-1bd5-82ab-92084d0fd74a@canonical.com>
Message-ID: <9771a472-9bda-3600-8cd2-05f297bc9a8d@canonical.com>
Date: Thu, 21 Oct 2021 09:55:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2866a54f-ebee-1bd5-82ab-92084d0fd74a@canonical.com>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib: memutils: respect minimum memory
 watermark when polluting memory
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjEvMTAvMjAyMSAwOTozNiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToKPiBPbiAyMS8x
MC8yMDIxIDA5OjIxLCBMaSBXYW5nIHdyb3RlOgo+Pgo+Pgo+PiBPbiBXZWQsIE9jdCAyMCwgMjAy
MSBhdCA1OjE0IFBNIEtyenlzenRvZiBLb3psb3dza2kKPj4gPGtyenlzenRvZi5rb3psb3dza2lA
Y2Fub25pY2FsLmNvbQo+PiA8bWFpbHRvOmtyenlzenRvZi5rb3psb3dza2lAY2Fub25pY2FsLmNv
bT4+IHdyb3RlOgo+Pgo+PiAgICAgUHJldmlvdXMgZml4IGZvciBhbiBvdXQtb2YtbWVtb3J5IGtp
bGxlciBraWxsaW5nIGlvY3RsX3NnMDEgcHJvY2Vzcwo+PiAgICAgaW4gY29tbWl0IDRkMmUzZDQ0
ZmFkNSAoImxpYjogbWVtdXRpbHM6IGRvbid0IHBvbGx1dGUKPj4gICAgIGVudGlyZSBzeXN0ZW0g
bWVtb3J5IHRvIGF2b2lkIE9vTSIpIHdhcyBub3QgZnVsbHkgZWZmZWN0aXZlLsKgIFdoaWxlIGl0
Cj4+ICAgICBjb3ZlcnMgbW9zdCBvZiB0aGUgY2FzZXMsIGFuIEFSTTY0IG1hY2hpbmUgd2l0aCAx
MjggR0Igb2YgbWVtb3J5LCA2NCBrQgo+PiAgICAgcGFnZSBzaXplIGFuZCB2NS4xMSBrZXJuZWwg
aGl0IGl0IGFnYWluLsKgIFBvbGx1dGluZyB0aGUgbWVtb3J5IGZhaWxzCj4+ICAgICB3aXRoIE9v
TToKPj4KPj4gICAgIMKgIExUUDogc3RhcnRpbmcgaW9jdGxfc2cwMQo+PiAgICAgwqAgaW9jdGxf
c2cwMSBpbnZva2VkIG9vbS1raWxsZXI6Cj4+ICAgICBnZnBfbWFzaz0weDEwMGRjYShHRlBfSElH
SFVTRVJfTU9WQUJMRXxfX0dGUF9aRVJPKSwgb3JkZXI9MCwKPj4gICAgIG9vbV9zY29yZV9hZGo9
MAo+PiAgICAgwqAgLi4uCj4+ICAgICDCoCBNZW0tSW5mbzoKPj4gICAgIMKgIGFjdGl2ZV9hbm9u
OjMwOSBpbmFjdGl2ZV9hbm9uOjE5NjQ3ODEgaXNvbGF0ZWRfYW5vbjowCj4+ICAgICDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBhY3RpdmVfZmlsZTo5NCBpbmFjdGl2ZV9maWxlOjAgaXNvbGF0
ZWRfZmlsZTowCj4+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1bmV2aWN0YWJsZToz
MDUgZGlydHk6MCB3cml0ZWJhY2s6MAo+PiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
c2xhYl9yZWNsYWltYWJsZToxNTEwIHNsYWJfdW5yZWNsYWltYWJsZTo1MDEyCj4+ICAgICDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtYXBwZWQ6MTE1IHNobWVtOjMzOSBwYWdldGFibGVzOjQ2
MyBib3VuY2U6MAo+PiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnJlZToxMTIwNDMg
ZnJlZV9wY3A6MSBmcmVlX2NtYTozMTU5Cj4+ICAgICDCoCBOb2RlIDAgYWN0aXZlX2Fub246MTk3
NzZrQiBpbmFjdGl2ZV9hbm9uOjEyNTc0NTk4NGtCCj4+ICAgICBhY3RpdmVfZmlsZTo2MDE2a0Ig
aW5hY3RpdmVfZmlsZTowa0IgdW5ldmljdGFibGU6MTk1MjBrQiAuLi4KPj4gICAgIMKgIE5vZGUg
MCBETUEgZnJlZTo3MTA2NTZrQiBtaW46MjA1MTIwa0IgbG93OjI1NjM4NGtCIGhpZ2g6MzA3NjQ4
a0IKPj4gICAgIHJlc2VydmVkX2hpZ2hhdG9taWM6MEtCIGFjdGl2ZV9hbm9uOjBrQiBpbmFjdGl2
ZV9hbm9uOjMzMzIwMzJrQiAuLi4KPj4gICAgIMKgIGxvd21lbV9yZXNlcnZlW106IDAgMCA3OTA4
IDc5MDggNzkwOAo+PiAgICAgwqAgTm9kZSAwIE5vcm1hbCBmcmVlOjY0NjAwOTZrQiBtaW46NjQ2
MzE2OGtCIGxvdzo4MDc4OTEya0IKPj4gICAgIGhpZ2g6OTY5NDY1NmtCIHJlc2VydmVkX2hpZ2hh
dG9taWM6MEtCIGFjdGl2ZV9hbm9uOjE5Nzc2a0IKPj4gICAgIGluYWN0aXZlX2Fub246MTIyNDEz
OTUya0IgLi4uCj4+ICAgICDCoCBsb3dtZW1fcmVzZXJ2ZVtdOiAwIDAgMCAwIDAKPj4KPj4gICAg
IFRoZSBpbXBvcnRhbnQgcGFydCBhcmUgZGV0YWlscyBvZiBtZW1vcnkgb24gTm9kZSAwIGluIE5v
cm1hbCB6b25lOgo+PiAgICAgMS4gZnJlZSBtZW1vcnk6IDY0NjAwOTYga0IKPj4gICAgIDIuIG1p
biAobWluaW11bSB3YXRlcm1hcmspOiA2NDYzMTY4IGtCCj4+Cj4+ICAgICBQYXJzZSB0aGUgL3By
b2Mvc3lzL3ZtL21pbl9mcmVlX2tieXRlcyB3aGljaCBjb250YWlucyB0aGUgZnJlZQo+PiAgICAg
bWVtb3J5IGxldmVsIHVzZWQgYXMgbWluaW11bSB3YXRlcm1hcmsgKHRyaWdnZXJpbmcgT29NIGtp
bGxlcikuCj4+Cj4+ICAgICBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpCj4+ICAg
ICA8a3J6eXN6dG9mLmtvemxvd3NraUBjYW5vbmljYWwuY29tCj4+ICAgICA8bWFpbHRvOmtyenlz
enRvZi5rb3psb3dza2lAY2Fub25pY2FsLmNvbT4+Cj4+Cj4+ICAgICAtLS0KPj4KPj4gICAgIENo
YW5nZXMgc2luY2UgdjI6Cj4+ICAgICAxLiBVc2UgL3Byb2Mvc3lzL3ZtL21pbl9mcmVlX2tieXRl
cyBpbnN0ZWFkIG9mIHBhcnNpbmcgem9uZWluZm8sIHRoYW5rcwo+PiAgICAgwqAgwqB0Z28gTGl1
IFhpbnBlbmcuCj4+Cj4+ICAgICBDaGFuZ2VzIHNpbmNlIHYxOgo+PiAgICAgMS4gQWRkIHN0YXRp
YyBhbmQgcmVuYW1lIHRvIGNvdW50X21pbl9wYWdlcygpLgo+PiAgICAgLS0tCj4+ICAgICDCoGxp
Yi90c3RfbWVtdXRpbHMuYyB8IDggKysrKysrKy0KPj4gICAgIMKgMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiAgICAgZGlmZiAtLWdpdCBhL2xpYi90
c3RfbWVtdXRpbHMuYyBiL2xpYi90c3RfbWVtdXRpbHMuYwo+PiAgICAgaW5kZXggYWYxMzJiY2M2
YzI0Li5kZjUzYzU0MmQyMzkgMTAwNjQ0Cj4+ICAgICAtLS0gYS9saWIvdHN0X21lbXV0aWxzLmMK
Pj4gICAgICsrKyBiL2xpYi90c3RfbWVtdXRpbHMuYwo+PiAgICAgQEAgLTE2LDEyICsxNiwxOCBA
QAo+PiAgICAgwqB2b2lkIHRzdF9wb2xsdXRlX21lbW9yeShzaXplX3QgbWF4c2l6ZSwgaW50IGZp
bGxjaGFyKQo+PiAgICAgwqB7Cj4+ICAgICDCoCDCoCDCoCDCoCBzaXplX3QgaSwgbWFwX2NvdW50
ID0gMCwgc2FmZXR5ID0gMCwgYmxvY2tzaXplID0gQkxPQ0tTSVpFOwo+PiAgICAgK8KgIMKgIMKg
IMKgdW5zaWduZWQgbG9uZyBtaW5fZnJlZTsKPj4gICAgIMKgIMKgIMKgIMKgIHZvaWQgKiptYXBf
YmxvY2tzOwo+PiAgICAgwqAgwqAgwqAgwqAgc3RydWN0IHN5c2luZm8gaW5mbzsKPj4KPj4gICAg
ICvCoCDCoCDCoCDCoFNBRkVfRklMRV9TQ0FORigiL3Byb2Mvc3lzL3ZtL21pbl9mcmVlX2tieXRl
cyIsICIlbHUiLAo+PiAgICAgJm1pbl9mcmVlKTsKPj4gICAgICvCoCDCoCDCoCDCoG1pbl9mcmVl
ICo9IDEwMjQ7Cj4+ICAgICArwqAgwqAgwqAgwqAvKiBBcHBseSBhIG1hcmdpbiBiZWNhdXNlIHdl
IGNhbm5vdCBnZXQgYmVsb3cgIm1pbiIgd2F0ZXJtYXJrICovCj4+ICAgICArwqAgwqAgwqAgwqBt
aW5fZnJlZSArPSBtaW5fZnJlZSAvIDEwOwo+PiAgICAgKwo+PiAgICAgwqAgwqAgwqAgwqAgU0FG
RV9TWVNJTkZPKCZpbmZvKTsKPj4gICAgIMKgIMKgIMKgIMKgIHNhZmV0eSA9IE1BWCg0MDk2ICog
U0FGRV9TWVNDT05GKF9TQ19QQUdFU0laRSksIDEyOCAqIDEwMjQgKgo+PiAgICAgMTAyNCk7Cj4+
ICAgICAtwqAgwqAgwqAgwqBzYWZldHkgPSBNQVgoc2FmZXR5LCAoaW5mby5mcmVlcmFtIC8gNjQp
KTsKPj4gICAgICvCoCDCoCDCoCDCoHNhZmV0eSA9IE1BWChzYWZldHksIG1pbl9mcmVlKTsKPj4K
Pj4KPj4gVGhlcmljYWxseSB0aGlzIGlzIGNvcnJlY3QsIGFuZCBJIGJlbGlldmXCoGl0IHdpbGwg
d29yayBvbiB5b3VyIHRlc3RlZAo+PiBtYWNoaW5lLgo+Pgo+PiBCdXQgbXkgY29uY2VybiBpcyBp
b2N0bF9zZzAxIHN0aWxsIGZhaWxzIG9uIHRoZSBzcGVjaWFsIHN5c3RlbSB3aGljaAo+PiBNZW1B
dmFpIDwgTWVtRnJlZS4KPj4KPj4gSnVzdCBsaWtlIHRoZSBvbmUgWGlucGVuZyBtZW50aW9uZWQg
YmVmb3JlOgo+PiBodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyMS1KYW51
YXJ5LzAyMDgxNy5odG1sCj4+IDxodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAv
MjAyMS1KYW51YXJ5LzAyMDgxNy5odG1sPgo+Pgo+PiBbcm9vdEB0ZXN0LWVudi1ubTA1LWNvbXB1
dGUtMTRlNWU3MmUzOAo+PiA8bWFpbHRvOnJvb3RAdGVzdC1lbnYtbm0wNS1jb21wdXRlLTE0ZTVl
NzJlMzg+fl0jIGNhdCAvcHJvYy9tZW1pbmZvCj4+Cj4+IE1lbVRvdGFsOiAgICAgICA1MjY5OTc0
MjAga0IKPj4gTWVtRnJlZTogICAgICAgIDUyMDIyNDkwOCBrQgo+PiBNZW1BdmFpbGFibGU6ICAg
NTE5OTM2NzQ0IGtCCj4+IC4uLgo+Pgo+PiBbcm9vdEB0ZXN0LWVudi1ubTA1LWNvbXB1dGUtMTRl
NWU3MmUzOCA8bWFpbHRvOnJvb3RAdGVzdC1lbnYtbm0wNS1jb21wdXRlLTE0ZTVlNzJlMzg+IH5d
IyBjYXQgIC9wcm9jL3N5cy92bS9taW5fZnJlZV9rYnl0ZXMKPj4gOTAxMTIKPj4KPj4KPj4gVGhl
cmUgZXZlbiByZXNlcnZlIHRoZSBzYWZldHkgdG8gdGhlIDEyOE1CLCBzdGlsbCBsZXNzIHRoYW4g
dGhlIGdhcAo+PiBiZXR3ZWVuIE1lbUZyZWUgYW5kIE1lbUF2YWlsYWJsZS7CoAo+Pgo+PiBNZW1G
cmVlICg1MjAyMjQ5MDgga0IpIC0gTWVtQXZhaWxhYmxlICg1MjAyMjQ5MDgga0IpID3CoDI4ODE2
NCBrQsKgID4gc2FmZXR5Cj4gCj4gSSBkb24ndCBoYXZlIHN1Y2ggY2FzZSBhbmQgSSBhbSBub3Qg
c3VyZSBpdCBpcyByZWFzb25hYmxlLgo+IAo+IEFzIG1lbnRpb25lZCBpbiB0aGUgdGhyZWFkIHRo
ZXJlIGl0IGxvb2tzIHVudXN1YWwgdG8gaGF2ZSBsZXNzIGF2YWlsYWJsZQo+IG1lbW9yeSB0aGFu
IGZyZWUuIE1heWJlIHRoZSBzeXN0ZW0gaGFzIHNvbWUgd2VpcmQgbWVtb3J5IGFjY291bnRpbmcK
PiBiZWNhdXNlIE1lbUF2YWlsYWJsZSBpcyBjb3VudGVkIGZyb20gTWVtRnJlZSBieSBhZGRpbmcg
bWVtb3J5IHdoaWNoIGNhbgo+IGJlIHJlY2xhaW1lZC4gV2hlbiBhZGRpbmcgYSBub24tbmVnYXRp
dmUgbnVtYmVyLCB5b3Ugc2hvdWxkIG5vdCBlbmQgdXAKPiB3aXRoIGxvd2VyIE1lbUF2YWlsYWJs
ZSB0aGFuIE1lbUZyZWUuIDopCj4gCj4gTWF5YmUgdGhhdCdzIHRoZSByZWFzb24gd2h5IHRoYXQg
cGF0Y2ggd2FzIG5vdCBhY2NlcHRlZCAtIHRoZSBzeXN0ZW0gaXMKPiBub3QgdmFuaWxsYSwgbm90
IGNvbW1vbj8KCk9LLCBJIGZvdW5kIGEgcG9zc2libGUgZXhwbGFuYXRpb24gKG9uIHZhbmlsbGEg
a2VybmVsKSAtIHRoZQp0b3RhbHJlc2VydmVfcGFnZXMuIFRoaXMgaXMgdGhlIG9ubHkgc3VidHJh
Y3Rpb24gZnJvbSBmcmVlIG1lbW9yeSB3aGVuCmNvdW50aW5nIGF2YWlsYWJsZS4gVGhpcyBjb3Vs
ZCBoYXBwZW4gaWYgc29tZW9uZSB3YXMgc2V0dGluZyBzeXNjdGwKbG93bWVtX3Jlc2VydmVfcmF0
aW8gb3IgbWluX2ZyZWVfa2J5dGVzLgoKV2hlbiBzZXR0aW5nIG1pbl9mcmVlX2tieXRlcywgdGhp
cyB3aWxsIGJlIHJlZmxlY3RlZCBpbgovcHJvYy9zeXMvdm0vbWluX2ZyZWVfa2J5dGVzLCBzbyB3
ZSBhcmUgZ29vZC4KCldoZW4gc2V0dGluZyB2bS5sb3dtZW1fcmVzZXJ2ZV9yYXRpbywgdGhpcyB3
aWxsIGJlIG1pc3NlZCBieSBteSBwYXRjaAphbmQgTWVtQXZhaWxhYmxlIGNvdWxkIGJlIGxvd2Vy
IHRoYW4gTWVtRnJlZS4KCkknbGwgc2VuZCBhIHY0LgoKQmVzdCByZWdhcmRzLApLcnp5c3p0b2YK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
