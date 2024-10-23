Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1458FCDDE7B
	for <ltp@archiver.kernel.org>; Wed, 23 Oct 2024 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1729685523; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=AsSsbPo1cbSStgJdiuAa/faj9YVBzqmpxsat9jgJRXs=;
 b=LOLZoMr9qmSZO4IuB4/H6t9UgjZG7jQq7etHT4jpHEKrW+Ilkmv9QFqfVugyhTQRtEV9M
 YMF5qujbstv0vzQ/1ct5YZWMtsVjiHjIaIAgU3PHPD6hju5IWrK5OqsoScw68zhp3Wuefqo
 f7VHVAcMmjHLO1hgVCb6cDi5itwTdLs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E612A3C704B
	for <ltp@archiver.kernel.org>; Wed, 23 Oct 2024 14:12:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EE4C3C702B
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 14:11:44 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4F6BB1459E2D
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 14:11:43 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso39838175e9.3
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 05:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1729685503; x=1730290303; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMlwRRvQ9N8ZfgarqQwvKgMW7kOkwtqx6JbjYS7WbMI=;
 b=BRY4cMEUtSX4pvY+x+NKikq/H3QbuCo/m4aUrxSjkoYAwtH/m+yvgUlxn5pwq73X0Z
 YEUzFSDmd8uvNALJH1A5ghY75r2pAIoIIs/RLXJ0LI+mIHQn0QyS4lGCcPhsmU63llsw
 X5xG1NA0mqOO4f6FGsa7lIugaawYaWziFPihY4AJoJdZcZ5YarzlLf3HR4Ng72Zdnm9M
 p+utKFrcrEV0Grz6G7nsV9phiel35DYqsKUbQ5Q+r7g9bcoF2QDrtSy15aIl8Fx3tndN
 qT9tSdr66SOonXZ7wE6CZUvDxPRI6Nbvku3/iOfIncYGtINjZjZyUY7TxFi0bSVLW6YX
 36hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729685503; x=1730290303;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XMlwRRvQ9N8ZfgarqQwvKgMW7kOkwtqx6JbjYS7WbMI=;
 b=ItLHT+6255jA7JSayLvrsvFuQDlmC5ePXf4JQ4oV6JXcq20eUSUWPjb2o/CUt8DrCt
 6alhJI+B84R//YnOY4dAmxssy+dJEvPlPt07ielvGV1LA5BUfczeFN4zCEeDeF37MaSk
 s6pHEw0pyi9lW9/gwCrmxl2qxZU5q0uXtV6eyv/NYL+h6NuzWoieM9tMOvCqxY067RgM
 lxKzYba3racxOrXapmWx9cV33He39aR05BysP/6NM1KBvY2Bv6mtPJ5vLSJFqDxd8wI/
 D1QCgc22kI9285s+GWGlqga6SqgjMlifsFw7u6y0xmD1BF9O0g9vwdSb6fVdyhKYOmAT
 Irww==
X-Gm-Message-State: AOJu0Yw9e09ToHB/C1DenxnMiuOqxPHhY7Os3ugDa2QGb5+GG3L3Dit4
 G13azFcWbMcNvOhfIZKYN6ptJ5BFf6RLPksHd0NhlqSjsPvsrn2LlyG6tRg9iyA=
X-Google-Smtp-Source: AGHT+IHxFL7xUq0mnkaYgT55/K0w1bQGVmcEfLf++54Xfh5LdIJphpQ4otGcw9SBfzVom9LY2KIelA==
X-Received: by 2002:a5d:654f:0:b0:37d:4647:155a with SMTP id
 ffacd0b85a97d-37efcc5f0e7mr1767118f8f.0.1729685502539; 
 Wed, 23 Oct 2024 05:11:42 -0700 (PDT)
Received: from [10.15.23.93] ([213.61.187.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a4864csm8792311f8f.35.2024.10.23.05.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 05:11:42 -0700 (PDT)
Message-ID: <a896b44c-6574-4566-a6ad-8e356547514c@suse.com>
Date: Wed, 23 Oct 2024 14:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-4-5328a785bbad@suse.com>
 <CAEemH2fnQ+H83o4L6Rx1p-e7s3ExFAwK9PNRkbGZuc2OFYUEYg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2fnQ+H83o4L6Rx1p-e7s3ExFAwK9PNRkbGZuc2OFYUEYg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 4/4] Update syscalls files
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

SGkgTGksCk9uIDEwLzE1LzI0IDA4OjQ5LCBMaSBXYW5nIHdyb3RlOgo+Cj4gQW5kcmVhIENlcnZl
c2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmRlPiB3cm90ZToKPgo+ICAgICBTaWduZWQtb2Zm
LWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+ICAgICAt
LS0KPiAgICAgwqBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvYXJjLmluIDxodHRwOi8vYXJjLmluPiDC
oCDCoCDCoCDCoHzCoCA0MSArLQo+ICAgICDCoGluY2x1ZGUvbGFwaS9zeXNjYWxscy9hcm0uaW4g
PGh0dHA6Ly9hcm0uaW4+IMKgIMKgIMKgIMKgfCA4MTkKPiAgICAgKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0KPiAgICAgwqBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvYXJtNjQuaW4g
PGh0dHA6Ly9hcm02NC5pbj4gwqAgwqAgwqB8wqAgMTggKy0KPiAgICAgwqBpbmNsdWRlL2xhcGkv
c3lzY2FsbHMvaTM4Ni5pbiA8aHR0cDovL2kzODYuaW4+IMKgIMKgIMKgIHzCoCAxOCArLQo+ICAg
ICDCoGluY2x1ZGUvbGFwaS9zeXNjYWxscy9pYTY0LmluIDxodHRwOi8vaWE2NC5pbj4gwqAgwqAg
wqAgfMKgIDEwICstCj4KPgo+Cj4gVGhlIG1haW5saW5lIGtlcm5lbCBoYXMgZHJvcHBlZMKgc3Vw
cG9ydCBmb3IgSXRhbml1bSBJQS02NCAKPiBmcm9twqBrZXJuZWwtdjYuNy4KPiBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQv
Y29tbWl0Lz9pZD1jZjhlODY1ODEwMGQ0ZWFlODBjZTliMjFmN2E4MWNiMDI0ZGQ1MDU3Cj4KPiBJ
J23CoHdvbmRlcmluZyBpZiB3ZSBzaG91bGQgcmVtb3ZlIElBNjQgc3VwcG9ydCBmb3IgTFRQIGFz
IHdlbGwuCj4KPiBCdXQgd2hhdGV2ZXIgTFRQIGtlZXBzIHRoZSBjb2RlIGZvciBJQTY0IG9yIG5v
dCwgbWF5YmUgd2UgZG9uJ3QKPiBuZWVkIHRoZXNlIHVwZGF0ZSBmb3IgaWE2NCwgcmlnaHQ/Ckkg
ZG9uJ3Qga25vdyBpZiBpdCdzIGEgZ29vZCBpZGVhLCBzaW5jZSB3ZSBzdGlsbCBzdXBwb3J0IG9s
ZGVyIGtlcm5lbCAKdmVyc2lvbnMuCj4KPgo+IC0tIAo+IFJlZ2FyZHMsCj4gTGkgV2FuZwpBbmRy
ZWEKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
