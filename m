Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3B9C3DA61
	for <ltp@archiver.kernel.org>; Fri, 19 Jul 2024 02:03:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 825623D1B29
	for <ltp@archiver.kernel.org>; Fri, 19 Jul 2024 04:03:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8DC83D0D45
 for <ltp@lists.linux.it>; Fri, 19 Jul 2024 04:03:18 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8C0BF1400973
 for <ltp@lists.linux.it>; Fri, 19 Jul 2024 04:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721354595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KGxIfTSbijqbJcPJnmrAVjlFu80gNSeY2LG3VTM8HI=;
 b=MX4ftIWkZuVagN/GLpvZMfWfzmt1JoZVOH7Bov0rk0OtrspJnQ+7tbk/+r8gVgwXkj+mE4
 jJz2Cy3UcEJ7GyN7Ftkejp9avMrJ4XXKe37yd38BbBjYS1OhoAcNZR1ZO+VTUxGq1KpPBY
 UQpkvFl9fQ2U9UvBv9i94GEM8PnuoqI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-ixJDx4aCMrKJDyg3UH2m9w-1; Thu, 18 Jul 2024 22:03:12 -0400
X-MC-Unique: ixJDx4aCMrKJDyg3UH2m9w-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7876e1a04faso1253840a12.3
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 19:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721354591; x=1721959391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/KGxIfTSbijqbJcPJnmrAVjlFu80gNSeY2LG3VTM8HI=;
 b=krlLG4H7t6k3/8du3dylH0j+aONsRIfx/oyCsk7O6/Q4iclvG3sb8Ve+Vmq0vtNJM0
 Kx6KoHoy/hdrPlu/ckfinAvXc1FgP3fanBxsqcy+Rz5km2aDiGikIsTaIGGOVo4fhpq+
 SEtyhBX/Wmpais51O0MLoViGlfb48hUR5aQrMvQjVP9XgTMip4i/TVi2rqenpAtqn4l6
 ETkWD3qaGZFz6+W7u3M1Ooqwktm32cukN9bUS6H3rIOXQ5/EhyrAnOXJtn7zvzXFqcGw
 TIPUtSatwANhwdS/uxytw0E8ZGDwayAF9EoCN995m9HbZywQH+0ki9PIBP4YT46OCEBU
 TZEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpCVB6HPmTzHL3RaWp72C3z4XFPC9US9WD2wG73ZHSLVrWRYVydxb2FkfJYFJjawWTxSbPvVXihW7/D14O4A6MzN8=
X-Gm-Message-State: AOJu0YwkkuRGP0jGy4d9EeqmBgrw1+1i9QCKFyNp8b2va56ZD1IZiKDX
 EgXbY6ZwY3WQUCn6ddf+khGfo8PWClWfHPSlneE1XceT3wJ98xwvv/JwrUvsZlgf0rRsO3k15HW
 q6UAl1ssxiwzLelrxUJF2/WhvYe9/qOM9I5XRSh7S3bOEF321EK47LkoN/2h+td9xltk/mZfFXz
 5MZAtsz5MY31Cq8ax+6/qKuno=
X-Received: by 2002:a05:6a20:244d:b0:1c0:f274:c54a with SMTP id
 adf61e73a8af0-1c3fdcfd655mr8594393637.28.1721354591022; 
 Thu, 18 Jul 2024 19:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR+Hox+s+J3LfgkIqoQzpstvJf+zvPTkjX/Bq+8LZoRZHKZFDF7xD//yXBPdyWHQ5x+bC04r5AVSoqqMdPp14=
X-Received: by 2002:a05:6a20:244d:b0:1c0:f274:c54a with SMTP id
 adf61e73a8af0-1c3fdcfd655mr8594368637.28.1721354590642; Thu, 18 Jul 2024
 19:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240705031502.9041-1-liwang@redhat.com> <ZpeBVwXDVbJwLFu7@rei>
 <d7014164-0d1f-4ab5-be80-042d4da5cca2@suse.cz> <ZpkytUBtKfJ1Dfkk@yuki>
 <8b7a2aae-49fe-4ca0-b178-aa7396e8ee4b@suse.cz>
In-Reply-To: <8b7a2aae-49fe-4ca0-b178-aa7396e8ee4b@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Jul 2024 10:02:58 +0800
Message-ID: <CAEemH2eWQayu8p+vVdQqpv02eciP0E9Jg_1ZPF9yv9PrAJaEvA@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] perf_event_open: improve the memory leak detection
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

SGkgTWFydGluLCBDeXJpbCwKCk9uIFRodSwgSnVsIDE4LCAyMDI0IGF0IDExOjI14oCvUE0gTWFy
dGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6PiB3cm90ZToKCj4gT24gMTguIDA3LiAyNCAxNzoy
MCwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+ID4+PiBNYXliZSB0aGlzIGNhbiByYXRoZXIgYmUgaWYg
KChzYW1wbGUgPiA1KSAmJiAoZGlmZl90b3RhbCA+IDEwMCAqIDEwMjQpKQo+ID4+Pgo+ID4+PiBU
aGF0IG1lYW5zIHRoYXQgdGhlIGF2YWlsYWJsZSBtZW1vcnkgaGFzIGJlZW4gZWF0ZW4gYnkgc29t
ZXRoaW5nIGFuZAo+ID4+PiB0aGF0IGl0IGhhcHBlbmVkIG1vcmUgb3IgbGVzcyBpbiBhIGxpbmVh
ciBmYXNoaW9uIHdoZW4gdGhlIHByb2dyYW0gd2FzCj4gPj4+IHJ1bm5pbmcuCj4gPj4KPiA+PiBJ
bWFnaW5lIHRoYXQgc29tZSBvdGhlciBwcm9jZXNzIHJlbGVhc2VzIDMwME1CIG9mIG1lbW9yeSB3
aGlsZSB0aGUgdGVzdAo+ID4+IGlzIHJ1bm5pbmcuIElmIHlvdSBjaGFuZ2UgdGhlIHx8IHRvICYm
LCB5b3UnbGwgZ2V0IGEgZmFsc2UgbmVnYXRpdmUgaW4KPiA+PiB0aGF0IGNhc2UuIFRoZSBzYW1w
bGluZyBhcHByb2FjaCB3aWxsIHByb3RlY3QgYWdhaW5zdCBzdWNoIGludGVyZmVyZW5jZS4KPiA+
Pgo+ID4+IFRoYXQgYmVpbmcgc2FpZCwgaWYgdGhlIGF2YWlsYWJsZSBtZW1vcnkgb24geW91ciB0
ZXN0IHN5c3RlbSBmbHVjdHVhdGVzCj4gPj4gYnkgMTAwK01CIGR1cmluZyBhIHRlc3QgcnVuIHRo
YXQgdGFrZXMgPDEwIHNlY29uZHMsIEknZCByZWNvbW1lbmQKPiA+PiBpbnZlc3RpZ2F0aW5nIHdo
YXQncyBjYXVzaW5nIHN1Y2ggZmx1Y3R1YXRpb24uIE9uIHRoZSB0ZXN0IG1hY2hpbmUgSQo+ID4+
IHVzZWQgdG8gdmVyaWZ5IHRoaXMgcGF0Y2gsIEkgY2FuIHNlZSA8MTBNQiBvZiBkaWZmZXJlbmNl
IGJlZm9yZSBhbmQKPiA+PiBhZnRlciBydW5uaW5nIHRoZSB0ZXN0IG9uIGEgZml4ZWQga2VybmVs
Lgo+ID4KPiA+IFNvIHNoYWxsIHdlIHJlbW92ZSB0aGUgZGlmZl90b3RhbCBjb21wbGV0ZWx5Pwo+
Cj4gTm8sIGRpZmZfdG90YWwgaXMgc3RpbGwgdXNlZnVsIGJlY2F1c2UgaXQgY2hlY2tzIGZvciBz
bWFsbGVyIGxlYWsgdGhhbgo+IHRoZSBzdW0gb2Ygc2FtcGxlcy4KPgoKVGhhbmtzIHNvIG11Y2gg
Zm9yIHlvdXIgY29uZmlybWF0aW9uIGFuZCB0ZXN0LgoKSSBwdXNoZWQgdGhlIHBhdGNoIHdpdGgg
aW1wcm92ZW1lbnRzIGFzIHlvdSBzdWdnZXN0ZWQuIExldCdzIHNlZSBob3cgaXQKZ29lcyBpbiBm
dXR1cmUgdGVzdHMuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
