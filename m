Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB87C83F27
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 13:32:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECC4C3CCC97
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 15:32:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFA5B3C58D0
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 15:20:43 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4FD9D1A00619
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 15:20:43 +0200 (CEST)
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b31e0ead80eso4310370a12.0
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753190442; x=1753795242; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kp6KvvSowISPKkw/qg/7kYfxAMhXbJs6FD+Mld6wtDU=;
 b=VZiArHuYOFrlXDTQrCW4jvnw7j0e/Mfdxj4MFCaP7ebnhEfjBNg9mvoIEd2O/9v9vz
 356AC5OQXCMlzoh0MZbFCxKMSjVpfbO0H7FUTdX6vPedlBl8EIcXGyL4alFzPE9Ck2qm
 7IATPc0UD4sHW//YQzIXX2aE+0BYtBKQfpF6HoTL7bJ0hvCAb6xFWaR5t/vHM2N8yaWG
 So/AkEtUrh14hn42xt2nnDSjJBdlxNWTXDyCtsTHnKEDJFEcb+sl7jy8O2L9Knk0d+F7
 Dqwv+jAgfEdtasc+L0T1fyVUcs2OEypoeI009ra3ZXDg0ttwbtnW+vQdekly6xjUU0r/
 r2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753190442; x=1753795242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kp6KvvSowISPKkw/qg/7kYfxAMhXbJs6FD+Mld6wtDU=;
 b=hGyqvmm44ekk1wCDet7v3wtyTvUgDSLn1CJFBAurWmTqlpKerY7VvH9eSBkjzgh/1h
 ICXxD+0W/URKUDxrJ0JRoRMEy3YOicOXPSC8n5jys4N89vuDoyRcdRyAvBsjqW2Hf+m2
 +R8QK8W/2hSuApxZDiXhJmwkAk6Nj1aM4epBq77BgV1lt+5XMRyO8pLRB1hLPd5fXcsy
 5gq6thvh5nLngC3HA1R+QKwaRtlvncZjyZWuzp+t2o6qZc64vjNVDgtuhPHx9Gch9LAC
 fReSqHn8nutVkNEGSs8Ao2B5vLJ8GmC66tdYIcUDxu1/FHgQ+YnCuTlIfxNhttHuiubj
 +aFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfAGErWbZzK8CtwNXHbfAQao20w0tdXf8bEgnBRWZnVcUkKYhChJscPpXTO9z7ZGnvfYc=@lists.linux.it
X-Gm-Message-State: AOJu0Yy1U9xgLiqRlNAS19o1aoIQNzOL61iMrrnfsuvcLVljeQscWsz6
 9ra55xnjLcPj/fI5DeRq+tj+oq/zdxvb/nAyXKCKl1ovV5Ajq1/wDU7IGgmajsxBdoiDbFnC9dP
 1jUh4f6JB/uqbeDjSVFpupPaddthKUFw=
X-Gm-Gg: ASbGncvpz0y24yAQcjAfQqO+qYJ0Lg1538VQdpPmmVpJIM0WwF2IMY+V/9+T8YZQhpq
 rrzUmgiOeyPImZT/5TiwqK3FJQPIXSV2LXrs6YysG+H1W8VqGCd159Tv3WxafMZBTiHc0thbm+q
 4enHP1QOhN5mfxUpwRGMCtIcwanoncrkK1eUPhEWBkPc3PQtxECpfQHfzzFPxN2dWAdXaPR/oN7
 sfgBZo=
X-Google-Smtp-Source: AGHT+IF5gcdQf1tE/8WsznlNzTDrewxMbyUaQC7R5tw6NnTTL2zuz+I/c5wXTvNHxJDAaOY/Z/p9w+CZG+yJzUJLjEw=
X-Received: by 2002:a17:90b:5281:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-31c9e6e52e8mr29841952a91.5.1753190441532; Tue, 22 Jul 2025
 06:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
 <CAEjxPJ6WQRrfAnMtDzvUxYL6smYbKpDQNGp6rxs4dZ=DxC3M9A@mail.gmail.com>
In-Reply-To: <CAEjxPJ6WQRrfAnMtDzvUxYL6smYbKpDQNGp6rxs4dZ=DxC3M9A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 22 Jul 2025 09:20:30 -0400
X-Gm-Features: Ac12FXyZ2fWviIZK_F3podT_Z-bLiVhp2Q5G2NpfPYRBjP-hzctQJaRvNcrl-g4
Message-ID: <CAEjxPJ7gbWRWgbrLv+1xE0dJUq+c9UpNzYUgyis2f8gmJUo1wQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 22 Jul 2025 15:32:02 +0200
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

T24gVHVlLCBKdWwgMjIsIDIwMjUgYXQgOToxOOKAr0FNIFN0ZXBoZW4gU21hbGxleQo8c3RlcGhl
bi5zbWFsbGV5LndvcmtAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgSnVsIDIyLCAyMDI1
IGF0IDg6MDbigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4gPgo+ID4g
SGkgQW5kcmVhLCBhbGwsCj4gPgo+ID4gWyBDYyBTdGVwaGVuLCB0aGUgZml4IGF1dGhvciBpbiBj
YXNlIEknbSB3cm9uZyB3aXRoIHJlcHJvZHVjaW5nIG9uIGVuZm9yY2luZz0wIF0KPiA+Cj4gPiA+
IEFkZCB0c3Rfc2VsaW51eF9lbmFibGVkKCkgdXRpbGl0eSBpbiB0c3Rfc2VjdXJpdHkuaCBpbiBv
cmRlciB0byB2ZXJpZnkKPiA+ID4gaWYgU0VMaW51eCBpcyBjdXJyZW50bHkgdXAgYW5kIHJ1bm5p
bmcgaW4gdGhlIHN5c3RlbS4KPiA+IC4uLgo+ID4gPiAraW50IHRzdF9zZWxpbnV4X2VuYWJsZWQo
dm9pZCkKPiA+ID4gK3sKPiA+ID4gKyAgICAgaW50IHJlcyA9IDA7Cj4gPiA+ICsKPiA+ID4gKyAg
ICAgaWYgKHRzdF9pc19tb3VudGVkKFNFTElOVVhfUEFUSCkpCj4gPiA+ICsgICAgICAgICAgICAg
cmVzID0gMTsKPiA+Cj4gPiBJIHdhcyB3b25kZXJpbmcgaWYgaXQgdGhlIHRlc3QgcmVxdWlyZSBl
bmZvcmNpbmcgb3Igbm90IHRoZXJlZm9yZSBJIHJldGVzdGVkIGl0Cj4gPiBhbmQgaXQncyByZWFs
bHkgcmVwcm9kdWNpYmxlIHdpdGggcGVybWlzc2l2ZSBtb2RlLCBpLmUuIHdpdGgga2VybmVsIGNv
bW1hbmQgbGluZQo+ID4gc2VjdXJpdHk9c2VsaW51eCBzZWxpbnV4PTEgZW5mb3JjaW5nPTAKPiA+
Cj4gPiBCZWNhdXNlIGlmIGVuZm9yY2luZyB3YXMgcmVxdWlyZWQsIEkgd291bGQgYmUgZm9yIHVz
aW5nIHRzdF9zZWxpbnV4X2VuZm9yY2luZygpLAo+ID4gd2hpY2ggY2hlY2tzIC9zeXMvZnMvc2Vs
aW51eC9lbmZvcmNlIGZvciAxIGFzIFdlaSBzdWdnZXN0ZWQgaW4gdjM6Cj4gPgo+ID4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbHRwL2FIZjgzOVdTMEJQSWE1WnFATWlXaUZpLUNSNjYwOC1zcnYv
Cj4gPgo+ID4gQEN5cmlsIEBBbmRyZWEsIGp1c3QgY2hlY2tpbmcgaWYgL3N5cy9mcy9zZWxpbnV4
L2VuZm9yY2UgZXhpc3RzIHdvdWxkIGJlIGZhc3Rlcgo+ID4gdGhhbiBsb29waW5nIC9wcm9jL21v
dW50cyAodmlhIHRzdF9pc19tb3VudGVkKFNFTElOVVhfUEFUSCkpLiBDYW4gd2UganVzdCBtb2Rp
ZnkKPiA+IHRoZSBwYXRjaD8KPgo+IE5vdCBzdXJlIGlmIEkgaGF2ZSB0aGUgZnVsbCBjb250ZXh0
LCBidXQgbW9kZXJuIGxpYnNlbGludXggaGFzIHRoaXMKPiBmb3IgaXNfc2VsaW51eF9lbmFibGVk
KCk6Cj4KPiBpbnQgaXNfc2VsaW51eF9lbmFibGVkKHZvaWQpCj4gewo+ICAgICAgICAgLyogaW5p
dF9zZWxpbnV4bW50KCkgZ2V0cyBjYWxsZWQgYmVmb3JlIHRoaXMgZnVuY3Rpb24uIFdlCj4gICAg
ICAgICAgKiB3aWxsIGFzc3VtZSB0aGF0IGlmIGEgc2VsaW51eCBmaWxlIHN5c3RlbSBpcyBtb3Vu
dGVkLCB0aGVuCj4gICAgICAgICAgKiBzZWxpbnV4IGlzIGVuYWJsZWQuICovCj4gI2lmZGVmIEFO
RFJPSUQKPiAgICAgICAgIHJldHVybiAoc2VsaW51eF9tbnQgPyAxIDogMCk7Cj4gI2Vsc2UKPiAg
ICAgICAgIHJldHVybiAoc2VsaW51eF9tbnQgJiYgaGFzX3NlbGludXhfY29uZmlnKTsKPiAjZW5k
aWYKPiB9Cj4KPiBBbmQgaW5pdF9zZWxpbnV4bW50KCksIGEgY29uc3RydWN0b3IgZm9yIGxpYnNl
bGludXgsIGRvZXMgdGhpczoKPgo+IHN0YXRpYyB2b2lkIGluaXRfc2VsaW51eG1udCh2b2lkKQo+
IHsKPiAgICAgICAgIGNoYXIgKmJ1ZiA9IE5VTEwsICpwOwo+ICAgICAgICAgRklMRSAqZnAgPSBO
VUxMOwo+ICAgICAgICAgc2l6ZV90IGxlbjsKPiAgICAgICAgIHNzaXplX3QgbnVtOwo+Cj4gICAg
ICAgICBpZiAoc2VsaW51eF9tbnQpCj4gICAgICAgICAgICAgICAgIHJldHVybjsKPgo+ICAgICAg
ICAgaWYgKHZlcmlmeV9zZWxpbnV4bW50KFNFTElOVVhNTlQpID09IDApIHJldHVybjsKPgo+ICAg
ICAgICAgaWYgKHZlcmlmeV9zZWxpbnV4bW50KE9MRFNFTElOVVhNTlQpID09IDApIHJldHVybjsK
Pgo+ICAgICAgICAgLyogRHJvcCBiYWNrIHRvIGRldGVjdGluZyBpdCB0aGUgbG9uZyB3YXkuICov
Cj4gICAgICAgICBpZiAoIXNlbGludXhmc19leGlzdHMoKSkKPiAgICAgICAgICAgICAgICAgZ290
byBvdXQ7Cj4gLi4uCj4KPiBTbyBpbiB0aGUgY29tbW9uIGNhc2Ugd2UgZG9uJ3QgbmVlZCB0byBj
aGVjayAvcHJvYy9tb3VudHMgb3IKPiAvcHJvYy9maWxlc3lzdGVtcywgb25seSBpZiB3ZSBkb24n
dCBmaW5kIHNlbGludXhmcyBvbiBvbmUgb2YgdGhlCj4gZXhwZWN0ZWQgbW91bnQgZGlyZWN0b3Jp
ZXMgKC9zeXMvZnMvc2VsaW51eCBvciAvc2VsaW51eCkuCgpBbHNvLCBmb3IgcmVmZXJlbmNlLCB2
ZXJpZnlfc2VsaW51eG1udCgpIGlzIGFzIGZvbGxvd3M6CgpzdGF0aWMgaW50IHZlcmlmeV9zZWxp
bnV4bW50KGNvbnN0IGNoYXIgKm1udCkKewogICAgICAgIHN0cnVjdCBzdGF0ZnMgc2ZidWY7CiAg
ICAgICAgaW50IHJjOwoKICAgICAgICBkbyB7CiAgICAgICAgICAgICAgICByYyA9IHN0YXRmcyht
bnQsICZzZmJ1Zik7CiAgICAgICAgfSB3aGlsZSAocmMgPCAwICYmIGVycm5vID09IEVJTlRSKTsK
ICAgICAgICBpZiAocmMgPT0gMCkgewogICAgICAgICAgICAgICAgaWYgKCh1aW50MzJfdClzZmJ1
Zi5mX3R5cGUgPT0gKHVpbnQzMl90KVNFTElOVVhfTUFHSUMpIHsKICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IHN0YXR2ZnMgdmZzYnVmOwogICAgICAgICAgICAgICAgICAgICAgICByYyA9
IHN0YXR2ZnMobW50LCAmdmZzYnVmKTsKICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJjID09
IDApIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoISh2ZnNidWYuZl9mbGFn
ICYgU1RfUkRPTkxZKSkgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c2V0X3NlbGludXhtbnQobW50KTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9CiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7CiAgICAgICAgICAgICAgICAg
ICAgICAgIH0KICAgICAgICAgICAgICAgIH0KICAgICAgICB9CgogICAgICAgIHJldHVybiAtMTsK
fQoKPgo+ID4KPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKPiA+Cj4gPiArKysgbGliL3RzdF9z
ZWN1cml0eS5jCj4gPiBAQCAtMTA3LDcgKzEwNyw3IEBAIGludCB0c3Rfc2VsaW51eF9lbmFibGVk
KHZvaWQpCj4gPiAgewo+ID4gICAgICAgICBpbnQgcmVzID0gMDsKPiA+Cj4gPiAtICAgICAgIGlm
ICh0c3RfaXNfbW91bnRlZChTRUxJTlVYX1BBVEgpKQo+ID4gKyAgICAgICBpZiAoYWNjZXNzKFNF
TElOVVhfU1RBVFVTX1BBVEgsIEZfT0spID09IDApCj4gPiAgICAgICAgICAgICAgICAgcmVzID0g
MTsKPiA+Cj4gPiAgICAgICAgIHRzdF9yZXMoVElORk8sICJTRUxpbnV4IGVuYWJsZWQ6ICVzIiwg
cmVzID8gInllcyIgOiAibm8iKTsKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
