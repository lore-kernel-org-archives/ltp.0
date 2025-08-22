Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1923FCA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 07:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755847776; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nTEk6QXHkEvuP72c9sF+kCH592l57EQ2ZY6aV1RQW7c=;
 b=c8nA6QUAskowYFP99ilZK1Iy6efbbsHyvyyw1sfUte/Y2sXMlu+2w2w7hVc8w8Mtz9Cng
 C+jhyypJIoDufywROUxAoklQSQDDKp34KEETilFTlhRvSehV60KA9kArD8yGQHqVqz9WRkv
 Vltactwrbrg7VWGz7QpfpGhsKYWs+CM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8544B3CCD3B
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 09:29:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C15B3CCCE7
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 09:29:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A2DAF60013A
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 09:29:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755847752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V0N7gkpOpU8zKFmaiPYTfroZGQodOeHODzN6r5IxtYc=;
 b=JhE3BbioOOReY/mXccHRbh1qtpfK1RE6H02lmRXadGQT6AT0SailzkaYqBi0MgA65dkI+V
 q/bIJ/TQwPc2SCX1qkRVs1ZWfUjfQ+gX4I7dpLhWWBR0Aacc46X1wFLlCU1j2Dyhc1zRvk
 Vs0GyfI343k3MQ3Kr5ylNcUmzjvz+iY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-WnTcf5qoM56_WMXX0hBQUg-1; Fri, 22 Aug 2025 03:29:10 -0400
X-MC-Unique: WnTcf5qoM56_WMXX0hBQUg-1
X-Mimecast-MFC-AGG-ID: WnTcf5qoM56_WMXX0hBQUg_1755847749
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24458264c5aso21302205ad.3
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 00:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755847748; x=1756452548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V0N7gkpOpU8zKFmaiPYTfroZGQodOeHODzN6r5IxtYc=;
 b=YDdo7lpUtmXBHexg0TnC9v553fbP9xyeY8lHeYTttMXa3irsaV6AKQLvlanK+IScso
 dWU/Qu4qCpLTyRNR4eWFZNeKOcV3m9ADEHJJxg6bT1olepRYTMx4h8F2XV4/vFg93WGX
 YT/0BjxBQH2JsYhdPrq+8HihWNlXA+JzcatlxQMCWM/S2NtbFRtr4Zq8JjQNJiQf57KB
 timH/UMqL4mPZPlMJREXkNhEyNGsTCjaU+hrr0RWDqn4iSUYd3Ot5Nm1BdmjSqDTcMWt
 qGv8y3nojHW0eIu1Jnt2F8FvJmlkGVKrdoNMY85pMHmAsLajD5nrKnCumFL4idm8/d8B
 bLhg==
X-Gm-Message-State: AOJu0Yw4wagqjlRktxhQDKKCeS8lRq9hQGWFHcdr8ftIDYcgKpEaGuJE
 XHienu8/9WhXVejEso7Le8FokjhvZQI59nEs98g9ikv1E/C9PWu0f7tH38c4ejXZu0mvUU613fe
 xGiiAA3gCTWLEl6T6lLwsKPXurK0VJqV87VIja9/+GCjVkiB9vY5MyjsEM8Qf0gImUI33tOrpbN
 ttwaPOVBghTH7BbdDrVaK5SfBXWodHDP1LHTbJmG3D
X-Gm-Gg: ASbGncs/bRXDmtH+DxWITY84W61iLJGKbYc4Cr6h4x2cIfE3g94Gav3JGW+QFk89B4b
 FF42BlsINdpCFFD0TWp+S8AD0268ozRso2nPcKoi7fZwQfVlpw71WzHJmXPq8oS0O3mLkWM0JnX
 n1+PXSH/Ihp05AR4kxqDWH/Q==
X-Received: by 2002:a17:902:d486:b0:23f:cd6e:8d0f with SMTP id
 d9443c01a7336-2462ee1a473mr24686685ad.13.1755847747854; 
 Fri, 22 Aug 2025 00:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEegNJDxtX0TTtgL78jdy6aWpAqNXfcijpg27xRjSdGdU5vLO6DCegxeH6yeJVpRXtgv4WyQY4jaWJr5h2rFgI=
X-Received: by 2002:a17:902:d486:b0:23f:cd6e:8d0f with SMTP id
 d9443c01a7336-2462ee1a473mr24686465ad.13.1755847747432; Fri, 22 Aug 2025
 00:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250822072204.2191382-1-liwang@redhat.com>
 <20250822072204.2191382-2-liwang@redhat.com>
In-Reply-To: <20250822072204.2191382-2-liwang@redhat.com>
Date: Fri, 22 Aug 2025 15:28:55 +0800
X-Gm-Features: Ac12FXz5mf6IV4-LSx6s7yZoWHe30yeRIvnlx9D6tAmfnY4zV8xyZwjBPQKhG-4
Message-ID: <CAEemH2fM4vHRdgHh62krquK5CFuHvpKdJtj--S6Vvt_i0xRBFw@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7QlSvWxY5hLAiN1YGEql5XNMYRlK6VOdUfFHt2OyEhY_1755847749
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] mount05: check if mount path exist before
 tst_is_mounted
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMjIsIDIwMjUgYXQgMzoyNOKAr1BNIExpIFdhbmcgdmlhIGx0cCA8bHRwQGxp
c3RzLmxpbnV4Lml0PiB3cm90ZToKCj4gdHN0X2lzX21vdW50ZWQoKSBub3cgaW50ZXJuYWxseSBy
ZXNvbHZlcyB0aGUgbW91bnQgcGF0aCB2aWEgcmVhbHBhdGgoKSwKPgoKCj4gd2hpY2ggd2lsbCBm
YWlsIGlmIHRoZSBwYXRoIGRvZXMgbm90IGV4aXN0LiBJbiBtb3VudDA1LCBNTlRQT0lOVDIgbWF5
Cj4gbm90IGFsd2F5cyBiZSBjcmVhdGVkIGR1cmluZyB0aGUgdGVzdCBmbG93LCBzbyBjYWxsaW5n
IHRzdF9pc19tb3VudGVkKCkKPgoKVGhpcyBsaW5lIHdhcyBmb3Jnb3R0ZW4gdG8gYW1lbmQgaW4g
bXkgZ2l0IGxvZzoKCiJJbiBtb3VudDA1LCBNTlRQT0lOVDIgbWF5IG5vdCBleGlzdCB5ZXQgZHVy
aW5nIGNsZWFudXAuICIKCmRpcmVjdGx5IGNvdWxkIHByb2R1Y2UgbWlzbGVhZGluZyB3YXJuaW5n
cyBvciBlcnJvcnMuCj4KPiBBZGQgYW4gZXhwbGljaXQgYWNjZXNzKE1OVFBPSU5UMiwgRl9PSykg
Y2hlY2sgYmVmb3JlIGNhbGxpbmcKPiB0c3RfaXNfbW91bnRlZCgpLCBlbnN1cmluZyB3ZSBvbmx5
IHF1ZXJ5IG1vdW50cyBmb3IgZXhpc3RpbmcgcGF0aHMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBMaSBX
YW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9tb3VudC9tb3VudDA1LmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvbW91bnQvbW91bnQwNS5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21v
dW50MDUuYwo+IGluZGV4IDY2ZTEwMmEzMi4uNTU4NWUyMzBlIDEwMDY0NAo+IC0tLSBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwNS5jCj4gKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9tb3VudC9tb3VudDA1LmMKPiBAQCAtMzUsNyArMzUsNyBAQCBzdGF0aWMg
dm9pZCBjbGVhbnVwKHZvaWQpCj4gICAgICAgICBpZiAodHN0X2lzX21vdW50ZWQoTU5UUE9JTlQx
KSkKPiAgICAgICAgICAgICAgICAgU0FGRV9VTU9VTlQoTU5UUE9JTlQxKTsKPgo+IC0gICAgICAg
aWYgKHRzdF9pc19tb3VudGVkKE1OVFBPSU5UMikpCj4gKyAgICAgICBpZiAoIWFjY2VzcyhNTlRQ
T0lOVDIsIEZfT0spICYmIHRzdF9pc19tb3VudGVkKE1OVFBPSU5UMikpCj4gICAgICAgICAgICAg
ICAgIFNBRkVfVU1PVU5UKE1OVFBPSU5UMik7Cj4gIH0KPgo+IC0tCj4gMi40OS4wCj4KPgo+IC0t
Cj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
