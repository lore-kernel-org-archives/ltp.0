Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17836C3DA6D
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 06:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747981383; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ujPj0ak59DY9V0kV6qN/Y6j2m3BLzJQS69gj3xu99KA=;
 b=h0J1M/vD0M0OsHpT3QhPTTSpucyRqGzQ+4OyOkEUa3Lo37cLcaCOOPGCZtc9IemmeF1tX
 WbCwGzonk34Bcdz12i18lAtza8XpK0X0YVctSXXiRFBzYvG5v/bWAwYHIIKYxxRetp+nDBD
 D+y+9mbCEaQJmo1PP2ufSw5EgKGZI7k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 752DA3CC8C0
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 08:23:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C106D3C0E44
 for <ltp@lists.linux.it>; Fri, 23 May 2025 08:22:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7153660096C
 for <ltp@lists.linux.it>; Fri, 23 May 2025 08:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747981358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfQ4Ixn9JKOQ/EPw7P0ZOBlg2YJW92dggW1TOo7TMY0=;
 b=OTF89r8W0ARuvv7LwFi81JrqvNtKBb/SC/ceS+JthpbuqtZi0fvNBZu6+MZHSwREEbjJE+
 2kOGQjKpHz4nAyns9bNKothpI5bUz25+49CDtiawU9nxmHAvQA08OfhDigf8m5tOvuRV0r
 WE1/tZSoI62VWug07sCkcibsqm2Ysd4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-732wLUtCMOyr2VgjLN-sfw-1; Fri, 23 May 2025 02:22:37 -0400
X-MC-Unique: 732wLUtCMOyr2VgjLN-sfw-1
X-Mimecast-MFC-AGG-ID: 732wLUtCMOyr2VgjLN-sfw_1747981356
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43eed325461so52728175e9.3
 for <ltp@lists.linux.it>; Thu, 22 May 2025 23:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747981356; x=1748586156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfQ4Ixn9JKOQ/EPw7P0ZOBlg2YJW92dggW1TOo7TMY0=;
 b=ceGzl/ibjhiViAU0Ohl4yoab0RrnYcruWJemWIETmqnc1qQkvv8gVHlklcUgDp0yKx
 DvXMgPBav6McZsvUimyqP45QkplCxoOLQke36+0OS/9Zz9vJ4fg71BQBkh9igwbE0Uy6
 MSFVg2n7xYS6ZuXlDqrSirnZ2yJAvzJFl41M3DXBO+ASL6HBFpvH0ddJIiYzOyTBpQ2x
 zt1AyC9SxQJVcou4mYfmpp3wtyIpigcS9QnEA+oTBj3owQM9X+6WK8zM3lsmLsXpEbv7
 6XjPKvH+EzN2MOHBk4mTbsVqXbNNdUWzhg4hirvW4Xp3AitIck039LXeZtiYd44DLuCK
 V+6g==
X-Gm-Message-State: AOJu0YxSytG5udOLsTo0wtgynCpvJpKiOoOKyGDFRKVN/GX14/6qMfom
 +8ouIWzdzERbslZ0ABU2yD0o/Z236vfGlA1XvJRNmqHv5bNpx7InQtxd7rGnsW3X6CzvR7zOjQH
 uD7vOiVy5tawAIpBVWIq5ngtJYXjTCYJc06PWiz6QgWWW5fSm1M/LZBRuzP9s6Qe3vredsY5d/V
 gdI8oXUc1JtHiYksNwIgQKL/xuPzVaL3h06Yg=
X-Gm-Gg: ASbGnctQ8231XuAJ/bWoeexauDb0u0JTaFH9Somy9s16uTwpsARLEb0gAlKgPIZiJHU
 T6U4qMHi3xfUML2i77lHYA5L6Ewm0ZN2mmdHFVJvliqtfGG+HI5wmAE6VWezZi0uFJQ==
X-Received: by 2002:a05:6000:401f:b0:391:4ca:490 with SMTP id
 ffacd0b85a97d-3a35fe951d1mr24032019f8f.29.1747981355925; 
 Thu, 22 May 2025 23:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEibS3ghtBYhV78raeLJ1V4Kn87EkeMETG62+uDTDsURscdIO4H1Dl84ApgETc89U2B6URhLb9ZK3FwC2ofvYs=
X-Received: by 2002:a05:6000:401f:b0:391:4ca:490 with SMTP id
 ffacd0b85a97d-3a35fe951d1mr24032007f8f.29.1747981355616; Thu, 22 May 2025
 23:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250522152118.35942-1-japo@linux.ibm.com>
In-Reply-To: <20250522152118.35942-1-japo@linux.ibm.com>
Date: Fri, 23 May 2025 08:22:18 +0200
X-Gm-Features: AX0GCFvH5J7NWI2tjWI_aulGEl1_KtxGRwjFib8N4usPc93hgDi9WTSXIDZ1eJ0
Message-ID: <CAASaF6xHGq-NaHsNpzUOTYCFXyw=i-2PUYQgekgoW2K3vO7XRg@mail.gmail.com>
To: Jan Polensky <japo@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7VxLnoL-mVeonQXYFsLZDPDO8CvrG1escHkHSlRQgKQ_1747981356
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] overcommit_memory: Disable optimization
 for malloc to prevent false positives
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXkgMjIsIDIwMjUgYXQgNToyMeKAr1BNIEphbiBQb2xlbnNreSA8amFwb0BsaW51
eC5pYm0uY29tPiB3cm90ZToKPgo+IFdoZW4gY29tcGlsaW5nIHdpdGggR0NDIDE1LjEuMSssIHRo
ZSBkZWZhdWx0LWVuYWJsZWQgLWZtYWxsb2MtZGNlPTIgYW5kCj4gLWZhbGxvY2F0aW9uLWRjZSB1
bmRlciAtTzIgY2FuIGVsaW1pbmF0ZSB0aGUgZW50aXJlIG1hbGxvYyBibG9jayBiZWNhdXNlIGl0
cwo+IHJlc3VsdCBpcyBvbmx5IGNvbXBhcmVkIHRvIE5VTEwgYW5kL29yIHBhc3NlZCB0byBmcmVl
KCkuCj4KPiBUaGlzIGxlYWRzIHRvIGZhbHNlIHBvc2l0aXZlcyBpbiB0ZXN0cyB0aGF0IGV4cGVj
dCBtYWxsb2MoKSB0byBmYWlsIHVuZGVyIG1lbW9yeQo+IHByZXNzdXJlLCBhcyB0aGUgYWxsb2Nh
dGlvbiBpcyBvcHRpbWl6ZWQgYXdheS4KPgo+IERpc2FibGUgdGhpcyBvcHRpbWl6YXRpb24gZm9y
IHRoZSBhZmZlY3RlZCBmdW5jdGlvbiB0byBwcmVzZXJ2ZSB0aGUgaW50ZW5kZWQKPiB0ZXN0IGJl
aGF2aW9yLgo+Cj4gUmVmZXJlbmNlczogaHR0cHM6Ly9nY2MuZ251Lm9yZy9vbmxpbmVkb2NzL2dj
Yy0xNS4xLjAvZ2NjL09wdGltaXplLU9wdGlvbnMuaHRtbAo+IFNpZ25lZC1vZmYtYnk6IEphbiBQ
b2xlbnNreSA8amFwb0BsaW51eC5pYm0uY29tPgoKUHVzaGVkLgoKVGhhbmtzLApKYW4KCj4gLS0t
Cj4gQ2hhbmdlcyBzaW5jZSB2MSAodGhhbmtzIHRvIEN5cmlsIEhydWJpcyk6Cj4gLSBVc2UgTFRQ
X1ZBUl9VU0VEIG1hY3JvIHRvIHByZXZlbnQgR0NDIGZyb20gb3B0aW1pemluZyBhd2F5IG1hbGxv
YygpLgo+Cj4gIHRlc3RjYXNlcy9rZXJuZWwvbWVtL3R1bmFibGUvb3ZlcmNvbW1pdF9tZW1vcnku
YyB8IDMgKystCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS90dW5hYmxlL292ZXJjb21t
aXRfbWVtb3J5LmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS90dW5hYmxlL292ZXJjb21taXRfbWVt
b3J5LmMKPiBpbmRleCBiNWJlZWJiY2QzYzQuLjliMmNiNDc5ZDVlZSAxMDA2NDQKPiAtLS0gYS90
ZXN0Y2FzZXMva2VybmVsL21lbS90dW5hYmxlL292ZXJjb21taXRfbWVtb3J5LmMKPiArKysgYi90
ZXN0Y2FzZXMva2VybmVsL21lbS90dW5hYmxlL292ZXJjb21taXRfbWVtb3J5LmMKPiBAQCAtNjIs
NiArNjIsNyBAQAo+ICAjaW5jbHVkZSA8c3RkaW8uaD4KPiAgI2luY2x1ZGUgPHN0ZGxpYi5oPgo+
ICAjaW5jbHVkZSA8bGltaXRzLmg+Cj4gKyNpbmNsdWRlICJ0c3RfY29tbW9uLmgiCj4gICNpbmNs
dWRlICJ0c3RfdGVzdC5oIgo+Cj4gICNkZWZpbmUgREVGQVVMVF9PVkVSX1JBVElPICAgICA1MEwK
PiBAQCAtMTU1LDcgKzE1Niw3IEBAIHN0YXRpYyBpbnQgaGVhdnlfbWFsbG9jKGxvbmcgc2l6ZSkK
PiAgewo+ICAgICAgICAgY2hhciAqcDsKPgo+IC0gICAgICAgcCA9IG1hbGxvYyhzaXplICogVFNU
X0tCKTsKPiArICAgICAgIExUUF9WQVJfVVNFRChwKSA9IG1hbGxvYyhzaXplICogVFNUX0tCKTsK
PiAgICAgICAgIGlmIChwICE9IE5VTEwpIHsKPiAgICAgICAgICAgICAgICAgdHN0X3JlcyhUSU5G
TywgIm1hbGxvYyAlbGQga0Igc3VjY2Vzc2Z1bGx5Iiwgc2l6ZSk7Cj4gICAgICAgICAgICAgICAg
IGZyZWUocCk7Cj4gLS0KPiAyLjQ5LjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
