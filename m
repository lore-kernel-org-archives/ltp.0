Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFC5CD342F
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 09:27:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 759CA3E246A
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 11:27:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 981BC3E2460
 for <ltp@lists.linux.it>; Fri,  8 May 2026 11:26:50 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 395636003CB
 for <ltp@lists.linux.it>; Fri,  8 May 2026 11:26:50 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2ef38cf04f0so1729598eec.1
 for <ltp@lists.linux.it>; Fri, 08 May 2026 02:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778232408; x=1778837208; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hX16EANp9WOzJazocAPeiWW2blhPFYiQUwOM2USsi8=;
 b=KB+MGR9C1lUprc+TcQS3Xes093thJv66G53EkysW5Cke72RIGRkeHU760UU17Uyiro
 RyNqzBxIYGAkvxD11opSH2ol/UbNJ6ThxwiiIf3mCRxBZ2j+H9FrCE4eKrxWOg0J1Wyp
 mDyRmt2V44Fx3omkizZzXhNV3mbrpvHa5l2ICHX2TgrOMPU0BNxdfQ7bdMZIVQlM99hm
 tLaZU1Uv9qMl1ucz8Dn4mtERwvCc7O8BO4VvChE6RzsQzPvV4gNBKK9fWDCea4hIxr2R
 GTx+a2KqvQL8dRyaK18KMyriDOzapOwq6ihZphVmkalgg29yeKLHaZtpS4MIoVWEBqYC
 9Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778232408; x=1778837208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0hX16EANp9WOzJazocAPeiWW2blhPFYiQUwOM2USsi8=;
 b=RDKuYdNNn+3tgukctmZExtLERtZg7jJvaEhXxVdVaj7pZ91C5ee1dglYdKHrfPVzt6
 fLb7jGhTu6N8bywmbkfJ2I6UwxomUJ/9ZQJyca6Xr1AVCqTCqhinL81wZrJLQheJZXOb
 Ayyke6fI9GB0lmSOtD6jd2DKysT+vmO0fbJt+gxef+VBwq0as13qdhzkgcEedq1OTTb4
 odZ8RLvaLhdvlmuovjOu5BqI0Khe3U4XzBJDg3fPOQq4AzpYaYOJ2OJVgohl//60ayGZ
 xCL494C3a3GGxWM4QA44hn+StlzSWIq0j4Nmlt4R4V/4no1Xk6nDE50Tm2sDAFEAde8g
 4rNQ==
X-Gm-Message-State: AOJu0Yx2nkx2mXd5prkUfoO5lOF3S9A85LMQt1C6h96ysPaCM8GRwGkh
 g8nYKdb5QJ7rus7Lrq70aNPZ0eQ9vlw14J+7LixVgHzi9kJzISkomu+uX9of5iENIs4=
X-Gm-Gg: AeBDieu0B1hqlkJioufvhHM/iyl9wUjldzMbIZi8wSBu9yqraxezV9i03H6Jh8BFGXs
 5/jXoI3YOVLKvmnLKkV20W4+LtQx07s2vgcVXNfEtPCyykYQvPJ6uMitMiyUJc5iZEodOpXjK9n
 R1TODyh52Qg03xkkg9LB0uVhKCqS0IBkR2epsjbbuMavBKJdy70aK0JmpNPmYpvwwrSqJfSxyYt
 EXC+5CuKX7llRunBRtR6+jYn1TvDZ7H4PLT0aM2loNZLhepKrTX0W+se6DdPP+lfXPPr5Xvi6Ac
 2u4KyTfz68AdwvUFrWxIKWAw5uZmft1W7sWeZxTlzagFvcn76QCtqOr++gmumTDXOMD2uICvV/Z
 11AH4mSvPRrYAaRuh1DUEsjpS3WDIJhNCsvJlEvMPp0sTEIvB2dufqAAOV6+SMAadmgXdGmNMhK
 3nlff/lcUZDyg+WTMaY/ZwM0nmILnPKIUC+bFaSe2uLyYX0oLdcznmG/u4JX+2kcQ+Jbk1JoC3s
 bQJa2+ve6sLNUGeGYe5VYR0EWn3CA36nGevRmY=
X-Received: by 2002:a05:7301:5781:b0:2c5:50fe:c795 with SMTP id
 5a478bee46e88-2f54a3906f8mr6181363eec.29.1778232408453; 
 Fri, 08 May 2026 02:26:48 -0700 (PDT)
Received: from
 runnervmeorf1.ruemotfze4de3d0wsa50oj5uif.phxx.internal.cloudapp.net
 ([20.163.6.84]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8860c7accsm1463874eec.8.2026.05.08.02.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 02:26:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri,  8 May 2026 09:26:46 +0000
Message-ID: <20260508092646.3949-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508-cve-2026-43284-v1-1-bf2549d2430d@suse.com>
References: <20260508-cve-2026-43284-v1-1-bf2549d2430d@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: fallback SPLICE_F_MORE
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

SGkgQW5kcmVhLAoKLS0tIFtQQVRDSCAxLzNdIC0tLQoKT24gMjAyNi0wNS0wOCwgQW5kcmVhIENl
cnZlc2F0byB3cm90ZToKPiBsYXBpOiBmYWxsYmFjayBTUExJQ0VfRl9NT1JFCgpUaGUgY29tbWl0
IGJvZHkgaXMgZW1wdHkuIFBsZWFzZSBhZGQgYXQgbGVhc3Qgb25lIHNlbnRlbmNlIGV4cGxhaW5p
bmcKd2h5IHRoaXMgZmFsbGJhY2sgaXMgbmVlZGVkIOKAlCBlLmcuIHdoaWNoIGtlcm5lbCB2ZXJz
aW9uIGludHJvZHVjZWQKU1BMSUNFX0ZfTU9SRSwgb3IgdGhhdCBpdCBpcyByZXF1aXJlZCBieSB0
aGUgeGZybTAxIHRlc3QgYWRkZWQgbGF0ZXIKaW4gdGhpcyBzZXJpZXMuCgotLS0gW1BBVENIIDIv
M10gLS0tCgpPbiAyMDI2LTA1LTA4LCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+IGxhcGk6IGZh
bGxiYWNrIFVEUF9FTkNBUCBhbmQgVURQX0VOQ0FQX0VTUElOVURQCgpTYW1lIGlzc3VlOiB0aGUg
Y29tbWl0IGJvZHkgaXMgZW1wdHkuIEFkZCBhIHNlbnRlbmNlIGRlc2NyaWJpbmcgd2h5CnRoZXNl
IGNvbnN0YW50cyBuZWVkIGEgZmFsbGJhY2sgZGVmaW5pdGlvbi4KCi0tLQpOb3RlOgoKT3VyIGFn
ZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4gVGhlIGFnZW50IGNhbiBzb21l
dGltZXMKcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzIGZpbmRpbmdz
IGFyZSBnZW51aW5lLiBJZgp5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2Ug
Y29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZQp0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApM
VFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
