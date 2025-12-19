Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3197D78769
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766148118; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rab8yEypFXHc8UYVpwHBr5ZWCsSBrG8BJzCPygWsFfI=;
 b=deVk/ngWqNJa6o+gtp1UjZg79AFW+QbeMmtVYbh3RFwyvwbunqgIbqoka9/1sXwR2OrV1
 6hlRzgdHapc8yKvfITBuNE7ZKg0ms0okBIRCdOquMnFdLUiFJUfjUQu997wSWp6yi/qWIxF
 6SA+8Sa7W6st+RpOqWtwvWZEg3j0QlM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB5413D0518
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 13:41:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6687F3CED79
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 13:41:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E77641A010BD
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 13:41:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766148090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXH+veds8zYrezhNYnquUy5OR4F0zxcvR982H5AU9pA=;
 b=Q8FheLsRXL+Y5ytplWRdZxbvlUs+I3o2EaL0a0U0wRkTTLL0PIgHe6Wu8T+16qFfRLGuwz
 M4RbS0Q0hGOMxeln/VUL2pkJSC6syrE6qLqAOh4pxHrse8M7Gzt6Uqt2cz9J2RAwyMb3Nv
 /GfKW0cxtkXhQuxggDF2yt3f46bFy3U=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-FJqnymuvN4icRkERj0I2rw-1; Fri, 19 Dec 2025 07:41:28 -0500
X-MC-Unique: FJqnymuvN4icRkERj0I2rw-1
X-Mimecast-MFC-AGG-ID: FJqnymuvN4icRkERj0I2rw_1766148087
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-be8c77ecc63so2347557a12.2
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 04:41:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766148087; x=1766752887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXH+veds8zYrezhNYnquUy5OR4F0zxcvR982H5AU9pA=;
 b=diu7YQB0/mH8zrZ3A6ooDSFQg3DsvpfNKvudVCOJhUjsWkESkBkY2VBiojDSMG2eBo
 Hh6nuQTephGDyzi7hzlaJuwaW7XfMMm6DXIscjxKhwSFDvl1l0saRHDGGUam6XxrIw5N
 rQJbclyvgSe2XC+/1yCbjqaPz2x+1h602t7Q7AIp3qF36QwaAT5+u0RcZtvGs1ZqAhSo
 vSUR6kDLSpg5Xub1y+GamqdKzPDZf4sbunSjTpKhBG8DJKnV8Y5PlxMWJYMFcjTiriTu
 UxqSaajtSkX/xEjJkk//rzgUzHoXkpc6E2tEtW/cRcdn8mRij1KYmJ3KFdwrMP+WwHIR
 zM1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa4gDib+MPMxV5YFK7jY0YFQMF+I+LJprgTQ4zPE8WvDXT81oJUsZr9zC5wGRs4H5CjNQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yw5FF7URl2Ybp1djiAs4AQ5kpGpznO6s5YK0iSxrosP68mK+FmO
 ZjBbVWd9IrLIQjPQDtrn8+6PTgHkmdstK4J6oBHwwzM11Nk0J7Pl8x791QHKn60eEWOnAMXVxXf
 N2+nwycSXQoiAX5fE/t0/5Nx0OtFpZIcIChnVE/aBjkNdAVeHFEs1c0EW3w6sZjHAwIXkNxazRW
 8fqSxlE+Rx8RetDf2nQuW4Of0XrWU=
X-Gm-Gg: AY/fxX6/A7p73zWQIEhn6cVtlgiTUC/pcvUQCz0sOFA+EUl6BW7OGbFi5R3LYy5qTHQ
 yj8kH5vRrGOeRwN6Lx4bqf72xm4o3TNOX/17KBun+1e7XVamHNTY5dmY9uQskULvAB0SsJ2//N0
 SoMUHF7s34O9Mu3QIq3bz/mSCPIX6ecUzpVswk6ketRi/bN8qdg1cgUWUUHmqItCDoFYE=
X-Received: by 2002:a05:7022:7f0c:b0:119:e569:f60a with SMTP id
 a92af1059eb24-121721aba51mr2240917c88.3.1766148087230; 
 Fri, 19 Dec 2025 04:41:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7FjP8xOuHKQnl5P55vT4r+YKLud0ogkzYenJrjC/EZI97t/T4TJnFjwY6KcW8GLdfoaHoNv8MqPE/buyb9gI=
X-Received: by 2002:a05:7022:7f0c:b0:119:e569:f60a with SMTP id
 a92af1059eb24-121721aba51mr2240890c88.3.1766148086749; Fri, 19 Dec 2025
 04:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20251219094219.151887-1-pvorel@suse.cz>
 <aUUteQjVmMx1R_X9@yuki.lan>
In-Reply-To: <aUUteQjVmMx1R_X9@yuki.lan>
Date: Fri, 19 Dec 2025 20:41:11 +0800
X-Gm-Features: AQt7F2pL2TNdqnuYKTozC1j6cfXqWz2rsvP8ECDhoKV1nhgZPNc9Eua0rU1_vFw
Message-ID: <CAEemH2dwp0KUHpo+gVzBUNdDPJMo2xiZ59apHBWx=M_mmC7Y6g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gHqgc0qZgE4QIlu7bHbh3f0AQ0U4PDyJLeL9IIkIrjg_1766148087
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 1/1] swapon03: Try to swapon() as many files
 until it fails
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBEZWMgMTksIDIwMjUgYXQgNjo0N+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiAgICAgICB0c3RfcmVzKFRJTkZPLCAiU3VjY2Vzc2Z1
bGx5IGNyZWF0ZWQgJWQgc3dhcCBmaWxlcyIsIHN3YXBmaWxlcyk7Cj4gPiAtICAgICBNQUtFX1NN
QUxMX1NXQVBGSUxFKFRFU1RfRklMRSk7Cj4KPiBUaGlzIHNob3VsZCBzdGF5IGhlcmUsIHJpZ2h0
PyBJIHN1cHBvc2UgdGhhdCB0aGUgdGVzdCB3b3JrcyBldmVuIHdoZW4gd2UKPiBwYXNzIG5vbi1l
eGlzdGluZyBmaWxlIGluIHRoZSB2ZXJpZnlfc3dhcG9uKCkgYnV0IHdlIHNob3VsZG4ndCBiZXQg
b24KPiB0aGF0Lgo+CgpOb3QgZXhhY3RseSwgIEkgZ3Vlc3MgaGVyZSBkZWxldGVkIGl0IGJlY2F1
c2UgaXNfc3dhcF9zdXBwb3J0ZWQoVEVTVF9GSUxFKQpoYWQgYWxyZWFkeSBjcmVhdGVkIHRoZSBm
aWxlIGJ1dCBkaWRuJ3QgY2xlYW4gaXQgdXAgaW4gc2V0dXAsIHNvIGl0IHN0aWxsCmV4aXN0cy4K
Ck9yLCB3ZSBuZWVkIHRvIGRvIGlzIGltcHJvdmUgaXNfc3dhcF9zdXBwb3J0ZWQoKSwgcmVtb3Zl
IHRoZSBhbnkgdGVzdCBmaWxlLAphbmQgdGhlbiBhZGQgaXQgYmFjayBzZXBhcmF0ZWx5LgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
