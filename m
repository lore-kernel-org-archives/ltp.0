Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F69C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 17:15:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E717A3C260A
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 18:15:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AD683C01D4
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 18:15:27 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 07ADC200C1B
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 18:15:27 +0100 (CET)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so219578566b.3
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743095726; x=1743700526; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHIi7uYi1i+HQomFVbM/W5B+LQI0ELV9XeIoqhBzySM=;
 b=GI6HOERjEYKf4tphEoZztFGMCWLdvwVZQMxmCnFgVHKkt35kjjm7ieW0w2UD7tnTxv
 wxs/QLmdVfC/1JJkQL0iqBLtsNmP9bGpBa8s6zPpAz5YurTNTlGO7L5Aj2O4zNiimp3g
 YBACIru80DvAWrlwk/X1YaDLL2wzCgMFGxxq+SQ3ASPqAtwE2Mx5EB2jBIwZVrjJoxj3
 BPOXxDRIEY7TtdEFISEemvpNIimFg3cCgh1wqRvR9PiG9dR8/4Wl1PpHeZwMuzrU7jgT
 7Z2UA0uC3Vd1YhW63cekhSydr5kCQ9j53V/Sxy4I2r5lEKoiRf8vVvU6VqIAcMaBje/R
 UiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743095726; x=1743700526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHIi7uYi1i+HQomFVbM/W5B+LQI0ELV9XeIoqhBzySM=;
 b=QStVEMZK1jfYkaQYFJiyNS0Gxt2tbedCFwmAHKib09jWVW0LnsWagTDmGW96zLtMK7
 LKM+R/oKSoOlEW9yczs6lzEARyFrfFuMjLtSYU8u247/mIiICsbmvKsqM5NbRnEhPJMh
 tQYrNf3kDz8sP2paf2960zs9l2PmxGyd0AgOM+eyV1ZOkRylSm9lfKKJKMpMQ/UuoHEI
 4yyfLWQjc0wcDBff7I6jItQ3PNJBOlDK+SXPtqUGGNTjwg+cjcGDGSQ3WPfzfJzgfuDt
 RF3WWX0CuHG979ISytqfZD/UgVcxUupmsd36N9JdJhaATY+ZilcDwepB9C3ZjADspqdl
 mM3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc8GxIgr1UvO5HH4gg5f51HRJKwYazvKhYHKy1U3B9FvZyZfulLJSlkftLo9QTuUJZfto=@lists.linux.it
X-Gm-Message-State: AOJu0Yzomc7FgTcuZL7Rm3xsdEbNzpCXGioRJyz0iESN+L8B5/Oeh0dX
 WoZQAgMAJguQMCp+xh/7T8zPGn5lDgYr6ejQIgwYm8M+d9oPC8nvYxT9z87/+KTxhPR7/vV2vdX
 9t3EY7E1CJUjDmS4ecaBVUhr02dg=
X-Gm-Gg: ASbGncuCU3R9l992+I7KL4iiipNsmT6fb9d5gryeV0FvcYdmEaXNxm+t/+gEDcvPw5W
 1lzAnR+vpxLYFsz/KUV9AfxZSHSXIsEBYY4p7XLfn8S8+iw3GGJ+uBSGQJ3Bkq23watdVtLAFHw
 yFunsS6H52SB32eX4z4NMa7TAjvQ==
X-Google-Smtp-Source: AGHT+IHze8Q6J1nayVY8Bn7Re7qLL4iuHrrWVaJcYrpGiTx/1PjRH0U+Zx/oqAJrj4tOBn9wKk7k/+hpbHJePql66Pc=
X-Received: by 2002:a17:907:7213:b0:ac4:169:3670 with SMTP id
 a640c23a62f3a-ac6fb149f0cmr297539566b.48.1743095725915; Thu, 27 Mar 2025
 10:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250319192742.999506-1-amir73il@gmail.com>
 <20250319192742.999506-3-amir73il@gmail.com>
 <xpozkmxhtqd3lamf7n2dk43z6eey5ettmdw3vayykmjrv5dqgt@zeewki7ibawg>
 <CAOQ4uxgW8rFNLOXMOQzXMrGXtsVvX6QHKMc8tPrnibra_cCAZA@mail.gmail.com>
 <20250327105434.GA72472@pevik>
In-Reply-To: <20250327105434.GA72472@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Mar 2025 18:15:14 +0100
X-Gm-Features: AQ5f1JpRsZOKNakxiB4nnTg47VOuA_RTtKDpdPHuG2sZuamUqniVIc4kygx29CU
Message-ID: <CAOQ4uxhx8XO_LmSVJ+2FeAzFjuPT8u4iPE0WfpV=dM49TQUaQA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify24: print range info for pre-content
 events
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXIgMjcsIDIwMjUgYXQgMTE6NTTigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiBIaSBBbWlyLCBKYW4sCj4KPiA+ID4gPiBAQCAtMzg2LDYgKzM4OCwy
MiBAQCBzdGF0aWMgdm9pZCB0ZXN0X2Zhbm90aWZ5KHVuc2lnbmVkIGludCBuKQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICh1bnNpZ25lZCBpbnQpZXZlbnQtPnBpZCwKPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAodW5zaWduZWQgaW50KWNoaWxkX3Bp
ZCwKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBldmVudC0+ZmQpOwo+ID4g
PiA+ICsgICAgICAgICAgICAgfSBlbHNlIGlmIChldmVudC0+bWFzayAmIExUUF9QUkVfQ09OVEVO
VF9FVkVOVFMpIHsKPgo+ID4gPiBZb3Ugc2hvdWxkIHByb2JhYmx5IGNoZWNrIGhlcmUgdGhhdCB0
aGUgZXZlbnQtPmxlbiBpcyBzdWZmaWNpZW50bHkgbGFyZ2UgdG8KPiA+ID4gY29udGFpbiB0aGUg
cmFuZ2UgaW5mby4gT3RoZXJ3aXNlICdyYW5nZScgbWlnaHQgcG9pbnQgYmV5b25kIHRoZSBlbmQg
b2YKPiA+ID4gZXZlbnQgYW5kIHJlc3VsdCBpbiBvZGQgYmVoYXZpb3IuLi4KPgo+Cj4gPiBSaWdo
dC4gZmVlbCBmcmVlIHRvIHVzZSB0aGUgYW1lbmRlZCB2ZXJzaW9uIGJlbG93Cj4KPgo+Cj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBIb256YQo+Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChyYW5nZS0+
aGRyLmluZm9fdHlwZSAhPSBGQU5fRVZFTlRfSU5GT19UWVBFX1JBTkdFKSB7Cj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCwKPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJnb3QgZXZlbnQ6IG1hc2s9JWxseCBwaWQ9
JXUgZmQ9JWQgIgo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IihleHBlY3RlZCByYW5nZSBpbmZvKSIsCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZyBsb25nKWV2ZW50LT5tYXNrLAo+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHVuc2lnbmVkIGludClldmVudC0+
cGlkLAo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXZlbnQt
PmZkKTsKPgo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGV2ZW50LT5ldmVudF9sZW4g
PCBzaXplb2YoKmV2ZW50KSArCj4gPiBzaXplb2YoKnJhbmdlKSB8fAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJhbmdlLT5oZHIuaW5mb190eXBlICE9IEZBTl9FVkVOVF9JTkZPX1RZ
UEVfUkFOR0UpIHsKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHN0X3JlcyhU
RkFJTCwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiZ290IGV2
ZW50OiBtYXNrPSVsbHggcGlkPSV1Cj4gPiBsZW49JWQgZmQ9JWQgIgo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICIoZXhwZWN0ZWQgcmFuZ2UgaW5mbykiLAo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh1bnNpZ25lZCBsb25nIGxv
bmcpZXZlbnQtPm1hc2ssCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKHVuc2lnbmVkIGludClldmVudC0+cGlkLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICh1bnNpZ25lZCBpbnQpZXZlbnQtPmV2ZW50X2xlbiwKPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBldmVudC0+ZmQpOwo+Cj4gVGhhbmtz
ISBJIGRhcmVkIGluc3RlYWQgb2YgY29weSBwYXN0aW5nIHRvIHVzZSBmYW5faHNtIGJyYW5jaCBm
cm9tIHlvdXIgZm9yay4KClN1cmUuIFRoYXQncyBnb29kIHRvby4KClRoYW5rcywKQW1pci4KCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
