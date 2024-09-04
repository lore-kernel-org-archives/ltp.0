Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A546CA0ED3
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 08:58:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 754D03C1CA5
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 10:58:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 423403C0596
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 10:58:12 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9C159616622
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 10:58:11 +0200 (CEST)
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7a8116a4233so304687085a.2
 for <ltp@lists.linux.it>; Wed, 04 Sep 2024 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725440290; x=1726045090; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dd1uY+joNbio4dYy8AygSCYG0ImPzDMirwHV46YNFJ8=;
 b=kczd/h9TtsfbtbeVs0qpcDDL51NQdrBWYtFONAxhoenlsiyW+0Kz0UbjDr/rusVL/w
 4QD7UD4i0oZWw/ZsPbULog6QxqJUYbNX8EidYZ9fVfvJ8Z1oZVnr9Bt9dOW8NrYD4uQS
 h/bnAmwpW/jLZUtHkHE1cLoOzphw9Z8pAzAj0bPdbE5iNiUf7IMunwI0p4eRaS68x19f
 6v9oZgONKpScqJs7lvg9/YePxgBDGyHne5NsMeyNXTYDuv3V2SnvpvSlYGm/hbj3A8Ef
 kIdrctbGVK47WzujqvcrDdPeQeWIVZkXO5t9wArLaSFYsWbFyz37ebOCu2UHg8t4EBjs
 RRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725440290; x=1726045090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dd1uY+joNbio4dYy8AygSCYG0ImPzDMirwHV46YNFJ8=;
 b=mvMTzrytYL+2DDZq9RWvgUWl87jcjqymSg9TBvXyK1mwdLNFyn59iJPCyP/FXR9bZd
 /594O/1UO/v/dKvDlkzRUcYAjXV/QJ4ZHrz25lh/7w7D7iBtmHT7mg4zHchrz2ASbidy
 SDpgvxAHAgGfJA9VZybzdbyUphN7Vwb7wBHp7OEUWPdI2et3oCjMMgYSOGzQwrlSxIWJ
 JMIAUKVVcxTZ3m0K7syvAuHzWqtt2ibWxAz8NyB8+RpYy3bIQ7AIzW0E6B+FSkzz57N/
 ou6/7SHcLmV4AKklNxXTnUpWTwaJ2ZkaseiodoMF23vg67Mi3cLJL9oV6U9UXCnOmamn
 JdMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLa0bVH2t1WRYv0lpQUNOYgb8VVuq8tIxS+q8zHrDQNlTDOl3p+bXz/ShhtjIQUAlHL3E=@lists.linux.it
X-Gm-Message-State: AOJu0Yxtre1IW4CAX0mQIXLfkKoEBmm9xodO1yDCnKb7G8qZG/aGtGCJ
 HNB2RYtl6WzHNDeRSAmlgzaUCFA+p+IwzuF+/TtyXGM7pioFyHnonVuHrvN9wuxcvBcVQDcnLLw
 mQRL7ZLKjl6Pd4rlGEgzPS30F+NU=
X-Google-Smtp-Source: AGHT+IEhnK7cesWuj4K3ZgVK/UZNShWYk2rslRhGhOriTLoY9uQJ7ntE5C17B5EzY7GrCUFySwdGuOMYsC6NlHu9HiQ=
X-Received: by 2002:a05:620a:280c:b0:7a3:49f2:fc1f with SMTP id
 af79cd13be357-7a97bcb591emr513620285a.40.1725440290277; Wed, 04 Sep 2024
 01:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240830130003.3245531-1-wozizhi@huawei.com>
 <20240903140807.GA762653@pevik>
In-Reply-To: <20240903140807.GA762653@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 4 Sep 2024 10:57:58 +0200
Message-ID: <CAOQ4uxhBf5Eac=Dyo0VT9+7gQqVrXLYeharprXNZ-tq+pyzFJg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify10: Calling drop_cache twice to ensure
 the inode is evicted
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
Cc: yangerkun@huawei.com, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBTZXAgMywgMjAyNCBhdCA0OjA44oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+Cj4gSGkgYWxsLAo+Cj4gPiBJbiB0aGlzIHRlc3QgY2FzZSwgc29tZSBzY2Vu
YXJpb3MgYXJlIGRlc2lnbmVkIHRvIHZlcmlmeSB3aGV0aGVyIHRoZQo+ID4gRkFOT1RJRllfRVZJ
Q1RBQkxFIGZsYWcgdGFrZXMgZWZmZWN0OiBieSB2ZXJpZnlpbmcgdGhhdCBpbmZvcm1hdGlvbiBj
YW5ub3QKPiA+IGJlIG9idGFpbmVkIGZyb20gdGhlIGNvcnJlc3BvbmRpbmcgaW5vZGUgYWZ0ZXIg
ZHJvcF9jYWNoZSwgYXMgdGhpcyBmbGFnCj4gPiBkb2VzIG5vdCBwaW5nIHRoZSBpbm9kZS4KPgo+
ID4gSG93ZXZlciwgZHJvcF9jYWNoZSBpcyBvbmx5IHBlcmZvcm1lZCBvbmNlIGhlcmUsIHdoaWNo
IG1heSByZXN1bHQgaW4gdGhlCj4gPiBpbm9kZSBub3QgYmVpbmcgcmVsZWFzZWQgaW4gTlVNQSBz
Y2VuYXJpb3MuIFN1cHBvc2UgdGhlIGlub2RlIGlzIGxvY2F0ZWQKPiA+IG9uIE5VTUEwIGFuZCB0
aGUgZGVudHJ5IGlzIGxvY2F0ZWQgb24gTlVNQTE7IHRoZSBmaXJzdCBkcm9wX2NhY2hlIGNhbiBv
bmx5Cj4gPiBlbnN1cmUgdGhhdCB0aGUgaW5vZGUgaXMgYWRkZWQgdG8gdGhlIExSVSBsaXN0LCBi
dXQgZG9lcyBub3QgZ3VhcmFudGVlIHRoYXQKPiA+IGV2aWN0KCkgY2FuIGJlZW4gY2FsbGVkIGJl
Y2F1c2UgZGlzcG9zZV9saXN0IGRvZXMgbm90IHlldCBpbmNsdWRlIHRoaXMKPiA+IGlub2RlIHdo
ZW4gdHJhdmVyc2luZyBOVU1BMCwgd2hpY2ggY2F1c2VzIHRoZSB0ZXN0Y2FzZSBleGVjdXRpb24g
ZmFpbC4KPgo+IEkgd29uZGVyIGlmIHRoZXJlIGNhbiBiZSBzb21lIGRldGVjdGlvbiB0aGF0IGlu
b2RlIGlzIGV2aWN0ZWQuCj4gT3IsIGNhbiBpdCBoYXBwZW4gdGhhdCBldmVuIDJ4IGRyb3AgaXMg
bm90IGVub3VnaD8KPgo+ID4gRm9yIHRoZSBzaW5nbGUtZmlsZSBzY2VuYXJpbyBpbiB0aGlzIHRl
c3RjYXNlLCBleGVjdXRpbmcgZHJvcF9jYWNoZSB0d2ljZQo+ID4gaXMgbmVjZXNzYXJ5IHRvIGVu
c3VyZSB0aGUgaW5vZGUgaXMgZXZpY3RlZCwgdGh1cyBhbGxvd2luZyB0aGUgdGVzdGNhc2UgdG8K
PiA+IHBhc3MuCj4KPiBBY2tlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KPiBA
QW1pciwgSmFuLCBjb3VsZCB5b3UgcGxlYXNlIGhhdmUgYSBsb29rPwo+CgpTYW1lIHNvbHV0aW9u
IHdhcyBhbHJlYWR5IGFwcGxpZWQgdG8gZmFub3RpZnkyMwoKOGNjZjViNDVjIGZhbm90aWZ5MjM6
IE1ha2UgZXZpY3RhYmxlIG1hcmtzIHRlc3RzIG1vcmUgcmVsaWFibGUKClNvIEFDSy4KCkJUVywg
ZmFub3RpZnkyMyBhbHNvIHJlc3RyaWN0cyBpdHNlbGYgdG8gZXh0MiBmb3IgbW9yZSBkZXRlcm1p
bmlzdGljCmlub2RlIGV2aWN0aW9uIGJlaGF2aW9yLCBzbyB0aGlzIGNvdWxkIGJlIGNvbnNpZGVy
ZWQgZm9yIGZhbm90aWZ5MTAgYXMgd2VsbC4KCkZvciBleGFtcGxlLCBBRkFJSywgeGZzIGhhcyBp
dHMgb3duIGludGVybmFsIGV2aWN0aW9uIGxvZ2ljLCB3aGljaCBjYW4ga2VlcAppbm9kZXMgaW4g
Y2FjaGUgZm9yIG9uZSBtb3JlIHNocmlua2VyIGN5Y2xlLgoKVGhhbmtzLApBbWlyLgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
