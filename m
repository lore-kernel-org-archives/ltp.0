Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94976C47DDB
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 13:10:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 682E23CEE70
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 14:10:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD3013C080E
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 14:10:30 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DBC88140111D
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 14:10:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706015427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aDcSsPx0AQHrPaSFG9JRCqXB0EXfgMzAHgLs+TFEqCY=;
 b=gYTYItSUQC0EDIWnFF64J9fp8EkIM+5jCa7ZBYg6+8+ErkM0HXS8AVRooJ9CgApUaCIZUL
 A8EpvfcBKHbaGy127q5vbPU87yQntjkhsq8l/y2R3vZFudemFN5VQH83alsEDOubR52I2e
 IyVP37meCFDIez4yaa4JjpdUJ523EOU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-awropAe5Pma6IAb1T4JV9Q-1; Tue, 23 Jan 2024 08:10:26 -0500
X-MC-Unique: awropAe5Pma6IAb1T4JV9Q-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29000a3a589so2452004a91.0
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 05:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706015425; x=1706620225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aDcSsPx0AQHrPaSFG9JRCqXB0EXfgMzAHgLs+TFEqCY=;
 b=O2C0//L1nrmvvJJu8FZCccBxP7xM6zuGbKpldtEKKoMVCO58qYYk/+v9hY3awOnRTm
 JN8MBO0aEUDg0ELdwCsJ+DEqWGYbIoaXIaHfaI5JMf5YZ94MTD6Na4KP6Kmc4eYq4Zx4
 9Tx3PjcdQNT89Qx807/4bMgp/wK3aJmHAHSHRfPz2ZuAn2BW7WEf9tBS/M0qRdFJezCF
 k50RqrD5i7/X608z+oGMx8jmzqObNp0UQyC6kE+9GsNEQqr3mlCTB5cS2SyVNwECEDxZ
 urVqzYjWd4Yr0gza7L0c5dDLXLvdTPBqXxYLmxxlUiehhK0QMmZ/PHhP7qa3+bvKR+oB
 asAA==
X-Gm-Message-State: AOJu0YzpL2qF7wUCy+c+zv9k9+mSLCNHij6u6bDir6wTXXQe86jNjUwA
 lyyVHEP3r5n/bQPYNjh8yV5F2ox5lN4ofZmHA2tZs+vlMt8/W3/iVx3w9y/eHU4DTmUHm0P2YUJ
 yNjxMuV+PopmazumzPaqIkHanpstOFXRjrBRBDO82j74Bm1R4mfeQCACv+e63r2mKw2UbisUxof
 xPzTG2I+iJUNCZEImassZy2rvh/E+yW6Ebbg==
X-Received: by 2002:a17:90a:31c7:b0:28c:a722:c587 with SMTP id
 j7-20020a17090a31c700b0028ca722c587mr2462148pjf.42.1706015424808; 
 Tue, 23 Jan 2024 05:10:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8hbhGLf6K4iYW4NCoOfJJZuD34ujjCj6B9gTKaRiAFIvD2p5svZ7+/16gMQQIsjqdGLigRvuXaVjLKLzqK3g=
X-Received: by 2002:a17:90a:31c7:b0:28c:a722:c587 with SMTP id
 j7-20020a17090a31c700b0028ca722c587mr2462141pjf.42.1706015424442; Tue, 23 Jan
 2024 05:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122091356.GF76754@pevik>
 <CAEemH2dA6sjKz4LGUwYT3wr-4WRZ5H_usSptEG30HxVDVbWSWA@mail.gmail.com>
 <20240122110344.GB95077@pevik>
 <CAEemH2cNn1kyWrnqXHHeOteGT_FQ=PBVc55NFhkZbmkbMOoD=A@mail.gmail.com>
 <20240122202325.GA119341@pevik>
 <CAEemH2dTKjxuiMaHBh0Ky0VV+p2YmDQzH7nvZZjnOVop2E04jQ@mail.gmail.com>
 <CAEemH2cEY=kiJe91Y_kZNefjbh+L-3rikcxErSqVwhQN7mQ=fA@mail.gmail.com>
 <20240123074806.GA144741@pevik>
 <CAEemH2eDZ-Sn0mfH5_pKKLoMe=FXSPA2XRpbs5VmscSZrU4Eng@mail.gmail.com>
 <20240123123121.GB175806@pevik>
In-Reply-To: <20240123123121.GB175806@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Jan 2024 21:10:12 +0800
Message-ID: <CAEemH2fFr25_TyGoS2Zf-dkRtH0JzJ93JWfYamYverw5qxA8kQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

T24gVHVlLCBKYW4gMjMsIDIwMjQgYXQgODozMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBPbiBUdWUsIEphbiAyMywgMjAyNCBhdCAzOjQ44oCvUE0gUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4gPiA+IEhpIExpLAo+Cj4gPiA+ID4gVjMg
aXMgaGVyZTogaHR0cHM6Ly9naXRodWIuY29tL3dhbmdsaTU2NjUvbHRwL2NvbW1pdHMvbGlic3dh
cC12Mwo+Cj4gPiA+IEkndmUganVzdCBzY2hlZHVsZWQgbmV3IHJ1bnMgZm9yIGJvdGggVHVtYmxl
d2VlZCBhbmQgYWxsIFNMRVMgdmVyc2lvbnMKPiA+ID4gKHZhcmlvdXMga2VybmVsIHZlcnNpb25z
KS4KPgo+Cj4gPiBUaGFua3MgUGV0ciwgYW5kIHNvcnJ5IGZvciBwb3N0aW5nIHRvIE1MIHNvIGxh
dGVyLgo+ID4gSSBkaWQgc29tZSBwb2xpc2hpbmcgd29yayBhbmQgZml4ZWQgYSBmZXcgdGlueSBp
c3N1ZXMgYmFzZWQgb24gYWJvdmUgVjMuCj4KPiA+IEknbSBub3Qgc3VyZSBpZiB0aGUgbGlic3dh
cC12MyBicmFuY2ggd2lsbCB0ZXN0IHdlbGwgKHdpdGggdGlueSBpc3N1ZXMpLgo+ID4gU28gSSBw
dXNoZWQgdGhlIGxhdGVzdCB0byBteSBtYWluIGJyYW5jaDoKPiA+ICBodHRwczovL2dpdGh1Yi5j
b20vd2FuZ2xpNTY2NS9sdHAKPiA+IEFuZCwgSSBkZXBsb3llZCBpdCB3aXRoIGEgZ2VuZXJhbCB0
ZXN0IChhZ2FpbnN0IFJIRUwpIGZvciB0aGUgY29taW5nCj4gPiByZWxlYXNlIHdvcmsuCj4KPiBU
aGFua3MgTGkhCj4gQXMgSSB3cm90ZSB0byA0dGggcGF0Y2ggWzFdIHRoZXJlIHdpbGwgYmUgdjQg
bmVlZGVkLCBidXQgZml4IHNob3VsZCBiZQo+IGVhc3kuCj4KClRoZSBmaXggaXMgbmVlZGVkLCBi
dXQgaXQgZG9lcyBub3QgYmVsb25nIHRvIG15IGxpYnN3YXAgcGF0Y2ggc2V0LgpXaXRob3V0IGFw
cGx5aW5nIHRoZSBmaXZlIHBhdGNoZXMsIHN3YXBvZmYgc3RpbGwgZmFpbHMsIHJpZ2h0PwooaXQg
b3JpZ2luYWxseSBjYXVzZWQgYnkgdGhlIHRzdF9maWxsX2ZpbGUoKSBidXQgbm90IG90aGVyIHRo
aW5nKQoKSXQgcHJvYmFibHkgbmVlZHMgdG8gYmUgZml4ZWQgaW4gYSBzZXBhcmF0ZSBwYXRjaCBp
biBmb2xsb3dpbmcgdXAuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
