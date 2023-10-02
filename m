Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FB0E74902
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 17:50:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26A923CE055
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 19:50:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EBC43CDDD4
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 19:50:22 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7529A1A00A45
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 19:50:21 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4063bfc6c03so6925e9.0
 for <ltp@lists.linux.it>; Mon, 02 Oct 2023 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696269021; x=1696873821; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2AR1Ry7HVaQhZlybSp6mmudxf8TAg69EbrNqsYO1x6A=;
 b=2fufKNaI2eMLMHgJEGM1uGJh8/VH10941C/y5/qZwFaEkreBwASGdIhGZzqsaYdzQ7
 V1nvAOR3yYeFmJWKO+oumj+wUnMM1U/lWRSrU58s7VHDYHN9rS29sKwTVscnyl5YUAne
 M0QEAtDYkQU/jT8TLmJlTQmFb40mZReyBRZbw9eU40dYEGduk8qXvfxE/wSPEjiRGjZy
 qJBsyLjloHxWZoIxpXthGgIEYBGSI9IQIPxUYAMskZpzdQz/9oNjG1mkYDPQLsDz2J9i
 1rx4iZu+Hq+TlAEos39fYqLs6lzqk73bU6+t8233nUdPdpovhfvivoa1kogZ8hms/zYD
 6mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696269021; x=1696873821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2AR1Ry7HVaQhZlybSp6mmudxf8TAg69EbrNqsYO1x6A=;
 b=Aljb+PhVpjdyO+DYKj6GV3dsLMOeFZSxTbSuaV8ryZFtXQa/wbGkO/ZWn4NDDbzOIn
 No/YMvJYNMUuRO5KwRzZzvVIMFfH/zHGvZktYShWx/t/l20+1roD+tb1C9byt7kBxiqf
 ayeuWQv3jGsMWUU01wZgGjoasNQJsUCjXDkZzcY+hKfDd09m4KOQafp1TxbbGVbC027Z
 CN2rFqdMyno+WIP2iRD2Pqa5ROciSlAFlX0FDaonOCIArCStHI5wp0wmWKSEMyz0CKUg
 MsFYhxgChvpd9YQ79lY/cA9FFXrdCEsF34tFHlveRo2x/RQj/AV3tdbWtj36v8ajKoUo
 HMlg==
X-Gm-Message-State: AOJu0YzhiF8VRZaNvE/HHiSkbURl4Q5sWTJAWZX+X8eZsyDniUGy0nDL
 HhML6KHbjK+KEEDn8EHJX2ZL6vHKi2azplCEXx28ag==
X-Google-Smtp-Source: AGHT+IE+D07eCfXlrlz3AoUn/PPdmTM4xSYef3P5a8oIafXfK0CEocZxIu2ohJq78SuoA8rowxeMjgBgVjuMKpOgzmo=
X-Received: by 2002:a05:600c:1c21:b0:406:5779:181d with SMTP id
 j33-20020a05600c1c2100b004065779181dmr13883wms.2.1696269020754; Mon, 02 Oct
 2023 10:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230930000516.4063681-1-edliaw@google.com>
 <20230930065443.GC414289@pevik>
In-Reply-To: <20230930065443.GC414289@pevik>
Date: Mon, 2 Oct 2023 10:49:53 -0700
Message-ID: <CAG4es9Uf5s6ExauFg+K7o8TNnt3pcN64hpXD4-2XwDk-kMXFtQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getpgid01: On Android, pgid(1) is 0 instead of 1
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIEZyaSwgU2VwIDI5LCAyMDIzIGF0IDExOjU04oCvUE0gUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4gSGkgRWR3YXJkLAo+Cj4gPiBBbmRyb2lkJ3MgaW5p
dCBkb2VzIG5vdCBjYWxsIHNldHBnaWQoMCwgMCkgc28gaXQgZG9lcyBub3QgaGF2ZSBwZ2lkPTEu
Cj4gPiAwIGlzIGZ1bmN0aW9uYWxseSBlcXVpdmFsZW50LCBzaW5jZSBwZ2lkIDAgbWVhbnMgdGhl
IHBnaWQgaXMgdGhlIHNhbWUgYXMKPiA+IHRoZSBwcm9jZXNzIHBpZC4KPgo+ID4gU2lnbmVkLW9m
Zi1ieTogRWR3YXJkIExpYXcgPGVkbGlhd0Bnb29nbGUuY29tPgo+ID4gLS0tCj4gPiAgdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9nZXRwZ2lkL2dldHBnaWQwMS5jIHwgMiArLQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRwZ2lkL2dldHBnaWQwMS5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9nZXRwZ2lkL2dldHBnaWQwMS5jCj4gPiBpbmRleCA0NzlmZTVk
Y2IuLjg2NDBmMmM5MyAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
Z2V0cGdpZC9nZXRwZ2lkMDEuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9n
ZXRwZ2lkL2dldHBnaWQwMS5jCj4gPiBAQCAtMzcsNyArMzcsNyBAQCBzdGF0aWMgdm9pZCBydW4o
dm9pZCkKPiA+ICAgICAgICAgICAgICAgVFNUX0VYUF9FUV9MSShUU1RfUkVULCBwZ2lkKTsKPgo+
ID4gICAgICAgICAgICAgICBUU1RfRVhQX1BJRChnZXRwZ2lkKDEpKTsKPiA+IC0gICAgICAgICAg
ICAgVFNUX0VYUF9FUV9MSShUU1RfUkVULCAxKTsKPiA+ICsgICAgICAgICAgICAgVFNUX0VYUF9F
WFBSKFRTVF9SRVQgPT0gMSB8fCBUU1RfUkVUID09IDAsICJnZXRwZ2lkKDEpID09IDEgb3IgMCIp
Owo+IEFsdGhvdWdoIEkgZG9uJ3QgcHJlZmVyIHVzaW5nIG9mdGVuIGxpYmMgc3BlY2lmaWMgY29k
ZSwgaGVyZSBJJ2QgdXNlIGl0Ogo+Cj4gI2lmbmRlZiBfX0FORFJPSURfXwo+ICAgICAgICAgICAg
ICAgICBUU1RfRVhQX0VRX0xJKFRTVF9SRVQsIDApOwo+ICNlbHNlCj4gICAgICAgICAgICAgICAg
IFRTVF9FWFBfRVFfTEkoVFNUX1JFVCwgMSk7Cj4gI2VuZGlmCj4KPiBCZWNhdXNlIHlvdXIgY29k
ZSB3b3VsZCBsb29zZW4gdGVzdGluZyBmb3Igb3RoZXIgbGliYy4KCkknbSBmaW5lIHdpdGggdGhh
dC4gIEkgdHJpZWQgbG9va2luZyB1cCB3aGV0aGVyIHBnaWQgb2YgaW5pdCBzaG91bGQKYWx3YXlz
IGJlIDEgYnV0IHdhc24ndCBhYmxlIHRvIGZpbmQgYSBnb29kIGFuc3dlciwgc28gSSBkZWZlciB0
byB5b3VyCi8gdGhlIHRlYW0ncyBqdWRnZW1lbnQgaGVyZS4gIFdpbGwgc2VuZCBhIHYyLgoKPiBD
eXJpbCwgTGksIFdEWVQ/Cj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
