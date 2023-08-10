Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7532C001DB
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 13:30:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E22373CD420
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 15:30:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BA733C62E0
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 15:30:45 +0200 (CEST)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2A3AD1000521
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 15:30:45 +0200 (CEST)
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-79a83720538so317794241.1
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691674244; x=1692279044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoRDAvuRSylcere8SIeT9uxRMGeuxUzRw0sCKcLFQI4=;
 b=eULTR0nb1p9L4C/h88y+YQLI3gnQj0tHaUMHScbpHeiXKqpxxuHGrrkVtRijOihJ/z
 0IXveYu/gIqKg+4v+/m+KKJrhgfi1teNEbkinoPgfgJyTB0bRvlcQPS0EGgagKCGpgAX
 18OKu5qFBk5Ul7W8avF8E0agI9jO0klLuZ+6hKBwQaLOe6UOE1Drrtq8xHxHVL67+T3W
 EL4PKcYhWVhZ3JM+G+MrdkuWvKyeNP8YdgkfEQ/1SkHBH3tHszV5X6ZTeUER6o73nogN
 ry24y3SmvT0EPBOs+z8TQODvJTwHFO+85ipGoPEZAmtZFbMP6vWsZorJUupDDgu2ys99
 nvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691674244; x=1692279044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoRDAvuRSylcere8SIeT9uxRMGeuxUzRw0sCKcLFQI4=;
 b=kAB00FAZ3+31L2ZFKw/ulpJNccK/o5qioGrL5Dn8eXbWDnFEVAsVaZyK3Q90B+HUpx
 uQzvfGZ9pIdGahE5dvlAGm/KJ2MPs1VUnSJpxCE3zRZ+Rom0yx/HijWkPKXUiQ5HNnAu
 Ucmeqmv/q9KGSe8uZLk1fylB6zqnUB5IP+etCH77Gx5fBioJrPOfWMHre4C3P2kvw0RR
 THPMtvSp+HYOILP4J6IONyEML9eB8IGtEUwtbg7N4/NcA//zpXKcRBilOS2CBnFKaSV9
 /XtEK5EXt9jN4KmRqAbvTKjG9ai1OVZEXQrQ/C4F7ajWNqF3D7Y/t7xWi6QRgPsue3pK
 EzGA==
X-Gm-Message-State: AOJu0YwjJ3ZG5395DM4DNEa/eT6Tv8877XsmzJtxb0yYl/KcxXCp2VuY
 fmVi6GnVL6/M57gLXiSHlaBU6W/vc5VkOe4GfOGDGOIzcu4FCQ==
X-Google-Smtp-Source: AGHT+IHNhVCn5cLUVqkdQNf/nVdQZ78SOi6QNSlpoaRpYZUbYeHdm/AWPeHSDLfohrV1zJxtBwvyLIVkzz8QopxPF7I=
X-Received: by 2002:a67:f98b:0:b0:443:9873:6546 with SMTP id
 b11-20020a67f98b000000b0044398736546mr1641811vsq.34.1691674243947; Thu, 10
 Aug 2023 06:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230810131012.13026-1-jack@suse.cz>
In-Reply-To: <20230810131012.13026-1-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 10 Aug 2023 16:30:32 +0300
Message-ID: <CAOQ4uxiY3Qajthb_kVhzGbuzqzJvUWXdF4HRW=YtaojQ1Ys3DA@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify23: Make evictable marks tests more
 reliable
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
Cc: ltp@lists.linux.it, petr.vorel@suse.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgNDoxMOKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gSXQgaGFzIGJlZW4gb2JzZXJ2ZWQgdGhhdCB3aGVuIGZhbm90aWZ5MjMgdGVz
dCBpcyBydW4gaW4gYSBsb29wLCBpdAo+IGV2ZW50dWFsbHkgZmFpbHMgYXM6Cj4KPiBmYW5vdGlm
eTIzLmM6MTEyOiBUUEFTUzogRkFOX01BUktfQUREIGZhaWxlZCB3aXRoIEVFWElTVCBhcyBleHBl
Y3RlZCB3aGVuIHRyeWluZyB0byBkb3duZ3JhZGUgdG8gZXZpY3RhYmxlIG1hcmsKPiBmYW5vdGlm
eTIzLmM6NzU6IFRQQVNTOiBGQU5fTUFSS19SRU1PVkUgZmFpbGVkIHdpdGggRU5PRU5UIGFzIGV4
cGVjdGVkIGFmdGVyIGVtcHR5IG1hc2sKPiBmYW5vdGlmeTIzLmM6MTU2OiBUUEFTUzogR290IG5v
IGV2ZW50cyBhcyBleHBlY3RlZAo+IGZhbm90aWZ5MjMuYzo4MTogVEZBSUw6IEZBTl9NQVJLX1JF
TU9WRSBkaWQgbm90IGZhaWwgd2l0aCBFTk9FTlQgYXMgZXhwZWN0ZWQgYWZ0ZXIgZHJvcF9jYWNo
ZXM6IFNVQ0NFU1MgKDApCj4KPiBUaGlzIGlzIGJlY2F1c2UgcmVwZWF0ZWQgZXZpY3Rpb25zIG9m
IGNhY2hlcyBkb25lIGJ5IHRoZSB0ZXN0IHJlY2xhaW0KPiBhbGwgZnJlZWFibGUgc2xhYiBvYmpl
Y3RzIGluIHRoZSBzeXN0ZW0uIFNvIHdoZW4gdGhlIHRlc3QgY2FsbHMgZHJvcAo+IGNhY2hlcywg
b25seSB0aGUgZGVudHJ5IGFuZCBpbm9kZSBvZiB0aGUgdGVzdCBmaWxlIGFyZSB0aGVyZSB0byBy
ZWNsYWltLgo+IEJ1dCBmb3IgaW5vZGUgdG8gYmUgcmVjbGFpbWVkLCBkZW50cnkgKHdoaWNoIGhv
bGRzIGlub2RlIHJlZmVyZW5jZSkgaGFzCj4gdG8gYmUgZnJlZWQgZmlyc3QgYW5kIGZvciBkZW50
cnkgdG8gYmUgZnJlZWQgaXQgaGFzIHRvIGZpcnN0IGN5Y2xlCj4gdGhyb3VnaCB0aGUgTFJVIHdo
aWNoIHRha2VzIHR3byBzbGFiIHJlY2xhaW0gY2FsbHMuCj4KPiBDYWxsIGRyb3AgY2FjaGVzIHR3
aWNlIHRvIG1ha2Ugc3VyZSBkZW50cnkgaGFzIGNoYW5jZSB0byBwYXNzIHRocm91Z2gKPiB0aGUg
TFJVIGFuZCBiZSByZWNsYWltZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKYW4gS2FyYSA8amFja0Bz
dXNlLmN6Pgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90
aWZ5MjMuYyB8IDcgKysrKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
YW5vdGlmeS9mYW5vdGlmeTIzLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5
L2Zhbm90aWZ5MjMuYwo+IGluZGV4IDg5ZmQ0ZjM2YTA5Yi4uMmQ1MGY3MDU4NWI3IDEwMDY0NAo+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMy5jCj4g
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIzLmMKPiBA
QCAtMTYwLDEwICsxNjAsMTUgQEAgc3RhdGljIHZvaWQgdGVzdF9mYW5vdGlmeSh2b2lkKQo+ICAg
ICAgICAgfQo+Cj4gICAgICAgICAvKgo+IC0gICAgICAgICogZHJvcF9jYWNoZXMgc2hvdWxkIGV2
aWN0IGlub2RlIGZyb20gY2FjaGUgYW5kIHJlbW92ZSBldmljdGFibGUgbWFyawo+ICsgICAgICAg
ICogZHJvcF9jYWNoZXMgc2hvdWxkIGV2aWN0IGlub2RlIGZyb20gY2FjaGUgYW5kIHJlbW92ZSBl
dmljdGFibGUgbWFyay4KPiArICAgICAgICAqIFdlIGNhbGwgZHJvcF9jYWNoZXMgdHdpY2UgYXMg
b25jZSB0aGUgZGVudHJpZXMgd2lsbCBqdXN0IGN5Y2xlCj4gKyAgICAgICAgKiB0aHJvdWdoIHRo
ZSBMUlUgd2l0aG91dCBiZWluZyByZWNsYWltZWQgYW5kIGlmIHRoZXJlIGFyZSBubyBvdGhlcgo+
ICsgICAgICAgICogb2JqZWN0cyB0byByZWNsYWltLCB0aGUgc2xhYiByZWNsYWltIHdpbGwganVz
dCBzdG9wIGluc3RlYWQgb2YKPiArICAgICAgICAqIHJldHJ5aW5nLgo+ICAgICAgICAgICovCj4g
ICAgICAgICBmc3luY19maWxlKFRFU1RfRklMRSk7Cj4gICAgICAgICBTQUZFX0ZJTEVfUFJJTlRG
KERST1BfQ0FDSEVTX0ZJTEUsICIzIik7Cj4gKyAgICAgICBTQUZFX0ZJTEVfUFJJTlRGKERST1Bf
Q0FDSEVTX0ZJTEUsICIzIik7Cj4KPiAgICAgICAgIHZlcmlmeV9tYXJrX3JlbW92ZWQoVEVTVF9G
SUxFLCAiYWZ0ZXIgZHJvcF9jYWNoZXMiKTsKCklmIHRoaXMgaW1wcm92ZXMgdGhlIHJlbGlhYmls
aXR5IG9mIHRoZSB0ZXN0LCBJIGhhdmUgbm8gcHJvYmxlbSB3aXRoCnRoZSBzb2x1dGlvbiwKYnV0
IEkgYW0gYSBiaXQgdW5lYXN5IHdpdGggdGhlIGZhY3QgdGhhdCBmYW5vdGl5MTAgYW5kIGZhbm90
aWZ5MjMgaGF2ZSB0d28KZGlmZmVyZW50IG1pdGlnYXRpb25zLgoKQW55d2F5LCBJIHRoaW5rIHRo
YXQgdGhlIGV4cGxhbmF0aW9uIGFib3ZlIGlzIHRydWUgZm9yIHNvbWUgZnMgYnV0IHhmcwppbm9k
ZSBsaWZldGltZSBhbmQgc2hyaW5rZXJzIGZvciBleGFtcGxlIGFuZCBtb3JlIGNvbXBsZXgsIHNv
IGl0IGRvZXMKbm90IGhvbGQuIFJpZ2h0PwpNZWFuaW5nIHRoYXQgdGhlIGV4cGxhbmF0aW9uIGlz
IHRydWUgYmVjYXVzZSBmYW5vdGlmeTEwIGhhczoKCiAgICAgICAgLyogU2hyaW5rZXJzIG9uIG90
aGVyIGZzIGRvIG5vdCB3b3JrIHJlbGlhYmx5IGVub3VnaCB0bwpndWFyYW50ZWUgbWFyayBldmlj
dGlvbiBvbiBkcm9wX2NhY2hlcyAqLwogICAgICAgIC5kZXZfZnNfdHlwZSA9ICJleHQyIiwKCk1h
eWJlIHRoYXQgc2hvdWxkIGJlIHNwZWxsZWQgb3V0PwoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
