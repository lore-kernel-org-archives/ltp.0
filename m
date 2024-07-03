Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC71C2BD09
	for <ltp@archiver.kernel.org>; Wed,  3 Jul 2024 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720014174; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=sbrkB+uHUmjJmGaciVqCEIDDDsI1fS63llZfZJZbROU=;
 b=VYKYdC8GRlTeWl3OjYGJzEcGpf89gUpzlMzFKvnNR15naTbmoVdXLzPk4Ywh4P/Uv+taY
 NFLlMtX1K+6f1aI/LzWOYTeN+durTugI6LCny5XyfrEHfPUNuenhF7a01Am8XlEaRTIzCB/
 0sYvAyHgzANney88KK/FEJXZY6KyaGc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 719823D3DD5
	for <ltp@archiver.kernel.org>; Wed,  3 Jul 2024 15:42:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C45213D08BB
 for <ltp@lists.linux.it>; Wed,  3 Jul 2024 15:42:33 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 60E0720A6A5
 for <ltp@lists.linux.it>; Wed,  3 Jul 2024 15:42:32 +0200 (CEST)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ebe40673e8so66052581fa.3
 for <ltp@lists.linux.it>; Wed, 03 Jul 2024 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1720014151; x=1720618951; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAEB4YmMbjBaxlvgTBDsAzLJSK8tb+SiqWp1uoLoLuo=;
 b=aa+aL6iwi69IsdzNRrZbKb4oJ9aka0jmD+7DpCy4E2S9Q9eWjJXoHI8sQ8lclmx/J/
 kv9aLK/R+KqwnesDGTceX/fOkPdvoTBgVgWGgDWhEHFmleHZKvPEa43ja5slaCVKsfJv
 9bh1KARmQC9dYaqxFkQsRxCTQ0l7rLeYJQs5e2jKBzNL1LVmk3qtI9EhgOeVKVWxtVX+
 p/2BUPDemKMPJVstSXUGeYIt4W+YmEJcA+8Cql9315VKYBzp15/ZP+PLL+9iC0yTUFlY
 Fe/YhA4PKS1D9wJ3Hzj5d7Hs8sc7H94UvmLDRQPtmjqhsOuZiVgdQJiyFoVtYiU0PTGO
 W1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720014151; x=1720618951;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WAEB4YmMbjBaxlvgTBDsAzLJSK8tb+SiqWp1uoLoLuo=;
 b=Q6l0nDVBPCrY69olqXDl4SAdHuBCNJXt+uas2GSTUlnt0tPToofWvvDV6JGYE9hI6S
 uY0YX3DRJgEpYr45Bk6aDpy4gay3/L6muBcVTHuTeM6c1c66rakxwtwnYOtKZ5zf6cYh
 60IKmzJSJu6vvbr4BhQQKaGEGmI+9wpyFbQLm+nnEaIgVA1NtVcpnBMbhkvTObUtOoHt
 rjnhbW+37+onyU7XHuD7l+9RXUpNC5pilYqPI+WwRXpSMfOsCfSUBir+CaC/S8T3u8Zk
 Z52RNtNs1h4VIKaH2KVfm3aulpLF6DVRiX4HNkD2ke1GNzh33PXS4XYXtcuwm1K/zfTY
 +vcw==
X-Gm-Message-State: AOJu0Yzze6QFM2KbTpzzh6PWCCs1ZnuFObO8mtBqNIb3GwADEqSAPCjT
 3HjPHSucaYx0eCBeL2wF2lrCeur8UFewTx9ORiJ5PsvKmFGqZR43QvSgJH6wsHU=
X-Google-Smtp-Source: AGHT+IE9xQWFSs9LDIVcIcqW94XwhysyCuM2ki6ZMjjhV+zjuusR0bLayR4Guas544M2NR9gsEbH7Q==
X-Received: by 2002:a05:651c:1590:b0:2ee:7b7c:7f6e with SMTP id
 38308e7fff4ca-2ee7b7c8048mr21002391fa.39.1720014150868; 
 Wed, 03 Jul 2024 06:42:30 -0700 (PDT)
Received: from [10.232.133.69] ([88.128.88.47])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb15217780sm15153765ad.109.2024.07.03.06.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 06:42:30 -0700 (PDT)
Message-ID: <65c8c745-fdb7-4172-b81b-cd1930f0dbfd@suse.com>
Date: Wed, 3 Jul 2024 15:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-8-58e9af649a72@suse.com>
 <CAEemH2f_Tq0W46x61FokVYwv4sK=8NhwfM5SY-gj1znbGnAmFg@mail.gmail.com>
 <CAEemH2cM6DMQZ-3j3sQ-0b1zD-rfeaCRTefO00wMnGqYeLn+Pw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2cM6DMQZ-3j3sQ-0b1zD-rfeaCRTefO00wMnGqYeLn+Pw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 08/10] Add landlock04 test
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Q29tbWVudHMgYmVsb3cuCgpPbiA3LzIvMjQgMTQ6MjIsIExpIFdhbmcgd3JvdGU6Cj4KPgo+IE9u
IFR1ZSwgSnVsIDIsIDIwMjQgYXQgNDowMOKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPgo+Cj4KPiAgICAgT24gTW9uLCBKdWwgMSwgMjAyNCBhdCAxMTo0NOKAr1BNIEFu
ZHJlYSBDZXJ2ZXNhdG8KPiAgICAgPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5kZT4gd3JvdGU6Cj4K
PiAgICAgICAgIEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5j
b20+Cj4KPiAgICAgICAgIFRoaXMgdGVzdCB2ZXJpZmllcyB0aGF0IGFsbCBsYW5kbG9jayBydWxl
cyBhcmUgd29ya2luZyBwcm9wZXJseS4KPiAgICAgICAgIFRoZSB3YXkgd2UgZG8gaXQgaXMgdG8g
dmVyaWZ5IHRoYXQgYWxsIGRpc2FibGVkIHN5c2NhbGxzIGFyZSBub3QKPiAgICAgICAgIHdvcmtp
bmcgYnV0IHRoZSBvbmUgd2UgZW5hYmxlZCB2aWEgc3BlY2lmYyBsYW5kbG9jayBydWxlcy4KPgo+
ICAgICAgICAgU2lnbmVkLW9mZi1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0
b0BzdXNlLmNvbT4KPiAgICAgICAgIC0tLQo+ICAgICAgICAgwqBydW50ZXN0L3N5c2NhbGxzwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgMSAr
Cj4gICAgICAgICDCoHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svLmdpdGlnbm9y
ZcKgIMKgIMKgIHwgwqAyICsKPiAgICAgICAgIMKgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9s
YW5kbG9jay9NYWtlZmlsZcKgIMKgIMKgIMKgIHwgwqA1ICsKPiAgICAgICAgIMKgdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay9sYW5kbG9jazA0LmPCoCDCoCB8IDE0Mwo+ICAgICAg
ICAgKysrKysrKysrCj4gICAgICAgICDCoHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxv
Y2svbGFuZGxvY2tfZXhlYy5jIHwgwqA5ICsKPiAgICAgICAgIMKgLi4uL2tlcm5lbC9zeXNjYWxs
cy9sYW5kbG9jay9sYW5kbG9ja190ZXN0ZXIuaMKgIMKgIMKgfCAzNTAKPiAgICAgICAgICsrKysr
KysrKysrKysrKysrKysrKwo+ICAgICAgICAgwqA2IGZpbGVzIGNoYW5nZWQsIDUxMCBpbnNlcnRp
b25zKCspCj4KPiAgICAgICAgIGRpZmYgLS1naXQgYS9ydW50ZXN0L3N5c2NhbGxzIGIvcnVudGVz
dC9zeXNjYWxscwo+ICAgICAgICAgaW5kZXggMWUyZDY4MmUzLi45YWNkYWY3NjAgMTAwNjQ0Cj4g
ICAgICAgICAtLS0gYS9ydW50ZXN0L3N5c2NhbGxzCj4gICAgICAgICArKysgYi9ydW50ZXN0L3N5
c2NhbGxzCj4gICAgICAgICBAQCAtNjg3LDYgKzY4Nyw3IEBAIGtpbGwxMyBraWxsMTMKPiAgICAg
ICAgIMKgbGFuZGxvY2swMSBsYW5kbG9jazAxCj4gICAgICAgICDCoGxhbmRsb2NrMDIgbGFuZGxv
Y2swMgo+ICAgICAgICAgwqBsYW5kbG9jazAzIGxhbmRsb2NrMDMKPiAgICAgICAgICtsYW5kbG9j
azA0IGxhbmRsb2NrMDQKPgo+ICAgICAgICAgwqBsY2hvd24wMSBsY2hvd24wMQo+ICAgICAgICAg
wqBsY2hvd24wMV8xNiBsY2hvd24wMV8xNgo+ICAgICAgICAgZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svLmdpdGlnbm9yZQo+ICAgICAgICAgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrLy5naXRpZ25vcmUKPiAgICAgICAgIGluZGV4IGY3
OWNkMDkwYi4uNGZlOGQ3Y2JhIDEwMDY0NAo+ICAgICAgICAgLS0tIGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9sYW5kbG9jay8uZ2l0aWdub3JlCj4gICAgICAgICArKysgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrLy5naXRpZ25vcmUKPiAgICAgICAgIEBAIC0xLDMgKzEs
NSBAQAo+ICAgICAgICAgK2xhbmRsb2NrX2V4ZWMKPiAgICAgICAgIMKgbGFuZGxvY2swMQo+ICAg
ICAgICAgwqBsYW5kbG9jazAyCj4gICAgICAgICDCoGxhbmRsb2NrMDMKPiAgICAgICAgICtsYW5k
bG9jazA0Cj4gICAgICAgICBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9s
YW5kbG9jay9NYWtlZmlsZQo+ICAgICAgICAgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xh
bmRsb2NrL01ha2VmaWxlCj4gICAgICAgICBpbmRleCA0YjNlM2ZkOGYuLmJkYzZiZDJkNCAxMDA2
NDQKPiAgICAgICAgIC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svTWFr
ZWZpbGUKPiAgICAgICAgICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2sv
TWFrZWZpbGUKPiAgICAgICAgIEBAIC04LDMgKzgsOCBAQCBpbmNsdWRlICQodG9wX3NyY2Rpcikv
aW5jbHVkZS9tay90ZXN0Y2FzZXMubWsKPiAgICAgICAgIDxodHRwOi8vdGVzdGNhc2VzLm1rPgo+
ICAgICAgICAgwqBMRExJQlMgKz0gLWxjCj4KPiAgICAgICAgIMKgaW5jbHVkZSAkKHRvcF9zcmNk
aXIpL2luY2x1ZGUvbWsvZ2VuZXJpY19sZWFmX3RhcmdldC5tawo+ICAgICAgICAgPGh0dHA6Ly9n
ZW5lcmljX2xlYWZfdGFyZ2V0Lm1rPgo+ICAgICAgICAgKwo+ICAgICAgICAgKyMgdGhlIHJlYXNv
biB3aHkgbGFuZGxvY2tfZXhlYyB0ZXN0IGJpbmFyeSBpcyBzdGF0aWNhbGx5Cj4gICAgICAgICBs
aW5rZWQsIGlzIHRoYXQKPiAgICAgICAgICsjIHdlIGNhbid0IHJlYWQgbGliYyBvdXQgb2YgdGhl
IHNhbmRib3hlZCBmb2xkZXIgb25jZQo+ICAgICAgICAgTEFORExPQ0tfQUNDRVNTX0ZTX0VYRUNV
VEUKPiAgICAgICAgICsjIGhhcyBiZWVuIGFjdGl2YXRlZAo+ICAgICAgICAgK2xhbmRsb2NrX2V4
ZWM6IExETElCUyArPSAtc3RhdGljIC1mUElDCj4KPgo+IEFuZCwgaWYgd2UgZGVjaWRlZCB0byBi
dWlsZCB0aGUgcHJvZ3JhbSBhcyBzdGF0aWMsIHdlJ2QgYmV0dGVyCj4gYWRkaW5nIGdsaWJjLXN0
YXRpYyBpbnRvIHRoZSBkZXBlbmRlbmN5IGxpc3QsIG90aGVyd2lzZSBpdCBhbHdheXMKPiBmYWls
ZWQgdG8gbGluayB0aGUgYmluYXJ5IG9uIFJIRUwgZGlzdHJpYnV0aW9ucy4KPgpXZSBmb3VuZCBh
IHNvbHV0aW9uIGZvciB0aGlzLiBXZSBjb21waWxlIGxhbmRsb2NrX2V4ZWMgd2l0aCBkeW5hbWlj
IApsaW5raW5nLCB0aGVuIHdlIGFwcGx5IFJFQUQgKyBFWEVDIHJ1bGVzIHRvIC9saWIgYW5kIC9s
aWI2NC4KSW4gdGhpcyB3YXkgd2UgY2FuIGVhc2lseSBleGVjdXRlIHRoZSBiaW5hcnkgYW5kIHdl
IGRvbid0IG5lZWQgbW9yZSBMVFAgCmRlcGVuZGVuY2VzLgo+IC0tLSBhL2NpL2ZlZG9yYS5zaAo+
ICsrKyBiL2NpL2ZlZG9yYS5zaAo+IEBAIC0xNyw2ICsxNyw3IEBAICR5dW0gXAo+IMKgIMKgIMKg
IMKgIG51bWFjdGwtZGV2ZWwgXAo+IMKgIMKgIMKgIMKgIGxpYnRpcnBjIFwKPiDCoCDCoCDCoCDC
oCBsaWJ0aXJwYy1kZXZlbCBcCj4gKyDCoCDCoCDCoCBsaWJjLXN0YXRpYyBcCj4gwqAgwqAgwqAg
wqAgcGVybC1KU09OIFwKPiDCoCDCoCDCoCDCoCBwZXJsLWxpYnd3dy1wZXJsIFwKPiDCoCDCoCDC
oCDCoCBwa2ctY29uZmlnIFwKPgo+Cj4KPiAtLSAKPiBSZWdhcmRzLAo+IExpIFdhbmcKCkFuZHJl
YQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
