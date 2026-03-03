Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98A1EC0480
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 09:55:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30FDC3DA1A8
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 10:55:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDB593D79FE
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 10:54:43 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9DCC720077E
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 10:54:42 +0100 (CET)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso240476866b.0
 for <ltp@lists.linux.it>; Tue, 03 Mar 2026 01:54:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772531682; cv=none;
 d=google.com; s=arc-20240605;
 b=ZyhHuGhPFUcC1k1SmCtFAs3k4HhDaUW2OdUEeRBZR6sLbIfjCD6b9+lMZgoAUsgvmt
 DB2xmesK+qCTGyPhKaMCwAptAEIHKDZVtR3u9WDPtFI4yl/tOylE/vN7CTWUEwZLW7yD
 iCGROFyXAd1AozXzFiNjtjzI38SvTBA4q7cy61LecAmXd8l5AH5DK2GjUFi37AujaLwW
 EiINkhP3ZFBDB5/x+m5IcmTibDc3yJB8u+BmVFg9OIJU1mXKnSX5OL+XptFFkTSee19m
 pT7rXifN38FwuvnQ9Qc6IDZQxLNsGm44QX8m1VTtwr3Bq/TgsSNLHDFxn9PQJEN/EQvp
 JApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N4Pid5S6lDHZQepxk/svzHt4RGZ1qnnMQYg9UKLAVYc=;
 fh=hDvSV2uRcKgInC2bAPuAcd8HaALA6jvoQEfxwzzsv1g=;
 b=HXoYJKM2wieIIGQqbJ9YAaI+ptXdQ/K1XKm5ZXrhXsgRwwu4MfDgqWqJYD/n2S12MT
 gN9ag9v4wkQeG9nIjnSoAF1N8dI4JN76AQFwbhK3M8/BGG1e6Okxi/C7OAlWj7l4hPwz
 Lg8fPQRF9fDCNQLsarBTNtcVINJ0Ws8CJn5aKQJyDEJj5F/7FHHmzT/tfqAaH8UndUpl
 HHkBelhDHJ67tbqT7KJ0vIpmX4ItQjgHAFGKconqKvKfAsB0kU9dVDyYdrnlSYDhhG4/
 Xv6t+AZ+MrLqiIBCD83cyMjxN3s3WFei2/teFDwrnkWZsAZUfKx00XVLxCnrlnarHJOD
 u+YQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772531682; x=1773136482; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4Pid5S6lDHZQepxk/svzHt4RGZ1qnnMQYg9UKLAVYc=;
 b=OHFUKCByMtpcoCL5dphn7ov479QuJOv7VNHfA0ZO5gBGhuTztgqzpf8dNTPGXjkZBz
 szUGwblPVOYfduVdo4kpWQJizoMe8y9SpeVC6VbOzaOcKuzf4k3kMl2Co1FlggOpcm+S
 6CsyZerVelNyJDE3o1tERguXFtE7dbQ3Ixcz8FmsvZ/9h04/1HTV7GrkjaTrbNe2vQBl
 zMQdHKU8rrL/WDGXPxPDpWox6ZQuafugUSY52a2xF/FTp9+tQjfogVx+5znSn3YupZd4
 1b+ITb8SDqpvQC57VO69HczQFIjP5QLT+OXVgr7Wsz3LbskX2SwEpb91FeK8pD7TNJ4/
 3hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772531682; x=1773136482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N4Pid5S6lDHZQepxk/svzHt4RGZ1qnnMQYg9UKLAVYc=;
 b=HqJyno9uiNzOilKAAFlebASDFUeEmJ9kdsIfMYp0FXuYALsy/TIcYrd0C1Yv79bXzn
 wcZHQMcmxbLgfSTOmrKa3SN1tkCsOcChz0S2FJ3yje8HWrKcEvDW3l4tb6GE2ZKRrzLv
 +fLEp19mocLh6IVE9jONVn0KujE7pDa35vBApYGGI4FysXJXWw0V4zPLzCspBXRKld6L
 2Z4ttwA5YcNTwuIQ+p8UwoCsh+RRIRbmFr0P0I06oG/gJAacf1UgpLi7vM+MnHfgTfXj
 EyYvlR4D4/FcDa+4fY/UNhcNwNBYDT0nYWTFuP3MFzFGVWElESVudDCCxOKZgs+CKVha
 XrAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4yOfPt215Vc3LHsTlRWN/klLZzpU6/radgKJxyaj2oNByjOj7z8IcWK3lXS+zfHFi5tA=@lists.linux.it
X-Gm-Message-State: AOJu0YyyjvOIbruA1CWFIxQ+AfYdnUp3rDmRDPz2mk92BnQJIacWrQRk
 c8DAY2VuyDNmw5fKqn2y8qJThsmXUHYv7dySY76E+v8J7ma1ZggZAh2LHZkeNVyc7XB3jPouIEa
 1Xi6iLlgBxxa6OgIvZIMlqQlfwPQoZ8k=
X-Gm-Gg: ATEYQzyHpoMWX7LdC24TihCyg0L+Hvu2WepgHHwondBkOXM18bg5MF9mPafdqYHCqLd
 fnJdWu2DXcfzvaZylooM2VDoidXQzjkCreltVulwrb47J+Y/MraUjgF1q6kl/4XfzCt6I7y7fd0
 35A7DmPH0t8xRA26Xgqbs5QQ7k+hCGm0IzwEcsRTKM3wY7p3w8SyUk2/zOz1aswNrXLk/W0B7wk
 grewevOBi1hiUmmomwGgh2DS+Z/wsTVNucis+K0koijRgW9jRty3q1733cKiqnJaTthu695hD4z
 BZYrWCnw3gzG6jBJdYvlMo12gjvvsY6aoc9lB3rP
X-Received: by 2002:a17:907:c24:b0:b8f:de69:b597 with SMTP id
 a640c23a62f3a-b93d429186amr120103666b.7.1772531681625; Tue, 03 Mar 2026
 01:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20260302144446.1291724-1-amir73il@gmail.com>
 <aaWvOIlfyIDH7J8A@yuki.lan>
 <CAOQ4uxhpcC76cpj21Dv-279FnVgHLSjCXmYKxu526jV-Uo7G_w@mail.gmail.com>
 <10488dc1-a369-4ad1-b26b-23118f6c9801@suse.cz>
In-Reply-To: <10488dc1-a369-4ad1-b26b-23118f6c9801@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 10:54:30 +0100
X-Gm-Features: AaiRm52w52IDCTxPbCirq6evzy2KCtbZj26DkEsMVRexnuOnZ07BQsw9XwRyHMs
Message-ID: <CAOQ4uxhqubq4wy8Y5TkOVgtU0VgTcztJnrbycVC=idO_-XbKww@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify25: fix test failure on kernel with
 CONFIG_MODULES=n
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

T24gVHVlLCBNYXIgMywgMjAyNiBhdCAxMDo0OeKAr0FNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cj4KPiBPbiAzLzIvMjYgMTg6MDcsIEFtaXIgR29sZHN0ZWluIHdyb3Rl
Ogo+ID4gT24gTW9uLCBNYXIgMiwgMjAyNiBhdCA0OjM54oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1
YmlzQHN1c2UuY3o+IHdyb3RlOgo+ID4+IElmIHBvc3NpYmxlIEkgd291bGQgbGlrZSB0byBhdm9p
ZCB3aGFjay1hLW1vbGUgZ2FtZSB0cnlpbmcgdG8gZmluZAo+ID4+IHNvbWV0aGluZyB0aGF0IGlz
IGNvbW1vbmx5IGVuYWJsZWQuCj4gPgo+ID4gRmVlbCBmcmVlIHRvIGNob29zZSBhbnkgb3RoZXIg
c3ltYm9sLgo+Cj4gSGksCj4gaG93IGFib3V0IG9vbV9raWxsX3Byb2Nlc3MoKT8gVGhhdCBvbmUn
cyB1bmNvbmRpdGlvbmFsbHkgYXZhaWxhYmxlIGFuZAo+IHNob3VsZG4ndCBnZXQgY2FsbGVkIHZl
cnkgb2Z0ZW4gaW4gYSByZWFzb25hYmxlIHRlc3QgZW52aXJvbm1lbnQgZWl0aGVyLgoKV2h5IGRv
ZXMgaXQgbWF0dGVyIGhvdyBtdWNoIHRoZSBmdW5jdGlvbiBnZXRzIGNhbGxlZD8KSXNuJ3QgdGhh
dCBpcnJlbGV2YW50IGZvciB0aGUgdGVzdD8KCj4KPiBJJ2xsIHByZXBhcmUgYSBwYXRjaCBhbmQg
Y2hlY2sgdGhhdCBpdCBzdGlsbCB0cmlnZ2VycyB0aGUgZXhwZWN0ZWQKPiBmYWlsdXJlcyBvbiBi
cm9rZW4ga2VybmVscy4KCkkgcmVhbGx5IHRoaW5rIHdlIGFyZSBvdmVyLXRoaW5raW5nIHRoaXMu
CgpUaGUgcHJvYmxlbSB3aXRoIGxvYWRfbW9kdWxlIHdhcyB0aGF0IHNvbWUgdGVzdCBzZXR1cCBj
b25maWdzCmRvIG5vdCBoYXZlIGl0IC0gdGhhdCdzIGFsbC4KClRoYW5rcywKQW1pci4KCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
