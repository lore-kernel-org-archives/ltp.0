Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12231D609C4
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 09:42:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24B123DB593
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 10:42:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB0CF3DB35F
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 10:42:28 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2D7C0100C6AC
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 10:42:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732700546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J7XlJolDgzpz8BHxgftOsyhg33WdppMYRPJA7DVgE7M=;
 b=Ex3pQyud3uV9jRgIg+IYVk/gk2Wk2Q0Ri9yK32ikrKCFhI0MxxSCwjv5qPtzXa47B4Q7iX
 ESL/Le8JBHObsNnMNxLtIv5H4ftykuIRwPDgAEIfxdPBeYLCPQVetEfccYiIL1wrbQEFfM
 h6MStNgTkHf9POb8cjdts9utJmO9KUQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-u2qxrEFIPW-dci6o8Y0Vog-1; Wed, 27 Nov 2024 04:42:23 -0500
X-MC-Unique: u2qxrEFIPW-dci6o8Y0Vog-1
X-Mimecast-MFC-AGG-ID: u2qxrEFIPW-dci6o8Y0Vog
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7fc2dc586eeso2643757a12.1
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 01:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732700543; x=1733305343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J7XlJolDgzpz8BHxgftOsyhg33WdppMYRPJA7DVgE7M=;
 b=BhdxpHqfGr/KjlJjUVzplcipDQDFLABhTQeutFT7jTyM2CjSOM+retAJgqhp5Q9qQb
 t3TTRB2FzfjPzsEeLxFPfaEUkdT1V5Q6prPGZPlzb3KuzEw0IToHgpWA0HIiBogvMn4e
 JMMjuyQaOYfrIn2AuhgHyF46FRxeg8GrKc/AnUdE0B2P7AtgxsIASn5bIoD//qogt8bB
 +wOXggarxNhyv+FLYV9m6cBUjmJ3x3OoLgq0rJBSjDUGG7p1dqVZU8l2AK1RA0EpI7kS
 KSiJGmZsuXSOzckFNEotmSiqRhJ2Ool2fzKCE5o9+N/vCuXgjse6pcANqTb+Dm2xUnuP
 shmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeQZflilvDSddv98XPbPA3wiCXwa8pYcvNia/rBFv+U5qcgpI8Erl4CNrLuzLNWma0sLE=@lists.linux.it
X-Gm-Message-State: AOJu0YzKQLVgEke9/ZXOoJUIKgAsXA4NJEN5AJipA1Gwsgi2bVSy5Gpg
 Pw5CTqBHSfKoiW8tpFKg08eOVnhjaXMHuXP8ReGX4QXY9GG5JJJsGFs/C6xk8sYu5q8TwYZR3xE
 iMa6jKTfmYpEXSynIYjis0+dsVDHIFH81msrrjzDMjTDUwxaEhJN0cOTPbZPBjfo6BY6hBp1Iwu
 dMPJyZ/1WkVns+h6zI6CMMNcg=
X-Gm-Gg: ASbGncsH9L8h5g1k6qPIkmmjyCR/fyoVACII9JOgLXLKgK3yq8kyuuRKM47xKdQSXJI
 /zQzmB3JaKu6157cBQp+nDO/hm8yInu4Y
X-Received: by 2002:a05:6a20:6f0a:b0:1e0:d766:8da1 with SMTP id
 adf61e73a8af0-1e0e0c033c3mr3459844637.39.1732700542765; 
 Wed, 27 Nov 2024 01:42:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUapF/iSLjKv6dw2XrXDzeBIG6ESbe4uzdUG33wDM5TCO/esM0EMgWKDy3t4ZjNx8X+/KVOi8kvSiBeV5AGYk=
X-Received: by 2002:a05:6a20:6f0a:b0:1e0:d766:8da1 with SMTP id
 adf61e73a8af0-1e0e0c033c3mr3459835637.39.1732700542476; Wed, 27 Nov 2024
 01:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20241115164101.17983-1-chrubis@suse.cz>
 <CAASaF6wWy6HwbBRmTQcYg3WRwhxexE1ZUernL4WKQzOJYeO+Eg@mail.gmail.com>
 <Z0XgJVa9czWm2YMc@yuki.lan>
In-Reply-To: <Z0XgJVa9czWm2YMc@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Nov 2024 17:42:10 +0800
Message-ID: <CAEemH2f9dBfdJM2DkdCnfaxFbMvtWM+USbkuvDcL=DDZs3sopQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AtHtwXKkM6YyXleXQgbjag-xhzTvtFE2bxU4KUccG6I_1732700543
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] [RFC] lib/tst_test.c: Fix tst_brk() handling
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

T24gVHVlLCBOb3YgMjYsIDIwMjQgYXQgMTA6NTDigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+ID4gPiBUaGlzIG1ha2VzIHRoZSB0c3RfYnJrKCkgaGFu
ZGxpbmcgY2xlYW5lciBhbmQgc2FuZXIgYXMgaW5zdGVhZCBvZgo+ID4gPiBwcm9wYWdhdGluZyB0
aGUgdHN0X2JyaygpIHJlc3VsdCBpbiBhIHJldHVybiB2YWx1ZSBhbiBhYm9ydCBmbGFnIGlzCj4g
PiA+IGludHJvZHVjZWQgaW50byB0aGUgc2hhcmVkIG1lbW9yeS4KPiA+ID4KPiA+ID4gTm93Ogo+
ID4gPgo+ID4gPiAtIEFsbCB0aGUgcHJvY2Vzc2VzIGJ1dCB0aGUgbGlicmFyeSBvbmUgdGhhdCBy
ZXBvcnRzIHRoZSByZXN1bHRzIGV4aXQKPiA+ID4gICB3aXRoIDAKPiA+ID4gLSB0c3RfYnJrKFRC
Uk9LLCAuLi4pIGluY3JlbWVudHMgcmVzdWx0IGNvbnRlcnMsIHNldHMgdGhlIGFib3J0IGZsYWcu
Cj4gPiA+ICAgYW5kIGV4aXQgY3VycmVudCBwcm9jZXNzCj4gPiA+IC0gYWxsIG90aGVyIHRzdF9i
cmsoKSB2YXJpYW50cyB3aWxsIGp1c3QgaW5jcmVtZW50cyB0aGUgY291bnRlcyBhbmQKPiA+ID4g
ICBleGl0cyB0aGUgY3VycmVudCBwcm9jZXNzCj4gPgo+ID4gSXQgcmVtb3ZlcyB0aGUgZWFzeSB3
YXkgZm9yIHBhcmVudCB0byBjaGVjayB0aGF0IGNoaWxkIGhhc24ndCBydW4gaW50bwo+ID4gYW55
IGlzc3VlcywKPiA+IGJ1dCBJIGNhbid0IHJlY2FsbCBhIHNwZWNpZmljIHRlc3Qgd2UgaGF2ZSB0
b2RheSB0aGF0IGRlcGVuZHMgb24gaXQuCj4KPiBJIHN1cHBvc2UgdGhhdCB3ZSBjYW4gbWFrZSB0
aGUgdHN0X2JyayBmbGFnIHBhcnQgb2YgYSBwdWJsaWMgQVBJIGlmCj4gYW55b25lIG5lZWRzIHRo
YXQgYnV0IEkgZ3Vlc3MgdGhhdCBpbiB0aGUgY2FzZSBvZiB0c3RfYnJrKFRCUk9LLCAuLi4pCj4g
YWxsIHdlIHdhbnQgaXMgdG8gbWFrZSB0aGUgdGVzdCBwcm9jZXNzZXMgZXhpdCBhcyBzb29uIGFz
IHBvc3NpYmxlLgo+Cj4gPiA+IFRoaXMgbWFrZXMgdGhlIHRzdF9icmsoKSBiZWhhdmlvciB3ZWxs
IGRlZmluZWQgc28gd2UgY2FuIG5vdyBldmVuIGNhbGwKPiA+ID4gdHN0X2JyaygpIHdpdGggVEZB
SUwgYW5kIFRQQVNTIGFzIHdlbGwuCj4gPgo+ID4gV2hhdCdzIHRoZSB1c2UtY2FzZSBmb3IgaXQ/
IFdvdWxkbid0IGl0IGJlIG1vcmUgY2xlYXIgdG8ganVzdCByZXBvcnQKPiA+IFRQQVNTICsgZXhp
dD8KPgo+IEkgdGhpbmsgdGhpcyBtYWtlcyBhY3R1YWxseSB0aGUgQVBJIG1vcmUgY29uc2lzdGVu
dC4gSS5lLiB0c3RfcmVzKCkKPiByZXBvcnRzIHJlc3VsdCBhbmQgdHN0X2JyaygpIHJlcG9ydHMg
cmVzdWx0IGFuZCBleGl0cyB0aGUgY3VycmVudAo+IHByb2Nlc3MuCj4KPiBJIHRoaW5rIHRoYXQg
d2UgYWxsIGNhcnJ5IGEgbWVudGFsIGJhZ2dhZ2UgdGhhdCBhc3NvY2lhdGVzIHRoZSB0c3RfYnJr
KCkKPiBjYWxsIHdpdGggYW4gZXJyb3IsIGJ1dCB0aGF0IGlzIHNvbWV0aGluZyB3ZSBmb3JjZWQg
dXBvbiBvdXJzZWx2ZXMuCj4gQUZBSUsgaXQncyBzaG9ydCBmb3IgdHN0X2JyZWFrLCB3aGljaCBp
dHNlbGYgb25seSBzdWdnZXN0cyB0aGF0IGl0IGRvZXMKPiBleGl0IHRoZSBjdXJyZW50IHByb2Nl
c3MsIHNpbWlsYXIgdG8gYnJlYWsgYmVpbmcgdXNlZCBpbiBzd2l0Y2goKQo+IHN0YXRlbWVudC4K
PgoKSW5kZWVkLiBXaXRoIHRoaXMgY2hhbmdlLCB3ZSBkb24ndCBoYXZlIHRvIHVzZSAidHN0X3Jl
cygpICsgcmV0dXJuIiBmb3IKc29tZSBzaXR1YXRpb25zLApvbmx5IHRzdF9icmsoVFBBU1MsICkg
d291bGQgYmUgZW5vdWdoLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
