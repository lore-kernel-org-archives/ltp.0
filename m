Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0C9C83F1A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 12:46:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FA643CCD66
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:46:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E04DF3CAF64
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 14:46:34 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 49FC81000374
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 14:46:34 +0200 (CEST)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b390d09e957so7110366a12.1
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753274793; x=1753879593; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N+GkIRAavmMwPBYyxXnife6TWIm4j8AYY/fDagBFAVU=;
 b=EXIRH2Tw21vwyOxTBRMthFH3FUzoycF41pgKRwVWeA81VkTLqz7BqqJN3g1YV+mqbc
 GzRlWl9791hcFsrkMrNxQzVwm40gYz8OpWfLo+0HB6JIvn6YA5BCm6V/XFjDOhVysxKh
 8XXl5xnlPsfNSFB0F9BDDjrCWSLZ7jaycFFyatoyznYn9JsVRfO4B0zxPq0xFEvIWiqw
 dLyUsw/wMkGGuhEwte96/hMM8hS9HCBZ2Lkgxp8sIAv7PyzdHjvoP7oUFpeeGEHYfora
 TWaxeU4g34go7uAjYbCNfxiYvCqLRTa02MiN5CeC4kQLpYyTBzcUPbRcHti/c1l2Dc1x
 UAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753274793; x=1753879593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+GkIRAavmMwPBYyxXnife6TWIm4j8AYY/fDagBFAVU=;
 b=w6MrvGXCJsKNHXJ8TwuiTM6dyDSqBiFkxa1gFmWtDfSeHKA3GWA6GmtQxK6yWoG4SV
 hwDki8gQgNjNKsfQsH/t06y02Fue7krOEVh38pUVnBb5zzVuLsAVQuwFrCFesGtAPMiN
 yESJ1WjCiBhPdhzunit1Z0Aaue4Xqt8XU2wIVmnOapoJf+ktSsBH8tfrWyiDjCXa+4Et
 So34cfloLa2hU19Z15Q7HOJY4lcytQkldnf44QX3CDb7VVvhVMOEnvKhSmt1xZ9ZnJHo
 cYTd881hYLOaw6gVNsLiPM+iaaqEkTmbkQ/apewkyJm73rN3kmVZHoU4eDCmLTg8Vn0L
 MPwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbNsif+JyPG4ZTc97teUumP2sxqSSuzUe5P4NijWSy1+k+V7J+3BwFi9q7M1iTR4Z37yc=@lists.linux.it
X-Gm-Message-State: AOJu0YzGLuTQcIMRvLKzjKyLlm6pCqf5B1u6gRbV15OPOmptjXphGXii
 TlQQWWjmxhpGqlFgP70/7grg3+ogYS45W5Fyq4FWWlCOGVs7tTWiUyWA5870gsFWOlgYITGbuTU
 CxoRLBk+q8rF3vSnckycn4fYy9tikMsU=
X-Gm-Gg: ASbGnctNzaS2a2eWjIyo56SzTj8lN+Q8VggBxFQCWYDNOhil7LQlH7YBhTvTyQcBOd3
 3HsYVFaHa3IvUFw4IHJOHI3EUzrCaAQVdFbxMPInLBfLz4wvLRqhooS1CsVr+UeWnxYBWXn/WwE
 U8xo+gSxlvePmUmTsjvCzR6XDKVH69b+Vtd+TrE7sbeYo12HT5unTaV4fyn0TCWm/QubqjeGAm0
 y8fcJM=
X-Google-Smtp-Source: AGHT+IHpWTapiXa46+MRlDaXpka24BtBa6jIL8FEnr1o8kyGgAWrbpVsykDZGXMnm6++hMKrnrNpti7ADRRKeTvAvrA=
X-Received: by 2002:a17:90b:4ccc:b0:31e:4033:9e87 with SMTP id
 98e67ed59e1d1-31e50735e05mr4802936a91.10.1753274792578; Wed, 23 Jul 2025
 05:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
 <a911cbc1-ad7e-4b0e-97f0-4e2c594c7084@suse.com>
 <20250723124127.GA154226@pevik>
 <3a8c2634-09d2-4d29-951a-4e5c5b1adef1@suse.com>
In-Reply-To: <3a8c2634-09d2-4d29-951a-4e5c5b1adef1@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 23 Jul 2025 08:46:21 -0400
X-Gm-Features: Ac12FXxYOSnDBiOMgQj8kUZc-ewbe61AldBINlJkbytyHVcY3bwcTzjLzAJS3IU
Message-ID: <CAEjxPJ7bj-4_PSKiSuH57UZJWof7ky9QECkUeaeWX8T81wHtjQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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

T24gV2VkLCBKdWwgMjMsIDIwMjUgYXQgODo0M+KAr0FNIEFuZHJlYSBDZXJ2ZXNhdG8KPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5jb20+IHdyb3RlOgo+Cj4gT24gNy8yMy8yNSAyOjQxIFBNLCBQZXRy
IFZvcmVsIHdyb3RlOgo+ID4gSGkgYWxsLAo+ID4KPiA+PiBPbiA3LzIyLzI1IDI6MDYgUE0sIFBl
dHIgVm9yZWwgd3JvdGU6Cj4gPj4+ICsrKyBsaWIvdHN0X3NlY3VyaXR5LmMKPiA+Pj4gQEAgLTEw
Nyw3ICsxMDcsNyBAQCBpbnQgdHN0X3NlbGludXhfZW5hYmxlZCh2b2lkKQo+ID4+PiAgICB7Cj4g
Pj4+ICAgICBpbnQgcmVzID0gMDsKPiA+Pj4gLSAgIGlmICh0c3RfaXNfbW91bnRlZChTRUxJTlVY
X1BBVEgpKQo+ID4+PiArICAgaWYgKGFjY2VzcyhTRUxJTlVYX1NUQVRVU19QQVRILCBGX09LKSA9
PSAwKQo+ID4+PiAgICAgICAgICAgICByZXMgPSAxOwo+ID4+PiAgICAgdHN0X3JlcyhUSU5GTywg
IlNFTGludXggZW5hYmxlZDogJXMiLCByZXMgPyAieWVzIiA6ICJubyIpOwo+ID4+IFRoaXMgaXMg
bW9yZSBvciBsZXNzIHdoYXQgSSB3YXMgZG9pbmcgYXQgdGhlIGJlZ2lubmluZywgYnV0IEN5cmls
IHN1Z2dlc3RlZAo+ID4+IHRoaXMgYXBwcm9hY2ggd2hpY2ggaXMgbW9yZSBzaW1pbGFyIHRvIGxp
YnNlbGludXguIFBsZWFzZSwgY2hlY2sgdjMuCj4gPiBTdXJlIDopLiBGWUkgSSBkaWQgY2hlY2sg
djMgYmVmb3JlIHJlcGx5aW5nIHRvIHY0IChJIGFsd2F5cyB0cnkgdG8gZ2V0IHRvIHRoZQo+ID4g
Y29udGV4dCBsb29raW5nIGludG8gb2xkZXIgdmVyc2lvbnMsIEkgYWxzbyBub3RlZCB2MyBpbiBv
bmUgb2YgbXkgcmVwbGllcyA6KSkuCj4gPgo+ID4gQW5kIHllcywgSSB0aGluayB5b3Ugd2VyZSBy
aWdodCwgdGhhdCdzIHdoeSBJIHJhaXNlZCBteSBjb25jZXJuIGFnYWluLgo+ID4KPiA+IEJ1dCBv
aywgdG8gcXVvdGUgaXQgaGVyZSBDeXJpbCdzIHJlcGx5IGluIHYzOgo+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbHRwL2FHNXY2ZW5oZHFGR2dpQmpAeXVraS5sYW4vCj4gPgo+ID4gICAgICAg
PiArICAgICBpZiAoYWNjZXNzKFNFTElOVVhfUEFUSCwgRl9PSykgPT0gMCAmJiAhdHN0X2Rpcl9p
c19lbXB0eShTRUxJTlVYX1BBVEgsIDApKQo+ID4gICAgICAgPiArICAgICAgICAgICAgIHJlcyA9
IDE7Cj4gPgo+ID4gICAgICAgTWF5YmUgd2Ugd2UgY2FuIGRvIHRzdF9pc19tb3VudGVkKFNFTElO
VVhfUEFUSCkgaGVyZSBpbnN0ZWFkLiBBdCBsZWFzdAo+ID4gICAgICAgdGhhdCBzZWVtcyB0byBi
ZSB3aGF0IGlzX3NlbGludXhfZW5hYmxlZCgpIHNlZW1zIHRvIGJlIGRvaW5nLgo+ID4gLS0tCj4g
Pgo+ID4gRW5hYmxlZCBTRUxpbnV4IG1lYW5zIGJvdGggL3N5cy9mcy9zZWxpbnV4L2VuZm9yY2Ug
YW5kIG1vdW50ZWQgL3N5cy9mcy9zZWxpbnV4Ly4KPiA+IEkgZXZlbiBjaGVja2VkIHRvIGJvb3Qg
a2VybmVsIHdpdGggU0VMaW51eCBjb21waWxlZCBpbiBidXQgZGlzYWJsZWQgaW4gdGhlCj4gPiBj
b21tYW5kIGxpbmUgdmlhICdzZWN1cml0eT1zZWxpbnV4IHNlbGludXg9MCBlbmZvcmNpbmc9MCcg
YW5kIHRoZSByZXN1bHQgaXMKPiA+IGV4cGVjdGVkOiBubyAvc3lzL2ZzL3NlbGludXggZGlyZWN0
b3J5Lgo+ID4KPiA+IEJvdGggd2F5cyBvZiBjaGVja2luZyBhcmUgT0ssIGp1c3QgImFjY2VzcyhT
RUxJTlVYX1NUQVRVU19QQVRILCBGX09LKSA9PSAwIiBpcwo+ID4gdGhlIHF1aWNrZXN0IHdheSAo
Z2l2ZW4gdGVzdCByZXF1aXJlcyBqdXN0IFNFTGludXggZW5hYmxlZCwgbm90IGVuZm9yY2luZyBt
b2RlKS4KPiA+Cj4gPiBUaGlzIGNhbiBiZSBjaGFuZ2VkIGJlZm9yZSBtZXJnZS4gT3IsIGZlZWwg
ZnJlZSB0byBrZWVwIHRoZSBvcmlnaW5hbCB2ZXJzaW9uIGFzCj4gPiBpdCBhbHNvIHdvcmtzLgo+
ID4KPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKPiA+Cj4gPj4gLSBBbmRyZWEKPgo+IE9rIHRo
YW5rcywgSSB3YXMgYWxzbyB0aGlua2luZyB0aGF0IG1heWJlIHdlIGNhbiB2ZXJpZnkgaWYgY2Vy
dGFpbiBMU01zCj4gYXJlIGVuYWJsZWQgdmlhIC9zeXMva2VybmVsL3NlY3VyaXR5L2xzbSAuIEF0
IHRoZSBtb21lbnQgd2Ugb25seSBjaGVjawo+IGZvciBzZWxpbnV4LCBidXQgZXZlbnR1YWxseSB3
ZSBjYW4gYWxzbyB2ZXJpZnkgaWYgYXBwYXJtb3IgaXMgZW5hYmxlZCBieQo+IGxvb2tpbmcgYXQg
dGhlIGxpc3QgaW4gdGhhdCBmaWxlLiBXRFlUPwoKSWYgdGhpcyBpcyB0ZXN0aW5nIGZvciB0aGUg
bGlzdHhhdHRyIGJ1ZywgdGhlbiB5b3UgY2FuIG9ubHkgdGVzdCBmb3IKTFNNcyB0aGF0IGltcGxl
bWVudCB0aGVpciBvd24geGF0dHIsIHdoaWNoIHdvdWxkIGJlIFNFTGludXggYW5kIFNtYWNrLgpB
cHBBcm1vciBkb2Vzbid0IGltcGxlbWVudCBhbiB4YXR0ciwgYXQgbGVhc3Qgbm90IHVwc3RyZWFt
LgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
