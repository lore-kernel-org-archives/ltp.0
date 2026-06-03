Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF30CD6E55
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 10:24:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 390783E308C
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 12:24:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC8C43D036A
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 12:24:17 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1C59D600620
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 12:24:17 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-687ed9aabb3so10522201a12.1
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 03:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780482256; cv=none;
 d=google.com; s=arc-20240605;
 b=VnCwmklAiv/AUx43hOO+l5qUrYHw0lbiMGEmhntKf6KcwNS7H4o/g1Wh3favhWwxnR
 mfIlAFSfVMldjVq8uL2B4erJOtmZeiqLAJX+xc+CeiX+Np5Y0Hq1GlEI8ZACY8/O0rAZ
 damNu1UV3GwNBq+7WiFCL0I2jIraOTlIzlk8TbWbT6oppjFjNWK5lkWT+IOx7CYwOf2w
 MhcFXIzGK3iHwGHRZyPUWHx++/hLRBlkzCOVkCYtYkIWtvUZoQ+Nhi2YZaBezwwEgKMc
 1WVynEr6V0UMpuPh8h0zR8sRb2EVtLR8qkTeXkNngiDL/r8ebhbGQEhKyIum3Etr5zG8
 HWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t6ZLBpl9/DX+A4AniA+9rGn7Z86LOmRjfd0yOS/Hvm4=;
 fh=QydmCw0UiHF/jyDhReCfs3Csx3SMYqmfX5tPLKjoIIA=;
 b=GwHO8s1Ut/6XaN0gBOzV9/J7BAL2nw8ybm/q0jclgvpsya9b+LLJF55dFiQUIEEfQm
 73vYITOJ3j8+UZIK51Mrv+pmbtuSAxfO2KP/pAn4PEkj+JV78hx1tydOyYvXwObHMrKy
 53N/weYsQf39YI9ZxUX1dcNwlwXZ0l66IcjIhcgjxC1B2LRD9UPo5xfLcJlLdnPoxyvE
 S50S//N3Q/67SAxjh/W6k93SEvFciE/VrcDlmtkeYz3dJI7k8ytbIglVYTShSkFuDzUz
 udBdcffgSxCDBObvBfVCldxKgWklLE8f/S6z9Vqn92jGQtM4AwruhlgHLZPy1beCAYFa
 Lq3A==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780482256; x=1781087056; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6ZLBpl9/DX+A4AniA+9rGn7Z86LOmRjfd0yOS/Hvm4=;
 b=G+NxuXFChD4L+rhw+FRgCAKC3j/VZz6v8HMg0eOO3g4TMpFx6XSkKGdFNuSqLEuJti
 dsFM16oJEL6+8qOpEzvwfTZqCE1sBkWye9VE/bAC6D416CVz4QkLwR4uDmiLkFqQQB83
 7EAJO3cWF9HSYziFu6ApunAYiTxc7df+XlIQESfqORTGm1ZMLWjlbtSV4Bji9mDK//GO
 PKV2e/PFxmPcsDS/+dWSIZmcggnVm3ySM//OSuGBhYgfxvJg+bYQ+Fn9N1wN3wQ4lMoI
 s27uAvqTBsWHR75++05A7gA0bvHgfs9KZm2XNdZFzSMg97LjD1htpW6GYXj8OlNaYv0G
 jPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780482256; x=1781087056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t6ZLBpl9/DX+A4AniA+9rGn7Z86LOmRjfd0yOS/Hvm4=;
 b=dWE5Xjy+YR40L7wq+FDd68FRbnSfZdac1iiJiy5BZdGgnvkMlMzl8L7PLAPirOFzmW
 qW8LPGO1qOLsDr9vo5u2t58Q+myKh1PDMcTafb5fw3rKpVyzi8XREdKfeJ9UC3x/z57y
 b+XZReX2blXXaehz4cW8EV38bhPcjEkMuTduNNaGbyJcK88hVPjIezGj8g5Gl1mImcbZ
 wmFOS8c/JekR/0eBNRgGJBw0nUczkOuM2Y+QY5zLUx8Vr2xp9QHG/Kh9B5Y/gY33DUDZ
 ZLbELNFwBNTVENnxhuBDMv5vAhFSG6gVY6DisQcJwI/wVeUmg84OBcGas7wmgL8UxRXA
 m4Aw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JJMh19ww4GHgBOh5gYe3QEDd1lAwy3jRHOR78qpY6McELjFg/ty/v2KJxmYlEF2tVR+s=@lists.linux.it
X-Gm-Message-State: AOJu0Yz6LtyZWdYdMVfT+iYWZPuPLv63i6A/Hr1rSXR01AIoFdcZL/yI
 v+ChnLT6m1E0e23n/Qycp4iwuiaDRSWCnr0uhO8CcFh6boYaDEeCi7Ym6xFuFbeWBkhRplPqGoo
 GkzGbV/L1smUHUniWOZtua5me5E2QYzQ=
X-Gm-Gg: Acq92OFKKmhc0i+P+yQAtvGfDcfGCVuSvD2E8Yr7xxpIw6/XeqidOJoERHU0sVRRxX5
 h3gcAxTh1JpHQH9Yoto4si4vrwV0gsgsUKkzDJ6hOpFOYOArWuZ9kjsIVmqOgPtHLISNjTSDqR3
 vymsxDnsrrcFt29jlKfEgeVn+zllgyAJVfW8Tojp88sNBxXVCRj2HiEahAr0OG3xEfsjO+FWhT5
 0Is6rzpvQbdoUxFkkh4OxUh8VvbFQ6EBRRZudI08b4SXijg3+96fOv2ONlFKvWa7LvRBH0v4Dd9
 v7fvRZXdyNrPYq4gRds2+YPDeKOsYMKWItM4vWmxags/G30uAabq
X-Received: by 2002:a05:6402:5018:b0:67b:4e46:f12f with SMTP id
 4fb4d7f45d1cf-68e714dbf07mr1333427a12.25.1780482256086; Wed, 03 Jun 2026
 03:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxizKqbByJHpQB1KAkfhgiXysSuD+8UZFmg0KY5J-4B8pw@mail.gmail.com>
 <20260603015841.16230-1-anonymemeow@gmail.com>
In-Reply-To: <20260603015841.16230-1-anonymemeow@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 3 Jun 2026 12:24:04 +0200
X-Gm-Features: AVHnY4JrXN4ys16VHMYCBVolAVAK4rVmqUoM1CYTDtsp3idWGX1o5OyPLQ9uYxc
Message-ID: <CAOQ4uxjzJMyv5usNkzjUg2c27D6sMK7oQXu-Rc+BKksZ5o8Zog@mail.gmail.com>
To: AnonymeMeow <anonymemeow@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fanotify13: fix test failure when running
 iterations
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
Cc: jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdW4gMywgMjAyNiBhdCAzOjU44oCvQU0gQW5vbnltZU1lb3cgPGFub255bWVtZW93
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBUaGUgRkFOX0RFTEVURV9TRUxGIHRlc3QgY2FzZSByZW1v
dmVzIHRlc3QgZmlsZXMsIGNhdXNpbmcgbGF0ZXIKPiBpdGVyYXRpb25zIHRvIGNyYXNoLiBSZWNy
ZWF0ZSB0aGUgcmVtb3ZlZCBmaWxlcyBhZnRlciB0aGUgdGVzdCB0bwo+IHJlc3RvcmUgdGhlIGV4
cGVjdGVkIGluaXRpYWwgc3RhdGUuIEFuZCBhZGp1c3QgdGhlIG92ZXJsYXlmcyBtb3VudAo+IHRp
bWluZyB0byBhdm9pZCBjcmVhdGluZyBmaWxlcyBkaXJlY3RseSBpbiB0aGUgZmlsZXN5c3RlbSB1
bmRlcm5lYXRoCj4gdGhlIGFscmVhZHkgbW91bnRlZCBvdmVybGF5ZnMuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBBbm9ueW1lTWVvdyA8YW5vbnltZW1lb3dAZ21haWwuY29tPgo+IC0tLQo+Cj4gSGksIEFt
aXIsCj4KPiBJIHRlc3RlZCB5b3VyIHN1Z2dlc3RlZCBzb2x1dGlvbiwgYnV0IHRoZSBvdmVybGF5
ZnMgbW91bnQgZmFpbGVkIHdpdGg6Cj4KPiBmYW5vdGlmeTEzLmM6MTY1OiBUQlJPSzogb3Zlcmxh
eWZzIG1vdW50IGZhaWxlZDogRVNUQUxFICgxMTYpCj4KPiBTbyBJIGtlcHQgY2xlYW5fdXBwZXJf
ZGlyKCkgaW4gcmVzdG9yZV9vYmplY3RzKCkgdG8gcmVzdG9yZSB0aGUgZXhwZWN0ZWQKPiBpbml0
aWFsIHN0YXRlLgoKT2sgbm8gcHJvYmxlbS4gVGhpcyBpcyBmaW5lIHRvby4KVGhhbmtzLAoKUmV2
aWV3ZWQtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cgo+Cj4gV2l0aCBC
ZXN0IFJlZ2FyZHMsCj4gQW5vbnltZU1lb3cKPgo+IC0tLQo+ICAuLi4va2VybmVsL3N5c2NhbGxz
L2Zhbm90aWZ5L2Zhbm90aWZ5MTMuYyAgICAgfCA0OSArKysrKysrKysrKysrKysrLS0tCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxMy5jIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTEzLmMKPiBpbmRleCA3
NmQ0MGVhZjcuLjE4Mjg1ODQ3MCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTMuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZmFub3RpZnkvZmFub3RpZnkxMy5jCj4gQEAgLTUzLDYgKzUzLDkgQEAKPiAgI2RlZmluZSBG
SUxFX1BBVEhfT05FIE1PVU5UX1BBVEgiLyJGSUxFX09ORQo+ICAjZGVmaW5lIEZJTEVfUEFUSF9U
V08gTU9VTlRfUEFUSCIvIkZJTEVfVFdPCj4KPiArI2RlZmluZSBUU1RfVkFSSUFOVF9PVkxfTE9X
RVIgKHRzdF92YXJpYW50ICYgMSkKPiArI2RlZmluZSBUU1RfVkFSSUFOVF9PVkxfV0FUQ0ggKHRz
dF92YXJpYW50ID4gMikKPiArCj4gICNpZiBkZWZpbmVkKEhBVkVfTkFNRV9UT19IQU5ETEVfQVQp
Cj4gIHN0cnVjdCBldmVudF90IHsKPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgbG9uZyBleHBlY3Rl
ZF9tYXNrOwo+IEBAIC0xMzcsNiArMTQwLDIyIEBAIHN0YXRpYyB2b2lkIGRlbGV0ZV9vYmplY3Rz
KHZvaWQpCj4gICAgICAgICB9Cj4gIH0KPgo+ICtzdGF0aWMgdm9pZCBjbGVhbl91cHBlcl9kaXIo
dm9pZCkKPiArewo+ICsgICAgICAgdW5zaWduZWQgaW50IGk7Cj4gKwo+ICsgICAgICAgU0FGRV9V
TU9VTlQoTU9VTlRfUEFUSCk7Cj4gKyAgICAgICBTQUZFX1VNT1VOVChPVkxfTU5UKTsKPiArCj4g
KyAgICAgICBTQUZFX01PVU5UKE9WTF9VUFBFUiwgTU9VTlRfUEFUSCwgIm5vbmUiLCBNU19CSU5E
LCBOVUxMKTsKPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKG9iamVjdHMpOyBp
KyspCj4gKyAgICAgICAgICAgICAgIFNBRkVfVU5MSU5LKG9iamVjdHNbaV0ucGF0aCk7Cj4gKyAg
ICAgICBTQUZFX1VNT1VOVChNT1VOVF9QQVRIKTsKPiArCj4gKyAgICAgICBTQUZFX01PVU5UX09W
RVJMQVkoKTsKPiArICAgICAgIFNBRkVfTU9VTlQoT1ZMX01OVCwgTU9VTlRfUEFUSCwgIm5vbmUi
LCBNU19CSU5ELCBOVUxMKTsKPiArfQo+ICsKPiAgc3RhdGljIHZvaWQgZ2V0X29iamVjdF9zdGF0
cyh2b2lkKQo+ICB7Cj4gICAgICAgICB1bnNpZ25lZCBpbnQgaTsKPiBAQCAtMTQ3LDYgKzE2Niwx
NyBAQCBzdGF0aWMgdm9pZCBnZXRfb2JqZWN0X3N0YXRzKHZvaWQpCj4gICAgICAgICB9Cj4gIH0K
Pgo+ICtzdGF0aWMgdm9pZCByZXN0b3JlX29iamVjdHModm9pZCkKPiArewo+ICsgICAgICAgaWYg
KFRTVF9WQVJJQU5UX09WTF9MT1dFUikKPiArICAgICAgICAgICAgICAgY2xlYW5fdXBwZXJfZGly
KCk7Cj4gKyAgICAgICBlbHNlCj4gKyAgICAgICAgICAgICAgIGNyZWF0ZV9vYmplY3RzKCk7Cj4g
Kwo+ICsgICAgICAgLyogR2V0IHRoZSByZS1jcmVhdGVkIG9iamVjdCBpZHMgKi8KPiArICAgICAg
IGdldF9vYmplY3Rfc3RhdHMoKTsKPiArfQo+ICsKPiAgc3RhdGljIGludCBzZXR1cF9tYXJrcyh1
bnNpZ25lZCBpbnQgZmQsIHN0cnVjdCB0ZXN0X2Nhc2VfdCAqdGMpCj4gIHsKPiAgICAgICAgIHVu
c2lnbmVkIGludCBpOwo+IEBAIC0zNDAsNiArMzcwLDEwIEBAIHN0YXRpYyB2b2lkIGRvX3Rlc3Qo
dW5zaWduZWQgaW50IG51bWJlcikKPiAgICAgICAgICAgICAgICAgICAgICAgICAiRGlkIG5vdCBn
ZXQgYW4gZXhwZWN0ZWQgZXZlbnQgKGV4cGVjdGVkOiAlbGx4KSIsCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgZXZlbnRfc2V0W2ldLmV4cGVjdGVkX21hc2spOwo+ICAgICAgICAgfQo+ICsKPiAr
ICAgICAgIC8qIFJlc3RvcmUgdG8gc3RhdGUgYmVmb3JlIGRlbGV0ZV9vYmplY3RzKCkgKi8KPiAr
ICAgICAgIGlmICh0Yy0+bWFzayAmIEZBTl9ERUxFVEVfU0VMRikKPiArICAgICAgICAgICAgICAg
cmVzdG9yZV9vYmplY3RzKCk7Cj4gIG91dDoKPiAgICAgICAgIFNBRkVfQ0xPU0UoZmFub3RpZnlf
ZmQpOwo+ICB9Cj4gQEAgLTM2NywxNCArNDAxLDExIEBAIHN0YXRpYyB2b2lkIGRvX3NldHVwKHZv
aWQpCj4gICAgICAgICAgKi8KPiAgICAgICAgIGlmICh0c3RfdmFyaWFudCkgewo+ICAgICAgICAg
ICAgICAgICBSRVFVSVJFX0hBTkRMRV9UWVBFX1NVUFBPUlRFRF9CWV9LRVJORUwoQVRfSEFORExF
X0ZJRCk7Cj4gLSAgICAgICAgICAgICAgIG92bF9tb3VudGVkID0gVFNUX01PVU5UX09WRVJMQVko
KTsKPiAtICAgICAgICAgICAgICAgaWYgKCFvdmxfbW91bnRlZCkKPiAtICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm47Cj4gKyAgICAgICAgICAgICAgIHRzdF9jcmVhdGVfb3ZlcmxheV9kaXJz
KCk7Cj4KPiAtICAgICAgICAgICAgICAgbW50ID0gdHN0X3ZhcmlhbnQgJiAxID8gT1ZMX0xPV0VS
IDogT1ZMX1VQUEVSOwo+ICsgICAgICAgICAgICAgICBtbnQgPSBUU1RfVkFSSUFOVF9PVkxfTE9X
RVIgPyBPVkxfTE9XRVIgOiBPVkxfVVBQRVI7Cj4gICAgICAgICB9IGVsc2Ugewo+ICAgICAgICAg
ICAgICAgICBtbnQgPSBPVkxfQkFTRV9NTlRQT0lOVDsKPiAtCj4gICAgICAgICB9Cj4gICAgICAg
ICBSRVFVSVJFX0ZBTk9USUZZX0lOSVRfRkxBR1NfU1VQUE9SVEVEX09OX0ZTKEZBTl9SRVBPUlRf
RklELCBtbnQpOwo+ICAgICAgICAgU0FGRV9NS0RJUihNT1VOVF9QQVRILCAwNzU1KTsKPiBAQCAt
Mzg1LDggKzQxNiwxNCBAQCBzdGF0aWMgdm9pZCBkb19zZXR1cCh2b2lkKQo+Cj4gICAgICAgICAv
KiBDcmVhdGUgZmlsZSBhbmQgZGlyZWN0b3J5IG9iamVjdHMgZm9yIHRlc3Rpbmcgb24gYmFzZSBm
cyAqLwo+ICAgICAgICAgY3JlYXRlX29iamVjdHMoKTsKPiArCj4gKyAgICAgICBpZiAodHN0X3Zh
cmlhbnQpIHsKPiArICAgICAgICAgICAgICAgb3ZsX21vdW50ZWQgPSBUU1RfTU9VTlRfT1ZFUkxB
WSgpOwo+ICsgICAgICAgICAgICAgICBpZiAoIW92bF9tb3VudGVkKQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybjsKPiArICAgICAgIH0KPgo+IC0gICAgICAgaWYgKHRzdF92YXJpYW50
ID4gMikgewo+ICsgICAgICAgaWYgKFRTVF9WQVJJQU5UX09WTF9XQVRDSCkgewo+ICAgICAgICAg
ICAgICAgICAvKiBTZXR1cCB3YXRjaGVzIG9uIG92ZXJsYXlmcyAqLwo+ICAgICAgICAgICAgICAg
ICBTQUZFX01PVU5UKE9WTF9NTlQsIE1PVU5UX1BBVEgsICJub25lIiwgTVNfQklORCwgTlVMTCk7
Cj4gICAgICAgICAgICAgICAgIG92bF9iaW5kX21vdW50ZWQgPSAxOwo+IC0tCj4gMi41NC4wCj4K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
