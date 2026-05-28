Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470BDCD5BD5
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 16:03:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 072FB3D0EA6
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 18:03:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3646D3CED10
 for <ltp@lists.linux.it>; Thu, 28 May 2026 18:03:18 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE8DB1A00700
 for <ltp@lists.linux.it>; Thu, 28 May 2026 18:03:17 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8ccdf8d4ac5so2536216d6.1
 for <ltp@lists.linux.it>; Thu, 28 May 2026 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779984197; x=1780588997; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AIr69WcU4alccRhYbk5JAYXCT25xIgcb1yMWnFKQb8=;
 b=Uzb3LotFg2Le9LTK93ncQL/4WzRyx62FvTgQ/D/zANCURIlOdBIjSQkXVQCYn60V/X
 +MarErlQO+plSlX+8zHTkI47CP79y6bTJg6Gu7oNMu5u3CuzsJUBtBKOGivMKQZHGdIn
 1OIQV7YM0kzEg/e5OGoNUVcouXyFumvF4giUX00/HHH07oG0WYlljC2psA12hfgZZdkv
 S5KS1vEPiITvsbIa9Mv9/lZRHMJRsgf1bXBi9FF4kWBQe4XULaSaeGW6nJ1bJlONgSeM
 EVoWLQj5xhz7KylhPgWX8zzRobtY+qcoEL1S+EeNva1z2fJD79CoLDm3x5RGb9rHnmKa
 6hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779984197; x=1780588997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6AIr69WcU4alccRhYbk5JAYXCT25xIgcb1yMWnFKQb8=;
 b=cP8/G42rhDxkcI6qUWSfxrPkVnbF2vi1W5rq3FBp/AE8a625Ro3ARmUOaYjzX1Qd9e
 OARtuzWkVY+pPDkHqouzpDbWvwfFiBZg9sEaWxbzsuHiu578KUbgAbShMDFy1wJmcJOk
 3RA2Df+A3y80cDAWQt1l1X08rXqEVPmaP6jK1PQ0VSdKxbnxK+VE7Qe9OQZjclynaAgg
 MVIrZrIw3mIX3cfe8/XABxgMEdEbuMEAnWUb72+v0pE9DUwEHP57hX+1kpNBrPwy5hdG
 YZvdNLyXC0riQVuPYvJZuqvDFoDZY3bcubMQ3qJlH1ELjZioEPUjO6pQYuOIVjeUlL+h
 SeKw==
X-Gm-Message-State: AOJu0YwNAzZG6BAucXdw5TO1vsU1oUQeraooAqqeTOeNim5imbG+OFBQ
 YtGncjGDKVXDwyHzQUkV3ppbPpwOvqjmmUZwfDlDx1ZnpPmfzFVYnh0W
X-Gm-Gg: Acq92OFsiu4i5ebZ4k8v/IENhTa38fkXuE/a8pZPkXuFmwt7KTAPhTkEkliE0FdRCcP
 z+IpYXACEe94S4sFRexfoMNy+ueDSPZP7MVvnxD6V2fvo2lT9IHFOHPslhyDmv13iyKCWAr/dMG
 MCL87IyQHPGgQT+rQxdQJCQlwgT3bs5VlUg361jvSkzg3LWgfL0zC4tt8k7BBQLJb+2PEkJ6u0H
 0XWDUS4dEr7F5ZFq8ne5ldpyMVGpxLfGCmeZiiCOiaCYhok/tiJu8lc7/8VkzFZMEqimU7X0yG6
 0C6LndeGFKAIUbK+Fy3cD8E0sMIZ477O/XYwSwfJYcI9LoybvMoeOXUewnTnQzAa0gzRy+2vcih
 Y/bspY8aqsiUSCXqYWMP+8z3vgHkwtvSfttSxLDTAdGmIx0BaV0TDHRg0znVt24VMiDSpM29F4d
 Ykq/Su5qndVlOTHzZaW398tuw567A3Wi9wBM8xcw9e/NoG5UYwtcR/Vo3gfNTCkLFYxxKPMCUiR
 wfozVaBzHz33znFDLcV6mXU1yX8uM8fgK8qUGg/jMRYBcBsZw==
X-Received: by 2002:a05:6214:3d8e:b0:8cb:f0e8:4a20 with SMTP id
 6a1803df08f44-8cc7b59a411mr427892736d6.23.1779984196491; 
 Thu, 28 May 2026 09:03:16 -0700 (PDT)
Received: from
 runnervm3jyl0.j13nh154uwcunnvc2ptqax0c5a.ex.internal.cloudapp.net
 ([52.240.186.26]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cca4705c62sm118902516d6.27.2026.05.28.09.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:03:16 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 May 2026 16:03:14 +0000
Message-ID: <20260528160315.3991-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528151938.909301-2-amir73il@gmail.com>
References: <20260528151938.909301-2-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify21: fix test failure when running iterations
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

SGkgQW1pciwKCk9uIFRodSwgMjggTWF5IDIwMjYgMTc6MTk6MzggKzAyMDAsIEFtaXIgR29sZHN0
ZWluIHdyb3RlOgo+IGZhbm90aWZ5MjE6IGZpeCB0ZXN0IGZhaWx1cmUgd2hlbiBydW5uaW5nIGl0
ZXJhdGlvbnMKCj4gKy8qIEJpbmQgbW91bnQgc28gcmVtb3VudCByby9ydyBhbHdheXMgd29yayAq
Lwo+ICtTQUZFX01PVU5UKE1PVU5UX1BBVEgsIE1PVU5UX1BBVEgsICJub25lIiwgTVNfQklORCwg
TlVMTCk7CgpUaGUgc2VsZi1iaW5kLW1vdW50IGFwcHJvYWNoIGlzIGNsZWFuIOKAlCBpdCBkZWNv
dXBsZXMgdGhlIHJlbW91bnQKcm8vcncgc3RhdGUgZnJvbSB0aGUgdW5kZXJseWluZyBmaWxlc3lz
dGVtIHR5cGUsIHJlbW92aW5nIGJvdGggdGhlCkZVU0Ugc3BlY2lhbC1jYXNlIGFuZCB0aGUgbmVl
ZCBmb3IgdHN0X2RldmljZS0+ZnNfdHlwZSBpbiB0aGUgcmVtb3VudApjYWxsLgoKPiAtaWYgKHRj
LT5yZW1vdW50X3JvKSB7Cj4gLS8qIFNBRkVfTU9VTlQgZmFpbHMgdG8gcmVtb3VudCBGVVNFICov
Cj4gLWlmIChtb3VudCh0c3RfZGV2aWNlLT5kZXYsIE1PVU5UX1BBVEgsIHRzdF9kZXZpY2UtPmZz
X3R5cGUsCj4gLSAgTVNfUkVNT1VOVHxNU19SRE9OTFksIE5VTEwpICE9IDApIHsKPiAtdHN0X2Jy
ayhURkFJTCwKPiAtImZpbGVzeXN0ZW0gJXMgZmFpbGVkIHRvIHJlbW91bnQgcmVhZG9ubHkiLAo+
IC10c3RfZGV2aWNlLT5mc190eXBlKTsKPiAtfQo+IC19Cj4gKy8qIHJlbW91bnQgcm8vcncgdGhl
IGJpbmQgbW91bnQgKi8KPiArU0FGRV9NT1VOVCgibm9uZSIsIE1PVU5UX1BBVEgsICJub25lIiwg
TVNfQklORCB8IE1TX1JFTU9VTlQgfAo+ICsgICAodGMtPnJlbW91bnRfcm8gPyBNU19SRE9OTFkg
OiAwKSwgTlVMTCk7CgpHb29kIOKAlCBhbHdheXMgcmVtb3VudGluZyB0byB0aGUgY29ycmVjdCBz
dGF0ZSAocncgb3Igcm8pIGJlZm9yZSBlYWNoCnRlc3QgY2FzZSBpcyBleGFjdGx5IHdoYXQgd2Fz
IG1pc3NpbmcgYW5kIGV4cGxhaW5zIHRoZSAtaTIgZmFpbHVyZS4KCj4gKy8qIFVubW91bnQgdGhl
IGJpbmQgbW91bnQgKi8KPiArU0FGRV9VTU9VTlQoTU9VTlRfUEFUSCk7CgpDb3JyZWN0LiBUaGUg
YmluZCBtb3VudCBpcyBjbGVhbmVkIHVwIGJlZm9yZSB0aGUgTFRQIGZyYW1ld29yawp1bm1vdW50
cyB0aGUgdW5kZXJseWluZyBkZXZpY2UuCgo+ICtSZXBvcnRlZC1ieTogcHZvcmVsQHN1c2UuY3oK
Ck1pc3NpbmcgZnVsbCBuYW1lLiBTaG91bGQgYmU6CgogIFJlcG9ydGVkLWJ5OiBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej4KClsuLi5dCgotLS0KTm90ZToKClRoZSBhZ2VudCBjYW4gc29tZXRp
bWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9mdGVuIGl0cwpmaW5kaW5ncyBh
cmUgZ2VudWluZS4gSWYgeW91IGZpbmQgaXNzdWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNlCmNv
bW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlIHN1Z2dlc3Rpb25zLgoKUmVnYXJkcywKTFRQ
IEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
