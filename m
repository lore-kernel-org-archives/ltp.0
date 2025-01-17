Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50327C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 08:20:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B02783C2EE4
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:20:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F38AD3C2EE4
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:20:39 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 326076342D6
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:20:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737102037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lUOHhI94SvFxY36c1bRrIdhZiZhtK4bPpGP34dL+kWE=;
 b=QCEJfa9QntHjfuSxEVR72xle0Lg5fvjmlNs7/VJY9iP8KEk6aIBQUEFDXR/ZxsHHqskTAf
 U+yQWIBoSSb/ImbupuDCxzXIHf9uimCZyWK8UVUG8jHZD5ZzRb+ZDn7uAWbNAnnFiHlOj1
 yqBvibt3LImX0cQKPq0wZhz3OPKX3sk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-EKkUZKhBOS6Fr_k_L4RMoA-1; Fri, 17 Jan 2025 03:20:36 -0500
X-MC-Unique: EKkUZKhBOS6Fr_k_L4RMoA-1
X-Mimecast-MFC-AGG-ID: EKkUZKhBOS6Fr_k_L4RMoA
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef79403c5eso5334630a91.0
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 00:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737102034; x=1737706834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lUOHhI94SvFxY36c1bRrIdhZiZhtK4bPpGP34dL+kWE=;
 b=em4yEqoXF1jKWTkqyhv31P52GA34LMF0XL8BhD0Aw0rM2lUGC2Ms9nkbMom8rpx4Ba
 B9yR0FrdKLHBZOls3+6f0FuKnrX6C7ChB1QFvbePu6mEF+G923mFGx6RbwWFBELO0T9k
 cZfyh0cRI9zyhcc1k7S5apRaj0QEWOQO9XitmvNHSUKXJHRKgCh1guw5I9Y9RcZLay/E
 phv4SviAkchiPWBnUdWZGY+Q/tT2Gx1WHNQ/PGF7Hdi2RZprxXBsyD7C++JWx1+Jh7m7
 GPP2iXtbTYF8qSX7AG5hIzZTR4ys3Zzqs/QM/xCyrrbVlPcattv/l6FoS+UUKKn9wmUG
 O7Cw==
X-Gm-Message-State: AOJu0YyIfPyV0PaghFgke21R3mxsoqZ6wvGt2Ui3gPZrXLcvvJ6ocbgs
 9nLFnTNO+PzaqO+7pXQw9RJ9xKoIhSRmPAW+XBshcZW1en5cyub4tviiKSEeA6mMsQ1BzqBRZpT
 PDihoSS8nQr/4ErzkXlx/NhK9YQOYNUQBWLIa4JsOL2qcU0FNaNpeerwrh8t/7eV5caQj7bIX8M
 7krH12JKR+BDPK0qfekroujO+d9l//x4/Jfw==
X-Gm-Gg: ASbGncsBt7mgOSfs33DD7BWTLOkPSKcXxUu2d9rKDIgO/XPiOdtqBpQv9YFf7pXLKEC
 yn256dDyAtrr5nDsN2JcAs1HclNlq82IVTqx3yjU=
X-Received: by 2002:a17:90b:1f8f:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2f782c71e64mr2993057a91.12.1737102033772; 
 Fri, 17 Jan 2025 00:20:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7nW/C+DHZyzVOUE1srjV5WH+cvXCSuwJA2Ao96prI2mgDiAKAHudJaXDQwd5oTve5TEJJAgM6rhBEo/S71TA=
X-Received: by 2002:a17:90b:1f8f:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2f782c71e64mr2993036a91.12.1737102033505; Fri, 17 Jan 2025
 00:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20250117071758.120366-1-liwang@redhat.com>
 <20250117073607.GA731427@pevik> <20250117080454.GD729073@pevik>
 <CAEemH2e4VnKVHUEKPKsa0LUkx1gGdii_tZxtiqA9TBfd6SBRNA@mail.gmail.com>
 <20250117081518.GA733756@pevik>
In-Reply-To: <20250117081518.GA733756@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Jan 2025 16:20:21 +0800
X-Gm-Features: AbW1kvYTYUMw_0sfG-rRJZt47R_oS0OY_fAl3HyIFuG0S53w4V0qSMEQccI2gdk
Message-ID: <CAEemH2f4RqkO8-NaKr5FLM-mmUKGfi+DQEnKWxC_DsuY9R+ZzA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -iDkbBkbCRCWFtIoh5pacqWVdMtq5geMeRPMZ0i17P8_1737102035
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib: add TST_NO_SLOW_KCONFIG_CHECK macro for
 testcase tools
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

T24gRnJpLCBKYW4gMTcsIDIwMjUgYXQgNDoxNeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBPbiBGcmksIEphbiAxNywgMjAyNSBhdCA0OjA14oCvUE0gUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4gPiA+IEhpIExpLAo+Cj4gPiA+ID4gSGkg
TGksCj4KPiA+ID4gPiA+IFRoZSBtYWNybyBUU1RfTk9fU0xPV19LQ09ORklHX0NIRUNLIGlzIGFk
ZGVkIHRvIGNvbnRyb2wgd2hldGhlcgo+ID4gPiA+ID4gdGhlIHRzdF9oYXNfc2xvd19rY29uZmln
KCkgZnVuY3Rpb24gKHdoaWNoIHByZXN1bWFibHkgY2hlY2tzIGZvcgo+ID4gPiA+ID4gc2xvdyBr
ZXJuZWwgY29uZmlndXJhdGlvbnMpIHNob3VsZCBiZSBleGVjdXRlZC4KPgo+ID4gPiA+IFRoYXQg
d2FzIHF1aWNrLCB0aGFua3MgYSBsb3QhCj4KPiA+ID4gPiBCdXQgdW5mb3J0dW5hdGVseSB0aGUg
cGF0Y2ggZG9lcyBub3QgaGVscCB0byBhdm9pZCBwcmludGluZyBUSU5GTwo+ID4gPiA+ICh0ZXN0
ZWQgb24gYSBmcmVzaCBjbG9uZSk6Cj4KPiA+ID4gPiAjIG1ha2UgJiYgLi90c3RfbnNfZXhlYyAx
NDUzNiBuZXQsbW50IHNoIC1jICIgY2F0Cj4gPiA+IC9wcm9jL3N5cy9uZXQvaXB2Ni9jb25mL2x0
cF9uc192ZXRoMS9kaXNhYmxlX2lwdjYiCj4gPiA+ID4gQ0MgdGVzdGNhc2VzL2xpYi90c3RfbnNf
ZXhlYwo+ID4gPiA+IG1ha2VbMV06IE5vdGhpbmcgdG8gYmUgZG9uZSBmb3IgJ2FsbCcuCj4gPiA+
ID4gdHN0X2tjb25maWcuYzo4ODogVElORk86IFBhcnNpbmcga2VybmVsIGNvbmZpZyAnL3Byb2Mv
Y29uZmlnLmd6Jwo+ID4gPiA+IHRzdF9rY29uZmlnLmM6NjY3OiBUSU5GTzogQ09ORklHX0xBVEVO
Q1lUT1Aga2VybmVsIG9wdGlvbiBkZXRlY3RlZAo+IHdoaWNoCj4gPiA+IG1pZ2h0IHNsb3cgdGhl
IGV4ZWN1dGlvbgo+ID4gPiA+IDAKPgo+ID4gPiA+IE1heWJlIGl0J3MgYmVjYXVzZSBzYWZlX2Ns
b25lKCkgdHJpZ2dlcnMgaXQ/IE9yIHdoYXQgYW0gSSBtaXNzaW5nPwo+Cj4gPiA+IFRoZSBwcm9i
bGVtIHdoeSBpdCBkb2VzIG5vdCB3b3JrIGlzIHRoYXQgaXQgdXNlcyBsaWIvdHN0X3Rlc3QubyB2
aWEKPiA+ID4gbGliL2xpYmx0cC5hLCB3aGljaCB3YXMgY29tcGlsZWQgd2l0aG91dCBUU1RfTk9f
U0xPV19LQ09ORklHX0NIRUNLLgo+Cj4KPiA+IFJlYWxseT8gSG93IGRvZXMgdGhhdCBUU1RfTk9f
REVGQVVMVF9NQUlOIHdvcms/Cj4gPiBSZWFkaW5nIHRoZSBjb2RlLi4uCj4KPiBJIGd1ZXNzIHRo
ZSBjb2RlIHdoaWNoIGV2YWx1YXRlcyBUU1RfTk9fREVGQVVMVF9NQUlOIG11c3QgYmUgaW4gc3Rh
dGljCj4gaW5saW5lCj4gZnVuY3Rpb24gaW4gdHN0X3Rlc3QuaCBoZWFkZXIuIFRoZW4gaXQgd2ls
bCB3b3JrLgo+CgpTZWVtcyBub3QsIHRoZSBUU1RfTk9fREVGQVVMVF9NQUlOIGlzIGRlZmluZWQg
aW4gdHN0X3Rlc3QuYyBkaXJlY3RseSwKc28gYmFzZSBvbiB0aGF0LCBhbGwgdGhlIFRTVF9OT18q
IG1hY3JvcyBpbiB0ZXN0Y2FzZS9saWIvKiBpcyByZWR1bmRhbnQuCgpUaGF0IG1pc2xlYWQgdXMg
dGhlIGNvcnJlY3Qgd2F5LgoKCgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+ID4gPiBJTUhP
IFdlIGNhbm5vdCBlYXNpbHkgc29sdmUgdGhpcyB3aXRoIHByZXByb2Nlc3NvciBkZWZpbml0aW9u
Lgo+Cj4gPiA+IEtpbmQgcmVnYXJkcywKPiA+ID4gUGV0cgo+Cj4gPiA+ID4gS2luZCByZWdhcmRz
LAo+ID4gPiA+IFBldHIKPgo+ID4gPiA+ID4gVGhpcyBhbGxvd3MgdGVzdCBjYXNlcyBhbmQgdG9v
bHMgdG8gb3B0IG91dCBvZiB0aGlzIGFkZGl0aW9uYWwKPiA+ID4gPiA+IGNoZWNrLCBlbmFibGlu
ZyBtb3JlIGZsZXhpYmxlIGFuZCBmYXN0ZXIgdGVzdCBleGVjdXRpb24gaW4KPiA+ID4gPiA+IGNl
cnRhaW4gc2NlbmFyaW9zLgo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
