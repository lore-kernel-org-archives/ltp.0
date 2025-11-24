Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829A4CFA466
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 09:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763976049; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=g+OZb6C7zKdylWWrKg/4wZmJHlac2F1HX2CaAbrzjdQ=;
 b=a3CddIUeEH68cKDVKQQzyumc7pNuAH2BdrM8H/wrmZ2ThK2oFpFQm4JPeCRK0wrBDn/mZ
 vmcFU/O2cAft0Ar8VQkCz1XYZUl147rP3Of9qqDnbDFG37iq83rF6wbSiZMZ3TDvLx2FCLN
 Pg1WuAnAXVAl65GPal9JQlAh5esbUq4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3E893C79A8
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 10:20:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B39F43C79B9
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 10:20:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0501B647870
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 10:20:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763976024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rag89E3GlxK8r4QdIUXCFBL2RR25bUUyKYWAUK1ZBfc=;
 b=EXTGOdemEP7XS+1NiocJwULOgoX1cntKASAy8F7Kv+Tq2ZU8jL/y1HW1uoYhRgumUGpjWk
 FYBatX+N243oi1IbCPCP8SbximWXECK9c/fk94A0VHgMfp+2xX0Ei/4d00kbUGMZ1UR+Be
 umFzQcCttmA443bN15NHAhex3w0qJVI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-ZvPy2LWFPzSChdTSZPIvqA-1; Mon, 24 Nov 2025 04:20:22 -0500
X-MC-Unique: ZvPy2LWFPzSChdTSZPIvqA-1
X-Mimecast-MFC-AGG-ID: ZvPy2LWFPzSChdTSZPIvqA_1763976021
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c95fdba8so1910163f8f.0
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 01:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763976021; x=1764580821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rag89E3GlxK8r4QdIUXCFBL2RR25bUUyKYWAUK1ZBfc=;
 b=kCeJVe/QLwQbniabXY00wwRC5NOQavf/1s1qyxj/fcoF5aOjDSVO4OKU2pGIjVymVh
 3+Hw6KuNhNh5EmZ4Ltn6Wv68tUPjvNLSFG8pSNobF2o/KzpTm2vt9royHBfW1FW2Lttf
 qVBW2lj/qzWuPRVpK/vvexvsG3Jf4eONKmSYVT2OhnppiT7mbwUt0pKNKHz6tbp3ot7V
 QHhfA7JBHrO+mYvhDVEdA9IOFggl7Rlrp69ZtTnAS7HonNZYYjFEochxv80Efj+KkhK+
 Zx9oZA5vSh3tdKJTlsUyuM9kn74BhEMsfoiX56qMMydHVV81J/8PUk0OpwcZ7nG+ycW6
 LrKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoYH9W/uAdyRG1wgV/39PR8SQ2hZP9tvsl47pSonsTslo6GreHAfRy1/ckIBYjiqIysp0=@lists.linux.it
X-Gm-Message-State: AOJu0YxtyQyxvqW+cHRkxvt+mTvPJpwtX3KlO46TxB6m4qkFuIaYJ7TW
 0sMs7UcQUmoZ/G+tOTXufzXVBDb44n6HR1kV1EIzEl9uez7JYpDw4/5ArrG97i7Oe948ai0IHxK
 aB+UED3MsKRdrYCJJVLG3oJHtuCECickWjQuMDV7F8FnGf2lcqRogHeI0pUK8fywRa7mBsU2jWf
 bkl32A5yEucyMSx7PPimMFDS9VJEw=
X-Gm-Gg: ASbGncuLfZvFwG557ecIY4KEfjlLeWSrbMbQBBZVLyKyDCRpIGkgZ2Qt/IjjFlhLzV9
 jjsI9AeYBxYM4tO6Hi+/INbcaers3Ox9qhsjA2ixuz+SvVwpudsDSLpWIrSdxlEB+QQvVKEkyQk
 hCW013QRRRLvKV6L6pP4d6Tf+X+Bv9kcOoB1racIf1yioCvAQ5SMAIf3I+5brCumlq
X-Received: by 2002:a05:6000:2dc5:b0:42b:3023:66a6 with SMTP id
 ffacd0b85a97d-42cc1d35666mr10815743f8f.40.1763976021334; 
 Mon, 24 Nov 2025 01:20:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKlHkoY4s/8w6Sn94DMeIFw9VMXT6Q7oiSlZpp38KtD3rx0stKTmqDbuNEk3f/K0/lnhrmrv3JYKNwaucG6pU=
X-Received: by 2002:a05:6000:2dc5:b0:42b:3023:66a6 with SMTP id
 ffacd0b85a97d-42cc1d35666mr10815713f8f.40.1763976020947; Mon, 24 Nov 2025
 01:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20251120163550.333241-1-pvorel@suse.cz>
 <aSBBzVaq4gJ6JfrK@yuki.lan>
 <20251121104506.GA25561@pevik> <aSBQDg8PRXFK8GxB@yuki.lan>
 <CAASaF6x+U0V52-=YVTRj__C7-nTzx-ScfQUCTwPzEmdP=7b1Kg@mail.gmail.com>
 <aSQi6XRFfh8ZEEy8@yuki.lan>
In-Reply-To: <aSQi6XRFfh8ZEEy8@yuki.lan>
Date: Mon, 24 Nov 2025 10:20:04 +0100
X-Gm-Features: AWmQ_bnoeEEG8BPY0rpyw-rB39bGdYs10GGMRsqZ_4HsSIobnvEpT4z0zw9P1eg
Message-ID: <CAASaF6z2QDNfXLrTs4kHfh=X_6kqVbzCMdKqDFgYLnaZo3q-ZA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t4e-Pt9flJXNf-s-_LSQhsJWR6Mu5oKN6GxoGJ-vV1Q_1763976021
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] readahead02: Sleep 1.5 msec to fix problem on
 bare metal
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBOb3YgMjQsIDIwMjUgYXQgMTA6MTfigK9BTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cj4KPiBIaSEKPiA+IElmIHJlYWRhaGVhZCBkb2Vzbid0IGluaXRpYXRl
IHdpdGhpbiB0aG9zZSBmaXJzdCA1bXMsIHRoaXMgYWJvcnRzCj4gPiBpbW1lZGlhdGVseSwgcmln
aHQ/Cj4gPiBJJ2QgdXNlIGhpZ2hlciB2YWx1ZSBmb3IgU0hPUlRfU0xFRVAsIHNheSA1MG1zIG9y
IG1vcmUuIFRoYXQncyBzdGlsbCBzbWFsbAo+ID4gb3ZlcmhlYWQgZm9yIHRoZSB0ZXN0Lgo+Cj4g
V2hhdCBhYm91dCBkb2luZyA1MG1zIHNsZWVwIGZpcnN0LCB0aGVuIHVzZSB0aGUgNW1zIGluIHRo
ZSBsb29wPwoKRmluZSBieSBtZSwgd2UgY2FuIHRyeSB0aGF0IGFuZCBzZWUgaG93IHRoaW5ncyBp
bXByb3ZlLgoKPgo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
