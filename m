Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655D7C10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 12:18:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA0413CDB74
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 14:18:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 777F83C068B
 for <ltp@lists.linux.it>; Tue,  7 May 2024 14:17:47 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 56F401000DE6
 for <ltp@lists.linux.it>; Tue,  7 May 2024 14:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715084264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCcGwem4fu562iv8nato4RasxM+Yx616J1OQnw6fh9s=;
 b=Pz591lrY5dTSC/MaJdZEvVyW9Y3Umj9gmppfI55VGmKiHIwdtyt8tQPUkXb/Vvpmd8OzO3
 KqiQn1qj1Be1tu9N+I9eB5VxSzYRQKaj25bk14ZWif/BiMp0nQGg0YXb63q3izIwqCxLKw
 FUXt/ECqfalzV7etOC1AOb5OWeieJFw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-hONXOO3TPUK7bWR64Z3Ryw-1; Tue, 07 May 2024 08:17:42 -0400
X-MC-Unique: hONXOO3TPUK7bWR64Z3Ryw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2b4330e5119so2589245a91.3
 for <ltp@lists.linux.it>; Tue, 07 May 2024 05:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715084262; x=1715689062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCcGwem4fu562iv8nato4RasxM+Yx616J1OQnw6fh9s=;
 b=WwiuRYwzB+7pLW503RlRyKPbdWbX3YgUPp23aMS6DPE6G48mrVwLKzarAdsoGjvGPO
 qbE0YS9qHrYQwuPd6cAxXgRy1mwx/46+RudNUIWYTqxiW4prlbbP0ZhmWKWuElFfiqWF
 A0jRLGcOJGPjOM/1xeHAaeBImZuRa66w3rz1ptJUAYt5zU05O8aYaRH6gnw+pLKVwiId
 5v81KCXC0Okme5I8s07Y2rcKVnAMr2ADe0Vb9mBbnwCwD6p6OqKL+ZCbH3StUysc0z7W
 irIL7j0B4XhtB4NpLhcmU1sMjghljLk7NDDO7yKS4yt4TO1yILxTJwCHBwLOqUr4FYO4
 WuzQ==
X-Gm-Message-State: AOJu0Yz2Jcp/50o2RSvv97768YeRd31tXKVPvOaUkKX//XyzBa5Y2qbD
 hVtvMpstTl5S9luzuQ2e/sWJEuuyqTA2nYlpBESlYj/SRQpoNdwFUuASyW47ZlmfHy5IDxVL5lz
 J8w3kPxGyA3hPSv8Kh4U8lBioTgwwyvGvgy05D5Ui3RntkBHgQtzPT26UbvGhY+rGa1ZT+RUP8o
 3CSXnhIWVQV4xh9Ns/DNQdnKA=
X-Received: by 2002:a17:90b:1889:b0:2b2:88f7:1f7f with SMTP id
 mn9-20020a17090b188900b002b288f71f7fmr10832500pjb.10.1715084260618; 
 Tue, 07 May 2024 05:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwQq3XiQxPcaO3RAJoDZMTTxaqu0jrU/X5CuAW5cQuoV3oBVyT+UVgHPbXn1D/ZYi5wXnncQhahRr94qAymMg=
X-Received: by 2002:a17:90b:1889:b0:2b2:88f7:1f7f with SMTP id
 mn9-20020a17090b188900b002b288f71f7fmr10832479pjb.10.1715084260144; Tue, 07
 May 2024 05:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240507095859.20802-1-chrubis@suse.cz>
 <CAEemH2cZ1bsBRGWrVXjRT3+b8i_M3dn=99yjRfs8=WHzQ9OkAA@mail.gmail.com>
In-Reply-To: <CAEemH2cZ1bsBRGWrVXjRT3+b8i_M3dn=99yjRfs8=WHzQ9OkAA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 May 2024 20:17:27 +0800
Message-ID: <CAEemH2e3EFdwSwwNe=yroKw++Ux=TFBdKGuHOgQN1BHpP_o8og@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] testcases: realtime: Get rid of autotools
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
Cc: John Stultz <jstultz@google.com>, kernel-team@android.com,
 Darren Hart <darren@os.amperecomputing.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXkgNywgMjAyNCBhdCA4OjEx4oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKPgo+IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKPgo+
IFRoZSBhdXRvdG9vbHMgY2hlY2tzIGFyZSBvdXRkYXRlZCBhbmQgbm90IG5lZWRlZCBhbnltb3Jl
Lgo+Pgo+PiAodW50ZXN0ZWQgYnV0IHNob3VsZCB3b3JrIGZpbmUpCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+PiAtLS0KPj4gIHRlc3RjYXNlcy9y
ZWFsdGltZS9NYWtlZmlsZSAgICAgICAgICAgIHwgNjQgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPj4gIHRlc3RjYXNlcy9yZWFsdGltZS9jb25maWd1cmUuYWMgICAgICAgIHwgNDIgLS0tLS0t
LS0tLS0tLS0tLS0KPj4gIHRlc3RjYXNlcy9yZWFsdGltZS9pbmNsdWRlL2xpYnJ0dGVzdC5oIHwg
IDkgKy0tLQo+PiAgdGVzdGNhc2VzL3JlYWx0aW1lL2xpYi9saWJzdGF0cy5jICAgICAgfCAgNiAt
LS0KPj4gIHRlc3RjYXNlcy9yZWFsdGltZS9tNC8uZ2l0aWdub3JlICAgICAgIHwgIDEgLQo+PiAg
dGVzdGNhc2VzL3JlYWx0aW1lL200L0dOVW1ha2VmaWxlICAgICAgfCAzNyAtLS0tLS0tLS0tLS0t
LS0KPj4gIHRlc3RjYXNlcy9yZWFsdGltZS9tNC9NYWtlZmlsZS5hbSAgICAgIHwgIDEgLQo+PiAg
dGVzdGNhc2VzL3JlYWx0aW1lL200L2NoZWNrLm00ICAgICAgICAgfCAxNCAtLS0tLS0KPj4gIDgg
ZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxNzIgZGVsZXRpb25zKC0pCj4+ICBkZWxl
dGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL3JlYWx0aW1lL2NvbmZpZ3VyZS5hYwo+PiAgZGVsZXRl
IG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9yZWFsdGltZS9tNC8uZ2l0aWdub3JlCj4+ICBkZWxldGUg
bW9kZSAxMDA2NDQgdGVzdGNhc2VzL3JlYWx0aW1lL200L0dOVW1ha2VmaWxlCj4+ICBkZWxldGUg
bW9kZSAxMDA2NDQgdGVzdGNhc2VzL3JlYWx0aW1lL200L01ha2VmaWxlLmFtCj4+ICBkZWxldGUg
bW9kZSAxMDA2NDQgdGVzdGNhc2VzL3JlYWx0aW1lL200L2NoZWNrLm00Cj4+Cj4KPiBTZWVtcyB3
ZSBoYXZlIHRvIHJlbW92ZSB0aGUgcmVsYXRlZCBsaW5lIGluIGF1dG9tYWtlLm1rIGFzIHdlbGws
Cj4gb3RoZXJ3aXNlIGJ1aWxkIGJyb2tlbiBpbiAnbWFrZSAtQyB0ZXN0Y2FzZXMvcmVhbHRpbWUg
YXV0b3Rvb2xzJy4KPgo+IC0tLSBhL2luY2x1ZGUvbWsvYXV0b21ha2UubWsKPiArKysgYi9pbmNs
dWRlL21rL2F1dG9tYWtlLm1rCj4gQEAgLTI3LDcgKzI3LDYgQEAgQVVUT0hFQURFUiAgICA/PSBh
dXRvaGVhZGVyCj4gIEFVVE9NQUtFICAgICAgID89IGF1dG9tYWtlCj4KPiAgQVVUT0NPTkZFRF9T
VUJESVJTICAgICA9IFwKPiAtICAgICAgICAgICAgICAgICAgICAgICB0ZXN0Y2FzZXMvcmVhbHRp
bWUgXAo+ICAgICAgICAgICAgICAgICAgICAgICAgIHRlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3Rz
dWl0ZQo+CgoKQWgsIGluY2x1ZGVzIG1vcmUgbGluZXMgcmVsYXRlZCBiZWxvdzoKCi0tLSBhL2lu
Y2x1ZGUvbWsvYXV0b21ha2UubWsKKysrIGIvaW5jbHVkZS9tay9hdXRvbWFrZS5tawpAQCAtMjcs
MTUgKzI3LDEwIEBAIEFVVE9IRUFERVIgID89IGF1dG9oZWFkZXIKIEFVVE9NQUtFICAgICAgID89
IGF1dG9tYWtlCgogQVVUT0NPTkZFRF9TVUJESVJTICAgICA9IFwKLSAgICAgICAgICAgICAgICAg
ICAgICAgdGVzdGNhc2VzL3JlYWx0aW1lIFwKICAgICAgICAgICAgICAgICAgICAgICAgdGVzdGNh
c2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlCgogIyBXZSB3YW50IHRvIHJ1biB0aGlzIGV2ZXJ5IHNp
bmdsZSB0aW1lIHRvIGVuc3VyZSB0aGF0IGFsbCBvZiB0aGUgcHJlcmVxCmZpbGVzCiAjIGFyZSB0
aGVyZS4KLS5QSE9OWTogdGVzdGNhc2VzL3JlYWx0aW1lL2NvbmZpZ3VyZQotdGVzdGNhc2VzL3Jl
YWx0aW1lL2NvbmZpZ3VyZToKLSAgICAgICAkKE1BS0UpIC1DICQoQEQpIGF1dG90b29scwotCiAu
UEhPTlk6IHRlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25maWd1cmUKIHRlc3RjYXNl
cy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25maWd1cmU6CiAgICAgICAgJChNQUtFKSAtQyAkKEBE
KSBhdXRvdG9vbHMKCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
