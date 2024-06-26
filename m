Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0784C27C4F
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 18:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719428322; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Qv6XC4pRtdQ6K1UdGOKTGi6w113U6ZcQmRXEcOXTP1M=;
 b=mS/82ersO6u3TyQAkTbPzkxG3QdxUooThVzZ+b1PDy0CSYLn/iCZ+li6m9Dt8TdVnZ0rc
 k91IiXHTteGUASiUnn4MxULBixNHc9TP8ldK6neGogtd6Pjc0ZoJA/H/HXC2oTThiPdZ6Ei
 0P1pGqcruxhwFW1GGk/+uPoffZyujmk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B8763D119E
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 20:58:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4C3D3D1133
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 20:58:19 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 051E2200922
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 20:58:18 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-424786e4056so14495e9.0
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719428298; x=1720033098; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUmpKKmThgWZWpe8sLtVfefFe/CIYfX7xKuekVwmsnk=;
 b=a1SconBKyWBhIPS1WgS3DFwPCsHw7JU1uENL9P6JdwmrJ80INU0fxiaPNT+SYHp/n+
 Pb7Tfw4X3dwtsKD1RV/cZU+sQUoV+2LF4FYAvmM9rFkYV/PLUEMowuqhojSez/EkmrUE
 QuJjglDPUCw+DuO0wAKfn1oXKdmEcg4Dx0OPHoPQyDMNKU4bHryyU/ks8nqCUNRB8+UA
 6xI5n2gnnRyw6oDNIpLnS9PVo6UiyVuYBHvHnJGhgCkVATsuXjg2FIY4HPDReuRrsdWM
 IRAsuWxGy/E8uNFRzFJOZuUxUu/6RakQKV02VrLo6Z8pQ9WKIiWHSgEI4gGYDBOjGmbd
 yMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719428298; x=1720033098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUmpKKmThgWZWpe8sLtVfefFe/CIYfX7xKuekVwmsnk=;
 b=mWtWfOWypkY8Sm7OX06RTRS/H/mq7UlIim6Go+CK8qGwNwuV6kJIXCNabkw7yzfmRj
 fVyb4vEQxBD3w9dcJ1v2tE2m3B1KD3BW82wxjdHbrbyA+lL26evUlIuoHJrCMIBaUSpY
 7jhiSM9LDev+ZhWM+rxFvNJFGPWA72knj8/eWPuT4NltkkJgyF7hSMI6LLU3QA2r23k6
 6L4WRgSW+FIy6jabG7YnkE89olqv40sKYi/T/pCfhpeLbvFXuMlVYj5U/xb2BTFvIk0J
 VbCPg1yTzB5ZfjvzhNObWCIIeTPuTcm7PD9FB6lcnG0O19GQOG7BiEItidJ9/7qPNatK
 /eSw==
X-Gm-Message-State: AOJu0YyU9/bxQoNZdvRcOF148Sri2uI8ZEtMt3TlzXN6a5m8HbkpdytF
 2VXhoxIKtedxZX7pStajNVaW5t0WP8IdlI7HArhUr++6EmT7CGxA53+MT3db0vRByBz5dv2slXa
 kLKuy4ilIvuaPmVhl3byKniFsu3Ri90T8Tvc=
X-Google-Smtp-Source: AGHT+IHgL+ligIY4IWeGWrnX6SdlT42E3jpTLKP1jOZgFSvth4o4+7Gz1y/EXTk1D2tHDu20LlRW9GT6q+mPmVx2Ylg=
X-Received: by 2002:a05:600c:1d93:b0:424:891e:a9ff with SMTP id
 5b1f17b1804b1-425633e02b8mr382725e9.2.1719428298228; Wed, 26 Jun 2024
 11:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240626133004.15810-1-chrubis@suse.cz>
In-Reply-To: <20240626133004.15810-1-chrubis@suse.cz>
Date: Wed, 26 Jun 2024 11:58:05 -0700
Message-ID: <CANDhNCpKJ5i41eNw_sthFQfdTaYoJU76swEWmwmBy_Y2t2pszQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] include/tst_timer: Add TST_NO_LIBLTP
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: kernel-team@android.com, Darren Hart <darren@os.amperecomputing.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdW4gMjYsIDIwMjQgYXQgNjozMOKAr0FNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IE9sZGVyIGNvbXBpbGVycyAoZ2NjLTQuOCkgYXJlIG5vdCBzbWFy
dCBlbm91Z2ggdG8gZWxpbWluYXRlIHRoZQo+IGltcG9zc2libGUgYnJhbmNoIHdpdGggdHN0X2Jy
aygpIGVhcmx5IGVub3VnaCBhbmQgdGhlIHNjaGVkX2Zvb3RiYWxsCj4gY29tcGlsYXRpb24gZmFp
bHMgZHVlIHRvIHRoZSB1bnJlc29sdmVkIGZ1bmN0aW9uLgo+Cj4gQWRkIFRTVF9OT19MSUJMVFAg
bWFjcm8gdGhhdCBjaGFuZ2VzIHRoZSB0c3RfYnJrKCkgbWVzc2FnZXMgaW50byBhYm9ydCgpCj4g
YW5kIG1ha2UgdXNlIG9mIGl0IGluIHNjaGVkX2Zvb3RiYWxsLgo+Cj4gRml4ZXMgY29tcGlsYXRp
b24gb24gTGVhcC00Mi4yLgo+Cj4gQ2M6IGtlcm5lbC10ZWFtQGFuZHJvaWQuY29tCj4gQ2M6IERh
cnJlbiBIYXJ0IDxkYXJyZW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNvbT4KPiBDYzogSm9obiBTdHVs
dHogPGpzdHVsdHpAZ29vZ2xlLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNo
cnViaXNAc3VzZS5jej4KPiAtLS0KPiAgaW5jbHVkZS90c3RfdGltZXIuaCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgMTYgKysrKysrKysrKysrKysrKwo+ICAuLi4vZnVuYy9zY2hlZF9m
b290YmFsbC9zY2hlZF9mb290YmFsbC5jICAgICAgICAgfCAgMSArCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMTcgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0X3RpbWVyLmgg
Yi9pbmNsdWRlL3RzdF90aW1lci5oCj4gaW5kZXggNmZiOTQwMDIwLi5mYzBjZGI1YmMgMTAwNjQ0
Cj4gLS0tIGEvaW5jbHVkZS90c3RfdGltZXIuaAo+ICsrKyBiL2luY2x1ZGUvdHN0X3RpbWVyLmgK
PiBAQCAtMTgwLDcgKzE4MCwxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgKnRzdF90c19nZXQoc3Ry
dWN0IHRzdF90cyAqdCkKPiAgICAgICAgIGNhc2UgVFNUX0tFUk5fVElNRVNQRUM6Cj4gICAgICAg
ICAgICAgICAgIHJldHVybiAmdC0+dHMua2Vybl90czsKPiAgICAgICAgIGRlZmF1bHQ6Cj4gKyNp
Zm5kZWYgVFNUX05PX0xJQkxUUAo+ICAgICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LLCAiSW52
YWxpZCB0eXBlOiAlZCIsIHQtPnR5cGUpOwo+ICsjZWxzZQo+ICsgICAgICAgICAgICAgICBhYm9y
dCgpOwo+ICsjZW5kaWYKPiAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4gICAgICAgICB9
Cj4gIH0KPiBAQCAtMTk2LDcgKzIwMCwxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgKnRzdF9pdHNf
Z2V0KHN0cnVjdCB0c3RfaXRzICp0KQo+ICAgICAgICAgY2FzZSBUU1RfS0VSTl9USU1FU1BFQzoK
PiAgICAgICAgICAgICAgICAgcmV0dXJuICZ0LT50cy5rZXJuX2l0czsKPiAgICAgICAgIGRlZmF1
bHQ6Cj4gKyNpZm5kZWYgVFNUX05PX0xJQkxUUAo+ICAgICAgICAgICAgICAgICB0c3RfYnJrKFRC
Uk9LLCAiSW52YWxpZCB0eXBlOiAlZCIsIHQtPnR5cGUpOwo+ICsjZWxzZQo+ICsgICAgICAgICAg
ICAgICBhYm9ydCgpOwo+ICsjZW5kaWYKPiAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4g
ICAgICAgICB9Cj4gIH0KLi4uCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5j
L3NjaGVkX2Zvb3RiYWxsL3NjaGVkX2Zvb3RiYWxsLmMgYi90ZXN0Y2FzZXMvcmVhbHRpbWUvZnVu
Yy9zY2hlZF9mb290YmFsbC9zY2hlZF9mb290YmFsbC5jCj4gaW5kZXggYjZhZTY5MmFmLi42ODQ2
OTc4ZjQgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL3JlYWx0aW1lL2Z1bmMvc2NoZWRfZm9vdGJh
bGwvc2NoZWRfZm9vdGJhbGwuYwo+ICsrKyBiL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3NjaGVk
X2Zvb3RiYWxsL3NjaGVkX2Zvb3RiYWxsLmMKPiBAQCAtNzQsNiArNzQsNyBAQAo+ICAjaW5jbHVk
ZSA8bGlicnR0ZXN0Lmg+Cj4gICNpbmNsdWRlIDx0c3RfYXRvbWljLmg+Cj4gICNkZWZpbmUgVFNU
X05PX0RFRkFVTFRfTUFJTgo+ICsjZGVmaW5lIFRTVF9OT19MSUJMVFAKPiAgI2luY2x1ZGUgPHRz
dF90aW1lci5oPgoKSSBkb24ndCBoYXZlIG11Y2ggYmFja2dyb3VuZCBhcm91bmQgdGhlIExUUCBw
cm9qZWN0LCBzbyBmZWVsIGZyZWUgdG8KaWdub3JlIG1lLCBidXQgdGhpcyBzZWVtcyBsaWtlIGl0
IGNvdWxkIGdldCBhIGxpdHRsZSBtZXNzeS4KCk9uZSBjb21tb24gcGF0dGVybiBpbiB0aGUga2Vy
bmVsLCB3aGljaCBtaWdodCBoZWxwLCBpcyB0byBoYW5kbGUKbWlzc2luZyBmdW5jdGlvbnMgdmlh
IHN0dWJzIGluIHRoZSBoZWFkZXJzLgoKU28gaW5zdGVhZCB5b3UgY2FuIGltcGxlbWVudCBpbiBh
IGhlYWRlciBvbmNlOgoKI2lmbmRlZiBUU1RfTk9fTElCTFRQCnN0YXRpYyBpbmxpbmUgdm9pZCB0
ZXN0X2JyayhpbnQgaSwgY2hhciAqcywgbG9uZyBkKQp7CiAgICBhYm9ydCgpOwp9CiNlbmRpZgoK
QW5kIHRoZW4gdGhlIGRvd25zdHJlYW0gdXNlcnMgZG9uJ3QgbmVlZCB0byBoYXZlICNpZmRlZnMg
bGl0dGVyaW5nIHRoZWlyIGxvZ2ljLgoKQWdhaW4sIGp1c3QgYW4gaWRlYS4KCnRoYW5rcwotam9o
bgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
