Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE16C27C79
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 10:04:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7B953D0E27
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 12:04:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA40C3D0DD8
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 12:04:36 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3CAB52102F5
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 12:04:36 +0200 (CEST)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f97a4c4588so395611a34.2
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718877875; x=1719482675; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qssxO3H97xYgQ6phX7ShXtegLep8IN5IzW1nwrh59UQ=;
 b=UGBkIVh8VwnpzZcK7ZRbmtUxi0WlI8RGqbd1+zdQV4HvJem6CYu/pG52SbbY91S0CX
 hnj/h80UNGCJB2aiBHAx6B236MBoAdbK6Hd6RjNr1dBKJqZ4leF6JijIpqB3KU0Ksa1U
 TuA2lJqebuQmaHPDbFDHMwsHGaSiilBAGTpiV+RaTQjCEJUjAQpffJ0sUIfBkp0qQZDg
 r8OBScJzygA6ho0mQ7XWBXXvX9Sq+ymkhBX3+J/Jvt5IT7KR8fCzMAvBY/O8e7POuVqW
 wekRtFVrM5jsQq54XGjR/hgDbeVz/T2HwhT4cv3xMO+83xHV+Hw+UrjpgwJ8vKtBTD/S
 aoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877875; x=1719482675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qssxO3H97xYgQ6phX7ShXtegLep8IN5IzW1nwrh59UQ=;
 b=JyfdjODjStyjU9bXPzvaET6xXk6cIVGnDexUMR+yKNfQlbsSeGiuAM6V4ZcwfJJwx+
 UgON1cOPLxbYtUBhgcp5nl+nxH1boNkkMBLBdK+aksD4cZZFBz4IAjyPO76ZDAUK1yP2
 FCFT5JW3V1CAso/U/zlz1s5zQtzig3p/eIsoHr8L0niWceWkM5ThjsELoJW0AJEaf1oX
 R4VHQo6YpA2S8P5D/MThqQkRzNK4inzf8/aB4+haJrV5YVS6h+igevV9abqUpvsBi2sj
 3WKRPEZJkPmJvomOa+zyZJCXuQGIv21jXhng4aP5XHbZIcq8l6zOvIcTZi+ji2VKuphh
 Zqkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNcpLCn/GkVZkhQdXHxHvMBIwGzZorDB9iq583Joahq+9TA2SXUJ1eg7+Al5pqTcN85PfzjQdLW3vbEC/06NfAx5g=
X-Gm-Message-State: AOJu0YzZ4zxuytY2u78UfDs9SrSNGGr6eRdc1Jn1163Lkym3AMjmVP6w
 RBwiDpLTJhxTqsa1unPMb2vSwVsFp7fH/dLsEX/KdpD12W0NbsZLHUbTyoSs/4sprNCUHve10FA
 63KDRwOFq6mkA2z1mkAfpZbvR+4U=
X-Google-Smtp-Source: AGHT+IEsRoAAbHHrux8RoioxqnCJYdrd6SXFlI9sC177VWlo2dg4V8kucLTYTM3m9HxTRR2I126OQYwbcrhsErp1o4o=
X-Received: by 2002:a05:6830:310f:b0:6f9:b69f:b64f with SMTP id
 46e09a7af769-70076a1c558mr5925673a34.35.1718877874742; Thu, 20 Jun 2024
 03:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
 <20240617093745.nhnc7e7efdldnjzl@quack3>
 <20240618-wahr-drossel-19297ad2a361@brauner>
 <20240620094151.cuamehtaioenokyv@quack3>
In-Reply-To: <20240620094151.cuamehtaioenokyv@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Jun 2024 13:04:22 +0300
Message-ID: <CAOQ4uxgqct2ru571NwzMqVaYOJwwr05La=OTecMCVQZJko9gPw@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
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
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>,
 linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it,
 Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKdW4gMjAsIDIwMjQgYXQgMTI6NDHigK9QTSBKYW4gS2FyYSA8amFja0BzdXNlLmN6
PiB3cm90ZToKPgo+IE9uIFR1ZSAxOC0wNi0yNCAxNjoxOTozNywgQ2hyaXN0aWFuIEJyYXVuZXIg
d3JvdGU6Cj4gPiA+IEFGQUlDVCB0aGlzIHdpbGwgaGF2ZSBhIHNpZGUtZWZmZWN0IHRoYXQgbm93
IGZzbm90aWZ5X29wZW4oKSB3aWxsIGJlCj4gPiA+IGdlbmVyYXRlZCBldmVuIGZvciBPX1BBVEgg
b3Blbi4gSXQgaXMgdHJ1ZSB0aGF0IGZzbm90aWZ5X2Nsb3NlKCkgaXMgZ2V0dGluZwo+ID4KPiA+
IFRoYW5rcyEgVGhhdCBjaGFuZ2Ugc2VlbWVkIHNlbnNpYmxlIGJlY2F1c2UgYSBjbG9zZSgpIGV2
ZW50IGlzCj4gPiBnZW5lcmF0ZWQuCj4gPgo+ID4gQnV0IEkgZG9uJ3QgYWdyZWUgdGhhdCBnZW5l
cmF0aW5nIGV2ZW50cyBmb3IgT19QQVRIIGZkcyBkb2Vzbid0IG1ha2UKPiA+IHNlbnNlIG9uIHBy
aW5jaXBsZS4gQnV0IEkgZG9uJ3QgY2FyZSBpZiB5b3UgZHJvcCBldmVudHMgZm9yIE9fUEFUSCBu
b3cuCj4KPiBXZWxsLCBJIGNhbiBiZSBjb252aW5jZWQgb3RoZXJ3aXNlIGJ1dCBJIHdhcyBub3Qg
YWJsZSB0byBmaW5kIGEgY29tcGVsaW5nCj4gdXNlY2FzZSBmb3IgaXQuIGZhbm90aWZ5KDgpIHVz
ZXJzIHByaW1hcmlseSBjYXJlIGFib3V0IGZpbGUgZGF0YQo+IG1vZGlmaWNhdGlvbiAvIGFjY2Vz
cyBldmVudHMgYW5kIHNlY29uZGFyaWx5IGFsc28gYWJvdXQgZGlyZWN0b3J5IGNvbnRlbnQKPiBj
aGFuZ2VzIChiZWNhdXNlIHRoZXkgY2hhbmdlIGhvdyBkYXRhIGNhbiBiZSBhY2Nlc3NlZCkuIEFu
ZCBjcmVhdGlvbiBvZgo+IE9fUEFUSCBmZHMgZG9lcyBub3Qgc2VlbSB0byBmYWxsIGludG8gZWl0
aGVyIG9mIHRoZXNlIGNhdGVnb3JpZXMuLi4KCk5vdCB0byBtZW50aW9uIHRoZSBmYWN0IHRoYXQg
c2VjdXJpdHlfZmlsZV9vcGVuKCkgYW5kIHRoZXJlZm9yZQpmc25vdGlmeV9vcGVuX3Blcm0oKSBp
cyBub3QgY2FsbGVkIGZvciBPX1BBVEggb3Blbi4KCkl0J3Mgbm90IHRoYXQgd2UgaGF2ZSB0byBr
ZWVwIEZTX09QRU4gYmFsYW5jZWQgd2l0aApGU19PUEVOX1BFUk0sIGJ1dCBJIHRoaW5rIGl0IHdp
bGwgYmUgcXVpdGUgb2RkIHRvIGdldCBGU19PUEVOIHdpdGhvdXQKRlNfT1BFTl9QRVJNLgoKSSB0
aGluayB0aGF0IG9wZW4gYW4gT19QQVRIIGZkIGZpdHMgcGVyZmVjdGx5IHRvIHRoZSBkZXNpZ24g
InByZSBwYXRoIgpldmVudHMgWzFdLgpJIGhhdmUgZGVzaWduYXRlZCBGQU5fUEFUSF9BQ0NFU1Mg
KHdpdGggZGlyIGlkICsgbmFtZSBpbmZvKSBmb3IgbG9va3VwCnBlcm1pc3Npb24uClBlcmhhcHMg
b3BlbiBhbiBPX1BBVEggY2FuIGdlbmVyYXRlIHRoZSBzYW1lIGV2ZW50IHdpdGggYWRkaXRpb25h
bCBjaGlsZCBpZApvciBhbm90aGVyIGRlZGljYXRlZCBGQU5fUEFUSF9PUEVOIGV2ZW50LgoKVGhh
bmtzLApBbWlyLgoKWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9hbWlyNzNpbC9tYW4tcGFnZXMvY29t
bWl0cy9mYW5fcHJlX3BhdGgvCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
