Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782DEC02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 12:59:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E61453C9274
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 13:59:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECA303C0277
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 13:59:10 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E4346612DB3
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 13:59:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738846748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6qj7k1sZLOGpv0ge/vAe5Bx1e3YCPfLwhwz+JZLwrgs=;
 b=KYmrOTGc7nCdi6aOCrelin1nFVXg2P3tTwRjcu8+BUZdyo8SELGjddtA6d34SsmoQPBgBP
 oGGmWAl15aCvqMiz5ae8F3urNj9Cm/uBRPxyxBDSerSm3JBdwHhkI0HZlsn1iFsVu1jkHM
 13GQG2oiBU7O+Iodi/ZwaOeWuEjW+Rc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-1GudtgSvNGSuDd241PWz7w-1; Thu, 06 Feb 2025 07:59:06 -0500
X-MC-Unique: 1GudtgSvNGSuDd241PWz7w-1
X-Mimecast-MFC-AGG-ID: 1GudtgSvNGSuDd241PWz7w
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3eb83258f06so954002b6e.0
 for <ltp@lists.linux.it>; Thu, 06 Feb 2025 04:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738846746; x=1739451546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qj7k1sZLOGpv0ge/vAe5Bx1e3YCPfLwhwz+JZLwrgs=;
 b=gOLx+r5N4OU74KN1pO/zd/whX9yT0hZu7i8MngSoVte82n5/F1FUzqA53gGBWSBy+y
 xHkbJ5t9E4O1WkCrHck+el08mG13z0rXpmddZaLwRBWFa3j1ooxmXd1FB2qPMlfcmoqr
 3Nyx0YwsPUVfiNJBhSKkUEo8DXmf+aQ7kbfTOARLbTKY/pPLlu0bGmDWtH9Plb5VhS3s
 oIbhYsMoWYUapSwl3vE8aB+pFMPAKo8kIz0zDA7DVOn8PuFzG7NqhpGkNAhaMIGTtT+H
 26gA5n/yEhQiTyXEpzJmToa16yf7GZZJod+1FDFVidS9aIGfzq9l1p8wHIBqJLvjRSMy
 CcJw==
X-Gm-Message-State: AOJu0Yw8vDIgk6IPeT9H3KJfoBetSkP2RKrcOL/PrL9wPUH2MnFf5RQv
 rpsjUIFXMWXbjta4GH0riimEExwKis6GMmgF4By4RSP++aaMOSPk2VrMrKxiJCLLZhNMfy3kvf5
 GvJ8AjH6OV/BzVy/nnVy/I5bG7omWAsYllrQEXPY8sVIk5zwD9ZOpZ05SO+DUjbWb/a0tuXAuwT
 IkWqjyyoXuwf651k8U2eVqOok=
X-Gm-Gg: ASbGncu+NmS7VZHGGuygGUWp05Cdu6nygmlhuizlo1rVS5bdhQxNWbLf6dEHEa0wu4v
 UFSOGDa6ZYp29oMZzroAKlkTuKzZj+/46MygNGRdljG9IUDM1WvE06NX89fLEEg==
X-Received: by 2002:a05:6808:2e97:b0:3eb:7303:1dfc with SMTP id
 5614622812f47-3f37c1af056mr5582031b6e.30.1738846746144; 
 Thu, 06 Feb 2025 04:59:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnZgR8cIG5KsOyG3TjjUgxs6f5iBbv7CwaO4ljkTFsUb5EEYlOgmyE+WFOnogB5lh9AVbjPo4OWGnpqnuufyA=
X-Received: by 2002:a05:6808:2e97:b0:3eb:7303:1dfc with SMTP id
 5614622812f47-3f37c1af056mr5582019b6e.30.1738846745870; Thu, 06 Feb 2025
 04:59:05 -0800 (PST)
MIME-Version: 1.0
References: <700f4d3bc73f0deebe7fe0e41305d365135c53eb.1738835278.git.jstancek@redhat.com>
 <Z6Sux-uScF-o3g7W@yuki.lan>
In-Reply-To: <Z6Sux-uScF-o3g7W@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 6 Feb 2025 13:58:50 +0100
X-Gm-Features: AWEUYZnG2_mKjfPcWWD82ugkO975-xLigqNgEhn8xnJkxrJXvnJ7l9a_g17WEms
Message-ID: <CAASaF6zuFMWJhph-8U4RRMhd0uHt1_mOVU5Bu0pZ=CVoLf+igw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BceqHweYLdryMLXbVi4RXpVanZIZ2A8YUI02tkoiL4E_1738846746
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mallinfo02: introduce LTP_VAR_USED to
 avoid optimization
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

T24gVGh1LCBGZWIgNiwgMjAyNSBhdCAxOjQ14oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gSGkhCj4gPiBnY2MgMTUgaXMgYSBiaXQgbW9yZSBjbGV2ZXIgYW5k
IG5vdGljZWQgdGhhdCAnYnVmJyBpc24ndCB1c2VkCj4gPiBmb3IgYW55dGhpbmcgc28gaXQgb3B0
aW1pemVkIGl0IG91dCwgaW5jbHVkaW5nIGNhbGwgdG8gbWFsbG9jLgo+ID4gU28sIHRoZXJlJ3Mg
YWxzbyBubyBtbWFwKCkgY2FsbCBiZWhpbmQgaXQgYW5kIHRlc3QgZmFpbHMsCj4gPiBiZWNhdXNl
IG5vdGhpbmcgd2FzIGFsbG9jYXRlZC4KPgo+IEh1aCwgdGhhdCBzb3VuZHMgbGlrZSB0aGUgb3B0
aW1pemF0aW9ucyBhcmUgZ2V0dGluZyBtb3JlIGFuZCBtb3JlIGV2aWwKPiBvdmVyIHRoZSB0aW1l
LgoKQWxzbyBzZWUgdGhlIG5leHQgcGF0Y2ggZm9yIGJwZi4KCj4KPiA+IEludHJvZHVjZSBMVFBf
VkFSX1VTRUQgbWFjcm8sIHRoYXQgbWFrZXMgY29tcGlsZXIgYXdhcmUgb2YgdGhlCj4gPiB2YXJp
YWJsZSBhbmQgZG9lc24ndCBvcHRpbWl6ZSBpdCBvdXQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTog
SmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICBpbmNsdWRlL3Rz
dF9jb21tb24uaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIgKysKPiA+ICB0ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL21hbGxpbmZvMi9tYWxsaW5mbzJfMDEuYyB8IDIgKy0KPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF9jb21tb24uaCBiL2luY2x1ZGUvdHN0X2NvbW1vbi5o
Cj4gPiBpbmRleCBiMTRiYmFlMDQwNzcuLjNkZTgyNmFjZDBlYyAxMDA2NDQKPiA+IC0tLSBhL2lu
Y2x1ZGUvdHN0X2NvbW1vbi5oCj4gPiArKysgYi9pbmNsdWRlL3RzdF9jb21tb24uaAo+ID4gQEAg
LTEzLDYgKzEzLDggQEAKPiA+ICAjZGVmaW5lIExUUF9BVFRSSUJVVEVfVU5VU0VEICAgICAgICAg
X19hdHRyaWJ1dGVfXygodW51c2VkKSkKPiA+ICAjZGVmaW5lIExUUF9BVFRSSUJVVEVfVU5VU0VE
X1JFU1VMVCAgX19hdHRyaWJ1dGVfXygod2Fybl91bnVzZWRfcmVzdWx0KSkKPiA+Cj4gPiArI2Rl
ZmluZSBMVFBfVkFSX1VTRUQocCkgYXNtIHZvbGF0aWxlKCIiIDo6ICJtIihwKSk7IHAKPgo+IFNo
b3VsZG4ndCBfX2F0dHJpYnV0ZV9fKCh1c2VkKSkgc3VmZmljZT8KCkl0J3MgaWdub3JlZCBmb3Ig
bG9jYWwgdmFyaWFibGVzLiBJdCBkb2VzIHdvcmsgZm9yIGdsb2JhbCBvbmVzLgoKPgo+ID4gICNp
Zm5kZWYgQVJSQVlfU0laRQo+ID4gICMgZGVmaW5lIEFSUkFZX1NJWkUoYXJyKSAoc2l6ZW9mKGFy
cikgLyBzaXplb2YoKGFycilbMF0pKQo+ID4gICNlbmRpZgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbWFsbGluZm8yL21hbGxpbmZvMl8wMS5jIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9tYWxsaW5mbzIvbWFsbGluZm8yXzAxLmMKPiA+IGluZGV4IDkwY2Y0
ZmNiM2I4OS4uNTE3ODNmYzIyYjgwIDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9tYWxsaW5mbzIvbWFsbGluZm8yXzAxLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbWFsbGluZm8yL21hbGxpbmZvMl8wMS5jCj4gPiBAQCAtMjYsNyArMjYsNyBA
QCB2b2lkIHRlc3RfbWFsbGluZm8yKHZvaWQpCj4gPiAgICAgICBjaGFyICpidWY7Cj4gPiAgICAg
ICBzaXplX3Qgc2l6ZSA9IDJVTCAqIDEwMjRVTCAqIDEwMjRVTCAqIDEwMjRVTDsKPiA+Cj4gPiAt
ICAgICBidWYgPSBtYWxsb2Moc2l6ZSk7Cj4gPiArICAgICBMVFBfVkFSX1VTRUQoYnVmKSA9IG1h
bGxvYyhzaXplKTsKPiA+Cj4gPiAgICAgICBpZiAoIWJ1ZikKPiA+ICAgICAgICAgICAgICAgdHN0
X2JyayhUQ09ORiwgIkN1cnJlbnQgc3lzdGVtIGNhbiBub3QgbWFsbG9jIDJHIHNwYWNlLCBza2lw
IGl0Iik7Cj4gPiAtLQo+ID4gMi40My4wCj4gPgo+ID4KPiA+IC0tCj4gPiBNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+IC0tCj4gQ3lyaWwg
SHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
