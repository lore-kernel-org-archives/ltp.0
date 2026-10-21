Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700FD606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=CJBKY8Yn;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cvNAmbpQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792566881; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ij51DUU2K/VzN9b/XFcRAke3yJ0N2qnXyTWJRAiBr2Y=;
 b=CJBKY8YnkS28vuToxDitKZRWb62eB9+/FfUEUtsaclPn5J6PDFVFygcKCGPVWUsnF8tWt
 Vl8ikPnLBhKW1E/oi5lQqaGTlDp+Mtg8VZaLQ8MeijoWU/ow6G3aj2sCzTDocmO+WrZ/D9d
 DLauL17nsCSwbmIlf6oA8uvTatZOoRk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FF763E60E9
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:14:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF9763E2717
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 09:14:20 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A519460090C
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 09:14:19 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so972559f8f.0
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792566859; x=1793171659; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rmCh1y1IlUMsfUJRHyuH7hrX0fbTASQwrRP5k/0ILEo=;
 b=cvNAmbpQ6zfFVKcWrcJr+gMFJ7fBrO53qzTOWEXrWPWyGCO8IpnVeVvC/FbqITtJoT
 uLU7QjRZPkMGkdfJ77SDVyjX85N+tkeOtqfCcOLy1zDcN5AHkUz6n8hOl+ZwY3UBkkoD
 tJnKblrvXn2ld+3/n/mgYpF2k+eisI4+sicsR0ZxTyV8npINeWet82pDNl7dQe6R5+pt
 +MbNTTA/OskoF1WrQsfxpePggbb/ucMsTc+4AT91c+2a//yIG5H1QQTRhQrt3UfcUas9
 gh/0z1DEcNPSbPfwLY+2d9h4H9W6EXdMgfcTizU4m6nKr1lkIRsqR6+2aFpqExe/UZnv
 tEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792566859; x=1793171659;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rmCh1y1IlUMsfUJRHyuH7hrX0fbTASQwrRP5k/0ILEo=;
 b=AoO4P2dJ9bY7a6xnvmSrfFL7DjhYbABVQeej/3Ys8uTheBj5qpXMAwoe49rfwLJKH9
 37w5KIfG+izXG3q8kN4ryQoIyeAPcJbOqjSX2OGIuEUwEKvKMJ9vUk16hQolaEwtpC8G
 YVw3tIEwzBmPJJPUSqOa3vAGWiL2x+vKDR1t2+AdSVdU5SDIch0y5r5sSHG1D5v/9B6K
 B/HRJCUiaVPpqyo9d2lv9Q8hX8NT8QqM22JpqPSxKAUD2I7v8PV0uINoGma5urn6SHwM
 /vOoH8x4oSQKQzDgFDSG5nED9mLEdbmTnKADxgdeR/DywxHXUfZzwhRYokD2Ku6A2SFz
 t6FQ==
X-Gm-Message-State: AFq9FYJKI0iKZX0xrzGsLO5lCMJneqcmtWdxwrlUBNEK28Uhb1cdXUF1
 RZuPxYqbTdkAZuj+u0Xq+5V4/OuCkANPolTSzga8e/ZAVOa0JXilL2BlwC6B18UIiyc=
X-Gm-Gg: AYBFou2UtdTDbgIqTrDnZwZrZwSzzUJ6DezxQdbfSKgXU05mL8vVHP3Klma7vskWsVT
 pn/rfPkiVx/Z+y7EUjEenLqf70JkFHeGMrNM0JP9PYRzxXz7RwYSntm7iNWoky16h5jxsxbqRuU
 w+oJYRSApQFwPa5Vp/d8nOQSt6WKIz5ma2a/jFRm2SeMvdWyFS6KAizTMD9wB06SNhdkbRQxxo+
 u9VRsCsGoC/yltxmemVsJAP2W2FDkyu8ioCAmr2ou7c2CnW+AqIsdjJ7KvZU5BPDzOfSUD8leQY
 QVqSGNrtld0ZzWTBg5Q61csGgVsI7MVetGE8/ExgAlmBb4XbqqIOJ+KeEL0bXjlz0Uo4qdbaKwM
 u1lqVsB9EoT0vrflBQ7gc0qCEvZTez7mJjMRpdC5q3ECTznkgh7uinjiI2/4lm0PvE78mQzrm5m
 +NdnTrHvaDt0s6pRoB3UaQWJeImgz9uSrpPq6fZcVBPjtoEeoXStgneN8QWdml3w5N7d4wUFiy2
 6NkBQ0ctB0X9qh9nhj9Oo4IcUbOb8Cw79BmL/pahNzfNztKJ/lB3l0OcQkq4YqR4jc+6Rfnk1GB
 Au5vdWlAAHvTCYMGDDEFu8kuN40vPXMArTjPSd69BCOCChx2CcpKK9sazqQ=
X-Received: by 2002:a05:600c:4f11:b0:4a2:30:f4ff with SMTP id
 5b1f17b1804b1-4a20030f54dmr9024855e9.1.1792566859033; 
 Wed, 21 Oct 2026 00:14:19 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a200f4d16bsm932695e9.2.2026.10.21.00.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 00:14:18 -0700 (PDT)
Message-ID: <4EkJ88xMyWBqTKeQ8KRctlqrIv8JfY4VYo5D@localhost.localdomain>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <as2dZ8VBuN2NM3TZ@linux.dev>
Date: Wed, 21 Oct 2026 07:14:17 +0000
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: LTP List <ltp@lists.linux.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGkgLyBldmVyeW9uZSwKCj4gSGkgQW5kcmVhLAo+IAo+ID4gSGVsbG8gZXZlcnlvbmUsCj4g
PiAKPiA+IHdoYXQgYWJvdXQgc2NoZWR1bGluZyBhIG5ldyBMVFAgbWVldGluZyBhZnRlciB0aGUg
cmVsZWFzZT8KPiA+IFdoZW4ncyB5b3VyIGZpcnN0IGF2YWlsYWJsZSBkYXRlPwo+IAo+IFNvdW5k
cyBnb29kLgo+IAo+IE15IGF2YWlsYWJpbGl0eSBpcyBvbiB3ZWVrZGF5cywgNOKAkzYgUE0gQmVp
amluZyB0aW1lIChVVEMrOCksIHdoaWNoCj4gc2hvdWxkIGJlIDnigJMxMSBBTSBDRVQuIAo+IAo+
IEl0IG1pZ2h0IGJlIGJldHRlciB0byBzaGFyZSBhbiBhZ2VuZGEgb3IgZGlzY3VzcyB0aGUgdG9w
aWNzIGJlZm9yZWhhbmQuCgpzb3JyeSBmb3IgbXkgZGVsYXksIGNyYXp5IHRpbWVzLgoKSSB3b3Vs
ZCBsaWtlIHRvIGhhdmUgYSBMVFAgbWVldGluZywgaWYgeW91IHdhbnQgd2UgY2FuIGRvIGl0IGF0
IDEwYW0gdGhlIG5leHQKd2VlayBpZiB3ZWRuZXNkYXkgYXJlIHRoZSBvbmx5IG9wdGlvbi4KCkBQ
ZXRyIEBDeXJpbCBXRFlUPwoKLS0KQW5kcmVhIENlcnZlc2F0bwpTVVNFIFFFIEF1dG9tYXRpb24g
RW5naW5lZXIgTGludXgKYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
