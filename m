Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5370FF589D4
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 13:43:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE0C03E4ACB
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 15:43:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F4E13E28DB
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 15:43:28 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D92AA60065D
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 15:43:27 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso9137392eec.1
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776951806; x=1777556606; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eBV0rAoOrvmd7SPzQdQITt7sbfT9BtMepHSQaJgORQU=;
 b=bylCWBqNc6ntv3Z4qNqyZYkOo+qwDex9AA+91UMRe3NWkUPuC5AGMMo0CxS8/APObE
 XPyr7DYEfs3OI09LeOuxZA18ebY9K4ww29cQ7baugQPztHz5N1NpKMG0SGyZ4luxsCQL
 3u4/BEuuo0VycHBrb9n1JcoIw3/xxqzyYP4LwyD2MKf6x9AjHvph5QuMhf6Pv7tbmJHW
 u4VcuUwUP/3tj9K7TMVlMDvfYgMj2Ty6wDxWXGIGwbC116We/3ONbuNCp+ymPhLC8kZO
 Gl2JzngZhWFlr63540GiTApuxjjY6eqa1mVIwZcIWURLoTb4peKoCUWuXpe9sZfaV2fh
 aUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951806; x=1777556606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eBV0rAoOrvmd7SPzQdQITt7sbfT9BtMepHSQaJgORQU=;
 b=AW6qvSIuNUIYPwkm9IrikO8BihhU6liGz21nuaKpBgL34ISp9JxTuxs/Loqu0yQ3Sy
 p/UWnmBggsN7qtW8B2gQ1D8FGQi7s7zNhIRGDh6e5x6tlwtKJsxZoiac6wDcA86Jpy9o
 rHMxLCM3crAD5uPda9y5Eu9rtxBx1VDMXlpymDD6CaMJeJxtm4886lnv4iqP/OniQgkA
 EsDm70E5sfKzsd80u3aY16e5Ah4yItU5QhxMAM3F/6THCWpeg6o3PQ0Ll93idvzPEXXQ
 HpIYuooYzW4H13k/DUpftJYYK5IOUO4Ku1oYKdoqx3tg6fiwjX5LF9AED8VQ8qXecUdr
 L1pg==
X-Gm-Message-State: AOJu0Yzmax4K/voEfASq72Yxj+nA2yJKHG0EG6jxzoVV4O87XvOBV66L
 IClsYefJDh7q1zU+L0CK9OIuu7kHYwZRweZHO4dAj4cNo7NwcbRwmLg3
X-Gm-Gg: AeBDietC3WM9Os70FfqA26GM9npxLozCooDDYs7+H3ABKpzXDHPll1ThNAvFjwwHp5F
 CilY1QF49VDh2QvMd+xX++Ie8xVKYrh4OxSUvrcLJfR8krknu59BRoxM8W/tatC/vN4Uv4nrP68
 PJa1ebUTPE/QjuAha069zgDKay/RLfu92q3Q1NJQT2fNZJKaZfkmd6xjeNYgdPgE5+NX3nUPrII
 IAz9ZSEopXb9anK0i7xaTX1fo3b3v3yrnawEQjYbdIuOsdY8mu5PFIybxVkBEHD7T2eLeNLz6IK
 8N6aKIn0LHbrI6VTjyE576ilT8Werr5Fv082MUB+XNv0+FYAQ1mNOBu3hGTO+7yQJyzrPsrJtaI
 6PvOKps1F3+Kbmo8Ju4nkcMGHhhoZz/byIZblaUE8fxg43t+G9K1E9On+hGadbRQrlV04cRAXZa
 F/DZD8P2cztD+v4Va3UrM+bzh5/jyCrRNpcRXMjJEqJG0qyNIW39IgEWVJiBfIfxTBhbM9dYGju
 fMveNMNDcI1BvTv0/lxHcvsS+IsuEMH2JoZZCRwgg0+ml2GUA==
X-Received: by 2002:a05:7300:6d23:b0:2de:aafb:fef3 with SMTP id
 5a478bee46e88-2e464eaa418mr16067015eec.1.1776951805961; 
 Thu, 23 Apr 2026 06:43:25 -0700 (PDT)
Received: from
 runnervmeorf1.tl2v0rktc0guzlcbunsqswfqba.yx.internal.cloudapp.net
 ([128.24.161.84]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d9b056fsm36233124eec.29.2026.04.23.06.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:43:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Apr 2026 13:43:23 +0000
Message-ID: <20260423134324.4268-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260423120309.18049-2-chrubis@suse.cz>
References: <20260423120309.18049-2-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: Add epoll_create03
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

SGkgQ3lyaWwsCgotLS0gW1BBVENIIDIvOF0gLS0tCgpPbiAyMDI2LTA0LTIzLCBDeXJpbCBIcnVi
aXMgd3JvdGU6Cj4gc3lzY2FsbHM6IEFkZCBlcG9sbF93YWl0MDgKCj4gKyAqIC0gQ3JlYXRlIGFu
IGVwb2xsIGluc3RhbmNlIGFuZCByZWdpc3RlciBhIHNvY2tldCBmZCBmb3IgRVBPTExJTi4KPiAr
ICogLSBGb3JrIGEgY2hpbGQgdGhhdCB3YWl0cyBmb3IgdGhlIHBhcmVudCB0byBlbnRlciBlcG9s
bF93YWl0LCB0aGVuIHNlbmRzCj4gKyAqICAgU0lHVVNSMSB0byBpbnRlcnJ1cHQgaXQuCgpUaGUg
YWxnb3JpdGhtIGNvbW1lbnQgaXMgd3Jvbmcgb24gdHdvIGNvdW50cy4gTm8gZmQgaXMgcmVnaXN0
ZXJlZCB3aXRoIHRoZQplcG9sbCBpbnN0YW5jZSDigJQgc2V0dXAoKSBvbmx5IGNhbGxzIFNBRkVf
RVBPTExfQ1JFQVRFMSgpLiBBbmQgaXQgaXMgdGhlCmNoaWxkIHRoYXQgYmxvY2tzIGluIGVwb2xs
X3dhaXQsIG5vdCB0aGUgcGFyZW50OyB0aGUgcGFyZW50IHNlbmRzIFNJR1VTUjEuCgotLS0gW1BB
VENIIDYvOF0gLS0tCgpPbiAyMDI2LTA0LTIzLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gc3lzY2Fs
bHM6IEFkZCBlcG9sbF93YWl0MTEKCj4gKyAqIC0gVGhlIGNoaWxkJ3MgZXBvbGxfd2FpdCBzaG91
bGQgcmV0dXJuIHdpdGggRVBPTExIVVAgYW5kIHRoZSBjaGlsZCByZXBvcnRzCj4gKyAqICAgdGhl
IHJlc3VsdCB2aWEgaXRzIGV4aXQgY29kZS4KClRoZSBjaGlsZCByZXBvcnRzIHZpYSB0c3RfcmVz
KFRQQVNTL1RGQUlMLCAuLi4pIGJlZm9yZSBleGl0KDApLCBub3QgdmlhCnRoZSBleGl0IGNvZGUu
IEZpeCB0aGUgY29tbWVudCBhY2NvcmRpbmdseS4KCi0tLQpOb3RlOgoKT3VyIGFnZW50IGNvbXBs
ZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4gVGhlIGZ1bGwgcmV2aWV3IGNhbiBiZQpmb3Vu
ZCBhdDogaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9saXN0Lz9zZXJp
ZXM9NTAxMTg4CgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZl
cyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlz
c3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3Jl
IHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
