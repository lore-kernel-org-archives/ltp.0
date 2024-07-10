Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BF1C38150
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 07:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720596637; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=pv7DAJlVkSMMWl3v/yKvMdBTY0cZFElqDNcpFd4OmT0=;
 b=JzOO2JRDyVzTEQe7ie7z+VKczwosJ7d14aefoSeok45suAGnYI1BVdprFdy6fmL59e1l9
 5axBOUCwMH/n+Gg5gf13tXVs/UmiHpeRRf80KZWOErRBuLBaCCXb5MPIDJvklloP1SeJQad
 svW48NSi0AVKYWLTaudzZlWpVRf2ZMk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 990313D3833
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 09:30:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 988D73CBB49
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 09:30:17 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5B75520172C
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 09:30:16 +0200 (CEST)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ee7a1ad286so63375761fa.2
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1720596615; x=1721201415; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlpEunhdyUNgnhue7oTYWonxegSklfBylWYcLvKoLjc=;
 b=MWKDUBYMI+UsWtpUYPqgsYdRFb/+m5Q5CCZbeCAg9kqEY+TYGSeqx+yLb6iNjNPh1r
 n/2xbj8yCQCgATOqJlUvBlFsIowsyNNraTqRKVkR46+TmB+isbe2Z2Pm7qpMBpjbV/6d
 QsdfJ52PLLZZZ4rm9pPb8ZXePlPEFyPFd9OtxmIpsigaJJBGsDW7rbUWW2WfH22C9WKs
 AbQylUSO2TV5ruAxx6oSvVX2PHIPp5caI1SyweOmFRQztsNj3mlO4wi/k7thDSynmk8x
 8YQlrmTI5MVI8Gr0f2NqIcuTr3rsLlZEzc9fNbWhCl73+2YD80f+kiTn2vAsvVtJr9yb
 Ov8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720596615; x=1721201415;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wlpEunhdyUNgnhue7oTYWonxegSklfBylWYcLvKoLjc=;
 b=VEwWwJopmw0AYelg9agN/mfEZZPLI6Isx+zrhc9xj0gbwR/jxGVIZ/NJcict57pt5d
 rqnymRT1dRQr6Rg9AAteLt7+6gapLZDMWALJR1VXh6VAfHmWb1yaWdHZv0i/PGxOavvy
 nLYexYVOZLK6ct+Z8RpQtZavnyqYzBgQf1sli62ONn0Wp+QIr2/yrn6pLnqDt7t85raf
 dfHCYBEiHtXt9l3TE3DGavJNPtGxdTmiL8uLMx8xRg/gGpxBJ+CH9ZjO0/5Nxx5rvOeF
 BsUj0acVVfPfQZivkK/LkQHucBWa6acrZLOHv/Sgutd4GK/YaGLvLSa3N6AJqfLFRxRG
 DsPw==
X-Gm-Message-State: AOJu0YyZ7wMrxTMkk4jMrAsiQn2KMKhT/8jBVNivn8OhIOi6Dj16y/1d
 sS5s0GFEv/UsWt0bePrKF0+9moBJpEgY8niKjILD91AA/Qu50D/BUZQJ2s3sGrc=
X-Google-Smtp-Source: AGHT+IHrn9CaqJVoy17sYDlBuBIXjoalrLVc4SHqXXu/npZl6ccub1lt8JVJdm648Mu9xecj5HBV+Q==
X-Received: by 2002:a2e:9bcc:0:b0:2ee:493f:d751 with SMTP id
 38308e7fff4ca-2eeb30fd3admr34456111fa.23.1720596615050; 
 Wed, 10 Jul 2024 00:30:15 -0700 (PDT)
Received: from [192.168.178.49] ([212.86.40.91])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ac8651sm27149365ad.242.2024.07.10.00.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 00:30:14 -0700 (PDT)
Message-ID: <aa325118-82e0-4400-a675-ff0333f2c11d@suse.com>
Date: Wed, 10 Jul 2024 09:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
 <20240709-stat04-v2-5-2693a473a2ab@suse.com>
 <CAEemH2eC8Vgrnfiaf=fL69crXtc4kXScFEYFP1AyLES_NfPAyw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2eC8Vgrnfiaf=fL69crXtc4kXScFEYFP1AyLES_NfPAyw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 5/5] Add open15 test
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

T24gNy85LzI0IDE0OjE0LCBMaSBXYW5nIHdyb3RlOgo+IEhpIEFuZHJlYSwKPgo+IE9uIFR1ZSwg
SnVsIDksIDIwMjQgYXQgNjo0N+KAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gCj4gPGFuZHJlYS5jZXJ2
ZXNhdG9Ac3VzZS5kZT4gd3JvdGU6Cj4KPiAgICAgRnJvbTogQW5kcmVhIENlcnZlc2F0byA8YW5k
cmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPgo+ICAgICBUaGlzIHRlc3QgaGFzIGJlZW4gZXh0cmFj
dGVkIGZyb20gc3ltbGluazAxIGFuZCBpdCB2ZXJpZmllcyB0aGF0Cj4gICAgIG9wZW4oKSBpcyB3
b3JraW5nIGNvcnJlY3RseSBvbiBzeW1saW5rKCkgZ2VuZXJhdGVkIGZpbGVzLgo+Cj4gICAgIFNp
Z25lZC1vZmYtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+
Cj4gICAgIC0tLQo+ICAgICDCoHJ1bnRlc3Qvc3lzY2FsbHPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB8wqAgMiArLQo+ICAgICDCoHRlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvb3Blbi8uZ2l0aWdub3JlIHzCoCAxICsKPiAgICAgwqB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL29wZW4vb3BlbjE1LmPCoCDCoHwgNjQKPiAgICAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwo+ICAgICDCoDMgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQo+Cj4gICAgIGRpZmYgLS1naXQgYS9ydW50ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9z
eXNjYWxscwo+ICAgICBpbmRleCA0MGMwZGQwNzAuLjRkZmRmMzc4MiAxMDA2NDQKPiAgICAgLS0t
IGEvcnVudGVzdC9zeXNjYWxscwo+ICAgICArKysgYi9ydW50ZXN0L3N5c2NhbGxzCj4gICAgIEBA
IC05MjMsNyArOTIzLDYgQEAgbmljZTA0IG5pY2UwNAo+ICAgICDCoG5pY2UwNSBuaWNlMDUKPgo+
ICAgICDCoG9wZW4wMSBvcGVuMDEKPiAgICAgLW9wZW4wMUEgc3ltbGluazAxIC1UIG9wZW4wMQo+
ICAgICDCoG9wZW4wMiBvcGVuMDIKPiAgICAgwqBvcGVuMDMgb3BlbjAzCj4gICAgIMKgb3BlbjA0
IG9wZW4wNAo+ICAgICBAQCAtOTM2LDYgKzkzNSw3IEBAIG9wZW4xMSBvcGVuMTEKPiAgICAgwqBv
cGVuMTIgb3BlbjEyCj4gICAgIMKgb3BlbjEzIG9wZW4xMwo+ICAgICDCoG9wZW4xNCBvcGVuMTQK
PiAgICAgK29wZW4xNSBvcGVuMTUKPgo+ICAgICDCoG9wZW5hdDAxIG9wZW5hdDAxCj4gICAgIMKg
b3BlbmF0MDIgb3BlbmF0MDIKPiAgICAgZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvb3Blbi8uZ2l0aWdub3JlCj4gICAgIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9v
cGVuLy5naXRpZ25vcmUKPiAgICAgaW5kZXggMDAxZDg3NGQ2Li5hZjU5OTc1NzIgMTAwNjQ0Cj4g
ICAgIC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Blbi8uZ2l0aWdub3JlCj4gICAg
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Blbi8uZ2l0aWdub3JlCj4gICAgIEBA
IC0xMiwzICsxMiw0IEBACj4gICAgIMKgL29wZW4xMl9jaGlsZAo+ICAgICDCoC9vcGVuMTMKPiAg
ICAgwqAvb3BlbjE0Cj4gICAgICsvb3BlbjE1Cj4gICAgIGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL29wZW4vb3BlbjE1LmMKPiAgICAgYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL29wZW4vb3BlbjE1LmMKPiAgICAgbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiAgICAgaW5k
ZXggMDAwMDAwMDAwLi40YWQ3MjkyYWUKPiAgICAgLS0tIC9kZXYvbnVsbAo+ICAgICArKysgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW4vb3BlbjE1LmMKPiAgICAgQEAgLTAsMCArMSw2
NCBAQAo+ICAgICArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIK
PiAgICAgKy8qCj4gICAgICsgKiBDb3B5cmlnaHQgKGMpIDIwMDAgU2lsaWNvbiBHcmFwaGljcywg
SW5jLsKgIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCj4gICAgICsgKsKgIMKgIEF1dGhvcjogRGF2aWQg
RmVubmVyCj4gICAgICsgKsKgIMKgIENvcGlsb3Q6IEpvbiBIZW5kcmlja3Nvbgo+ICAgICArICog
Q29weXJpZ2h0IChDKSAyMDI0IEFuZHJlYSBDZXJ2ZXNhdG8gYW5kcmVhLmNlcnZlc2F0b0BzdXNl
LmNvbQo+ICAgICArICovCj4gICAgICsKPiAgICAgKy8qXAo+ICAgICArICogW0Rlc2NyaXB0aW9u
XQo+ICAgICArICoKPiAgICAgKyAqIFRoaXMgdGVzdCB2ZXJpZmllcyB0aGF0IG9wZW4oKSBpcyB3
b3JraW5nIGNvcnJlY3RseSBvbiBzeW1saW5rKCkKPiAgICAgKyAqIGdlbmVyYXRlZCBmaWxlcy4K
PiAgICAgKyAqLwo+ICAgICArCj4gICAgICsjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiAgICAgKwo+
ICAgICArI2RlZmluZSBGSUxFTkFNRSAibXlmaWxlLnR4dCIKPiAgICAgKyNkZWZpbmUgU1lNQk5B
TUUgIm15ZmlsZV9zeW1saW5rIgo+ICAgICArI2RlZmluZSBCSUdfU1RSSU5HCj4gICAgICJhYmNk
ZWZnaGlqa2xtbm9wcXJzdHV2d3h5emFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6Igo+ICAgICAr
Cj4gICAgICtzdGF0aWMgY2hhciBidWZmX2ZpbGVbMTI4XTsKPiAgICAgK3N0YXRpYyBjaGFyIGJ1
ZmZfc3ltbGlua1sxMjhdOwo+ICAgICArc3RhdGljIGludCBzdHJfc2l6ZTsKPiAgICAgKwo+ICAg
ICArc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4gICAgICt7Cj4gICAgICvCoCDCoCDCoCDCoGludCBm
ZF9maWxlLCBmZF9zeW1saW5rOwo+ICAgICArCj4gICAgICvCoCDCoCDCoCDCoG1lbXNldChidWZm
X2ZpbGUsIDAsIHNpemVvZihidWZmX2ZpbGUpKTsKPiAgICAgK8KgIMKgIMKgIMKgbWVtc2V0KGJ1
ZmZfc3ltbGluaywgMCwgc2l6ZW9mKGJ1ZmZfc3ltbGluaykpOwo+ICAgICArCj4gICAgICvCoCDC
oCDCoCDCoGZkX2ZpbGUgPSBTQUZFX09QRU4oRklMRU5BTUUsIE9fQ1JFQVQgfCBPX1JEV1IsIDA3
NzcpOwo+Cj4KPiBNeSBpbml0aWFsIHN1Z2dlc3Rpb24gaW4gdGhlIGxhc3QgZW1haWwgd2FzIHRv
IGdlbmVyYXRlIGZpbGUgZGF0YSBieQo+IHN5bWxpbmssIHdoaWNowqBtYXRjaGVzIHRoZSBkZXNj
cmlwdGlvbiBpbiBjb2RlIGNvbW1lbnRzLgo+Cj4gZmRfc3ltbGluayA9IFNBRkVfT1BFTihzeW1u
YW1lLCBPX0NSRUFUIHwgT19SRFdSLCAwNzc3KTsKPiDCoCDCoMKgU0FGRV9XUklURShTQUZFX1dS
SVRFX0FMTCwgZmRfc3ltbGluaywgQklHX1NUUklORywgc3RyX3NpemUpOwo+Cj4gQnV0IG5vdCB0
b8KgY3JlYXRlJndyaXRlwqBmaWxlcyB2aWEgZmRfZmlsZS4gT3RoZXJ3aXNlIGl0IGRldmlhdGVz
IGZyb20gCj4gdGhlIHRlc3QgZ29hbC4KPgpBaCByaWdodCwgZ29ubmEgZml4IHRoYXQuIFRoYW5r
cwo+Cj4gICAgICvCoCDCoCDCoCDCoFNBRkVfV1JJVEUoU0FGRV9XUklURV9BTEwsIGZkX2ZpbGUs
IEJJR19TVFJJTkcsIHN0cl9zaXplKTsKPiAgICAgKwo+ICAgICArwqAgwqAgwqAgwqBTQUZFX1NZ
TUxJTksoRklMRU5BTUUsIFNZTUJOQU1FKTsKPiAgICAgKwo+ICAgICArwqAgwqAgwqAgwqBTQUZF
X0xTRUVLKGZkX2ZpbGUsIDAsIDApOwo+ICAgICArwqAgwqAgwqAgwqBTQUZFX1JFQUQoMSwgZmRf
ZmlsZSwgYnVmZl9maWxlLCBzdHJfc2l6ZSk7Cj4gICAgICsKPiAgICAgK8KgIMKgIMKgIMKgZmRf
c3ltbGluayA9IFNBRkVfT1BFTihTWU1CTkFNRSwgT19SRFdSLCAwNzc3KTsKPiAgICAgK8KgIMKg
IMKgIMKgU0FGRV9MU0VFSyhmZF9zeW1saW5rLCAwLCAwKTsKPiAgICAgK8KgIMKgIMKgIMKgU0FG
RV9SRUFEKDEsIGZkX3N5bWxpbmssIGJ1ZmZfc3ltbGluaywgc3RyX3NpemUpOwo+ICAgICArCj4g
ICAgICvCoCDCoCDCoCDCoFRTVF9FWFBfRVhQUighc3RybmNtcChidWZmX2ZpbGUsIGJ1ZmZfc3lt
bGluaywgc3RyX3NpemUpLAo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAiZmlsZSBkYXRh
IGlzIHRoZSBlcXVpdmFsZW50IHRvIHN5bWxpbmsgZ2VuZXJhdGVkCj4gICAgIGZpbGUgZGF0YSIp
Owo+ICAgICArCj4gICAgICvCoCDCoCDCoCDCoFNBRkVfQ0xPU0UoZmRfZmlsZSk7Cj4gICAgICvC
oCDCoCDCoCDCoFNBRkVfQ0xPU0UoZmRfc3ltbGluayk7Cj4gICAgICsKPiAgICAgK8KgIMKgIMKg
IMKgU0FGRV9VTkxJTksoU1lNQk5BTUUpOwo+ICAgICArwqAgwqAgwqAgwqBTQUZFX1VOTElOSyhG
SUxFTkFNRSk7Cj4gICAgICt9Cj4gICAgICsKPiAgICAgK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQp
Cj4gICAgICt7Cj4gICAgICvCoCDCoCDCoCDCoHN0cl9zaXplID0gc3RybGVuKEJJR19TVFJJTkcp
Owo+ICAgICArfQo+ICAgICArCj4gICAgICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7
Cj4gICAgICvCoCDCoCDCoCDCoC50ZXN0X2FsbCA9IHJ1biwKPiAgICAgK8KgIMKgIMKgIMKgLnNl
dHVwID0gc2V0dXAsCj4gICAgICvCoCDCoCDCoCDCoC5uZWVkc190bXBkaXIgPSAxLAo+ICAgICAr
fTsKPgo+ICAgICAtLSAKPiAgICAgMi40My4wCj4KPgo+ICAgICAtLSAKPiAgICAgTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgo+Cj4gLS0g
Cj4gUmVnYXJkcywKPiBMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
