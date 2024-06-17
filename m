Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A418C27C79
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 17:10:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFF883D0D5D
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 19:10:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 874EF3D0CFE
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 19:10:25 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EE1B01000D15
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 19:10:24 +0200 (CEST)
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7955dc86cacso264687085a.0
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718644224; x=1719249024; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Ez6wONf2/2cmZH1p6FhYRBtC2vHp1WfaArV/rCGFFw=;
 b=l0mJ5PpaIqiSzeEFuo55LylZkRP5WWbadzoHuRNsZBsZj38DUQDlxK07nIF95w5VOc
 u7aMzeTEtrGaFTAA9s/JykZCr5QxBsyfqHo3BCaD7oYRrYQ+miwRrtVR2voVy2RmDrR8
 ZBOrfafZUtXNM31seYWuD4OEPAvLSxH2WOnQyFkWLQZzoGit9v7nO0zNAfVX8ainQEs2
 X9WOmw1UXnlR9qpJnbY4lK83tiyJDiK5chk91x3+KuQ2ShNDwtUXuW+o6z5F9xTlHn/W
 DNjPmi3eeq7FDqBeA+l/NGzpkltSryG2Y5qkI8H/rdNxiUoqnyoHk3/LKgetkyMf+BFA
 50SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718644224; x=1719249024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Ez6wONf2/2cmZH1p6FhYRBtC2vHp1WfaArV/rCGFFw=;
 b=e78g+8zLLsEDzUwZlz8MIoEO9LHvoidd5ZqLHBpyrH2/+4hWSk0Vkcm+46Ck0Mlun5
 Te4x7r6gudJLqQxCzGFP5KbXH1LJM/10USFMrkmE0fnwe/anFuBJUZ0A7UxhYvP87BNH
 I3G4OZlltRpRwSn6CnQzGmfFI9vAg7n3DPqvY2KCO9KZSCyWAH4KTEVzKv5XNJkzM55N
 5NXOVOR7nGIrUaZWzcQP/PBRYdXbv/L2yzTJjpnqh+4zRrcWVIJv3urT0A+rn2cXRAGH
 977cF9eXNHgbDM68fujuszUoYD4sDsP25yKBjTJU+px3ugVa5DVTaVsaBxq5zIA2Zx7Z
 l+PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/2dBuTYS1uLYBgN/ELOJXaYqYM+RGMx7PurtlAUW0fB67O5FgTIR1oobvv3G0yVUbI2jqQZ61+OYmmqdEFu52iN8=
X-Gm-Message-State: AOJu0YyYna2JcicdQXcip3Qq7XT4yQNjdE5IaFh/UkQtDHYNM4Yu482Z
 WasjdTI9Gjt1wmdIqNUihPjuCzx7gxwwgCBEG0v3d8hpSj365IjZD3IP69yTVkRC0RDYKG2VWuu
 RSU2r88gF61oscRbXjqpn1hDAZBU=
X-Google-Smtp-Source: AGHT+IE9bI2jvgejW/jzxrWszTj6tPjedhG1vNzpswD5en5Ch8uMMStXbN2LpP+ohG6igpZ+tMRJAOhxZlXkWeXTLZs=
X-Received: by 2002:a05:620a:4687:b0:795:4a03:8032 with SMTP id
 af79cd13be357-798d258afc8mr1338207985a.52.1718644223569; Mon, 17 Jun 2024
 10:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240617161828.6718-1-jack@suse.cz>
 <20240617162303.1596-1-jack@suse.cz>
In-Reply-To: <20240617162303.1596-1-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Jun 2024 20:10:11 +0300
Message-ID: <CAOQ4uxhYuvs5_q+jqL-OAXzfPJv_NJTQpkGPzysGhq4i+WSjPw@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] fsnotify: Do not generate events for O_PATH
 file descriptors
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
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it,
 Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMTcsIDIwMjQgYXQgNzoyM+KAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gQ3VycmVudGx5IHdlIHdpbGwgbm90IGdlbmVyYXRlIEZTX09QRU4gZXZlbnRz
IGZvciBPX1BBVEggZmlsZQo+IGRlc2NyaXB0b3JzIGJ1dCB3ZSB3aWxsIGdlbmVyYXRlIEZTX0NM
T1NFIGV2ZW50cyBmb3IgdGhlbS4gVGhpcyBpcwo+IGFzeW1tZXRyeSBpcyBjb25mdXNpbmcuIEFy
Z3VhYmx5IG5vIGZzbm90aWZ5IGV2ZW50cyBzaG91bGQgYmUgZ2VuZXJhdGVkCj4gZm9yIE9fUEFU
SCBmaWxlIGRlc2NyaXB0b3JzIGFzIHRoZXkgY2Fubm90IGJlIHVzZWQgdG8gYWNjZXNzIG9yIG1v
ZGlmeQo+IGZpbGUgY29udGVudCwgdGhleSBhcmUganVzdCBjb252ZW5pZW50IGhhbmRsZXMgdG8g
ZmlsZSBvYmplY3RzIGxpa2UKPiBwYXRocy4gU28gZml4IHRoZSBhc3ltbWV0cnkgYnkgc3RvcHBp
bmcgdG8gZ2VuZXJhdGUgRlNfQ0xPU0UgZm9yIE9fUEFUSAo+IGZpbGUgZGVzY3JpcHRvcnMuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBKYW4gS2FyYSA8amFja0BzdXNlLmN6PgoKTG9va3MgZ29vZC4KClJl
dmlld2VkLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgoKPiAtLS0KPiAg
aW5jbHVkZS9saW51eC9mc25vdGlmeS5oIHwgOCArKysrKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9mc25vdGlmeS5oIGIvaW5jbHVkZS9saW51eC9mc25vdGlmeS5oCj4gaW5kZXggNGRhODBl
OTJmODA0Li4yNzg2MjBlMDYzYWIgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9mc25vdGlm
eS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9mc25vdGlmeS5oCj4gQEAgLTExMiw3ICsxMTIsMTMg
QEAgc3RhdGljIGlubGluZSBpbnQgZnNub3RpZnlfZmlsZShzdHJ1Y3QgZmlsZSAqZmlsZSwgX191
MzIgbWFzaykKPiAgewo+ICAgICAgICAgY29uc3Qgc3RydWN0IHBhdGggKnBhdGg7Cj4KPiAtICAg
ICAgIGlmIChmaWxlLT5mX21vZGUgJiBGTU9ERV9OT05PVElGWSkKPiArICAgICAgIC8qCj4gKyAg
ICAgICAgKiBGTU9ERV9OT05PVElGWSBhcmUgZmRzIGdlbmVyYXRlZCBieSBmYW5vdGlmeSBpdHNl
bGYgd2hpY2ggc2hvdWxkIG5vdAo+ICsgICAgICAgICogZ2VuZXJhdGUgbmV3IGV2ZW50cy4gV2Ug
YWxzbyBkb24ndCB3YW50IHRvIGdlbmVyYXRlIGV2ZW50cyBmb3IKPiArICAgICAgICAqIEZNT0RF
X1BBVEggZmRzIChpbnZvbHZlcyBvcGVuICYgY2xvc2UgZXZlbnRzKSBhcyB0aGV5IGFyZSBqdXN0
Cj4gKyAgICAgICAgKiBoYW5kbGUgY3JlYXRpb24gLyBkZXN0cnVjdGlvbiBldmVudHMgYW5kIG5v
dCAicmVhbCIgZmlsZSBldmVudHMuCj4gKyAgICAgICAgKi8KPiArICAgICAgIGlmIChmaWxlLT5m
X21vZGUgJiAoRk1PREVfTk9OT1RJRlkgfCBGTU9ERV9QQVRIKSkKPiAgICAgICAgICAgICAgICAg
cmV0dXJuIDA7Cj4KPiAgICAgICAgIHBhdGggPSAmZmlsZS0+Zl9wYXRoOwo+IC0tCj4gMi4zNS4z
Cj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
