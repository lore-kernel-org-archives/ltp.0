Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A33C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721829015; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=H2IJf+Ny3D0bhPduzrb1lTOtnPNVyB4mvCA0UiEsy+s=;
 b=CkGUkRAfcvZMeKhLynsaJf1VqdWdZRD5AZyPoJDS6m85rcb+NI3L1IVkpa0ob6QRpywQi
 QARRDq+XH0H1DtY4xBTqvMMTaWvl0f6ZH5Y4RhvFRMkOxWaTol6xzeMmMDYrCtAYTmuk2/0
 XcloAsVPxZ4NIvbmUguoCZkr7YwzJ40=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0A123D1C3C
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 15:50:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA50B3C21C6
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:49:53 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD96D1B61079
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:49:52 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso160304266b.0
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721828992; x=1722433792; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YzqRg/5AdHfH5GbOohzwvV4avA8+DgfOinCYyhz2yY=;
 b=VcGtgbc0Z3BNbWIuzcc3QzNf+VKqoUtYLpQ1OlDtauOTQIAXtMih93bOACl+O7YNZz
 r90bmJQo5qFJ+b0PGGop30dn4lCj7HWyKihtyEX5QrcXr81FN5ReZ6+JVdsSY4VSbFJM
 rJDxNlSsLMsXvNaeiBDMzncnty2Azwom0BYy5k5izvE6zzzyOMo4zcTu8qqQCdmPyQFp
 /gb5gGBOmuDQvczKJQyX434VDnLU9nnz04CGiuwSTvwnWoJCO2S8MAeGwdAj4z4HWz3T
 6yo21aVdbAM+nh/65L6BoYFhJJvW2EJ+fQ0w5PswEra5r/tIEnJAWYhHavcDAadP7l4i
 Gb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721828992; x=1722433792;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6YzqRg/5AdHfH5GbOohzwvV4avA8+DgfOinCYyhz2yY=;
 b=hzNbpsvsUmRcBn5ZiF7ZKZFwVdxhZUPh64QigFFh45Eu7zeqhGl7FZqqmFFe7MVBNw
 cI1ketmbk5ylm977O1B4e57aG7A/5n3ti3mRA3Dl2vhcl1cXuo3BzFST8rY0DQc7VFjY
 LKHohKJtOZygiyD379luCBQP2d7cydJU2BJwshNBhfF5j4OWvXBppGtT2l7qNvmhLraZ
 BNfThhZVhfG/F767kNW+hv5w83gQbW59Kf8H280+G8ZiaL/DzJER43Yr/htbQ4IqsZK8
 Ps6whStOojFUYsgaFekkoKzQjdHV/3Tswsck/jtgnpnHMYMFlyjeqpvf0O5ZapIkJ/9a
 UiZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvRXBjIVJaInQCe0QP+WhjjET6wWT4S5T/F8l1XaYklH+h4TnKEDclkF5fWyU5KI2eGyvJv6YCwfltrtT24NbWcN4=
X-Gm-Message-State: AOJu0YyHtyxBtl8zeEV2/xmdWPxB1JZFU6tP5XKGK6s9l6oO2ELYOJTe
 3xhTnCioI+Wo9IxGzjNchQr1nfWEm8QBC3YcADXOS0RZQMKa0C3l+g86VtKNwSY=
X-Google-Smtp-Source: AGHT+IFhQKQ/8/5sZcc7BlTWnHi1ugNgvTs1dP3F56KqTMq7c5iHyOh/EDfleckEBT51AILq7zL0bg==
X-Received: by 2002:a17:907:6d17:b0:a7a:a06b:eec9 with SMTP id
 a640c23a62f3a-a7ab0e2053emr156025566b.4.1721828991874; 
 Wed, 24 Jul 2024 06:49:51 -0700 (PDT)
Received: from [172.20.10.3] ([37.162.108.111])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c95200fsm643412166b.225.2024.07.24.06.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 06:49:51 -0700 (PDT)
Message-ID: <f4e9dadd-5f5f-48f0-ba1d-58ad71bf51f2@suse.com>
Date: Wed, 24 Jul 2024 15:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Petr Vorel <pvorel@suse.cz>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-9-c7b0e9edf9b0@suse.com>
 <20240716172725.GC549165@pevik>
 <CAEemH2fP9eGdHs1Wb5JLhS-H-XXxKB=73n8WAXqj3ZNxw9xDVA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2fP9eGdHs1Wb5JLhS-H-XXxKB=73n8WAXqj3ZNxw9xDVA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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

SGkgTGksCgp0aGFua3MgZm9yIGNoZWNraW5nLiBNbW1oIEkgZG9uJ3Qga25vdyBpZiBpdCdzIGJl
Y2F1c2UgdGhleSBhZGRlZCAKTEFORExPQ0tfUlVMRV9ORVRfUE9SVC4gSXQgc291bmRzIHN0cmFu
Z2UgdG8gbWUsIHNpbmNlIHRoYXQgd291bGQgYnJlYWsgCmFsbCB0aGUgb3RoZXIgZmVhdHVyZXMu
CgpBbmRyZWEKCk9uIDcvMjQvMjQgMTQ6MTIsIExpIFdhbmcgd3JvdGU6Cj4gSGkgUGV0ciwgQW5k
cmVhLAo+Cj4gT24gV2VkLCBKdWwgMTcsIDIwMjQgYXQgMToyN+KAr0FNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+ICAgICBIaSBBbmRyZWEsCj4KPiAgICAgLi4uCj4gICAg
ID4gK3N0YXRpYyB2b2lkIGVuYWJsZV9leGVjX2xpYnMoY29uc3QgaW50IHJ1bGVzZXRfZmQpCj4g
ICAgID4gK3sKPiAgICAgPiArwqAgwqAgwqBGSUxFICpmcDsKPiAgICAgPiArwqAgwqAgwqBjaGFy
IGxpbmVbMTAyNF07Cj4gICAgID4gK8KgIMKgIMKgY2hhciBwYXRoW1BBVEhfTUFYXTsKPiAgICAg
PiArwqAgwqAgwqBjaGFyIGRlcGVuZGVuY3lbOF1bUEFUSF9NQVhdOwo+ICAgICA+ICvCoCDCoCDC
oGludCBjb3VudCA9IDA7Cj4gICAgID4gK8KgIMKgIMKgaW50IGR1cGxpY2F0ZSA9IDA7Cj4gICAg
ID4gKwo+ICAgICA+ICvCoCDCoCDCoGZwID0gU0FGRV9GT1BFTigiL3Byb2Mvc2VsZi9tYXBzIiwg
InIiKTsKPiAgICAgPiArCj4gICAgID4gK8KgIMKgIMKgd2hpbGUgKGZnZXRzKGxpbmUsIHNpemVv
ZihsaW5lKSwgZnApKSB7Cj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHN0cnN0cihs
aW5lLCAiLnNvIikgPT0gTlVMTCkKPiAgICAgPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBjb250aW51ZTsKPiAgICAgPiArCj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgU0FG
RV9TU0NBTkYobGluZSwgIiUqeC0lKnggJSpzICUqeCAlKnMgJSpkICVzIiwgcGF0aCk7Cj4gICAg
ID4gKwo+ICAgICA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGZvciAoaW50IGkgPSAwOyBpIDwgY291
bnQ7IGkrKykgewo+ICAgICA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChz
dHJjbXAocGF0aCwgZGVwZW5kZW5jeVtpXSkgPT0gMCkgewo+ICAgICA+ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGR1cGxpY2F0ZSA9IDE7Cj4gICAgID4gK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7Cj4gICAgID4g
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfQo+ICAgICA+ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoH0KPiAgICAgPiArCj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGR1cGxp
Y2F0ZSkgewo+ICAgICA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGR1cGxpY2F0
ZSA9IDA7Cj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGludWU7
Cj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgfQo+ICAgICA+ICsKPiAgICAgPiArwqAgwqAg
wqAgwqAgwqAgwqAgwqBzdHJuY3B5KGRlcGVuZGVuY3lbY291bnRdLCBwYXRoLCBQQVRIX01BWCk7
Cj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgY291bnQrKzsKPiAgICAgPiArCj4gICAgID4g
K8KgIMKgIMKgIMKgIMKgIMKgIMKgdHN0X3JlcyhUSU5GTywgIkVuYWJsZSByZWFkL2V4ZWMgcGVy
bWlzc2lvbnMgZm9yCj4gICAgICVzIiwgcGF0aCk7Cj4gICAgID4gKwo+ICAgICA+ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoHBhdGhfYmVuZWF0aF9hdHRyLT5hbGxvd2VkX2FjY2VzcyA9Cj4gICAgID4g
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTEFORExPQ0tfQUNDRVNTX0ZTX1JFQURf
RklMRSB8Cj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTEFORExPQ0tf
QUNDRVNTX0ZTX0VYRUNVVEU7Cj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgcGF0aF9iZW5l
YXRoX2F0dHItPnBhcmVudF9mZCA9IFNBRkVfT1BFTihwYXRoLAo+ICAgICBPX1BBVEggfCBPX0NM
T0VYRUMpOwo+ICAgICA+ICsKPiAgICAgPiArwqAgwqAgwqAgwqAgwqAgwqAgwqBTQUZFX0xBTkRM
T0NLX0FERF9SVUxFKAo+ICAgICA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ1
bGVzZXRfZmQsCj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTEFORExP
Q0tfUlVMRV9QQVRIX0JFTkVBVEgsCj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcGF0aF9iZW5lYXRoX2F0dHIsCj4gICAgID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgMCk7Cj4KPiAgICAgVW5mb3J0dW5hdGVseSwgb24gNi42LjE1LWFtZDY0IGtlcm5l
bCAocmFuZG9tIERlYmlhbiBtYWNoaW5lKSBpdAo+ICAgICBmYWlscyAoYWZ0ZXIKPiAgICAgZnJl
c2ggYm9vdCkgd2l0aDoKPgo+ICAgICAuLi4KPiAgICAgdHN0X3N1cHBvcnRlZF9mc190eXBlcy5j
Ojk3OiBUSU5GTzogS2VybmVsIHN1cHBvcnRzIHRtcGZzCj4gICAgIHRzdF9zdXBwb3J0ZWRfZnNf
dHlwZXMuYzo0OTogVElORk86IG1rZnMgaXMgbm90IG5lZWRlZCBmb3IgdG1wZnMKPiAgICAgdHN0
X3Rlc3QuYzoxNzQ2OiBUSU5GTzogPT09IFRlc3Rpbmcgb24gZXh0MiA9PT0KPiAgICAgdHN0X3Rl
c3QuYzoxMTExOiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xvb3AxIHdpdGggZXh0MiBvcHRzPScn
Cj4gICAgIGV4dHJhIG9wdHM9JycKPiAgICAgbWtlMmZzIDEuNDcuMCAoNS1GZWItMjAyMykKPiAg
ICAgdHN0X3Rlc3QuYzoxMTIzOiBUSU5GTzogTW91bnRpbmcgL2Rldi9sb29wMSB0bwo+ICAgICAv
dG1wL0xUUF9sYW50NldiS0ovc2FuZGJveCBmc3R5cD1leHQyIGZsYWdzPTAKPiAgICAgbGFuZGxv
Y2tfY29tbW9uLmg6MzA6IFRJTkZPOiBMYW5kbG9jayBBQkkgdjMKPiAgICAgbGFuZGxvY2swNC5j
OjE1MTogVElORk86IFRlc3RpbmcgTEFORExPQ0tfQUNDRVNTX0ZTX0VYRUNVVEUKPiAgICAgbGFu
ZGxvY2swNC5jOjEyMzogVElORk86IEVuYWJsZSByZWFkL2V4ZWMgcGVybWlzc2lvbnMgZm9yCj4g
ICAgIC91c3IvbGliL2kzODYtbGludXgtZ251L2xpYmMuc28uNgo+ICAgICBsYW5kbG9jazA0LmM6
MTMxOiBUQlJPSzogbGFuZGxvY2tfYWRkX3J1bGUoMywgMSwgMHhmN2YxM2ZmNCwgMCk6Cj4gICAg
IEVJTlZBTCAoMjIpCj4KPgo+IFBvc3NpYmx5IHRoYXQncyBiZWNhdXNlIHRoZSAnTEFORExPQ0tf
UlVMRV9QQVRIX0JFTkVBVEgnwqAgd2FzCj4gcmVmYWN0b3JlZCBmcm9tIHRoZSB2Ni43IG1haW5s
aW5lIGtlcm5lbCwgc28gaXQgY2FuJ3QgYWRkIHRoZSBydWxlIAo+IGNvcnJlY3RseQo+IHdpdGgg
b2xkZXIga2VybmVscy4KPgo+IGNvbW1pdCAwZTBmYzdlOGViNGExMWJkOWY4OWE5Yzc0YmM3YzBl
MTQ0YzU2MjAzCj4gQXV0aG9yOiBLb25zdGFudGluIE1lc2toaWR6ZSA8a29uc3RhbnRpbi5tZXNr
aGlkemVAaHVhd2VpLmNvbT4KPiBEYXRlOiDCoCBUaHUgT2N0IDI2IDA5OjQ3OjQ2IDIwMjMgKzA4
MDAKPgo+IMKgIMKgIGxhbmRsb2NrOiBSZWZhY3RvciBsYW5kbG9ja19hZGRfcnVsZSgpIHN5c2Nh
bGwKPgo+IEJ1dCB0aGlzIGlzIG15IGd1ZXNzICh0aHJvdWdoIHJlYWRpbmcgdGhlIGNvZGUpLCBJ
IGRpZG4ndCBkbyBtb3JlIHRvCj4gdmVyaWZ5IHRoYXQgYnkgaW5zdGFsbGluZyBzdWNoIGEga2Vy
bmVsLgo+Cj4KPiAtLSAKPiBSZWdhcmRzLAo+IExpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
