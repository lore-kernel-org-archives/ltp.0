Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C7CC36010
	for <ltp@archiver.kernel.org>; Sun,  6 Apr 2025 02:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743907465; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=JqnsSwIJoYc/DjN+U+f0ri83j50DmwHmqPJ9YLgwe6c=;
 b=SbiWR//IAf6e5dBRRqJLzVV5q0k9TGFvetQzztqAPq3P5GNTrRv5vCD2NcBw3CD46Uv8e
 Tf0LlS0vB+g3DPktriLz/ltmNV1abZ0fDUY+GQbpteH8QN5rOeIfSqNhAGvry8X83FtGub3
 UwxETEJUnDUBNEFuxUboE4AnLa/0eNw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33FB83CB325
	for <ltp@archiver.kernel.org>; Sun,  6 Apr 2025 04:44:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C8953C9AB7
 for <ltp@lists.linux.it>; Sun,  6 Apr 2025 04:44:01 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CA667100040E
 for <ltp@lists.linux.it>; Sun,  6 Apr 2025 04:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743907437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KslQ8SxKLjkHlkdPy3w021mN1uIoWDfz3/4GSIAOwYg=;
 b=YCuAJHohV6ljFNlUyWE7svpCzDZXy8MC3WnWZmzxGBUDNxiJwQrlbT0LQylIF/rcX//Wja
 rKArzY1+mXFqqKlXgk2YGZM1H4/SfRh3sJio5dlGwDOifljFpwLJqmrgJVK2twsItaLvwj
 YQsWz7Lg0k4xvUixVw3ftzHnY6rSkRw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-VEjA1ivvNKSs1mxucohHmg-1; Sat, 05 Apr 2025 22:43:53 -0400
X-MC-Unique: VEjA1ivvNKSs1mxucohHmg-1
X-Mimecast-MFC-AGG-ID: VEjA1ivvNKSs1mxucohHmg_1743907432
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab397fff5a3so315770166b.1
 for <ltp@lists.linux.it>; Sat, 05 Apr 2025 19:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743907432; x=1744512232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KslQ8SxKLjkHlkdPy3w021mN1uIoWDfz3/4GSIAOwYg=;
 b=orqyPLjT+K2it0Y4j60bZrIxINZlgFVuy8o2EPSkUexu1OY2koY5zWTuQjquh6jQeU
 P5f0+dmY/7b7H9QaSMawzxZcdbI29BnxJ257MVX8LBhOC7pEe5XVi0JcLZVnRt2IGo/V
 a3tSnMEHoUkZ4ekSH/QDhH1Hg+DQl0uM1MdzjuQoYAex32gZ3cAFFHKSKpOx9MfhpWUL
 lo+598LYIMufxzoiWBpzlH8oP2ZimF5PXRBf2D7XynikneMaawukBPxrPkJl+5PtfMj+
 jNPlXynRg0Mie7v0xzR4H+vrLRpR80gpbceySiDLrjE8I2i0z2IbYO/mC3XGa6vQ62Iy
 Hg5g==
X-Gm-Message-State: AOJu0YyQsrkwQtT0kaHJ/bvhViNuQTIDqLc40B6lkyiRc7a/Ofaw7/sg
 tGL/BKMH5YeIugXmmO5O4oFOcBkx1cguuHtQT/Qf/xBHUWMlAjaM5yU2aADzKZm0kYgH8rfingT
 vetIMsoWtkhL1Lnh1WYoiRCnwbP8NCqIOUhnWMsU0Ho+InnwZNnW52u4drQiD0PANaDsVN4St7L
 gAZeboaXTQjFQVVCOCyZa0wzQ=
X-Gm-Gg: ASbGncs53AGFr4cENKv4UF5ZHYwrh9lkEHOPD/m7jyaoC91Iuqe3xudNrqLBQjznMLG
 9MQxFbMH9HCB6jkwK+DVmk0WtgY2/jNbIZcpnvaWGfxsapJO3ynJL6yc54l35yR9sAyxaneJF8Q
 ==
X-Received: by 2002:a17:907:1b08:b0:ac2:7ce7:cd2b with SMTP id
 a640c23a62f3a-ac7d2d860b1mr882575366b.2.1743907432104; 
 Sat, 05 Apr 2025 19:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3yA5fu8GylZA59FXNubyAOCqNLBA2SRUPbUJBlGDApDcT1Eq0oumxSGKsmtAqKGO9j2VC35SusFH0GAXQLn8=
X-Received: by 2002:a17:907:1b08:b0:ac2:7ce7:cd2b with SMTP id
 a640c23a62f3a-ac7d2d860b1mr882574466b.2.1743907431690; Sat, 05 Apr 2025
 19:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250403101912.459507-1-pvorel@suse.cz>
In-Reply-To: <20250403101912.459507-1-pvorel@suse.cz>
Date: Sun, 6 Apr 2025 10:43:38 +0800
X-Gm-Features: ATxdqUEa36gwYps77hcCB1LL91LiZwGFx5snzTXa8fFGFAqoTYunQeuqIPDIMEg
Message-ID: <CAEemH2cdbZH+xX9dPNqmuiq4VQ5H1p15hdGejYBajJBjvtJxNQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b8pJvFDTzFJPzwmqN0lS6mUpfQgDsYtt-n0QvyXbh6w_1743907432
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC][PATCH 0/2] Merge runtest files
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

T24gVGh1LCBBcHIgMywgMjAyNSBhdCA2OjE54oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSwKPgo+IGJlc2lkZXMgcnVudGVzdC9pcGMsIHRoZXJlIGFyZSBvdGhl
ciBzbWFsbCBydW50ZXN0IGZpbGVzLiAgSSBrbm93IHdlIGFyZQo+IHNsb3dseSB3b3JraW5nIHRv
d2FyZHMgcmVtb3ZpbmcgcnVudGVzdCBmaWxlcywgYnV0IHVudGlsIGl0IGhhcHBlbiB3ZQo+IG1p
Z2h0IHdhbnQgdG8gb3B0aW1pemUgKD0+IG1lcmdlKSBzbWFsbCBydW50ZXN0IGZpbGVzIGludG8g
b3RoZXJzLgo+CgpJIGFncmVlIHdpdGggb3B0aW1pemluZyB0aGUgcnVudGVzdCBmaWxlIHRvIG9y
Z2FuaXplIGNhc2VzIGJldHRlci4KU2luY2Ugd2Ugbm93IG1haW5seSByZWx5IG9uIHRoZSBydW50
ZXN0IGZpbGVzIHRvIHRyaWFnZSB0ZXN0IGNhdGVnb3JpZXMuCgoKCj4gV2l0aCB0aGlzIGNoYW5n
ZSB3ZSBoYXZlIGluIHRoZSBydW50ZXN0IGZpbGVzIChpZ25vcmluZyBjb21tZW50cyk6Cj4KPiAk
IGZvciBpIGluIHJ1bnRlc3QvKjsgZG8gZWNobyAiJChncmVwIC12ICcjJyAkaSB8IHdjIC1sKTog
JGkiOyBkb25lIHwgc29ydAo+IC1ybgo+Cj4KPiAkIHdjIC1sIHJ1bnRlc3QvKiB8IHNvcnQgLW5y
ICMgbm90IHRha2luZyBpbnRvIGFjY291bnQgdGhlIGNvbW1lbnRzCj4gMTgyMzogcnVudGVzdC9z
eXNjYWxscwo+IDM5MjogcnVudGVzdC9jb250cm9sbGVycwo+IDE0MDogcnVudGVzdC9zY3NpX2Rl
YnVnLnBhcnQxCj4gMTQwOiBydW50ZXN0L2x0cC1haW9kaW8ucGFydDEKPiAxMzc6IHJ1bnRlc3Qv
bmV0Lm5mcwo+IC4uLgo+IDk6IHJ1bnRlc3Qvd2F0Y2hxdWV1ZQo+IDk6IHJ1bnRlc3QvdHJhY2lu
Zwo+IDk6IHJ1bnRlc3QvaW1hCj4gNzogcnVudGVzdC9kbWFfdGhyZWFkX2Rpb3Rlc3QKPiA3OiBy
dW50ZXN0L2NwdWhvdHBsdWcKPiA2OiBydW50ZXN0L25ldC5pcHY2X2xpYgo+IDY6IHJ1bnRlc3Qv
aW5wdXQKPiA2OiBydW50ZXN0L2NhcGFiaWxpdHkKPiA1OiBydW50ZXN0L3Bvd2VyX21hbmFnZW1l
bnRfdGVzdHNfZXhjbHVzaXZlCj4gNTogcnVudGVzdC9wb3dlcl9tYW5hZ2VtZW50X3Rlc3RzCj4g
NTogcnVudGVzdC9rdm0KPiA0OiBydW50ZXN0L25ldC5tdWx0aWNhc3QKPiAzOiBydW50ZXN0L3Vl
dmVudAo+IDM6IHJ1bnRlc3QvaHlwZXJ0aHJlYWRpbmcKPiAzOiBydW50ZXN0L2NyYXNobWUKPiAz
OiBydW50ZXN0L2Nhbgo+IDI6IHJ1bnRlc3QvbnB0bAo+IDE6IHJ1bnRlc3QvczM5MHhfdGVzdHMK
PiAxOiBydW50ZXN0L2lycQo+IDE6IHJ1bnRlc3QvZmNudGwtbG9ja3Rlc3RzCj4gMDogcnVudGVz
dC9zdGFnaW5nCj4KPiBJIHdvdWxkIHN1Z2dlc3QgdG86Cj4KPiAqIG1vdmUgcnVudGVzdC9jYW4g
dG8gcnVudGVzdC9rZXJuZWxfbWlzYyAoYmV0dGVyCj4gbmFtZSB3b3VsZCBiZSBrZXJuZWxfZHJp
dmVycywgYnV0IEkgZG9uJ3Qgd2FudCB0byBkbyByZW5hbWVzLCBldmVuCj4gbWVyZ2luZyBydW50
ZXN0IGZpbGVzIHdpbGwgZGlzdHVyYiBmb2xrcyB0ZXN0aW5nIHdpdGggTFRQLgo+Cj4gKiBtb3Zl
IHJ1bnRlc3QvZmNudGwtbG9ja3Rlc3RzIHRvIHJ1bnRlc3QvbmV0Lm5mcy4KPgo+ICogcnVudGVz
dC9ucHRsIGlzIE5QVEwgdGVzdCBmb3IgcHRocmVhZF9jb25kX3RpbWVkd2FpdCgpLCBjYW4gdGhp
cyBiZQo+ICAgbW92ZWQgdG8gcnVudGVzdC9zY2hlZD8gKHRoZXJlIGFyZSBvdGhlciBwdGhyZWFk
XyogdGVzdHMpLiBOb3Qgc3VyZSBpZgo+ICAgdGVzdHMgYXJlIHJlbGV2YW50IG5vdy4KPgo+ICog
cnVudGVzdC9pcnEgT2J2aW91c2x5IHdlIHdvdWxkIG5lZWQgbW9yZSBJUlEgdGVzdHMgKElNSE8g
bm9uZSBldmVuIGluCj4gICBrc2VsZnRlc3QpCj4KPiBJIHdvbmRlciBpZiBydW50ZXN0L2RtYV90
aHJlYWRfZGlvdGVzdC4gcnVudGVzdC9jcmFzaG1lLAo+IHJ1bnRlc3QvcG93ZXJfbWFuYWdlbWVu
dF90ZXN0cyBhbmQgcnVudGVzdC9wb3dlcl9tYW5hZ2VtZW50X3Rlc3RzX2V4Y2x1c2l2ZQo+IGFy
ZSBzdGlsbCByZWxldmFudCBvciB0aGF0IG11Y2ggb3V0ZGF0ZWQsIHRoYXQgaXQgc2hvdWxkIGJl
IHJlbW92ZWQuCj4KPiBJIHRoaW5rIHZtY3BfbS5zaCAodGhlIG9ubHkgb25lIGluIHJ1bnRlc3Qv
czM5MHhfdGVzdHMpIHNob3VsZCBiZSByZW1vdmVkLgo+Cj4gT3RoZXIgc2hvdWxkIHByb2JhYmx5
IGJlIGtlcHQgc2VwYXJhdGUuCj4KPiBydW50ZXN0L3N0YWdpbmcgaXMgZXhwZWN0ZWQgdG8gYmUg
b2Z0ZW4gMC4KPgoKU291bmRzIGdvb2QgdG8gbWUsIGFib3ZlLgoKLS0gClJlZ2FyZHMsCkxpIFdh
bmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
