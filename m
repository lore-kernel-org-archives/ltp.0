Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AFBFF8864
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 02:58:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE3803E2548
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 04:58:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA94A3C7A5F
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 04:58:04 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 37C761400539
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 04:58:04 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2d96243c91fso17796283eec.1
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 19:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777345082; x=1777949882; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwJ+jczFmIFoXKDNKc/3buatJWOHSpM7A1xxXG/YUfI=;
 b=RjWROxy4y55ps+f/+VnF+lYmLCx7mkQK4Vd0vLKvRJBqqwHULMldA1Sxw26Lj0Px63
 8dUCUiD4SL7TxbOvlemS7/G5iK0kY9he+YChWz8xwYqSba8bvN+Ccjt7A7APo69d6z9S
 2qR9imQt2OJSgpKJ1nxEYMgMTlumpBq7swfqlVhU8PCmMhBmos/eq3kb3jen3oGwn85n
 YaKjSz+cyolTfG7g8ji0YvJjrYRaUEMWqx60qyvO1O95VCPMN5lrLkmswHNYdJFgjYha
 6xUlNiTAQ61WoV0oeSotVqbWbLHvuxk0vWBCnVy89Vpx1+WM0Gk8nBYAjf1hw2PTCGF5
 zL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777345082; x=1777949882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UwJ+jczFmIFoXKDNKc/3buatJWOHSpM7A1xxXG/YUfI=;
 b=R3qfsWSKkmy4mXL9JtCoWOLkNLLpVauOvRQDC8b6n2FWe1Lih2MKJ501mc/91oePzG
 YamAANpvs0LzdeUsci9Mam4OzkepCVFJn5YVAI6f9W66slwkU2px+B99JjZNJGleb9rh
 6KKwhvP8HaFeZSl88Ka9bhDpHfHZgywiDSkaUOcl/qw7ttzpMwy12NzTVIJYyb4dJU5s
 6cfq8OMUQjKJY+/rJGd1Rb/hGqJ6vYz45Z96T85y+auGv5ee/BJ1tfK06AVuNiUgkqo+
 EY2FitKAoO3OUvrfdK2aT3xj0U4qDvAIw+UWk3IunpHU9VAormd+nN9uHLsagSW1Sh3v
 lDMw==
X-Gm-Message-State: AOJu0YwtcmCIAfYDt9Em79mp0KNUcoc1HJEpZmWtDZ7fVjlsYgj6FUi+
 SuoI3V/mNqBBaIwGoyESo7ROdAQtijeuJ6z1b5s6tyEtfIjbY1PmTX7t
X-Gm-Gg: AeBDiet2z8lDZsdzVOTzNj0QPF5xQFfIPD9N/StN+aNC066C3GsIHy58ZMs1oaBIYrC
 C9vhsRJhLRSJgSfRhwsfUZ8pduQTrbB3nZ9PnkzaykJbcDa2Rshu7afh+mkrPPjwW9hqW91ukvP
 LcdqadNokVz+GmD5yHjW9jncMjGbrwHpYFnI16DiKRGpJJqtIi5vLe6MwTgPGHJc+MFTw9R0xZW
 FyU9foJv8tLUWiPT0NffSNDLkUwzKKz8pxVB8qo7s6wnjnB+vCjmrNrX+L5QsELZmMZyZEEOqFp
 JcSK8F0kEtUdoV5YoRe1BMWjCtUsgX+PMtNw2ZdDAPLsQI99vAum6pw0syjfUAoxBfjQs2vOmrH
 achwoWVl0rVnXaeiwnTvNp7HLksw9hSYe3FdWIvJzYdwy/Sd9omvwtHcPaSzAKr3HOHz1HVGqXr
 ggZy3lnHUoXoW8NFSjJirzZ8d8tI5ze4j6VMjU6ii/FcHt+HfwsfhPynGMheA12NRTH6/FjpMI+
 s49hOnU7E79sQdG38tir6SKA82ondicN9kXXl9INRdYdwc8kZRd6XHuPpvJHA==
X-Received: by 2002:a05:7300:e686:b0:2d8:7302:d21 with SMTP id
 5a478bee46e88-2ed0a121a0fmr723574eec.16.1777345082228; 
 Mon, 27 Apr 2026 19:58:02 -0700 (PDT)
Received: from
 runnervmeorf1.isbtygbhkgwune5ckp3zdudqla.dx.internal.cloudapp.net
 ([52.159.247.168]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed09fb6b7fsm1214150eec.10.2026.04.27.19.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 19:58:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: priyama2 <priyama2@linux.ibm.com>
Date: Tue, 28 Apr 2026 02:58:00 +0000
Message-ID: <20260428025800.4024-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429105114.710966-1-priyama2@linux.ibm.com>
References: <20260429105114.710966-1-priyama2@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] testcases/nvme: Add NVMe device discovery and
 identification test
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

SGkgcHJpeWFtYTIsCgpPbiBXZWQsIDI5IEFwciAyMDI2LCBwcml5YW1hMiB3cm90ZToKPiB0ZXN0
Y2FzZXMvbnZtZTogQWRkIE5WTWUgZGV2aWNlIGRpc2NvdmVyeSBhbmQgaWRlbnRpZmljYXRpb24g
dGVzdAoKPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgdGhlIGZpcnN0IHRlc3QgY2FzZSAobnZtZTAx
KSBmb3IgTlZNZSBkZXZpY2UKPiB0ZXN0aW5nIGluIExUUC4gVGhlIHRlc3QgdmVyaWZpZXM6IFsu
Li5dCgpUaGUgY29tbWl0IGJvZHkgZGVzY3JpYmVzIHdoYXQgdGhlIHRlc3QgZG9lcyBhbmQgd2hh
dCBoYXJkd2FyZSBpdCB3YXMKcnVuIG9uLCBidXQgZG9lc24ndCBleHBsYWluICp3aHkqIHRoaXMg
dGVzdCBpcyBiZWluZyBhZGRlZCB0byBMVFAg4oCUCndoYXQgZ2FwIGRvZXMgaXQgZmlsbCwgb3Ig
d2hhdCBwcm9ibGVtIHByb21wdGVkIHdyaXRpbmcgaXQ/Cgo+ICtUQVJHRVRTCQk9IG52bWUwMSBu
dm1lMDIgbnZtZTAzIG52bWUwNAoKbnZtZTAyLmMsIG52bWUwMy5jLCBudm1lMDQuYyBhcmUgbm90
IHByZXNlbnQgaW4gdGhpcyBwYXRjaCwgc28gYG1ha2VgCndpbGwgZmFpbC4gUmVtb3ZlIHRoZSBt
aXNzaW5nIHRhcmdldHMgKGFuZCB0aGVpciBleHBsaWNpdCBydWxlcykgZnJvbQp0aGlzIHBhdGNo
OyBhZGQgdGhlbSB3aGVuIHRob3NlIHRlc3RzIGxhbmQuCgo+ICsvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQg
SUJNIENvcnBvcmF0aW9uCj4gKyAqIEF1dGhvcjogTFRQIE5WTWUgVGVzdCBTdWl0ZQoKQ29weXJp
Z2h0IHllYXIgbXVzdCBiZSAyMDI2IGZvciBhIG5ld2x5IGFkZGVkIGZpbGUuICJBdXRob3I6IExU
UCBOVk1lClRlc3QgU3VpdGUiIGlzIG5vdCBhIHJlYWwgYXV0aG9yOyB1c2UgeW91ciBuYW1lIGFu
ZCBlbWFpbC4gQWxzbywgdGhlCnRlc3QgZGVzY3JpcHRpb24gbXVzdCBiZSBpbiBhIHNlcGFyYXRl
IC8qXCBSU1QgYmxvY2sgKG5vdCBtZXJnZWQgaW50bwp0aGUgY29weXJpZ2h0IGJsb2NrKS4KCj4g
KwlkaXIgPSBvcGVuZGlyKE5WTUVfREVWX1BBVEgpOwo+ICsJaWYgKCFkaXIpIHsKPiArCQl0c3Rf
YnJrKFRCUk9LIHwgVEVSUk5PLCAiRmFpbGVkIHRvIG9wZW4gJXMiLCBOVk1FX0RFVl9QQVRIKTsK
ClVzZSBTQUZFX09QRU5ESVIoKSBoZXJlIChhbmQgU0FGRV9GT1BFTigpIC8gU0FGRV9DTE9TRURJ
UigpIC8KU0FGRV9GQ0xPU0UoKSBlbHNld2hlcmUpLiBUaGVzZSBhcmUgZGVmaW5lZCBpbiB0c3Rf
c2FmZV9tYWNyb3MuaCBhbmQKdHN0X3NhZmVfc3RkaW8uaC4KCj4gK3N0YXRpYyBpbnQgbnZtZV9k
ZXZpY2VfZm91bmQgPSAwOwo+ICtzdGF0aWMgY2hhciBudm1lX2Rldl9uYW1lWzI1Nl07CgpCb3Ro
IHN0YXRpYyB2YXJzIGFyZSBzZXQgaW4gY2FzZSAwIG9mIHJ1bigpIGJ1dCBuZXZlciByZXNldC4g
VW5kZXIKYC1pYCAoaXRlcmF0aW9uKSwgc3Vic2VxdWVudCBpdGVyYXRpb25zIGluaGVyaXQgc3Rh
bGUgc3RhdGUuIFJlc2V0CnRoZW0gYXQgdGhlIHRvcCBvZiBydW4oKS4KCj4gKwkubmVlZHNfcm9v
dCA9IDEsCgpBbGwgb3BlcmF0aW9ucyBpbiB0aGlzIHRlc3QgYXJlIHVucHJpdmlsZWdlZCBzeXNm
cy9kZXZmcyByZWFkcy4gRHJvcAoubmVlZHNfcm9vdC4KCj4gK0NDCQk9IGdjYwo+ICtDRkxBR1MJ
CT0gLVdhbGwgLU8yIC1JL29wdC9sdHAvaW5jbHVkZQo+ICtMREZMQUdTCQk9IC1ML29wdC9sdHAv
bGliCgpUaGlzIGlzIGEgaGFuZC1yb2xsZWQgc3RhbmRhbG9uZSBNYWtlZmlsZSB3aXRoIGhhcmRj
b2RlZCBwYXRocy4gUmVwbGFjZQppdCB3aXRoIExUUCdzIGJ1aWxkIHN5c3RlbSAoZW52X3ByZS5t
ayArIGdlbmVyaWNfbGVhZl90YXJnZXQubWspLiBBbHNvCmFkZCBgbnZtZWAgdG8gU1VCRElSUyBp
biB0ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL01ha2VmaWxlLCBhbmQKYWRkIGEgcnVu
dGVzdCBlbnRyeSBhbmQgLmdpdGlnbm9yZSBlbnRyeSBmb3IgbnZtZTAxLgoKWy4uLl0KClByZS1l
eGlzdGluZyBpc3N1ZXMgbm90aWNlZCBpbiB0aGUgc3Vycm91bmRpbmcgY29kZSAobm90IGludHJv
ZHVjZWQgYnkKdGhpcyBwYXRjaCk6CgotIG52bWUwMS5jOjIzNiDigJQgU3RyYXkgYC8vIE1hZGUg
d2l0aCBCb2JgIGNvbW1lbnQgYXQgZW5kIG9mIGZpbGUuCi0gbnZtZTAxLmM6NTggIOKAlCBgc3Ry
bGVuKGVudHJ5LT5kX25hbWUpID09IDVgIHNpbGVudGx5IHNraXBzIG52bWUxMCsuCgotLS0KTm90
ZToKCk91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBmdWxs
IHJldmlldyBjYW4gYmUKZm91bmQgYXQ6IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXBy
b2plY3QvbHRwLWFnZW50L2FjdGlvbnMvcnVucy8yNTAzMTIxMjU3OAoKVGhlIGFnZW50IGNhbiBz
b21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRp
bmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVh
c2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRz
LApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
