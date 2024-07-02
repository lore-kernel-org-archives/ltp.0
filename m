Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D0EC30658
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 07:52:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65E743D3EBC
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 09:52:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F7623D3EA4
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:52:28 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7A88014013AA
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:52:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719906745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/OjlFgWqzYtQMn/XhF99/1/jkq2IQWMbNL5KkgvQZrQ=;
 b=hkJcQ+DKtGwMQLGdThSVJ39pOzzeO1mq2cs5eDKFWp50aNYpy5KaEot523Sr7bp/imUZB2
 559pJT3w2gshSJVY4S14v6NlFVsbh61hoxrM2T6UBW2LP4eoIvh2A1As6OuRwA7dcvltZd
 TL2nLQ4PEVx2bJwpCE1uKaazC2mSq9g=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-EnM7WJqwMsKOzUVuQK64lw-1; Tue, 02 Jul 2024 03:52:24 -0400
X-MC-Unique: EnM7WJqwMsKOzUVuQK64lw-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5c21edc391cso4431005eaf.3
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 00:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719906743; x=1720511543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/OjlFgWqzYtQMn/XhF99/1/jkq2IQWMbNL5KkgvQZrQ=;
 b=B1FISU1SE9ZdCRFzVu+UlFN+npDWE9KsisSk2JUzd/JD2EL4HNtHwhOQB2uFzFgOpN
 YyxJZBDkU/WTcjdTSDYXIxuuLatLq+sAL2gSdfPAdhoyb3RcmKjUYE4s0Pjb50gQTxpF
 zbm3378qYddo+h68pE5fle5ct1gXUgfnAXY/+Rtx489hZswb7bqTf6AwEorbqaNO+2bi
 dqiClRx3gS+Yh8NT2Q2732VRkpLJylb+lonBVT1UKx+qyRyHMzqjsTbOYY/fdo5SyoKv
 /upA/kdYB5lTbsF3MrQePp5kt8BWxO+JpDphidn85g+UwLPpU17VNpFIFFt4vwEmI6xL
 X2bA==
X-Gm-Message-State: AOJu0YxgA2c9hAbk54zQV8LEK61BKPPMIEUoE4QpjngowgMj9l2iTf/r
 r5AtN9uRRxpTooxFM6waQD6bn+sJmsM6qZe1aymDa45YzHcx6aK428vh59tTLPCguXoFCunkHgU
 QInfKVNcwqc9FOZRZKQwcK7TI/GcEUYKqcVJe72ji8L+qvwUwoXEmXQyouvcOopG7WHAdJqW6dO
 ceoqnvw+B/362gwSDk2pQyMQo=
X-Received: by 2002:a05:6358:710:b0:19f:4967:4e8f with SMTP id
 e5c5f4694b2df-1a6acec7110mr880306155d.22.1719906743373; 
 Tue, 02 Jul 2024 00:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi7Zg0pBubSO0Uft8dpixfkp1Hnu3xIOSN8ZqfLN/WgKM8B8V9r2cMuIEAgez7svDKJ5xgg1DtzT3kmjdjKHE=
X-Received: by 2002:a05:6358:710:b0:19f:4967:4e8f with SMTP id
 e5c5f4694b2df-1a6acec7110mr880305055d.22.1719906742939; Tue, 02 Jul 2024
 00:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-4-58e9af649a72@suse.com>
In-Reply-To: <20240701-landlock-v1-4-58e9af649a72@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Jul 2024 15:52:10 +0800
Message-ID: <CAEemH2e1LP29j5Hgs8kScPcePiTW3Ob2P9vxNfiNWehB3fsZSw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 04/10] Add SAFE_PRCTL macro
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

UmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKT24gTW9uLCBKdWwgMSwg
MjAyNCBhdCAxMTo0M+KAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3Vz
ZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9A
c3VzZS5jb20+Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2Vy
dmVzYXRvQHN1c2UuY29tPgo+IC0tLQo+ICBpbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oIHwgIDYg
KysrKysrCj4gIGxpYi90c3Rfc2FmZV9tYWNyb3MuYyAgICAgfCAxNiArKysrKysrKysrKysrKysr
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggYi9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oCj4gaW5k
ZXggNzc0OGJkMzRmLi43MzNhMjUwNmUgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS90c3Rfc2FmZV9t
YWNyb3MuaAo+ICsrKyBiL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmgKPiBAQCAtNTA0LDYgKzUw
NCwxMiBAQCBpbnQgc2FmZV9zc2NhbmYoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVu
bywKPiBjb25zdCBjaGFyICpyZXN0cmljdCBidWZmZXIsCj4gICNkZWZpbmUgU0FGRV9TU0NBTkYo
YnVmZmVyLCBmb3JtYXQsIC4uLikgXAo+ICAgICAgICAgc2FmZV9zc2NhbmYoX19GSUxFX18sIF9f
TElORV9fLCAoYnVmZmVyKSwgKGZvcm1hdCksCj4gICMjX19WQV9BUkdTX18pCj4KPiAraW50IHNh
ZmVfcHJjdGwoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiArICAgICAgIGlu
dCBvcHRpb24sIHVuc2lnbmVkIGxvbmcgYXJnMiwgdW5zaWduZWQgbG9uZyBhcmczLAo+ICsgICAg
ICAgdW5zaWduZWQgbG9uZyBhcmc0LCB1bnNpZ25lZCBsb25nIGFyZzUpOwo+ICsjZGVmaW5lIFNB
RkVfUFJDVEwob3B0aW9uLCBhcmcyLCBhcmczLCBhcmc0LCBhcmc1KSBcCj4gKyAgICAgICBzYWZl
X3ByY3RsKF9fRklMRV9fLCBfX0xJTkVfXywgKG9wdGlvbiksIChhcmcyKSwgKGFyZzMpLCAoYXJn
NCksCj4gKGFyZzUpKQo+ICsKPiAgaW50IHNhZmVfbGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQoY29u
c3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiAgICAgICAgIGNvbnN0IHN0cnVjdCBs
YW5kbG9ja19ydWxlc2V0X2F0dHIgKmF0dHIsCj4gICAgICAgICBzaXplX3Qgc2l6ZSAsIHVpbnQz
Ml90IGZsYWdzKTsKPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF9zYWZlX21hY3Jvcy5jIGIvbGliL3Rz
dF9zYWZlX21hY3Jvcy5jCj4gaW5kZXggYmE5OTdlYjdjLi5hODEwMzcxNjEgMTAwNjQ0Cj4gLS0t
IGEvbGliL3RzdF9zYWZlX21hY3Jvcy5jCj4gKysrIGIvbGliL3RzdF9zYWZlX21hY3Jvcy5jCj4g
QEAgLTEwLDYgKzEwLDcgQEAKPiAgI2luY2x1ZGUgPGVycm5vLmg+Cj4gICNpbmNsdWRlIDxzY2hl
ZC5oPgo+ICAjaW5jbHVkZSA8c3lzL3B0cmFjZS5oPgo+ICsjaW5jbHVkZSA8c3lzL3ByY3RsLmg+
Cj4gICNpbmNsdWRlICJjb25maWcuaCIKPiAgI2lmZGVmIEhBVkVfU1lTX0ZBTk9USUZZX0gKPiAg
IyBpbmNsdWRlIDxzeXMvZmFub3RpZnkuaD4KPiBAQCAtNzExLDYgKzcxMiwyMSBAQCBpbnQgc2Fm
ZV9tcHJvdGVjdChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLAo+ICAgICAgICAg
cmV0dXJuIHJ2YWw7Cj4gIH0KPgo+ICtpbnQgc2FmZV9wcmN0bChjb25zdCBjaGFyICpmaWxlLCBj
b25zdCBpbnQgbGluZW5vLAo+ICsgICAgICAgaW50IG9wdGlvbiwgdW5zaWduZWQgbG9uZyBhcmcy
LCB1bnNpZ25lZCBsb25nIGFyZzMsCj4gKyAgICAgICB1bnNpZ25lZCBsb25nIGFyZzQsIHVuc2ln
bmVkIGxvbmcgYXJnNSkKPiArewo+ICsgICAgICAgaW50IHJ2YWw7Cj4gKwo+ICsgICAgICAgcnZh
bCA9IHByY3RsKG9wdGlvbiwgYXJnMiwgYXJnMywgYXJnNCwgYXJnNSk7Cj4gKyAgICAgICBpZiAo
cnZhbCA9PSAtMSkgewo+ICsgICAgICAgICAgICAgICB0c3RfYnJrXyhmaWxlLCBsaW5lbm8sIFRC
Uk9LIHwgVEVSUk5PLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICJwcmN0bCglZCwgJWx1LCAl
bHUsICVsdSwgJWx1KSIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgb3B0aW9uLCBhcmcyLCBh
cmczLCBhcmc0LCBhcmc1KTsKPiArICAgICAgIH0KPiArCj4gKyAgICAgICByZXR1cm4gcnZhbDsK
PiArfQo+Cj4gIGludCBzYWZlX2xhbmRsb2NrX2NyZWF0ZV9ydWxlc2V0KGNvbnN0IGNoYXIgKmZp
bGUsIGNvbnN0IGludCBsaW5lbm8sCj4gICAgICAgICBjb25zdCBzdHJ1Y3QgbGFuZGxvY2tfcnVs
ZXNldF9hdHRyICphdHRyLAo+Cj4gLS0KPiAyLjQzLjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJk
cywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
