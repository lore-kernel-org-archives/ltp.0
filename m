Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEB7C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 14:48:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E643A3CD970
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 15:48:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 222D43C81C6
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:48:09 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 126531A00ECC
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:48:09 +0100 (CET)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67a242c232eso25569106d6.0
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701269288; x=1701874088; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRp1EwKmznylIAeJj0uMBVRjvbSuJcHGWC+yugRLG3c=;
 b=Wp4RqffM8sUvPQplukVWOO3sUqYGP34bRG0AfeiXinwG3TyEbZHaJ3Ef+ofIqm0sKJ
 N9mCdBUHAzsyj1OC3/H5yoe3suhv7Z7f+lCSRM1mtWuHKDunBZzUERbFJ/uTEhanFyR+
 v8hwkux5bJc8WJlAUUBqVjnrQWiwfLa6deKKPp4+9ztDoAjhGgXt+q2Ht5Mrwsn2KYAe
 cuqT0fSGacShuDNbyPIMiA7cy2+uHyC7uHJEhqOAEDId3uTvXcL7wNVgmWPC2D2sLYsr
 PaSXyQP5mNcYWU86d2dAy+DBdHzJjmOWtZTwwBx5zfLoRgsXRaapXWRE7lelxWJ3+CV5
 WhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701269288; x=1701874088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRp1EwKmznylIAeJj0uMBVRjvbSuJcHGWC+yugRLG3c=;
 b=I8bseDrAR4+iwj0jCu8d+0Q0TXlPqCBHFhduuZ2gZHgoUovzuJ/89xE7A5hx2Gz0MW
 nHt9aYo7nGYsb+kczxPDMTyH/94wCEc61pZcIlKRAn8gpN8zz2OcpuhfgFuz+q+NZsSd
 /kRpV1SIDWlWQ2THolUYpSHh6SXITkATyGzCm8YmigRZfYhLxxgadvlPFu/bf9FKazF0
 TH0D5p77KQREsQh5F5YbuPH4HZySFeHhU+k9ORZz/HlAgmT4KqORfgjaRGHFo1DjpwPS
 26Ho0d0zsiJfT7V/z2D/CAGCrbkjf7frCOUbqeaEM0WvI9I+rj2nTY7lK+nG5ou2zR1m
 4yZA==
X-Gm-Message-State: AOJu0YxmLzBELhEiXqz59P2BnSR+iO9mWKNtpQ5WwuSIAyxjZ++Qy3mw
 VK1gAgc2rShZKbmzz2uSPPKmNGrYlM71AkSMf7E=
X-Google-Smtp-Source: AGHT+IEQp5gIhTTqL01+/Uagnj+h7Gzbx6ByxWPGljZm2NeWJi7IOYlcUDoNZpNMWTzy02OLmIAHxC13yjS7VzpntQE=
X-Received: by 2002:a0c:ec0f:0:b0:67a:225e:2d28 with SMTP id
 y15-20020a0cec0f000000b0067a225e2d28mr16939649qvo.8.1701269287748; Wed, 29
 Nov 2023 06:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20231129114617.12660-1-jack@suse.cz>
 <20231129115440.19100-2-jack@suse.cz>
In-Reply-To: <20231129115440.19100-2-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 Nov 2023 16:47:56 +0200
Message-ID: <CAOQ4uxjZ3mfz7FR38ynStaJb=m_STS_ZEYqkveFAWHSeNJwgug@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] fanotify: Provide
 fanotify_mark_supported_on_fs()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBOb3YgMjksIDIwMjMgYXQgMTo1NOKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gUHJvdmlkZSBoZWxwZXIgY2hlY2tpbmcgd2hldGhlciBhIG1hcmsgaXMgc3Vw
cG9ydGVkIG9uIGEgZmlsZXN5c3RlbQo+IHNpbmNlIHNvbWUgbWFya3MgbmVlZCBub3QgYmUgYXZh
aWxhYmxlIG9uIGFsbCBmaWxlc3lzdGVtcyAoZS5nLiBidHJmcwo+IHN1YnZvbHVtZXMpLiBBbHNv
IGNvbnZlcnQgUkVRVUlSRV9NQVJLX1RZUEVfU1VQUE9SVEVEX0JZX0tFUk5FTCgpIGFuZAo+IGl0
cyBvbmx5IHVzZXIgdG8gdXNlIHRoaXMgbmV3IGZ1bmN0aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTog
SmFuIEthcmEgPGphY2tAc3VzZS5jej4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9mYW5vdGlmeS9mYW5vdGlmeS5oICAgfCAxMSArKysrKysrKy0tLQo+ICB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMuYyB8ICAyICstCj4gIDIgZmlsZXMgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaCBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaAo+IGluZGV4IGVlNzRjMmZmZmJkNS4u
ZjI4ZGExYTVlZTU1IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFu
b3RpZnkvZmFub3RpZnkuaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3Rp
ZnkvZmFub3RpZnkuaAo+IEBAIC0yMjYsNiArMjI2LDExIEBAIHN0YXRpYyBpbmxpbmUgaW50IGZh
bm90aWZ5X2luaXRfZmxhZ3Nfc3VwcG9ydGVkX2J5X2tlcm5lbCh1bnNpZ25lZCBpbnQgZmxhZ3Mp
Cj4gICAgICAgICByZXR1cm4gZmFub3RpZnlfaW5pdF9mbGFnc19zdXBwb3J0ZWRfb25fZnMoZmxh
Z3MsIE5VTEwpOwo+ICB9Cj4KPiArc3RhdGljIGlubGluZSBpbnQgZmFub3RpZnlfbWFya19zdXBw
b3J0ZWRfb25fZnModWludDY0X3QgZmxhZywgY29uc3QgY2hhciAqZm5hbWUpCj4gK3sKPiArICAg
ICAgIHJldHVybiBmYW5vdGlmeV9mbGFnc19zdXBwb3J0ZWRfb25fZnMoRkFOX0NMQVNTX0NPTlRF
TlQsIGZsYWcsIEZBTl9BQ0NFU1MsIGZuYW1lKTsKCldoeSBub3QgRkFOX0NMQVNTX05PVElGPwoK
PiArfQo+ICsKPiAgI2RlZmluZSBUU1RfRkFOT1RJRllfSU5JVF9LTk9XTl9GTEFHUyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ICAgICAgICAgKEZBTl9SRVBPUlRfREZJ
RF9OQU1FX1RBUkdFVCB8IEZBTl9SRVBPUlRfVElEIHwgRkFOX1JFUE9SVF9QSURGRCB8IFwKPiAg
ICAgICAgIEZBTl9DTEFTU19OT1RJRiB8IEZBTl9DTEFTU19DT05URU5UIHwgRkFOX0NMQVNTX1BS
RV9DT05URU5UKQo+IEBAIC0zMzMsOSArMzM4LDkgQEAgc3RhdGljIGlubGluZSBpbnQgZmFub3Rp
ZnlfaGFuZGxlX3N1cHBvcnRlZF9ieV9rZXJuZWwoaW50IGZsYWcpCj4gICAgICAgICByZXR1cm4g
MDsKPiAgfQo+Cj4gLSNkZWZpbmUgUkVRVUlSRV9NQVJLX1RZUEVfU1VQUE9SVEVEX0JZX0tFUk5F
TChtYXJrX3R5cGUpIFwKPiArI2RlZmluZSBSRVFVSVJFX01BUktfVFlQRV9TVVBQT1JURURfT05f
RlMobWFya190eXBlLCBmbmFtZSkgXAo+ICAgICAgICAgZmFub3RpZnlfZmxhZ3NfZXJyX21zZygj
bWFya190eXBlLCBfX0ZJTEVfXywgX19MSU5FX18sIHRzdF9icmtfLCBcCj4gLSAgICAgICAgICAg
ICAgIGZhbm90aWZ5X21hcmtfc3VwcG9ydGVkX2J5X2tlcm5lbChtYXJrX3R5cGUpKQo+ICsgICAg
ICAgICAgICAgICBmYW5vdGlmeV9tYXJrX3N1cHBvcnRlZF9vbl9mcyhtYXJrX3R5cGUsIGZuYW1l
KSkKPgo+ICAjZGVmaW5lIFJFUVVJUkVfSEFORExFX1RZUEVfU1VQUE9SVEVEX0JZX0tFUk5FTCho
YW5kbGVfdHlwZSkgXAo+ICAgICAgICAgZmFub3RpZnlfZmxhZ3NfZXJyX21zZygjaGFuZGxlX3R5
cGUsIF9fRklMRV9fLCBfX0xJTkVfXywgdHN0X2Jya18sIFwKPiBAQCAtMzQzLDcgKzM0OCw3IEBA
IHN0YXRpYyBpbmxpbmUgaW50IGZhbm90aWZ5X2hhbmRsZV9zdXBwb3J0ZWRfYnlfa2VybmVsKGlu
dCBmbGFnKQo+Cj4gICNkZWZpbmUgUkVRVUlSRV9GQU5PVElGWV9FVkVOVFNfU1VQUE9SVEVEX09O
X0ZTKGluaXRfZmxhZ3MsIG1hcmtfdHlwZSwgbWFzaywgZm5hbWUpIGRvIHsgXAo+ICAgICAgICAg
aWYgKG1hcmtfdHlwZSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFwKPiAtICAgICAgICAgICAgICAgUkVRVUlSRV9NQVJLX1RZUEVfU1VQUE9SVEVEX0JZ
X0tFUk5FTChtYXJrX3R5cGUpOyAgICAgICBcCj4gKyAgICAgICAgICAgICAgIFJFUVVJUkVfTUFS
S19UWVBFX1NVUFBPUlRFRF9PTl9GUyhtYXJrX3R5cGUsIGZuYW1lKTsgICAgXAo+ICAgICAgICAg
aWYgKGluaXRfZmxhZ3MpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFwKPiAgICAgICAgICAgICAgICAgUkVRVUlSRV9GQU5PVElGWV9JTklUX0ZMQUdTX1NV
UFBPUlRFRF9PTl9GUyhpbml0X2ZsYWdzLCBmbmFtZSk7IFwKPiAgICAgICAgIGZhbm90aWZ5X2Zs
YWdzX2Vycl9tc2coI21hc2ssIF9fRklMRV9fLCBfX0xJTkVfXywgdHN0X2Jya18sIFwKPiBkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIzLmMg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMuYwo+IGluZGV4
IGZiODEyYzUxZTM0ZS4uNWEwMzUwM2U5NTJhIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMy5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIzLmMKPiBAQCAtMjMwLDcgKzIzMCw3IEBAIHN0
YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gIHsKPiAgICAgICAgIFNBRkVfVE9VQ0goVEVTVF9GSUxF
LCAwNjY2LCBOVUxMKTsKPgo+IC0gICAgICAgUkVRVUlSRV9NQVJLX1RZUEVfU1VQUE9SVEVEX0JZ
X0tFUk5FTChGQU5fTUFSS19FVklDVEFCTEUpOwo+ICsgICAgICAgUkVRVUlSRV9NQVJLX1RZUEVf
U1VQUE9SVEVEX09OX0ZTKEZBTl9NQVJLX0VWSUNUQUJMRSwgIi4iKTsKPiAgICAgICAgIFJFUVVJ
UkVfRkFOT1RJRllfRVZFTlRTX1NVUFBPUlRFRF9PTl9GUyhGQU5fQ0xBU1NfTk9USUZ8RkFOX1JF
UE9SVF9GSUQsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRkFOX01BUktfRklMRVNZU1RFTSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBGQU5fQVRUUklCLCAiLiIpOwo+IC0tCj4gMi4zNS4zCj4KCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
