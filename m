Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6160C021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 10:32:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11F5A3C98CB
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 11:32:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B8A43C987F
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:32:32 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B00111429EB1
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:32:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740393149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMEQkMYv70xs9wE771eSI01liSJmVS1ifIdGM4Fdqss=;
 b=U607fpr3yDRwPAzEhQMVotfG5+z1NJSWLwSCd3tyTx6rU9OYtnBuPUjuBM+YiKPHD7D7Ps
 AzLjQWWjiZttpqERCIWMJdZfonxU0vYpaHyymjnS2D0hOcXoaCvNBopE1vcudFxW3clAHO
 B1uYEGGTXAjpxeccCDHc9jwxY10v23Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-DwCZOjZJP3uiwmi3tQfTNQ-1; Mon, 24 Feb 2025 05:32:27 -0500
X-MC-Unique: DwCZOjZJP3uiwmi3tQfTNQ-1
X-Mimecast-MFC-AGG-ID: DwCZOjZJP3uiwmi3tQfTNQ_1740393147
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fc1a4c150bso8212899a91.2
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 02:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740393146; x=1740997946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMEQkMYv70xs9wE771eSI01liSJmVS1ifIdGM4Fdqss=;
 b=cHxCZ3oYXYCx8QE/qIbxhFNooF/5QDbw28OihV9uJ6Qc01+zAad5yQ+uEzYnu4QFfG
 /7k9nlbRTer6A3eseo1pX8LxZj+fEcO/UcNhy07JXg1GWbfUe2cL1bEKT8iw4zZ+G/Q4
 dH61dMHd18Eaq2LeQVABXTACk9Ji+/twi7/qNBjiLi3MrKDWvas4HBGqMzbaGM6LWsmM
 mu70S/oM8zoqdngMcxPhf/YQkUz9xrWaqObvw/2Z52zWGtd8oMf36x/eP0O75ycTqGnz
 HbEDLBmUM4Y0ngdDbM9f/VimE2C+e5wJA/qeIniTjj34Z00qOl0BwA6faZbfBOMcAYUW
 lNzQ==
X-Gm-Message-State: AOJu0YzQ5atnNi3SHvSj2Vc0w/BavqwAQD9zIsW/GdxKAV3DQ4fORywF
 qK/p+iQbYbIAAbWgCKgwzFVFIEsLApo/JI9IleVdNYfiJtEaMRYqD3fvsWEnrd3RMzvgHmsQ8zt
 vyY9R6QUQyyFtbHgB9aOmWHqESoBYYDtw9eARFf8AlPUlYhJwc8WAg2d4PvYQZHHH5cZyE1n9jj
 QzB/x6je1REu4/mVYJZiD4cFE=
X-Gm-Gg: ASbGncvmRIwcfOKn5JvZYaqRKzThdRK79mU1n5a2QRBhHlcwOeICH+2v+LlR0R73EfQ
 IFq3y79kDpVd+QApAy6rHxrBPlCIfuWbd+LNj3teolZf7rQoOFk4u+MzWIJF4KsxUlegBUIg7fA
 ==
X-Received: by 2002:a17:90b:4d0d:b0:2f7:7680:51a6 with SMTP id
 98e67ed59e1d1-2fce76a1ed1mr19542822a91.6.1740393146671; 
 Mon, 24 Feb 2025 02:32:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcCxt2BuPEeuxiM/Gk+nRFA7JolJEyVnG/pglhgLztOPqHWqpYwTQUhdlylTiZ3Ih4/DQkyzhpH2np6SFzcSk=
X-Received: by 2002:a17:90b:4d0d:b0:2f7:7680:51a6 with SMTP id
 98e67ed59e1d1-2fce76a1ed1mr19542803a91.6.1740393146413; Mon, 24 Feb 2025
 02:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20250224100016.2857704-1-pvorel@suse.cz>
 <CAEemH2d=xOZCjNhMoavCE9hXB-9+efxWWDc6_pp_BFMkBZvZuQ@mail.gmail.com>
 <20250224102143.GA2858881@pevik>
In-Reply-To: <20250224102143.GA2858881@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Feb 2025 18:32:14 +0800
X-Gm-Features: AWEUYZmStiT6NpCPgtM7duBrvn9P4-rTEh0sMXDnLF_yFW2PpadByXGTe8WPMuM
Message-ID: <CAEemH2dhxvwghPV-f9eWSoNfCFWvaFeqwnMNXZy239dfdDCgxg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hy9yy1AgZdy_N-E8U9P6wMPyXUf3G-T5DWc7y3v4FfQ_1740393147
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] tst_test: Add $LTP_SINGLE_ITERATION to limit
 variant
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

T24gTW9uLCBGZWIgMjQsIDIwMjUgYXQgNjoyMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+ID4gSGkgYWxsLAo+Cj4gPiA+IEFuZHJlYSB3YW50
ZWQgdG8gcnVuIG9ubHkgc2luZ2xlIHZhcmlhbnQuCj4KPiA+IENvdWxkIHlvdSB0ZWxsIG1lIHdo
YXQgdGhlIGJlbmVmaXQgaXM/IHdoeSBkbyB3ZSBuZWVkIHRoaXM/Cj4KPiBAQW5kcmVhIF4KPgo+
IElNSE8gc2ltaWxhciB0byBMVFBfU0lOR0xFX0ZTX1RZUEUgLSBzcGVlZHVwLiBBbHRob3VnaCBJ
IGFkbWl0Cj4gTFRQX1NJTkdMRV9GU19UWVBFIGFsbG93cyBtdWNoIGJpZ2dlciBjbGVhbnVwLgo+
Cj4gPiBBbmQgYmFjayB0byB0aGUgcGF0Y2ggaXRzZWxmLCBpZiBMVFBfU0lOR0xFX0lURVJBVElP
TiBpcyB1c2VkLCB3aGljaAo+ID4gdmFyaWFudCB3aWxsIGJlIGNob3NlbiB0byBydW4gYnkgZGVm
YXVsdD8gSXMgdGhhdCBleHBlY3RlZD8KPgo+IEJ5IGRlZmF1bHQgYWxsIHZhcmlhbnRzIGFyZSB0
ZXN0ZWQuCj4KClNvcnJ5LCBoZXJlIEkgd2FudGVkIHRvIGFzazoKIFdoaWNoIHZhcmlhbnQgd2ls
bCBiZSBzZWxlY3RlZCB3aGVuIExUUF9TSU5HTEVfVkFSSUFOVCBpcyBzZXQ/CiBJcyB0aGUgc2Vs
ZWN0ZWQgdmFyaWFudCB0aGUgZXhwZWN0ZWQgb25lPwoKU2luY2UgdGhlIG9yZGVyIG9mIHRlc3Qg
dmFyaWFudHMgaXMgbm90IHN0YW5kYXJkaXplZCBhbmQgaXMgZGV0ZXJtaW5lZApieSB0aGUgYXV0
aG9yIHdoaWxlIHRlc3Qgd3JpdGluZy4gT25jZSB3ZSB1c2VkIExUUF9TSU5HTEVfVkFSSUFOVApp
dCBzdGlsbCBkb2VzIG5vdCBndWFyYW50ZWUgdGhlIGV4ZWN1dGVkIHZhcmlhbnQgaXMgdGhlIHNh
bWUgZm9yIGFsbCB0ZXN0cy4KVW5sZXNzIHBlb3BsZSBvbmx5IHVzZSBpdCBpbiBtYW51YWwgZGVi
dWdnaW5nIG1vZGUuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
