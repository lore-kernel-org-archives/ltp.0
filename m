Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59016C3DA7E
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 07:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721891605; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=jkgn6pKLe0n0R+/PXITlqcPCPQ0FSW3fTEz+VLdSv78=;
 b=VnVLcJd+gTMEk5I+y0ksp1nuC5NCB2nmjb9DNdd1zM5xw6ZvWDTAMcnvozIFlBuCstMAe
 gLoYa+iHXHcqwPhILBS9mq2ApTQRcdRNnn2QVAJAp1b1R1F+MKyMO3cbmDRLWzrKC4t8TiQ
 yw/qrP0P2yw5N4DvQn5GS22aZPuXJ5M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B40783D1C94
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 09:13:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDC163D1C63
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 09:13:04 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 03F351016B86
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 09:13:03 +0200 (CEST)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7a843bef98so17992466b.2
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721891583; x=1722496383; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hs6XnsLC2O3r+BccvGY8j5f8M3Eszk9Q8c4oAwYSVdQ=;
 b=HwTKqfMlxeKo+c9R9OW4LwwZ4Yn/x+sw0EQZtxpriFwyongVrJpDOYNgj2KWadkiAj
 60WTP6hsthgTBGNEc2BeDh8rQozWJJk7Q2JbPWbo1PrCkdtWsZuq4MBcOv2rd/+VR3Tz
 tFhhNxL/aCsEm87CUtrfpEfR7Ps6RwTDzb1OtsUzramQz44U//76NYCbY9fyy4KpuIRx
 NG7cKkl9W+o9VnzUOgRe/Qa2r+VgF4eTVd5Lted51P8yI/e/GOYQQP7TjYh7sZ6B2GJS
 0bFSJHo24GpMl4WW0e75RDqHm62CMpN8+dxLiMySOTWnEl2g9KAQOdLKUzdtg7qt0DRB
 bGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721891583; x=1722496383;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hs6XnsLC2O3r+BccvGY8j5f8M3Eszk9Q8c4oAwYSVdQ=;
 b=CCLvP/qQDrc7Wtv62SD77Xjhq+3cOJGp2Oa4Piu9JlUaQY0aQ7qWuJR4SqISd1jHnf
 Hz4LbeMa80vKjZrtzanxlpuMdw711EAansvkfO2PIo/YncPuaFWOAZRSKXB5XCah4D1O
 VFVDGscPsak2XP8ysG1hBipO6oKDgCgQx6svpNN4FUU7fDf6lak2qYConOLPaiK2fMYK
 i+s+c9hK2snfdVfGfWpgbQp4qRmyV3G1HZqlfNejYIOp2kpfS/M/gqYFEwBQ2tqluD7C
 SCRd8t4susZOoVYwjk+xesIlB+PTcdGtJ48287X04WAQhCeS3x+DCHrSluur838ntgJa
 A0Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+30KvBD9xhym7ujqRTv/oSGYGlyP7rs1dbvlGlREccnzUA7+JfwwurBlg3BFDOl4V9/n/xcIHImjWhd8g/22w4j4=
X-Gm-Message-State: AOJu0YwRxiaDY41QqaabJHtbNJsn2OzcIjNCnTGIWghBo5Jj6jDWhXkl
 kE9UfTp7r+d3job3mnm7Ery7skznCm5sHzKroD9oCWY0/rWkSj61O34qPBdfNRo=
X-Google-Smtp-Source: AGHT+IHIF90GkLklNhRUVjf9sEDTeHoSUeLYJyr1zqEkUozRLiq6x61Wi1rf706rCP+OPBggoQcg2w==
X-Received: by 2002:a17:906:6a27:b0:a7a:9ca6:531 with SMTP id
 a640c23a62f3a-a7ac5129d42mr120754466b.4.1721891582962; 
 Thu, 25 Jul 2024 00:13:02 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:b3c4:a558:3bdc:9662?
 ([2a02:a31b:84a1:b780:b3c4:a558:3bdc:9662])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23f62sm40801566b.16.2024.07.25.00.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 00:13:02 -0700 (PDT)
Message-ID: <fc172149-12e9-45c3-9411-ab158fa7d747@suse.com>
Date: Thu, 25 Jul 2024 09:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Petr Vorel <pvorel@suse.cz>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-9-c7b0e9edf9b0@suse.com>
 <20240716172725.GC549165@pevik>
 <CAEemH2fP9eGdHs1Wb5JLhS-H-XXxKB=73n8WAXqj3ZNxw9xDVA@mail.gmail.com>
 <f4e9dadd-5f5f-48f0-ba1d-58ad71bf51f2@suse.com>
Content-Language: en-US
In-Reply-To: <f4e9dadd-5f5f-48f0-ba1d-58ad71bf51f2@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 09/11] Add landlock04 test
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
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgppdCBzZWVtcyBsaWtlIHRoZSBsYW5kbG9jaygpIHN1cHBvcnQgaW4ga2VybmVsIDYuNiBp
cyBkaWZmZXJlbnQgdGhhbiB0aGUgCm9uZSBpbiA2LjcuIFRoZSByZWFzb24gd2h5IHdlIHNlZSB0
aGF0IGVycm9yIGluIGtlcm5lbCA8PTYuNiBpcyByZWxhdGVkIAp0byBob3cgbGFuZGxvY2sgaXMg
aGFuZGxpbmcgdGhlIHJ1bGVzIHNldCBhY2NvcmRpbmcgdG8gdGhlIHJ1bGUgd2Ugd2FudCAKdG8g
ZW5hYmxlLgoKTGV0J3Mgc3VwcG9zZSB3ZSB3YW50IHRvIGVuYWJsZSB0aGUgZXhlY3V0aW9uIGZv
ciBhIGZpbGUuIFdoYXQgd2Ugc2hvdWxkIApiZSBhYmxlIHRvIGRvLCBpcyB0byBjb25zaWRlciBf
X0FMTF9fIHRoZSBydWxlcyBhdmFpbGFibGUgZm9yIGxhbmRsb2NrLCAKdGhlbiB0byBlbmFibGUg
RVhFQyBvbmx5IGZvciBhIHNwZWNpZmljIGZpbGUuIFRoZW4sIGlmIHdlIG1ha2UgYW55IG90aGVy
IApvcGVyYXRpb24gdGhhdCBpcyBub3QgRVhFQywgd2Ugc2hvdWxkIGhhdmUgYSBwZXJtaXNzaW9u
IGVycm9yLiBUaGlzIAp0cmFuc2xhdGVzIHRvOgoKLSBzZXQgcnVsZXNldF9hdHRyLT5oYW5kbGVk
X2FjY2Vzc19mcyBmb3IgYWxsIGF2YWlsYWJsZSAKTEFORExPQ0tfQUNDRVNTX0ZTXyogcnVsZXMK
LSBzZXQgcGF0aF9iZW5lYXRoX2F0dHItPmFsbG93ZWRfYWNjZXNzIHRvIExBTkRMT0NLX0FDQ0VT
U19GU19FWEVDIHwgCkxBTkRMT0NLX0FDQ0VTU19GU19SRUFEICh3ZSBuZWVkIHRvIHJlYWQgaW4g
b3JkZXIgdG8gZXhlY3V0ZSkgZm9yIGEgYmluYXJ5Ci0gZW5mb3JjZSB0aGUgcnVsZXMgaW5zaWRl
IGEgc2FuZGJveCBjb250YWluaW5nIHRoZSBiaW5hcnkKLSBleGVjdXRlIHRoZSBiaW5hcnkgd2ls
bCB3b3JrCi0gZG8gYW55IG90aGVyIG9wZXJhdGlvbiBpbnNpZGUgdGhlIHNhbmRib3ggYW5kIG9i
dGFpbiBhIHBlcm1pc3Npb25zIGVycm9yCi0gYXQgdGhpcyBwb2ludCwgYW55IG5ldyBydWxlIHRo
YXQgaXMgYWRkZWQsIHdpbGwgdXBkYXRlIHRoZSBsaXN0IG9mIApsYW5kbG9jayBydWxlcywgZW5h
YmxpbmcgdGhlIHNhbmRib3ggcGVybWlzc2lvbnMKCkZvciBzb21lIHJlYXNvbnMgdGhhdCBJIGRv
bid0IGtub3cgKGFuZCB0aGlzIGlzIGV2aWRlbnQgZnJvbSBrc2VsZnRlc3RzIAphcyB3ZWxsKSwg
aWYgdGhlIGluaXRpYWwgcnVsZXMgc2V0IChydWxlc2V0X2F0dHItPmhhbmRsZWRfYWNjZXNzX2Zz
KSBpcyAKbm90IGlkZW50aWNhbCB0byB0aGUgcnVsZXMgd2UgYXJlIGdvaW5nIHRvIGVuYWJsZSAK
KHBhdGhfYmVuZWF0aF9hdHRyLT5hbGxvd2VkX2FjY2VzcyksIGxhbmRsb2NrX2FkZF9ydWxlKCkg
d2lsbCBmYWlsIHdpdGggCkVJTlZBTC4gQW5kIHRoaXMgaXMgb3VyIGNhc2UgZm9yIGFsbCBrZXJu
ZWxzIDw9Ni42LgoKSSByZWFsbHkgaGF2ZSBubyBpZGVhIHdoeSB0aGlzIGhhcHBlbnMgYW5kIG1h
eWJlIHdlIG5lZWQgdG8gY29udGFjdCB0aGUgCmxhbmRsb2NrIGRldmVsb3BlcnMuCgpBbmRyZWEK
Ck9uIDcvMjQvMjQgMTU6NDcsIEFuZHJlYSBDZXJ2ZXNhdG8gd3JvdGU6Cj4gSGkgTGksCj4KPiB0
aGFua3MgZm9yIGNoZWNraW5nLiBNbW1oIEkgZG9uJ3Qga25vdyBpZiBpdCdzIGJlY2F1c2UgdGhl
eSBhZGRlZCAKPiBMQU5ETE9DS19SVUxFX05FVF9QT1JULiBJdCBzb3VuZHMgc3RyYW5nZSB0byBt
ZSwgc2luY2UgdGhhdCB3b3VsZCAKPiBicmVhayBhbGwgdGhlIG90aGVyIGZlYXR1cmVzLgo+Cj4g
QW5kcmVhCj4KPiBPbiA3LzI0LzI0IDE0OjEyLCBMaSBXYW5nIHdyb3RlOgo+PiBIaSBQZXRyLCBB
bmRyZWEsCj4+Cj4+IE9uIFdlZCwgSnVsIDE3LCAyMDI0IGF0IDE6MjfigK9BTSBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4+Cj4+ICAgICBIaSBBbmRyZWEsCj4+Cj4+ICAgICAu
Li4KPj4gICAgID4gK3N0YXRpYyB2b2lkIGVuYWJsZV9leGVjX2xpYnMoY29uc3QgaW50IHJ1bGVz
ZXRfZmQpCj4+ICAgICA+ICt7Cj4+ICAgICA+ICvCoCDCoCDCoEZJTEUgKmZwOwo+PiAgICAgPiAr
wqAgwqAgwqBjaGFyIGxpbmVbMTAyNF07Cj4+ICAgICA+ICvCoCDCoCDCoGNoYXIgcGF0aFtQQVRI
X01BWF07Cj4+ICAgICA+ICvCoCDCoCDCoGNoYXIgZGVwZW5kZW5jeVs4XVtQQVRIX01BWF07Cj4+
ICAgICA+ICvCoCDCoCDCoGludCBjb3VudCA9IDA7Cj4+ICAgICA+ICvCoCDCoCDCoGludCBkdXBs
aWNhdGUgPSAwOwo+PiAgICAgPiArCj4+ICAgICA+ICvCoCDCoCDCoGZwID0gU0FGRV9GT1BFTigi
L3Byb2Mvc2VsZi9tYXBzIiwgInIiKTsKPj4gICAgID4gKwo+PiAgICAgPiArwqAgwqAgwqB3aGls
ZSAoZmdldHMobGluZSwgc2l6ZW9mKGxpbmUpLCBmcCkpIHsKPj4gICAgID4gK8KgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgKHN0cnN0cihsaW5lLCAiLnNvIikgPT0gTlVMTCkKPj4gICAgID4gK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGludWU7Cj4+ICAgICA+ICsKPj4gICAgID4g
K8KgIMKgIMKgIMKgIMKgIMKgIMKgU0FGRV9TU0NBTkYobGluZSwgIiUqeC0lKnggJSpzICUqeCAl
KnMgJSpkICVzIiwKPj4gICAgIHBhdGgpOwo+PiAgICAgPiArCj4+ICAgICA+ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoGZvciAoaW50IGkgPSAwOyBpIDwgY291bnQ7IGkrKykgewo+PiAgICAgPiArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc3RyY21wKHBhdGgsIGRlcGVuZGVuY3lb
aV0pID09IDApIHsKPj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZHVwbGljYXRlID0gMTsKPj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7Cj4+ICAgICA+ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoH0KPj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgfQo+PiAgICAgPiAr
Cj4+ICAgICA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChkdXBsaWNhdGUpIHsKPj4gICAgID4g
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZHVwbGljYXRlID0gMDsKPj4gICAgID4g
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGludWU7Cj4+ICAgICA+ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoH0KPj4gICAgID4gKwo+PiAgICAgPiArwqAgwqAgwqAgwqAgwqAgwqAg
wqBzdHJuY3B5KGRlcGVuZGVuY3lbY291bnRdLCBwYXRoLCBQQVRIX01BWCk7Cj4+ICAgICA+ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoGNvdW50Kys7Cj4+ICAgICA+ICsKPj4gICAgID4gK8KgIMKgIMKg
IMKgIMKgIMKgIMKgdHN0X3JlcyhUSU5GTywgIkVuYWJsZSByZWFkL2V4ZWMgcGVybWlzc2lvbnMg
Zm9yCj4+ICAgICAlcyIsIHBhdGgpOwo+PiAgICAgPiArCj4+ICAgICA+ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoHBhdGhfYmVuZWF0aF9hdHRyLT5hbGxvd2VkX2FjY2VzcyA9Cj4+ICAgICA+ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoExBTkRMT0NLX0FDQ0VTU19GU19SRUFEX0ZJTEUg
fAo+PiAgICAgPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBMQU5ETE9DS19BQ0NF
U1NfRlNfRVhFQ1VURTsKPj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgcGF0aF9iZW5lYXRo
X2F0dHItPnBhcmVudF9mZCA9IFNBRkVfT1BFTihwYXRoLAo+PiAgICAgT19QQVRIIHwgT19DTE9F
WEVDKTsKPj4gICAgID4gKwo+PiAgICAgPiArwqAgwqAgwqAgwqAgwqAgwqAgwqBTQUZFX0xBTkRM
T0NLX0FERF9SVUxFKAo+PiAgICAgPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
dWxlc2V0X2ZkLAo+PiAgICAgPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBMQU5E
TE9DS19SVUxFX1BBVEhfQkVORUFUSCwKPj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcGF0aF9iZW5lYXRoX2F0dHIsCj4+ICAgICA+ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDApOwo+Pgo+PiAgICAgVW5mb3J0dW5hdGVseSwgb24gNi42LjE1LWFtZDY0
IGtlcm5lbCAocmFuZG9tIERlYmlhbiBtYWNoaW5lKSBpdAo+PiAgICAgZmFpbHMgKGFmdGVyCj4+
ICAgICBmcmVzaCBib290KSB3aXRoOgo+Pgo+PiAgICAgLi4uCj4+ICAgICB0c3Rfc3VwcG9ydGVk
X2ZzX3R5cGVzLmM6OTc6IFRJTkZPOiBLZXJuZWwgc3VwcG9ydHMgdG1wZnMKPj4gICAgIHRzdF9z
dXBwb3J0ZWRfZnNfdHlwZXMuYzo0OTogVElORk86IG1rZnMgaXMgbm90IG5lZWRlZCBmb3IgdG1w
ZnMKPj4gICAgIHRzdF90ZXN0LmM6MTc0NjogVElORk86ID09PSBUZXN0aW5nIG9uIGV4dDIgPT09
Cj4+ICAgICB0c3RfdGVzdC5jOjExMTE6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDEgd2l0
aCBleHQyIG9wdHM9JycKPj4gICAgIGV4dHJhIG9wdHM9JycKPj4gICAgIG1rZTJmcyAxLjQ3LjAg
KDUtRmViLTIwMjMpCj4+ICAgICB0c3RfdGVzdC5jOjExMjM6IFRJTkZPOiBNb3VudGluZyAvZGV2
L2xvb3AxIHRvCj4+ICAgICAvdG1wL0xUUF9sYW50NldiS0ovc2FuZGJveCBmc3R5cD1leHQyIGZs
YWdzPTAKPj4gICAgIGxhbmRsb2NrX2NvbW1vbi5oOjMwOiBUSU5GTzogTGFuZGxvY2sgQUJJIHYz
Cj4+ICAgICBsYW5kbG9jazA0LmM6MTUxOiBUSU5GTzogVGVzdGluZyBMQU5ETE9DS19BQ0NFU1Nf
RlNfRVhFQ1VURQo+PiAgICAgbGFuZGxvY2swNC5jOjEyMzogVElORk86IEVuYWJsZSByZWFkL2V4
ZWMgcGVybWlzc2lvbnMgZm9yCj4+ICAgICAvdXNyL2xpYi9pMzg2LWxpbnV4LWdudS9saWJjLnNv
LjYKPj4gICAgIGxhbmRsb2NrMDQuYzoxMzE6IFRCUk9LOiBsYW5kbG9ja19hZGRfcnVsZSgzLCAx
LCAweGY3ZjEzZmY0LCAwKToKPj4gICAgIEVJTlZBTCAoMjIpCj4+Cj4+Cj4+IFBvc3NpYmx5IHRo
YXQncyBiZWNhdXNlIHRoZSAnTEFORExPQ0tfUlVMRV9QQVRIX0JFTkVBVEgnwqAgd2FzCj4+IHJl
ZmFjdG9yZWQgZnJvbSB0aGUgdjYuNyBtYWlubGluZSBrZXJuZWwsIHNvIGl0IGNhbid0IGFkZCB0
aGUgcnVsZSAKPj4gY29ycmVjdGx5Cj4+IHdpdGggb2xkZXIga2VybmVscy4KPj4KPj4gY29tbWl0
IDBlMGZjN2U4ZWI0YTExYmQ5Zjg5YTljNzRiYzdjMGUxNDRjNTYyMDMKPj4gQXV0aG9yOiBLb25z
dGFudGluIE1lc2toaWR6ZSA8a29uc3RhbnRpbi5tZXNraGlkemVAaHVhd2VpLmNvbT4KPj4gRGF0
ZTogwqAgVGh1IE9jdCAyNiAwOTo0Nzo0NiAyMDIzICswODAwCj4+Cj4+IMKgIMKgIGxhbmRsb2Nr
OiBSZWZhY3RvciBsYW5kbG9ja19hZGRfcnVsZSgpIHN5c2NhbGwKPj4KPj4gQnV0IHRoaXMgaXMg
bXkgZ3Vlc3MgKHRocm91Z2ggcmVhZGluZyB0aGUgY29kZSksIEkgZGlkbid0IGRvIG1vcmUgdG8K
Pj4gdmVyaWZ5IHRoYXQgYnkgaW5zdGFsbGluZyBzdWNoIGEga2VybmVsLgo+Pgo+Pgo+PiAtLSAK
Pj4gUmVnYXJkcywKPj4gTGkgV2FuZwo+Cj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
