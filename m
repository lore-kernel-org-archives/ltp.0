Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44D7CA553C
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 13:25:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 156A23CE73C
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 15:25:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF8B83CE71D
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 15:25:06 +0200 (CEST)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4FC551A00CC6
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 15:25:06 +0200 (CEST)
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4935f87ca26so441027e0c.3
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694697905; x=1695302705; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8g7cbRHNiBB7kLy/+15nJEy1q3Dnsjo9urJij9aaIE=;
 b=jItU7KCJUD8P2u+M755zvjUeX8jwrN/cZ2SgAoNIk5E711K8w8xDrGM0uZuHLwNFT+
 Qxv1Zx8XHHe7iZYp6iu0/UFpgrCBhIvjdAn7CnylJUW/Gu9/aGj2/z6u/Tl4vcHo5bIs
 Xp5peJf3/AqvXHqOXKiIQ+OVlaPKp0GD3uVV/DSgWxpzhWX8/pCgz7pkoZFAa9VUfOEt
 kVcDEnSl+j46mAicYpVDWnhVR3Qas9b+r9uUqTRNs7LUDG3o/IeIjhJN913ZqYzMPxsV
 17vLjXbvZ3zYJzxu036V0XnbCxA3wz7mmJESXtUGa+nTZL5WsQKUJFae4eyLBtV/JZ7Z
 EFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694697905; x=1695302705;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8g7cbRHNiBB7kLy/+15nJEy1q3Dnsjo9urJij9aaIE=;
 b=uU1gZa634JvSHls0MdPFXJY74kYi/oHtMCvyY6Dj/axTiLLU4amfws/WYih2lXqTLh
 q3jd2eGiD9FPhQfxRRBNEXP44smufP6wPRs+eZsBLCMbzA2vBCC7vbVcjQtXMZzBiM7s
 Nqx7RN9PGzEeGFft4ZuuX2Xk/lhYhC9mlfLwFmwH5jdetuqTzleb/6lKluxUQbJYO5TW
 NzQhu55PLXDT1Et4ZIi0M8Q3JFggMCGfhy8fOdjfuP6gv58Lv5yNMDG3dkNT3nOy+4Ow
 j1ksC+2ZJH7pJWa7I3jtPHsmLvnOPrdrUaiQHrCNvqfyGTsNW5yEHbRh1FXniCNiraGk
 WY2A==
X-Gm-Message-State: AOJu0Yz68Rt9ha4vgBywIEGDczSuw0lzHTrtf5DSl52iErYwXGZPePBw
 xOrHPmlky6NFhBc7VwupOyyZ9iZyqGoO6Wl7HPg=
X-Google-Smtp-Source: AGHT+IH7odsW9+Jh4wQazpPfnhEMWvhHwdmJIXKKqe0W8X4g0avhi866LtGxnWyUZ4PyTandiFuP3i68Lm1fNlYW48c=
X-Received: by 2002:a1f:cac7:0:b0:495:e236:a73 with SMTP id
 a190-20020a1fcac7000000b00495e2360a73mr5732956vkg.11.1694697905041; Thu, 14
 Sep 2023 06:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230903111558.2603332-1-amir73il@gmail.com>
 <20230903111558.2603332-2-amir73il@gmail.com>
 <87il8dghw0.fsf@suse.de>
In-Reply-To: <87il8dghw0.fsf@suse.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Sep 2023 16:24:53 +0300
Message-ID: <CAOQ4uxhM8F6iyp5AVLquaq=NoR_V_6Y6NUjBDjqfjgcPvA5-Dw@mail.gmail.com>
To: rpalethorpe@suse.de
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] fanotify13: Test watching overlayfs upper fs
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgMTozN+KAr1BNIFJpY2hhcmQgUGFsZXRob3JwZSA8cnBh
bGV0aG9ycGVAc3VzZS5kZT4gd3JvdGU6Cj4KPiBIZWxsbyBBbWlyLAo+Cj4gQW1pciBHb2xkc3Rl
aW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4gd3JpdGVzOgo+Cj4gPiBSdW4gYSB0ZXN0IHZhcmlhbnQg
d2l0aCBvdmVybGF5ZnMgKG92ZXIgYWxsIHN1cHBvcnRlZCBmcykKPiA+IHdoZW4gd2F0Y2hpbmcg
dGhlIHVwcGVyIGZzLgo+ID4KPiA+IFRoaXMgaXMgYSByZWdyZXNzaW9uIHRlc3QgZm9yIGtlcm5l
bCBmaXggYmMyNDczYzkwZmNhCj4gPiAoIm92bDogZW5hYmxlIGZzbm90aWZ5IGV2ZW50cyBvbiB1
bmRlcmx5aW5nIHJlYWwgZmlsZXMiKSwKPiA+IGZyb20ga2VybmVsIDYuNSwgd2hpY2ggaXMgbm90
IGxpa2VseSB0byBiZSBiYWNrcG9ydGVkIHRvIG9sZGVyIGtlcm5lbHMuCj4gPgo+ID4gVG8gYXZv
aWQgd2FpdGluZyBmb3IgZXZlbnRzIHRoYXQgd29uJ3QgYXJyaXZlIHdoZW4gdGVzdGluZyBvbGQg
a2VybmVscywKPiA+IHJlcXVpcmUgdGhhdCBrZXJuZWwgc3VwcG9ydHMgZW5jb2RpbmcgZmlkIHdp
dGggbmV3IGZsYWcgQVRfSEFETkxFX0ZJRCwKPiA+IGFsc28gbWVyZ2VkIHRvIDYuNSBhbmQgbm90
IGxpa2VseSB0byBiZSBiYWNrcG9ydGVkIHRvIG9sZGVyIGtlcm5lbHMuCj4KPiBVbmZvcnR1bmF0
ZWx5IFBldHIncyBub3QgaGVyZSBhdCB0aGUgbW9tZW50Lgo+Cj4gSSBndWVzcyB0aGlzIGZpcnN0
IHBhdGNoIGRvZXNuJ3QgcmVxdWlyZSA2LjY/IFNvIGl0IGNvdWxkIGJlIG1lcmdlZAo+IGluZGVw
ZW5kZW50bHkgd2l0aG91dCBmdXJ0aGVyIGNvbnNpZGVyYXRpb25zIGZvciB3aGF0IG1ha2VzIGl0
IGludG8gNi42Pwo+CgpZZXMgdGhhdCBpcyBjb3JyZWN0LgoKVGhhbmtzLApBbWlyLgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
