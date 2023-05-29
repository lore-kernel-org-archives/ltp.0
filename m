Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5F9C77B7E
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 16:16:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 607A63CD060
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 18:16:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16EE33CCFF0
 for <ltp@lists.linux.it>; Mon, 29 May 2023 18:16:32 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 946DB6001AC
 for <ltp@lists.linux.it>; Mon, 29 May 2023 18:16:31 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-514924b4f8cso3774881a12.3
 for <ltp@lists.linux.it>; Mon, 29 May 2023 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=colorfullife-com.20221208.gappssmtp.com; s=20221208; t=1685376991;
 x=1687968991; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x9Wct7xO9SnRtB839Od+ilnX6yvbSUwAnQvf6TlnDk0=;
 b=EJZ6fuxibG+QARg+qFrUAAdPBCAFkb/bnlhwgGpemrvAFodcSsXifEMu31rMwZ5br/
 YWNNO4d5DSq7RE3COouJAZ5dZrL1Ycfph669wRRoPVse0udSS9zWIi5jr52ggPTCRETr
 1t98QlzjPCmrJjGHwHZGFth+S7kRN60RNSlRT0dmF6P+NCKSAeRJa/FtaCEMFa8CaaNn
 olLBHulWEMRi2uywJDTlEpuw75sv/dG6jufEe280bMPEQ9bwZ8PHThGPMMIrj5qaXWeY
 n5mQK/6746S38hSWd6iO4+PXXTrFchWf1ZRuZ8m+Bp2CWZKAQp2LN8RnDlE4XbKX/CYy
 0rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685376991; x=1687968991;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x9Wct7xO9SnRtB839Od+ilnX6yvbSUwAnQvf6TlnDk0=;
 b=Iv2hdv2B0MweetNAcYj8cP6GBfECdkQRp5z9N+IS9sN6hgNrBWg29gndX/g62PxanF
 E5AX7f2L1eU3hp62AYhUrJM+ncXv+ZAN1PAcuWLIniQfiluAs2Y+Q60abcTiT4RibVa3
 rO6ghnABlbc1gmPv0Kst1shhzWghdtAKe7xX6sR9xc+BbRwV8DJqYWtmrzh2PAehEDRJ
 LSbaC0aMrQyTYLYjocs5JRXDMQVo+f1r8en3lPQm93fCnmOTubwl8odxd0PiUn0jj2Nq
 3jKDC/N8izUO/x5RElifYDfSlLP0PHWexy7/soIMtetYt7ZZRjWON19GwB9OvYUht0Hh
 Imjg==
X-Gm-Message-State: AC+VfDylIwMfoAB7N7JfGywye6l6Fh0nImyV21i10FBNMVn9P1JcPnNi
 KhNxMM6ahlNwKmKB/LQuc/mK1A==
X-Google-Smtp-Source: ACHHUZ5703AgkrC0YfjdiR6RB6L0/mPghnO6w3UOBq6X+IT89WlR+1XQGJJRTPBriE8ntd2yBcVc/A==
X-Received: by 2002:a17:907:d8c:b0:96f:5cb3:df66 with SMTP id
 go12-20020a1709070d8c00b0096f5cb3df66mr11827105ejc.18.1685376990923; 
 Mon, 29 May 2023 09:16:30 -0700 (PDT)
Received: from ?IPV6:2003:d9:972e:ae00:3a2e:69fd:25d5:812f?
 (p200300d9972eae003a2e69fd25d5812f.dip0.t-ipconnect.de.
 [2003:d9:972e:ae00:3a2e:69fd:25d5:812f])
 by smtp.googlemail.com with ESMTPSA id
 f11-20020a1709062c4b00b0096a6bf89259sm5995013ejh.167.2023.05.29.09.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 09:16:30 -0700 (PDT)
Message-ID: <5c4040b2-fdbb-1897-e6a8-1c990226586c@colorfullife.com>
Date: Mon, 29 May 2023 18:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Li Wang <liwang@redhat.com>
References: <CA+G9fYuKehraq_kcHdVgqWnwQWHN2QiE7ze53mXJvtL0DLc0uQ@mail.gmail.com>
 <9677ced3-8386-47f0-a2d6-de27ec84207e@app.fastmail.com>
 <b3b0d222-b745-07bc-8dcd-38f762343c84@colorfullife.com>
 <CAEemH2cKjmef+R=gF94J3VT8Kg0inQaWu93dybvPsJM+OM1fQA@mail.gmail.com>
Content-Language: en-US
From: Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <CAEemH2cKjmef+R=gF94J3VT8Kg0inQaWu93dybvPsJM+OM1fQA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: shmget02 fails on compat mode - 64-bit kernel and
 32-bit userspace
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Davidlohr Bueso <dbueso@suse.de>, open list <linux-kernel@vger.kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, lkft-triage@lists.linaro.org,
 Ard Biesheuvel <ardb@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgpPbiA1LzIwLzIzIDA1OjU4LCBMaSBXYW5nIHdyb3RlOgo+IEhpIE1hbmZyZWQsCj4K
PiBPbiBTYXQsIE1heSAyMCwgMjAyMyBhdCAxOjU14oCvQU0gTWFuZnJlZCBTcHJhdWwgCj4gPG1h
bmZyZWRAY29sb3JmdWxsaWZlLmNvbT4gd3JvdGU6Cj4KPiAgICAgSGkgYWxsLAo+Cj4gICAgIE9u
IDUvMTkvMjMgMTI6NTcsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4gICAgID4gT24gRnJpLCBNYXkg
MTksIDIwMjMsIGF0IDExOjE3LCBOYXJlc2ggS2FtYm9qdSB3cm90ZToKPiAgICAgPj4gTFRQIHJ1
bm5pbmcgb24gY29tcGF0IG1vZGUgd2hlcmUgdGhlIHRlc3RzIHJ1biBvbgo+ICAgICA+PiA2NC1i
aXQga2VybmVsIGFuZCAzMi1iaXQgdXNlcnNwYWNlIGFyZSBub3RpY2VkIG9uIGEgbGlzdCBvZgo+
ICAgICBmYWlsdXJlcy4KPiAgICAgPj4KPiAgICAgPj4gV2hhdCB3b3VsZCBiZSB0aGUgYmVzdCB3
YXkgdG8gaGFuZGxlIHRoaXMgcmFyZSBjb21iaW5hdGlvbiBvZgo+ICAgICBmYWlsdXJlcyA/Cj4g
ICAgID4+Cj4gICAgID4+ICogYXJtNjQ6IGp1bm8tcjItY29tcGF0LCBxZW11X2FybTY0LWNvbXBh
dCBhbmQgcWVtdV94ODZfNjQtY29tcGF0Cj4gICAgID4+wqAgwqAgwqAgLSBzaG1nZXQwMgo+ICAg
ICA+Pgo+ICAgICA+PiBSZXBvcnRlZC1ieTogTGludXggS2VybmVsIEZ1bmN0aW9uYWwgVGVzdGlu
ZyA8bGtmdEBsaW5hcm8ub3JnPgo+ICAgICA+Pgo+ICAgICA+PiB0c3RfaHVnZXBhZ2UuYzo4Mzog
VElORk86IDAgaHVnZXBhZ2UocykgcmVzZXJ2ZWQKPiAgICAgPj4gdHN0X3Rlc3QuYzoxNTU4OiBU
SU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAybSAzMHMKPiAgICAgPj4gdHN0X2tjb25maWcu
Yzo4NzogVElORk86IFBhcnNpbmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwo+ICAg
ICA+PiBzaG1nZXQwMi5jOjk1OiBUUEFTUzogc2htZ2V0KDE2NDQxOTk4MjYsIDIwNDgsIDEwMjQp
IDogRU5PRU5UICgyKQo+ICAgICA+PiBzaG1nZXQwMi5jOjk1OiBUUEFTUzogc2htZ2V0KDE2Mjc0
MjI2MTAsIDIwNDgsIDE1MzYpIDogRUVYSVNUICgxNykKPiAgICAgPj4gPDQ+W8KgIMKgODQuNjc4
MTUwXSBfX3ZtX2Vub3VnaF9tZW1vcnk6IHBpZDogNTEzLCBjb21tOiBzaG1nZXQwMiwgbm90Cj4g
ICAgID4+IGVub3VnaCBtZW1vcnkgZm9yIHRoZSBhbGxvY2F0aW9uCj4gICAgID4+IHNobWdldDAy
LmM6OTU6IFRQQVNTOiBzaG1nZXQoMTY0NDE5OTgyNiwgMCwgMTUzNikgOiBFSU5WQUwgKDIyKQo+
ICAgICA+PiBzaG1nZXQwMi5jOjk1OiBURkFJTDogc2htZ2V0KDE2NDQxOTk4MjYsIDQyNzgxOTAw
ODAsIDE1MzYpIGV4cGVjdGVkCj4gICAgID4+IEVJTlZBTDogRU5PTUVNICgxMikKPiAgICAgPiBB
ZGRpbmcgTGlhbSBIb3dsZXR0LCBEYXZpZGxvaHIgQnVlc28gYW5kIE1hbmZyZWQgU3ByYXVsIHRv
IENjLCB0aGV5Cj4gICAgID4gaGF2ZSB3b3JrZWQgb24gdGhlIHNobSBjb2RlIGluIHRoZSBwYXN0
IGZldyB5ZWFycy4KPiAgICAgPgo+ICAgICA+IFRoaXMgaXMgdGhlIGxpbmUKPiAgICAgPgo+ICAg
ICA+wqAgwqAgwqAgwqB7JnNobWtleTEsIFNITU1BWCArIDEsIElQQ19DUkVBVCB8IElQQ19FWENM
LCAwLCAwLCBFSU5WQUx9LAo+ICAgICA+Cj4gICAgID4gZnJvbQo+ICAgICA+Cj4gICAgID4KPiAg
ICAgaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvYmxvYi8wNGU4ZjJm
NGZkOTQ5L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL3NobWdldC9zaG1nZXQwMi5jI0xM
NTlDMS1MNTlDNjEKPiAgICAgPgo+ICAgICA+IHJpZ2h0Pwo+ICAgICA+Cj4gICAgID4gSSB0aGlu
ayB0aGlzIGlzIGEgcmVzdWx0IG9mIFNITU1BWCBiZWluZyBkZWZpbmVkIGFzCj4gICAgID4gI2Rl
ZmluZSBTSE1NQVggKFVMT05HX01BWCAtICgxVUwgPDwgMjQpKSwgc28gdGhlIGtlcm5lbCB3b3Vs
ZAo+ICAgICA+IGxpa2VseSB1c2UgYSBsYXJnZSA2NC1iaXQgdmFsdWUgaGVyZSwgd2hpbGUgdGhl
IDMyLWJpdCB1c2VyCj4gICAgID4gc3BhY2UgdXNlcyBhIG11Y2ggc21hbGxlciBsaW1pdC4KPiAg
ICAgPgo+ICAgICA+IFRoZSBleHBlY3RlZCByZXR1cm4gY29kZSBsaWtlbHkgY29tZXMgZnJvbQo+
ICAgICA+Cj4gICAgID4gc3RhdGljIGludCBuZXdzZWcoc3RydWN0IGlwY19uYW1lc3BhY2UgKm5z
LCBzdHJ1Y3QgaXBjX3BhcmFtcwo+ICAgICAqcGFyYW1zKQo+ICAgICA+IHsKPiAgICAgPiAuLi4K
PiAgICAgPsKgIMKgIMKgIMKgIMKgIGlmIChzaXplIDwgU0hNTUlOIHx8IHNpemUgPiBucy0+c2ht
X2N0bG1heCkKPiAgICAgPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAtRUlOVkFM
Owo+ICAgICA+Cj4gICAgID4gYnV0IGlmIG5zLT5zaG1fY3RsbWF4IGlzIHByb2JhYmx5IHNldCB0
byB0aGUgNjQtYml0IHZhbHVlIGhlcmUuCj4gICAgID4gSXQgd291bGQgdGhlbiB0cmlnZ2VyIHRo
ZSBhY2NvdW50aW5nIGxpbWl0IGluIF9fc2htZW1fZmlsZV9zZXR1cCgpOgo+ICAgICA+Cj4gICAg
ID7CoCDCoCDCoCDCoCDCoCBpZiAoc2htZW1fYWNjdF9zaXplKGZsYWdzLCBzaXplKSkKPiAgICAg
PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwo+ICAg
ICA+Cj4gICAgID4gTXkgZmVlbGluZyBpcyB0aGF0IHRoZSBrZXJuZWwgaW4gdGhpcyBjYXNlIHdv
cmtzIGFzIGV4cGVjdGVkLAo+ICAgICA+IGFuZCBJIHdvdWxkbid0IHNlZSB0aGlzIGFzIGEgYnVn
LiBPbiB0aGUgb3RoZXIgaGFuZCwgdGhpcwo+ICAgICA+IGNhbiBwcm9iYWJseSBiZSBhZGRyZXNz
ZWQgaW4gdGhlIGtlcm5lbCBieSBhZGRpbmcgYSBjaGVjayBmb3IKPiAgICAgPiBjb21wYXQgdGFz
a3MgbGlrZQo+ICAgICA+Cj4gICAgID4gLS0tIGEvaXBjL3NobS5jCj4gICAgID4gKysrIGIvaXBj
L3NobS5jCj4gICAgID4gQEAgLTcxNCw3ICs3MTQsOCBAQCBzdGF0aWMgaW50IG5ld3NlZyhzdHJ1
Y3QgaXBjX25hbWVzcGFjZSAqbnMsCj4gICAgIHN0cnVjdCBpcGNfcGFyYW1zICpwYXJhbXMpCj4g
ICAgID7CoCDCoCDCoCDCoCDCoCBjaGFyIG5hbWVbMTNdOwo+ICAgICA+wqAgwqAgwqAgwqAgwqAg
dm1fZmxhZ3NfdCBhY2N0ZmxhZyA9IDA7Cj4gICAgID4KPiAgICAgPiAtwqAgwqAgwqAgwqBpZiAo
c2l6ZSA8IFNITU1JTiB8fCBzaXplID4gbnMtPnNobV9jdGxtYXgpCj4gICAgID4gK8KgIMKgIMKg
IMKgaWYgKHNpemUgPCBTSE1NSU4gfHwgc2l6ZSA+IG5zLT5zaG1fY3RsbWF4IHx8Cj4gICAgID4g
K8KgIMKgIMKgIMKgIMKgIGluX2NvbXBhdF9zeXNjYWxsKCkgJiYgc2l6ZSA+IENPTVBBVF9TSE1N
QVgpKQo+ICAgICA+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIC1FSU5WQUw7Cj4g
ICAgID4KPiAgICAgPsKgIMKgIMKgIMKgIMKgIGlmIChudW1wYWdlcyA8PCBQQUdFX1NISUZUIDwg
c2l6ZSkKPiAgICAgPgo+ICAgICBJIHdvdWxkIGNvbnNpZGVyIHRoaXMgYXMgdWdseTogbnMtPnNo
bV9jdGxtYXggY2FuIGJlIGNvbmZpZ3VyZWQgYnkKPiAgICAgd3JpdGluZyB0byAvcHJvYy9zeXMv
a2VybmVsL3NobW1heC4KPgo+ICAgICBZb3UgY2FuIGJyZWFrIHRoZSB0ZXN0IGNhc2Ugb24gNjQt
Yml0IGFzIHdlbGwsIGp1c3QgYnkgd3JpdGluZwo+ICAgICBTSE1NQVgrMQo+ICAgICB0byAvcHJv
Yy9zeXMva2VybmVsL3NobW1heAo+Cj4gICAgIFRodXMgSSB0aGluayB0aGUgdGVzdCBjYXNlIGlz
IGZsYXdlZDoKPgo+ICAgICBJdCBpcyB0ZXN0aW5nIHRoZSBvdmVyZmxvdyBiZWhhdmlvciBmb3Ig
YSBjb25maWd1cmFibGUgdmFsdWUgYnkKPiAgICAgdGVzdGluZwo+ICAgICB3aXRoIGRlZmF1bHQr
MS4gQnV0IHNvbWV0aW1lcyB0aGUgYWN0dWFsIHZhbHVlIGlzIG5vdCB0aGUgZGVmYXVsdC4KPgo+
ICAgICBBcmUgdGhlIHRlc3RzIHJ1bm5pbmcgYXMgcm9vdD8KPgo+Cj4gWWVzLgo+Cj4KPiAgICAg
V2hhdCBhYm91dCBpbnRlbnRpb25hbGx5IHNldHRpbmcgdGhlIHZhbHVlIHRvIHNvbWV0aGluZyB1
c2VmdWw/Cj4KPgo+Cj4gVGhpcyBzdWdnZXN0IHNvdW5kcyByZWFzb25hYmxlLCBidXQgSSBoYXZl
IGEgcXVlc3Rpb246Cj4gaXMgdGhlcmUgYW55IHVwcGVyIGxpbWl0IGZvciBzZXR0aW5nIHRoZSAv
cHJvYy9zeXMva2VybmVsL3NobW1heD8KPgpUaGUgcmVhbCBsaW1pdCBpcyAweDdmZmZmZmZmZmZm
ZmZmZmYuIEV2ZW4gaWYgdGhlIHZhbHVlIG9mIHNobW1heCBpcyAKaGlnaGVyLCBzaG1nZXQoKSBm
YWlscy4KCkkgdGhpbmsgdGhpcyBpcyBkdWUgdG8gTUFYX0xGU19GSUxFU0laRSBpbiBfX3NobWVt
X2ZpbGVfc2V0dXAoKS4gSSAKZGlkbid0IGF0dGFjaCBhIGRlYnVnZ2VyLCB0aHVzIEkgY2Fubm90
IHJ1bGUgb3V0IHRoYXQgdGhlcmUgaXMgYW5vdGhlciAKY2hlY2sgdGhhdCBhbHNvIHJlamVjdHMg
Pj0gMHg4MDA8Li4uPjAKClRoZSBtYXhpbXVtIHVzZWZ1bCBzaXplIGlzIHByb2JhYmx5IGV2ZW4g
bG93ZXIsIHNobWF0KCkgd291bGQgZmFpbCBzaW5jZSAKdGhlIHZpcnR1YWwgbWVtb3J5IHNpemUg
aXMgZXZlbiBzbWFsbGVyLgoKPgo+IFRoZSB0ZXN0IHNlZW1zIHRvIHRyeSB0byB0ZXN0IHRoZSBi
b3VuZGVyIGFuZCBhcyBhCj4gY29ybmVyIGNhc2UgZm9yIGNvdmVyaW5nIHRoYXQgc2NlbmFyaW8u
CkJ1dCB0aGVuIGp1c3QgcmVkdWNlIHNobW1heDoKCi0gdGVzdCB0aGF0IHNobWdldCg1MDAwKSB3
b3JrcwoKLSBlY2hvICI0OTk5IiA+IC9wcm9jL3N5cy9rZXJuZWwvc2htbWF4CgotIHRlc3QgdGhh
dCBzaG1nZXQoNTAwMCkgZmFpbHMKCi0gZWNobyAiNTAwMCIgPiAvcHJvYy9zeXMva2VybmVsL3No
bW1heAoKLSB0ZXN0IHRoYXQgc2htZ2V0KDUwMDApIHdvcmtzIGFnYWluLgoKCgo+Cj4gICAgIHRt
cD0kKGNhdCAvcHJvYy9zeXMva2VybmVsL3NobW1heCkKPgo+ICAgICBlY2hvICIxMjM0IiA+IC9w
cm9jL3N5cy9rZXJuZWwvc2htbWF4Cj4KPiAgICAgc2VtZ2V0KCkgYmFzZWQgb24geyZzaG1rZXkx
LCAxMjM0ICsgMSwgSVBDX0NSRUFUIHwgSVBDX0VYQ0wsIDAsIDAsCj4gICAgIEVJTlZBTH0sCj4g
ICAgIGVjaG8gJHRtcCA+L3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXgKPgo+ICAgICBPciwgYWx0ZXJu
YXRpdmVseTogcmVhZCAvcHJvYy9zeXMva2VybmVsL3NobW1heCwgYW5kIHNraXAgdGhlIHRlc3Qg
aWYKPiAgICAgdGhlIHZhbHVlIGlzIGxhcmdlciB0aGFuIFVMT05HX01BWC0xLgo+Cj4gICAgIC0t
Cj4gICAgIMKgIMKgIMKgIMKgIE1hbmZyZWQKPgo+Cj4KPgo+IC0tIAo+IFJlZ2FyZHMsCj4gTGkg
V2FuZwoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
