Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F84C83F17
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 07:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752564374; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=wMoyDF2u/j2XroRlLpA0+bVoydbHXXnvgR4WG/8Ze+Y=;
 b=fBF7OtVOWYbPJV6TXysE06giAnii45m0jMKAHVvzgFFqEFQ3v2dWRc8aHLeavoAGdaG3H
 U6d+z5yN5oFMw/t8ltkeiyNE95wKJlbC/DEQntIagOyWl3WqPw/D7cIZwK0nEjCBHUQx2Qg
 Cw+siCnBvvdDjgfghYLN20K3wwgEJJQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75A503CC384
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 09:26:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 434723C83A9
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 09:25:50 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B14E600CC8
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 09:25:49 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso3878249f8f.1
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752564349; x=1753169149; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uz4AsN9cSs1UMke+tlRUnuH8Fg6YCUSiUDQm9WAAbeM=;
 b=NkYrxVInMi0A2tNCG+1ZTmtthT3mcIn4dTL917KGAJWWZZaesgkvXB92JZO1JgIxW1
 UUn8KQQXDVzOz+MN0DPD9jgnq2NfbD5gXaPd+KffbZqyth+V9errBAocgxcOnL8ng81c
 SmNRSM8b8aQZroaiQyQZUr5uaCp9jkBSvdaoES4IkQCcsaXG/ybOoqKWCuqAJMjXzDO7
 QRPi88Y0Ho4ay32SS/528avdNfCLgoqerDwHvKF/sfFhGG7+NXqMlWKCax18BTuI+rzP
 aW28wwMzBMptn6177t4P2NyTy+veMGT+rt+yA4PjQXgrpb5xnhr/ieF1PGZjf++APM06
 MdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752564349; x=1753169149;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uz4AsN9cSs1UMke+tlRUnuH8Fg6YCUSiUDQm9WAAbeM=;
 b=Uelz8u2NFuWaBvucp0JT86ZVhVq1FmH9DaWdEjVcMoKJSdVcIYLB4J9VWBCutJvRua
 8xIxBqdfO6saUBjoXRrTSsLcXSY/Nrd7B+9B7DJOQC8Gax2RPx0QOu68wghV7luo2Vem
 ho9qRnhpcw9tY8TqhOEVwfbD/hHUYAnVd9MCSP0CHBG6GPTmMMCQlIue9BEyZmCOwuyA
 quCrXj9SkSYKtEaOruqcU3TNHddCMvwBmgtkKx18883aSavpAALGqNAQakjyQZirxca+
 RMxuB4VoXJJuVC+wa5DgfHw1zd0XxUF0gR2Mk+py6lyKpLaV5QoPQA4+LR/KLjdLwHkF
 7yxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYIVQYzKhQ+fgEdYQZibwIK0Ndz5tEHmZlwspuK1BU0RSCbQqWC8IaLXOBxLEACUEwS0I=@lists.linux.it
X-Gm-Message-State: AOJu0Yy6PY5cTGfWt6qjnkaF+nKnNSj604N5Go0a+Cx25eONuD8qqHEu
 ODbTCFidFu59gHTEU7eF72qel0hgS3DceYbXrwuH7xzcfFTDtenAgTHzF9Y3uUZGxApiFsoXFIf
 IpZDw/P8=
X-Gm-Gg: ASbGncscKjISqvv7HahyB6KBLkBa31ZRRTdBPN5+a8UA+CZ/TwF1z+vu5i89wjILR7u
 QdoShdCuoc1se4hslLHvNjoCThwv1gixwZugg0INcQ0TvnqqHo1sfMIc+daSPoNAClqMPNAaU33
 jbawZfCgALZUTMUV1RpwoXJ2wG1gN7PPXqi/s1dzNzljZT+NXQbGapUIrOxUbcgrMKfaVaao+b4
 4/G2B3MsqNapwIcnf4Oj4n/KpBuc/UO7FPEi/mu+DqxdhJNCcxkypE6AQ3ZuvyCv3oVKsXfZgBJ
 Vw7LSbm+bkvGlW9rIoFmH3aO/2du2t4PqyrjDUFV8p0yuYW+tI+LHgyeGVkBFJRyJfPk4Sy28w0
 DbwtDi2f5MflQaOGuxtiN2j/wnOGIfBv7W3m5Zrnns5/ytQ8d747iaLdzXups3xrzzcAZkxHzPp
 goSSVSL+O18hPxsuQgXwPX9VYvr9/QgOzP6xcqolCKWA63H6QJz08nYlPa/dqidA==
X-Google-Smtp-Source: AGHT+IGydosREkCRVK3DwRSwqWFpNqtYFcZ55eZ5T9wVE20HWbEnOKPJ/cJFxMTBK5tbSACM0MqASw==
X-Received: by 2002:a05:6000:2c0f:b0:3a4:d4cd:b06 with SMTP id
 ffacd0b85a97d-3b5f18d98c1mr15041146f8f.34.1752564348716; 
 Tue, 15 Jul 2025 00:25:48 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e25e75sm14218680f8f.87.2025.07.15.00.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 00:25:48 -0700 (PDT)
Message-ID: <2f0a9863-03c8-4036-a619-2b910421bc6f@suse.com>
Date: Tue, 15 Jul 2025 09:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lufei <lufei@uniontech.com>, ltp@lists.linux.it
References: <20250711072406.41444-1-lufei@uniontech.com>
 <20250715021426.59851-1-lufei@uniontech.com>
Content-Language: en-US
In-Reply-To: <20250715021426.59851-1-lufei@uniontech.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add unshare(CLONE_NEWPID) test
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiA3LzE1LzI1IDQ6MTQgQU0sIGx1ZmVpIHdyb3RlOgo+IFRlc3QgdW5zaGFyZShDTE9O
RV9ORVdQSUQpIHRvIG1ha2UgZmlyc3QgY2hpbGQgaW4gbmV3IFBJRCBuYW1lc3BjZSBnZXQKPiBw
aWQgMS4KIMKgwqDCoCBBZGQgdW5zaGFyZTA1IHRlc3QKCiDCoMKgwqAgVGVzdCBpZiB1bnNoYXJl
KENMT05FX05FV1BJRCkgYXNzaWduIHBpZCAxIHRvIHRoZSBmaXJzdCBjaGlsZC4KCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBsdWZlaSA8bHVmZWlAdW5pb250ZWNoLmNvbT4KPiAtLS0KPiAgIHJ1bnRlc3Qv
c3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKPiAgIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS8uZ2l0aWdub3JlICB8ICAxICsKPiAgIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNoYXJlMDUuYyB8IDQ3ICsrKysrKysrKysrKysr
KysrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQo+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNoYXJlMDUuYwo+
Cj4gZGlmZiAtLWdpdCBhL3J1bnRlc3Qvc3lzY2FsbHMgYi9ydW50ZXN0L3N5c2NhbGxzCj4gaW5k
ZXggNTczMzgyOTdhLi44MmUyMjJiZjQgMTAwNjQ0Cj4gLS0tIGEvcnVudGVzdC9zeXNjYWxscwo+
ICsrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKPiBAQCAtMTcyNiw2ICsxNzI2LDcgQEAgdW5zaGFyZTAx
IHVuc2hhcmUwMQo+ICAgdW5zaGFyZTAyIHVuc2hhcmUwMgo+ICAgdW5zaGFyZTAzIHVuc2hhcmUw
Mwo+ICAgdW5zaGFyZTA0IHVuc2hhcmUwNAo+ICt1bnNoYXJlMDUgdW5zaGFyZTA1Cj4gICAKPiAg
ICMKPiAgICMgVGhlc2UgdGVzdHMgcmVxdWlyZSBhbiB1bm1vdW50ZWQgYmxvY2sgZGV2aWNlCj4g
ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS8uZ2l0aWdub3Jl
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJlLy5naXRpZ25vcmUKPiBpbmRleCBi
MTIwNmU0NTIuLjhlY2U1Zjk4OCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3Vuc2hhcmUvLmdpdGlnbm9yZQo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
dW5zaGFyZS8uZ2l0aWdub3JlCj4gQEAgLTIsMyArMiw0IEBACj4gICAvdW5zaGFyZTAyCj4gICAv
dW5zaGFyZTAzCj4gICAvdW5zaGFyZTA0Cj4gKy91bnNoYXJlMDUKPiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJlL3Vuc2hhcmUwNS5jIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy91bnNoYXJlL3Vuc2hhcmUwNS5jCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQK
PiBpbmRleCAwMDAwMDAwMDAuLmM4NWRiMzZiOQo+IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vuc2hhcmUvdW5zaGFyZTA1LmMKPiBAQCAtMCwwICsxLDQ3
IEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gKy8q
Cj4gKyAqIENvcHlyaWdodCAoYykgMjAyNSBsdWZlaSA8bHVmZWlAdW5pb250ZWNoLmNvbT4KPiAr
ICovCj4gKwo+ICsvKlwKPiArICogVGhpcyB0ZXN0IGNhc2UgdmVyaWZpZXMgdW5zaGFyZShDTE9O
RV9ORVdQSUQpIGNyZWF0ZXMgYSBuZXcgUElEIG5hbWVzcGFjZQo+ICsgKiBhbmQgdGhhdCB0aGUg
Zmlyc3QgY2hpbGQgcHJvY2VzcyBpbiB0aGUgbmV3IG5hbWVzcGFjZSBnZXRzIFBJRCAxLgo+ICsg
Ki8KPiArCj4gKyNkZWZpbmUgX0dOVV9TT1VSQ0UKPiArCj4gKyNpbmNsdWRlICJ0c3RfdGVzdC5o
Igo+ICsjaW5jbHVkZSAibGFwaS9zY2hlZC5oIgo+ICsKPiArc3RhdGljIHN0cnVjdCB0c3RfY2xv
bmVfYXJncyAqYXJnczsKPiArCj4gK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gK3sKPiArCWFy
Z3MtPmZsYWdzID0gQ0xPTkVfTkVXUElEOwo+ICsJYXJncy0+ZXhpdF9zaWduYWwgPSBTSUdDSExE
Owo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCBydW4odm9pZCkKPiArewo+ICsJaWYgKCFTQUZFX0NM
T05FKGFyZ3MpKSB7Cj4gKwkJU0FGRV9VTlNIQVJFKENMT05FX05FV1BJRCk7Cj4gKwo+ICsJCWlm
ICghU0FGRV9GT1JLKCkpIHsKPiArCQkJVFNUX0VYUF9FUV9MSShnZXRwaWQoKSwgMSk7Cj4gKwkJ
CWV4aXQoMCk7Cj4gKwkJfQo+ICsKPiArCQlleGl0KDApOwo+ICsJfQo+ICt9Cj4gKwo+ICtzdGF0
aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gKwkuc2V0dXAgPSBzZXR1cCwKPiArCS5mb3Jr
c19jaGlsZCA9IDEsCj4gKwkubmVlZHNfcm9vdCA9IDEsCj4gKwkudGVzdF9hbGwgPSBydW4sCj4g
KwkuYnVmcyA9IChzdHJ1Y3QgdHN0X2J1ZmZlcnMgW10pIHsKPiArCQl7JmFyZ3MsIC5zaXplID0g
c2l6ZW9mKCphcmdzKX0sCj4gKwkJe30sCj4gKwl9Cj4gK307CgpTb3JyeSBJIG1hZGUgYSBtaXN0
YWtlIGluIHRoZSByZXZpZXcuIHRzdF9yZWFwX2NoaWxkcmVuKCkgbXVzdCBiZSBjYWxsZWQgCmZv
ciBuZXN0ZWQgY2hpbGRyZW4uClRoZSBjb3JyZWN0IHdheSBpcyB0aGUgZm9sbG93aW5nIChJIHJl
ZHVjZWQgbmVzdGluZyBzdGF0ZW1lbnRzIGFzIHdlbGwgCmhlcmUpOgoKc3RhdGljIHZvaWQgcnVu
KHZvaWQpCnsKIMKgwqDCoCBpZiAoU0FGRV9DTE9ORShhcmdzKSkKIMKgwqDCoMKgwqDCoMKgIHJl
dHVybjsKCiDCoMKgwqAgU0FGRV9VTlNIQVJFKENMT05FX05FV1BJRCk7CgogwqDCoMKgIGlmICgh
U0FGRV9GT1JLKCkpIHsKIMKgwqDCoMKgwqDCoMKgIFRTVF9FWFBfRVFfTEkoZ2V0cGlkKCksIDEp
OwogwqDCoMKgwqDCoMKgwqAgZXhpdCgwKTsKIMKgwqDCoCB9CgogwqDCoMKgIHRzdF9yZWFwX2No
aWxkcmVuKCk7Cn0KCi0gQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
