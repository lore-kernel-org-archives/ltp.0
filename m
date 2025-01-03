Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F656E7718F
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 08:36:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0E4E3EE098
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 09:36:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC30B3EE096
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 09:35:45 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1D6A21BBEDD1
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 09:35:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735893343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OvCSuHk7GISKWs1wmIxKhLxbWzxjBnFlcMeu39NmZqg=;
 b=ZoMOJWiGB07JtD8+HXDUR3xhIuLtTPdUsXZ4cI5t2h0MhELgavdFCj4fq70AAVP3cASC4G
 B/DTOxOoIdUxCRw6gKkShNdtimtTRYPY+JAKrUL/v8AhZpvqU45Zkn7IqX2AM0bOWtq3AA
 PYNf5UryefkdvZPL4wS5LwphRfh6I8Q=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-9FhAR8NSNKikWLDjksEpvw-1; Fri, 03 Jan 2025 03:35:41 -0500
X-MC-Unique: 9FhAR8NSNKikWLDjksEpvw-1
X-Mimecast-MFC-AGG-ID: 9FhAR8NSNKikWLDjksEpvw
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2f46b7851fcso21169926a91.1
 for <ltp@lists.linux.it>; Fri, 03 Jan 2025 00:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735893340; x=1736498140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OvCSuHk7GISKWs1wmIxKhLxbWzxjBnFlcMeu39NmZqg=;
 b=a1hILIJ5IhDDkOgA9wYSUzPPRfVygzbzY6b8xSM2DQBMhIFTyvF0YAbMUoXEKNnGLk
 kR85lz0ca/AlGBN4VW+nziOjwIBBRBYpN1NpCa1tXxamBKp6ZAa/WS4COp3gy+tAWa4q
 iP5iVpmuKq9EJapJvaFVw37UKLTHC4uHMSEIkuQGhPooW67eSyG++olz+mqkCDwLDGAw
 Br65TnUpDjRVk55OaRxJL7MALxOV/YttHZFm2yoYEQ3W2oTIbviX6paHVU6DQ/dB98ro
 plC9ijHAD7jCqQc2IUn+54b4xmgxi4+xsS6nWEa1ghPvyz5tt2oQuWmClBR3NoHQstxL
 6+iQ==
X-Gm-Message-State: AOJu0YwA9nJuVCpIndN9hgjz6iyjcXWKfl6Wn8B6xpSEdu1Tqcd0/UOP
 LAvwWRWoRDt1wAviG7k5BoVSqV7BK3DMapIdJr4nqlqzopjSt/LrY4bhSt0QJUSISW1EWp2bqQK
 ohyS6q4IK84MdyNrqGiNbsZv5zHcYTcGmhjgKOnxrcp7STYTlB6urM007JZfdDuRBSChlpxBDjP
 DAP7hB94fid2mXPiWk6JbsjrU=
X-Gm-Gg: ASbGnctQvMsvhZO8EbaYefpfyNXIE6vKa0Lho5dmjneKwXTWDgOHwDwKXZ8106cHuy9
 XcnFQKwJYgA0EJLpGLJtkD7V5f+sF49rZWchu/X4=
X-Received: by 2002:a17:90a:e187:b0:2ee:8430:b847 with SMTP id
 98e67ed59e1d1-2f452dfcd26mr67703987a91.6.1735893340445; 
 Fri, 03 Jan 2025 00:35:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/yd2taa/mbCHl80PS9iSaTL07bxqvRFECK3m2RCQDyKO/W8M2hck+d6Q3Rn4lHjlVc8szyrkLVCy5GWpKegQ=
X-Received: by 2002:a17:90a:e187:b0:2ee:8430:b847 with SMTP id
 98e67ed59e1d1-2f452dfcd26mr67703974a91.6.1735893340181; Fri, 03 Jan 2025
 00:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20241126085808.14616-1-liwang@redhat.com>
 <20250102145903.GE94207@pevik>
In-Reply-To: <20250102145903.GE94207@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 3 Jan 2025 16:35:28 +0800
Message-ID: <CAEemH2dNVsJ4QhdNkQ=d8hPpEqvCTPGXQm6stCjfg3uVQkwx7A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DpQvlhPPtC-91KK4CRZLhCsiMa7iR4Zhmu8RAajZ0vA_1735893340
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] process_madvise01: running the test in mem_cg
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

T24gVGh1LCBKYW4gMiwgMjAyNSBhdCAxMDo1OeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IFRoZSBNQURWX1BBR0VPVVQgYmVoYXZpb3IgaW4g
dGhlIGtlcm5lbCBpcyBhZHZpc29yeSBhbmQgbWF5IHNraXAKPiA+IHN3YXBwaW5nIGlmIHRoZSBz
eXN0ZW0gaGFzIHN1ZmZpY2llbnQgZnJlZSBSQU0sIGV2ZW4gd2hlbiB0aGUKPiA+IGFkdmljZSBp
cyBleHBsaWNpdGx5IHJlcXVlc3RlZC4gVGhpcyBjYXVzZXMgc3BvcmFkaWMgZmFsc2UgcG9zaXRp
dmVzCj4gPiBpbiBvdXIgQ0ksIHBhcnRpY3VsYXJseSBvbiBzeXN0ZW1zIHdpdGggbGFyZ2UgYW1v
dW50cyBvZiBSQU06Cj4KPiA+ICAgcHJvY2Vzc19tYWR2aXNlMDEuYzozODogVElORk86IEFsbG9j
YXRlIG1lbW9yeTogMTA0ODU3NiBieXRlcwo+ID4gICBwcm9jZXNzX21hZHZpc2UwMS5jOjk5OiBU
SU5GTzogUmVjbGFpbSBtZW1vcnkgdXNpbmcgTUFEVl9QQUdFT1VUCj4gPiAgIHByb2Nlc3NfbWFk
dmlzZTAxLmM6NjI6IFRGQUlMOiBFeHBlY3Q6IE1vc3Qgb2YgdGhlIG1lbW9yeSBoYXMgYmVlbgo+
IHN3YXBwZWQgb3V0OiAwa0Igb3V0IG9mIDEwMjRrQgo+Cj4gPiBUbyBhZGRyZXNzIHRoaXMsIHRo
ZSBwYXRjaCBjb25maW5lcyB0aGUgdGVzdCB0byBhIG1lbW9yeSBjZ3JvdXAKPiA+IHdpdGggY29u
ZmlndXJlZCBsaW1pdHMgZm9yIG1lbW9yeS5tYXggYW5kIG1lbW9yeS5zd2FwLm1heCwgaW1wcm92
aW5nCj4gPiBjb250cm9sIG92ZXIgbWVtb3J5IGFuZCBzd2FwIHVzYWdlLiBUaGlzIHJlZHVjZXMg
dGhlIGxpa2VsaWhvb2Qgb2YKPiA+IGZhbHNlIHBvc2l0aXZlcyBjYXVzZWQgYnkgc3lzdGVtLXdp
ZGUgbWVtb3J5IGNvbmRpdGlvbnMuCj4KPiBPdXQgb2YgY3VyaW9zaXR5LCBvbiBob3cgbWFueSBS
QU0gZG9lcyBpdCBmYWlsPyBBbmQgaXMgaXQgYXJjaCBzcGVjaWZpYz8KPgo+CkFoLCBJIGNvbXBs
ZXRlbHkgZm9yZ290IHRoZSBjb250ZXh0IG9mIHRoaXMgcGF0Y2gsIG15IG1lbW9yeSBpcyBiYWQg
bm93IDovLgoKCj4gLi4uCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Byb2Nl
c3NfbWFkdmlzZS9wcm9jZXNzX21hZHZpc2UwMS5jCj4gPiBAQCAtMjMsNyArMjMsOSBAQAo+ID4g
ICNpbmNsdWRlICJsYXBpL3N5c2NhbGxzLmgiCj4gPiAgI2luY2x1ZGUgInByb2Nlc3NfbWFkdmlz
ZS5oIgo+Cj4gPiAtI2RlZmluZSBNRU1fQ0hJTEQgICAgKDEgKiBUU1RfTUIpCj4gPiArI2RlZmlu
ZSBNRU1fTElNSVQgICAoMTAwICogVFNUX01CKQo+ID4gKyNkZWZpbmUgTUVNU1dfTElNSVQgKDIw
MCAqIFRTVF9NQikKPiA+ICsjZGVmaW5lIE1FTV9DSElMRCAgICgxICAgKiBUU1RfTUIpCj4gLi4u
Cj4gPiBAQCAtMTIzLDcgKzEzMSw5IEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsK
PiA+ICAgICAgIC5taW5fa3ZlciA9ICI1LjEwIiwKPiA+ICAgICAgIC5uZWVkc19jaGVja3BvaW50
cyA9IDEsCj4gPiAgICAgICAubmVlZHNfcm9vdCA9IDEsCj4gPiAtICAgICAubWluX3N3YXBfYXZh
aWwgPSBNRU1fQ0hJTEQgLyBUU1RfTUIsCj4gPiArICAgICAubWluX21lbV9hdmFpbCA9IDIgKiBN
RU1fTElNSVQgLyBUU1RfTUIsCj4gUmVxdWlyaW5nIDIwMCBNQiBmb3IgdGVzdCBsb29rcyBMR1RN
Lgo+Cj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+CgpUaGFua3Mg
Zm9yIHRoZSByZXZpZXcsIGFmdGVyIHJlYWRpbmcgdGhlIHBhdGNoIHN1bW1hcnkgSSBndWVzcyBp
dApzdGlsbCBtYWtlcyBzZW5zZSB0byBhcHBseSBpdCwgc2luY2UgTUFEVl9QQUdFT1VUIGlzIGlu
ZGVlZCBub3QKYSBtYW5kYXRvcnkgb3B0aW9uIGFuZCBzdGlsbCBtYXkgaWdub3JlZCBieSBrZXJu
ZWwgaW4gdGhlIHRlc3QuCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
