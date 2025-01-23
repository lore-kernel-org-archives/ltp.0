Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72909C0218B
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 11:20:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9F0F3C4C5C
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 12:20:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 288C63C096D
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 12:20:01 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D420724CCB1
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 12:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737631199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1iE6YJBR/Tbn826NXwxNqewtgpoGfAs064lbtj+GbE=;
 b=Hu6tBAbejro+Pofl+/Ax55qn+rZYVUQJOfG+YZTt6GgYILCE00LSAlQNXheBNwQu0G9l83
 PF66A7It15lhDx7EPxShAvmfFrzLtdoRndJJ6BnoMp9b9XM9Q4pE1Lt/D5xlI1xu0jo5Np
 22wnzhpUGMGyjCYWinKqHxGtM5x9r5E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-X7JNJLSUPdCBS8xFLb8MjA-1; Thu, 23 Jan 2025 06:19:55 -0500
X-MC-Unique: X7JNJLSUPdCBS8xFLb8MjA-1
X-Mimecast-MFC-AGG-ID: X7JNJLSUPdCBS8xFLb8MjA
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2163c2f32fdso26643085ad.2
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 03:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737631194; x=1738235994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d1iE6YJBR/Tbn826NXwxNqewtgpoGfAs064lbtj+GbE=;
 b=eIZfN6a+8LKVYZcQx1nXU8QtcqFSFT/LgtEd2C7bqk+JoKx4MkemQGf9nJ3wBiXRRI
 WmqrqB1kg7vlxSPYVatLvJv1lprniJGrnOPuBjjzD/pVNgIrgw0fqKoxA/CA+M8GwA3R
 2+RwBwdgv8prEvJuNwLbukBsJn8fcveuVosxfen1Nz0nxiA8Ieyn3CpWmcLdEvWYZb6y
 DLIWk3Q4lE5X5+k5P//NF4x6+nND+yTZMG+qIMOO4wUTg+IQ16//J2v7Cw9CEWBIWLea
 HNTGJNFiViIfFATt8+6Mcp7BSAnXGponLNQcnmunKm3ALxfApvxv5VW55WhjO8KwjYKz
 lX1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD7ih4Jr+A8BzbBZcX2Miu91kVS7OL+1K9+DhZZBTe6Pvjb3efSZGCrmlh8zaTDLKM5iw=@lists.linux.it
X-Gm-Message-State: AOJu0Yz/hXHl9MKszhESur8p16MRtdQSiH13/iF2D7MS4c81TEvNKtbh
 fkwZdmQ4LLlhC/WP7lPUcAFlgQtEv93VAq4Tzhx5FkvrszlM2093vufX7Mru2e44NqHJAOpC+5W
 uIP3o2w1NdD8brJBmVArRn6ooO4BxLJWSsJB/14NR9yLiy83KcgFtPBGcHHU2vq6JiVRdEfnJg8
 MbafqJuX/S4lwnj9fUQ6Qq/d4=
X-Gm-Gg: ASbGncvgYK3V4CUvIPUNZhsOfkg3Qf9pg9WkfSBdRaW5I3oCJfjoGQaTeZBAeKUnvDr
 ERCvV6Ffyx0uLbnV7SUBbfYE93GFLZNpn6VaqUWWGcpTBnoBIMFhd
X-Received: by 2002:a17:902:7c0d:b0:216:356b:2685 with SMTP id
 d9443c01a7336-21c353ef7a8mr286715305ad.11.1737631194722; 
 Thu, 23 Jan 2025 03:19:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDuPexwm4MG17xMOqRbM2y8rDSsNeIgacl5dFPqjbrrXOpjebmbs1sq6XhBLEqj8VWWxfmJfcw+6yHrIhNoaw=
X-Received: by 2002:a17:902:7c0d:b0:216:356b:2685 with SMTP id
 d9443c01a7336-21c353ef7a8mr286715085ad.11.1737631194470; Thu, 23 Jan 2025
 03:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20250122-cyril_script_update_timeouts-v2-0-c29846cc0925@suse.com>
 <Z5IVdjsKwcGqBZa2@yuki.lan>
In-Reply-To: <Z5IVdjsKwcGqBZa2@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Jan 2025 19:19:42 +0800
X-Gm-Features: AWEUYZlqe4PJ5k-nBPKVu4VYJAgyC9qk0c6DWWROiIxOgvn1oIZRZOYrbUB2114
Message-ID: <CAEemH2fawV53KN_BBBHTyDjj7exid3U3LEn5Qh298AT4otojfw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6hspp_lGfFhrAD6VVrkhqbsCWa_YoW3BRql4LW7FKE0_1737631195
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 0/2] Update test timeouts in an automated way
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

T24gVGh1LCBKYW4gMjMsIDIwMjUgYXQgNjoxMOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gTGksIFBldGVyIGlmIHBvc3NpYmxlIEkgd291bGQgbGlr
ZSB0byBnZXQgdGhpcyBmaXggaW4gYmVmb3JlIHRoZXJlCj4gcmVsZWFzZS4gSSB0aGluayB0aGF0
IGFkZGluZyB0aGUgdGltZW91dHMgc2hvdWxkIGJlIHNhZmUgZW5vdWdoLCB3aGF0IGRvCj4geW91
IHRoaW5rPwo+CgpZZXMsIEkgYWdyZWUuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
