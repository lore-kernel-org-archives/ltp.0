Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F015C54E58
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 09:56:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63F303CFBBC
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 10:56:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F394C3CD803
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 10:56:42 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8567160081A
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 10:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711014999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VrbtKcM/A0xUtyWOahAtAETJCHialOsjmZb3I8lxI2k=;
 b=FgU6YZmtxlxqdYpBNXgn62Jea0Lw8khQDcuSS6te+iQjklMJIYWpGwuXPQMlemyIE1Jb5Q
 xvJCHALTL58Ux7STH/vBqovD/M/OlNXdeCvYyqEKyYsWSp7N3vNrm2s/Deman/rGtTw1z8
 hxOjtVJUCOduVphTdcxgi3njzApqpnU=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-_k4iNDyDM1umzPLEwseJbA-1; Thu, 21 Mar 2024 05:56:36 -0400
X-MC-Unique: _k4iNDyDM1umzPLEwseJbA-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-47669edd219so284609137.2
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 02:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711014995; x=1711619795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VrbtKcM/A0xUtyWOahAtAETJCHialOsjmZb3I8lxI2k=;
 b=v2ZgmijWutT5h3jcEJjPxCjYwKUJw1sH/tq9JgQxZlgztu28+5r3IpRWO1O+WgC52I
 enuxyTNPwFZr7qZy2QYylZL5G1UNTfbjr0c8VyzK21bdurUZcc0DUUb3ufWKCflnPsKH
 VXNipUhRH+rzK4cPXnY6k6hGsPhtmwjooEkA//z/mNH/Y7J8MkbTChizawXOW/C7rQY8
 iyequ10HiHugLU5nOf/nV+h9C1eXWQdY/LD45RyIJ/hVgYZK3q2HUTk85lfRWlL5RXey
 MDVtFbAZradWZKrJApV1g5aSDF8bWm2VcCCEoIdGCsWeFq7R2AYLOZzwqRGNbzEcfGEG
 GtEg==
X-Gm-Message-State: AOJu0Yz+RXtIijS0J8oDJVo71UCmKcKqogiFoZC65jXVjTG76Ngp6D8g
 bEdVqa7vL5A3tIqGSiy1Fw6BS2UKp+L+9bLjAjMn5da4eKmEAA7Rt1WMR9O/5N+4sUW1RL+dQ+E
 8RniNEBWEep/YJZZCtu95x8L/ggchpJhV4E7aEjh61wRzEQbaBx8QS+59NFJ3ewJ3jfMqEQoOQB
 snT83EZ+ayjOi3a2t+Hh/ysRnVqbYeuDEF4Q==
X-Received: by 2002:a67:c98b:0:b0:473:213e:d547 with SMTP id
 y11-20020a67c98b000000b00473213ed547mr1178309vsk.30.1711014995348; 
 Thu, 21 Mar 2024 02:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH0UH1OUAVd1/KCF3aiqGmUXqvurggWWUxIn38xQRHSMv4+RhUrrm5bms7t5lgpMEOc76f1P9kL0ST7VPlwqU=
X-Received: by 2002:a05:6a20:c221:b0:1a3:463d:e6f1 with SMTP id
 bt33-20020a056a20c22100b001a3463de6f1mr1296511pzb.22.1711014611807; Thu, 21
 Mar 2024 02:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240319100822.3243785-1-liwang@redhat.com>
 <20240319100822.3243785-2-liwang@redhat.com>
 <20240320073116.GA452876@pevik>
In-Reply-To: <20240320073116.GA452876@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Mar 2024 17:49:59 +0800
Message-ID: <CAEemH2ebMOLj+uco1JCr-bhqk-OF87YXG1rH0VjdPLe_PUpwfg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] libswap: add two methods to create swapfile
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

T24gV2VkLCBNYXIgMjAsIDIwMjQgYXQgMzozMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiBHZW5lcmFsbHkgTEdUTS4KPgo+IFJldmlld2VkLWJ5
OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+IC4uLgo+ID4gIC8qCj4gPiAtICogTWFr
ZSBhIHN3YXAgZmlsZQo+ID4gKyAqIENyZWF0ZSBhIHN3YXBmaWxlIG9mIGEgc3BlY2lmaWVkIHNp
emUgb3IgbnVtYmVyIG9mIGJsb2Nrcy4KPiA+ICAgKi8KPiA+IC1pbnQgbWFrZV9zd2FwZmlsZShj
b25zdCBjaGFyICpzd2FwZmlsZSwgaW50IGJsb2NrcywgaW50IHNhZmUpOwo+ID4gK2ludCBtYWtl
X3N3YXBmaWxlKGNvbnN0IGNoYXIgKnN3YXBmaWxlLCB1bnNpZ25lZCBpbnQgbnVtLAo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIGludCBzYWZlLCBlbnVtIHN3YXBmaWxlX21ldGhvZCBtZXRob2Qp
Owo+IEkgd29uZGVyIGlmIGl0IHdvdWxkIGhlbHAgdG8gYWRkIGNvbnN0IGNoYXIgKmZpbGUsIGNv
bnN0IGludCBsaW5lbm8gaGVyZS4KPgo+ID4gKwo+ID4gKyNkZWZpbmUgTUFLRV9TV0FQRklMRV9T
SVpFKHN3YXBmaWxlLCBzaXplLCBzYWZlKSBcCj4gPiArICAgIG1ha2Vfc3dhcGZpbGUoc3dhcGZp
bGUsIHNpemUsIHNhZmUsIFNXQVBGSUxFX0JZX1NJWkUpCj4gbml0OiBJIGxpa2UgdGhlIG5hbWUg
YnV0IG9uZSBoYXZlIHRvIHNlYXJjaCB3aGljaCB1bml0cyAoa0IgdnMuIE1CIHZzLiBHQikKPiBh
cmUgdXNlZC4KPgoKTWF5YmUgd2UgY2FuIGFkZCBjb2RlIGNvbW1lbnRzIGxpa2U6CgorLyoqCisg
KiBNYWNybyB0byBjcmVhdGUgc3dhcGZpbGUgc2l6ZSBpbiBtZWdhYnl0ZXMgKE1CKQorICovCiAj
ZGVmaW5lIE1BS0VfU1dBUEZJTEVfU0laRShzd2FwZmlsZSwgc2l6ZSwgc2FmZSkgXAogICAgLi4u
CgorLyoqCisgKiBNYWNybyB0byBjcmVhdGUgc3dhcGZpbGUgc2l6ZSBpbiBibG9jayBudW1iZXJz
CisgKi8KICNkZWZpbmUgTUFLRV9TV0FQRklMRV9CTEtTKHN3YXBmaWxlLCBibG9ja3MsIHNhZmUp
IFwKICAgICAgLi4uCgoKPiA+ICsKPiA+ICsjZGVmaW5lIE1BS0VfU1dBUEZJTEVfQkxLUyhzd2Fw
ZmlsZSwgYmxvY2tzLCBzYWZlKSBcCj4gPiArICAgIG1ha2Vfc3dhcGZpbGUoc3dhcGZpbGUsIGJs
b2Nrcywgc2FmZSwgU1dBUEZJTEVfQllfQkxLUykKPgo+IEFuZCB3ZSBjb3VsZCBhbHNvIGhhdmUg
U0FGRV8gdmFyaWFudHMuCj4KPiBUaGVyZWZvcmUgbWF5YmUgcmVuYW1lIG1ha2Vfc3dhcGZpbGUo
KSB0byBtYWtlX3N3YXBmaWxlXygpCj4gKGFwcHJvYWNoIGluIExUUCBmb3IgZnVuY3Rpb25zIHRv
IGJlIHdyYXBwZWQpIGFuZCBkZWZpbmUgbWFjcm9zOgo+Cj4gaW50IG1ha2Vfc3dhcGZpbGVfKGNv
bnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCj4gICAgICAgICBjb25zdCBjaGFyICpz
d2FwZmlsZSwgdW5zaWduZWQgaW50IG51bSwKPiAgICAgICAgIGludCBzYWZlLCBlbnVtIHN3YXBm
aWxlX21ldGhvZCBtZXRob2QpOwo+Cj4gI2RlZmluZSBNQUtFX1NXQVBGSUxFX1NJWkUoc3dhcGZp
bGUsIHNpemUsIHNhZmUpIFwKPiAgICAgbWFrZV9zd2FwZmlsZV8oX19GSUxFX18sIF9fTElORV9f
LCBzd2FwZmlsZSwgc2l6ZSwgMCwgU1dBUEZJTEVfQllfU0laRSkKPgo+ICNkZWZpbmUgTUFLRV9T
V0FQRklMRV9CTEtTKHN3YXBmaWxlLCBibG9ja3MsIHNhZmUpIFwKPiAgICAgbWFrZV9zd2FwZmls
ZV8oX19GSUxFX18sIF9fTElORV9fLCBzd2FwZmlsZSwgYmxvY2tzLCAwLAo+IFNXQVBGSUxFX0JZ
X0JMS1MpCj4KPiAjZGVmaW5lIFNBRkVfTUFLRV9TV0FQRklMRV9TSVpFKHN3YXBmaWxlLCBzaXpl
LCBzYWZlKSBcCj4gICAgIG1ha2Vfc3dhcGZpbGVfKF9fRklMRV9fLCBfX0xJTkVfXywgc3dhcGZp
bGUsIHNpemUsIDEsIFNXQVBGSUxFX0JZX1NJWkUpCj4KPiAjZGVmaW5lIFNBRkVfTUFLRV9TV0FQ
RklMRV9CTEtTKHN3YXBmaWxlLCBibG9ja3MsIHNhZmUpIFwKPiAgICAgbWFrZV9zd2FwZmlsZV8o
X19GSUxFX18sIF9fTElORV9fLCBzd2FwZmlsZSwgYmxvY2tzLCAxLAo+IFNXQVBGSUxFX0JZX0JM
S1MpCj4KCgpHb29kIHN1Z2dlc3Rpb25zLgoKCj4KPiA+ICAvKgo+ID4gICAqIENoZWNrIHN3YXBv
bi9zd2Fwb2ZmIHN1cHBvcnQgc3RhdHVzIG9mIGZpbGVzeXN0ZW1zIG9yIGZpbGVzCj4gPiBkaWZm
IC0tZ2l0IGEvbGlicy9saWJsdHBzd2FwL2xpYnN3YXAuYyBiL2xpYnMvbGlibHRwc3dhcC9saWJz
d2FwLmMKPiA+IGluZGV4IGEyNmVhMjVlNC4uMGUyNDc2ZWMyIDEwMDY0NAo+ID4gLS0tIGEvbGli
cy9saWJsdHBzd2FwL2xpYnN3YXAuYwo+ID4gKysrIGIvbGlicy9saWJsdHBzd2FwL2xpYnN3YXAu
Ywo+ID4gQEAgLTEzMywxOCArMTMzLDI2IEBAIG91dDoKPiA+ICAgICAgIHJldHVybiBjb250aWd1
b3VzOwo+ID4gIH0KPgo+ID4gLWludCBtYWtlX3N3YXBmaWxlKGNvbnN0IGNoYXIgKnN3YXBmaWxl
LCBpbnQgYmxvY2tzLCBpbnQgc2FmZSkKPiA+ICtpbnQgbWFrZV9zd2FwZmlsZShjb25zdCBjaGFy
ICpzd2FwZmlsZSwgdW5zaWduZWQgaW50IG51bSwgaW50IHNhZmUsCj4gZW51bSBzd2FwZmlsZV9t
ZXRob2QgbWV0aG9kKQo+ID4gIHsKPiA+ICAgICAgIHN0cnVjdCBzdGF0dmZzIGZzX2luZm87Cj4g
PiAgICAgICB1bnNpZ25lZCBsb25nIGJsa19zaXplLCBiczsKPiA+ICAgICAgIHNpemVfdCBwZ19z
aXplID0gc3lzY29uZihfU0NfUEFHRVNJWkUpOwo+ID4gICAgICAgY2hhciBtbnRfcGF0aFsxMDBd
Owo+ID4gKyAgICAgdW5zaWduZWQgaW50IGJsb2NrcyA9IDA7Cj4KPiA+ICAgICAgIGlmIChzdGF0
dmZzKCIuIiwgJmZzX2luZm8pID09IC0xKQo+ID4gICAgICAgICAgICAgICByZXR1cm4gLTE7Cj4K
PiA+ICAgICAgIGJsa19zaXplID0gZnNfaW5mby5mX2JzaXplOwo+Cj4gPiArICAgICBpZiAobWV0
aG9kID09IFNXQVBGSUxFX0JZX1NJWkUpCj4gPiArICAgICAgICAgICAgIGJsb2NrcyA9IG51bSAq
IDEwMjQgKiAxMDI0IC8gYmxrX3NpemU7Cj4gPiArICAgICBlbHNlIGlmIChtZXRob2QgPT0gU1dB
UEZJTEVfQllfQkxLUykKPiA+ICsgICAgICAgICAgICAgYmxvY2tzID0gbnVtOwo+ID4gKyAgICAg
ZWxzZQo+ID4gKyAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LLCAiSW52YWxpZCBtZXRob2QsIHBs
ZWFzZSBzZWUKPiBpbmNsdWRlL2xpYnN3YXAuaCIpOwo+Cj4gbml0OiBJIHdvdWxkIHByaW50IHRo
ZSBtZXRob2QuCj4KCisxCgoKPiBVc2luZyBjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGlu
ZW5vIGFuZCB0c3RfYnJrXygpIHdvdWxkIGhlbHAKPiBsYXRlciB0byBwb2ludCBvdXQgd2hpY2gg
ZmlsZSBhY3R1YWxseSBjb250YWlucyB3cm9uZyBtZXRob2QuCj4KClllcywgdGhhdCBzaG91bGQg
YmUgYmV0dGVyLiBUaGFua3MhCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
