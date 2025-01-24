Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDB3C02181
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 10:22:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89EBC3C5624
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 11:22:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15E143C290F
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 11:22:08 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C2DC1A01991
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 11:22:08 +0100 (CET)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df90so3293857a12.2
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 02:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737714127; x=1738318927; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZI2gEJiN+1bTg06ohuji1jg9RLqdn1nBFvWNrXyZivU=;
 b=WARAn6VWrm4CEfQEhwxD3K5t+znc22MRavE9cxDqa51J/zi0YhS1gUQ8rGHbzr5ciA
 GcYxxJdbZGa/wG3+dRGgSZtA9pjHpWBrN1UL6ahUwPQmlYkir7gZjkbs4cQ+kFdYGSlF
 21m8Fz11oBACTc4WZcw3NdR0kkxuJ7wD1QYGT0TPqVTCUZVx7knJv9/UUFbK3IuL/MnN
 QlBCbaMwLT1NPrzr5qow3V+e8KjRynd07Lh5rmvWFa1OLObSF8MSV3Z8a45jrYJ7d8h0
 WGwzb/sGH87WbT9qsMxblOADCHH9EGhdkAcStEx2JSR8kGxIn/ZwuY0SDaFTpYsO9da1
 hVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737714127; x=1738318927;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZI2gEJiN+1bTg06ohuji1jg9RLqdn1nBFvWNrXyZivU=;
 b=hxF0xFwIDYHHjXU+ifgPh/6It7MCx8n4fbU5dL+SecRxtsMRcC+UOKkF9kpSJgbca9
 P0mpZNkhRChzSLDyPJc9cdhU5bcBmAeat4oQXHSdj6+8C/8YWoOhdRlaNRZscmFy4Hqd
 YimRmreaoklzEcmLiY79HJufCMT41Tcy2fuoKTLifHfyYxyJ9c+q7pKEV1viwTthEGWa
 JhDomXSvucAAkyfMQjioA2n9zILdfg/NJUtCN/9DdliTgvbjwH4feZZFJsENdhNA00YX
 T05fWTOUsNVxAn8Sk1BWXUmRHW0ZX2b+S58eHMkqacg8IEq6JnGbpEFVcogpkuk57cqs
 d1Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm7Xlm04kuAGttlBpfMdymWbSCJC2+jFoDhffWeeugnIx4VURuIke08aMPnD1LeNq5RDQ=@lists.linux.it
X-Gm-Message-State: AOJu0YzPhOUgrmwrKCj+1AttrGv170Gs4SRvKb1rHQHn9F8LjBRSoboL
 czcrOiftrvwO7LtH5zXriryJ8lUbIplEsR6mmg6ecjoadByAbsblJfSE5fjOQDxudiUhQ1aQVZC
 zcCfZI0+c6yDeTasftnnm141fUteLAH7gdQE=
X-Gm-Gg: ASbGnctGzU9MQ+pSbj71V4/iy1L1oOml7HmpZoupfcGtTVaGmpOnG5ELeRUYPv8F4qc
 IkzKA4Bx3rnP976cnniQ/vxNeh47lyttO3U4ZNzCF1LkZNyZA/fbc8iQ5D66Lxg==
X-Google-Smtp-Source: AGHT+IEdJCUqhoy09qxx8IiDzH9vPUuAaZStlYgNWb8Di41IxZaSzhEhv9G1ajwtznGyWhU4muGE4+zaysNt5YIZAn4=
X-Received: by 2002:a05:6402:2815:b0:5d2:7396:b0ca with SMTP id
 4fb4d7f45d1cf-5db7d2f873cmr25885804a12.12.1737714127076; Fri, 24 Jan 2025
 02:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20250124100151.GD159953@pevik>
In-Reply-To: <20250124100151.GD159953@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Jan 2025 11:21:55 +0100
X-Gm-Features: AWEUYZmvfBykOFZ6f0IXuAm244Kyq26hqq1AbZZpkOUmnvc1zOQKxPjlH0o56Ak
Message-ID: <CAOQ4uxgSLN9QgoZOaB4H+80AjgnLEHOQOcH-BpM=yAfQO47MTw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Split some fanotify tests
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKYW4gMjQsIDIwMjUgYXQgMTE6MDLigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiBIaSBBbWlyLAo+Cj4gRllJIHdlIHdlcmUgdGhpbmtpbmcgd2l0aCBN
YXJ0aW4gYWJvdXQgc3BsaXR0aW5nIHNvbWUgb2YgdGhlIGZhbm90aWZ5IHRlc3RzLgo+IFdoeT8K
Pgo+IFNvbWUgb2YgdGhlIGZhbm90aWZ5IHRlc3RzIGFyZSBoYXJkIHRvIHJldmlldyAoZS5nLiBm
YW5vdGlmeXsxMCwxMywxNH0uYywpLAo+IGJlY2F1c2UgdGhlIGhhdmUgYSBsb3Qgb2YgcmVzdWx0
cy4KCkkgYXNzdW1lIHlvdSBhcmUgcmVmZXJyaW5nIHRvIHRlc3QgY2FzZXMgdGhhdCBhcmUgZGVj
bGFyZWQgYXMgcmVncmVzc2lvbgp0ZXN0cyBmb3IgYSBmaXggY29tbWl0LgpEbyB5b3UgaW50ZW5k
IHRvIHNwbGl0IGV2ZXJ5IHN1Y2ggdGVzdCBjYXNlIGludG8gaXRzIG93biB0ZXN0PwoKSSBhZ3Jl
ZSB0aGF0IHRoZSBGQU5fREVMRVRFX1NFTEYgdGVzdCBjYXNlIGlzIGEgZ29vZCBjYW5kaWRhdGUK
Zm9yIHNwbGl0dGluZywgaWYgbm90IGZvciBhbnl0aGluZyBlbHNlLCBiZWNhdXNlIHRoZSB1Z2xp
bmVzcyBvZiByZXF1aXJpbmcgdGhpcwp0ZXN0IGNhc2UgdG8gYmUgdGhlIGxhc3QgdGVzdCBjYXNl
LgoKPgo+IEFsc28gb3RoZXIgcHJvYmxlbSBpcyB0aGF0IHNvbWUgZW50ZXJwcmlzZSBrZXJuZWxz
IGRvZXMgbm90IGJhY2twb3J0IG1pbm9yIGZpeGVzCj4gYW5kIHRoZSB1c3VhbCBhcHByb2FjaCBp
cyB0byB3aGl0ZWxpc3QgdGhlIGlzc3VlIGJhc2VkIG9uIGV4aXQgY29kZS4gQnV0IHRoaXMKPiBj
YW5ub3QgYmUgZG9uZSBvbiB0aGUgdGVzdCB3aGljaCBoYXMgbWFueSByZXN1bHRzLiBXZSBjb3Vs
ZCB3b3JrYXJvdW5kIGl0IHdpdGgKPiB0c3Rfa3ZlcmNtcDIoKSwgYnV0IHRoYXQncyBraW5kIG9m
IGEgbGFzdCByZXN1bHQuCgpBcyBhIGdlbmVyYWwgcnVsZSwgbm90IHRlc3RpbmcgYSBrbm93IGJ1
ZyBiZWNhdXNlIGl0IGlzIG5vdCBiYWNrcG9ydGVkCnNvdW5kcyBiYWQgdG8gbWUsIGFsdGhvdWdo
IEkgZG8gYWdyZWUgdGhhdCB0aGVyZSBjb3VsZCBiZSBleGNlcHRpb25zLCBsaWtlOgoKICAgICAg
ICBpZiAodGMtPmlnbm9yZWRfZmxhZ3MgJiBGQU5fRVZFTlRfT05fQ0hJTEQgJiYgdHN0X2t2ZXJj
bXAoNSwKOSwgMCkgPCAwKSB7CiAgICAgICAgICAgICAgICB0c3RfcmVzKFRDT05GLCAiaWdub3Jl
ZCBtYXNrIGluIGNvbWJpbmF0aW9uIHdpdGggZmxhZwpGQU5fRVZFTlRfT05fQ0hJTEQiCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIiBoYXMgdW5kZWZpbmVkIGJlaGF2aW9yIG9uIGtl
cm5lbCA8IDUuOSIpOwoKSWYgdGhlIHRlc3QgcnVubmVyIHdoaXRlbGlzdHMgYSB0ZXN0IGl0J3Mg
dXAgdG8gdGhlbS4KSXQgd291bGQgYmUgbmljZSBpZiBMVFAgY291bGQgYWRkIHRoZSBhYmlsaXR5
IHRvIHdoaXRlbGlzdCBhIHRlc3QgY2FzZS92YXJpYW50Cm9yIGV2ZW4gYSBzcGVjaWZpYyBmaWxl
c3lzdGVtIGZvciBhIHNwZWNpZmljIGFsbF9maWxlc3lzdGVtcyB0ZXN0LCBidXQKaXQncyB1cCB0
bwp5b3UgZ3V5cyB0byBkZWNpZGUgaWYgaXQgaXMgd29ydGggaXQuCgpUaGUgcmVhc29uIEkgdGVu
ZCB0byBhZGQgdGVzdCBjYXNlcyBpcyB0byBzYXZlIGNvZGUgZHVwbGljYXRpb24gYmV0d2VlbiB0
ZXN0cywKYmVjYXVzZSB0aGVyZSBpcyBhIGxvdCBvZiBib2lsZXJwbGF0ZSBjb2RlIGZvciBldmVu
dCB2ZXJpZmljYXRpb24sIHdoaWNoIG9mdGVuCmhhcyBidWdzIGFuZCBuZWVkcyBmaXhpbmcgaW4g
bXVsdGlwbGUgdGVzdHMuClRoZXJlIGlzIGFub3RoZXIgc29sdXRpb24gZm9yIGNvZGUgZHVwbGlj
YXRpb24gLSB0byB3cml0ZSBnZW5lcmljIGZhbm90aWZ5IGV2ZW50CnZlcmlmaWNhdGlvbiBoZWxw
ZXJzLgoKSXQncyB1cCB0byB5b3UgdG8gZGVjaWRlIGlmIHRoZXJlIGlzIHJvb20gZm9yIHNvbWUg
aGVscGVycyBmb3IgZmFub3RpZnkgZXZlbnQKdmVyaWZpY2F0aW9uIG9yIGlmIHlvdSB3YW50IHRv
IGZvcmsgdGhlIHRlc3RzIHdpdGggY29kZSBkdXBsaWNhdGlvbi4KV0RZVD8KClRoYW5rcywKQW1p
ci4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
