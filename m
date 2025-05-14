Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE06BC3ABD9
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 09:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747213497; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1qdvkoMdzgbcZWrHSng7rQFt73vWJ6dd2pYfI5IW7ek=;
 b=REYe057zenOi4OKYA+ef3IipdR6YK7EjaR5Qig1WU+CCMT27/UGcutP/OfAOjYieKHAIp
 26BFJ004WxfLyiVP8j17voAQPf71DxdEyp2kzTIxx90X1yk5Qvrxxepjo4WYvW2yw4jlYWd
 mmPGN1Z2wVFh3rOz848YjrDq+IsZUX0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC57A3CC38B
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 11:04:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12A993CAB2B
 for <ltp@lists.linux.it>; Wed, 14 May 2025 11:04:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 797971400F28
 for <ltp@lists.linux.it>; Wed, 14 May 2025 11:04:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747213472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJ68+P90tX2w+61MhSCvjRiIgaMWeQqErNZTMbVvGKY=;
 b=WdEUw26kRmBsOm3ibiKqSVwih8jCx1yxP5Ik1s+GzEtI8C4zV/X5//6jleECpjgEyYALA8
 KZTCSErvJgQWNROkuw6t0NXzFI/v8j9/ohzvALvXOGqn2gDdY5JMOWwbXHe6ZxuK2cGPHC
 28wFaiJTmxlevCsy/WaikrtvxU0Gozg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-bvB79K2LNAWfXQDQr9Bisw-1; Wed, 14 May 2025 05:04:31 -0400
X-MC-Unique: bvB79K2LNAWfXQDQr9Bisw-1
X-Mimecast-MFC-AGG-ID: bvB79K2LNAWfXQDQr9Bisw_1747213470
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22fba2426f5so54685005ad.3
 for <ltp@lists.linux.it>; Wed, 14 May 2025 02:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747213468; x=1747818268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJ68+P90tX2w+61MhSCvjRiIgaMWeQqErNZTMbVvGKY=;
 b=RXiaQXOmkEcGclvOt2Ss9NyWCxgZLBovD7qlFji9XrOjz+IZVI5k9TSO3TrWRemRgO
 JEIQFcte3jTm0JqEs6nkcLx0uO+fhery0y28KZ6lcPxS/vaiKybBGAEbEpr4B6rt12h/
 t+u0ta04nangB1GS9tuHHDXawuEqJH/YIEuQGNGhevxZKUMG5lvg+P1+rqQeulgqE9HY
 9iuJu0FFyC/QgyhogVFLbl4ntJZ0l3zcyxN2Qss92MMTwDEKzbJJqZOPHTbF0YbvdRka
 PQKTv464cXCGInZe6U3Y2ZfXfx2Nz0fN0mcGoFVriD5bbP8DihAxOkYiabrk611WpCg7
 h0NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNA/5Z5r+qI4NLaR/7JyBPWA7H60UQjlyI+R+Azs8a8krL/P3NklFhC/vzkUX324KvJ84=@lists.linux.it
X-Gm-Message-State: AOJu0YyyCnnJ3mFaybNEodVb2tLWukgoJ1PNh1BXe+SZlcB4r+/rDYI7
 cFe5I/75/tEe2jHaKOWRkQct/5nrE0tvEnd0YxCjDOhzSv+F0FqT3/TEONxXtIQoD7UlRL6YyUE
 lKe5+6YEQ9Lcon/vjZnga/i16A/0FiHSXkkMvdVOVYmq/pKd7/ScQItlVnFUcIee7r4n4rwI2Yf
 OOK/Bkxz8O55p2EGg2GkSH+v7ekT4V8gU=
X-Gm-Gg: ASbGnctRwKuGz9xlEz0JOOmRTztqpRKa+fu4aRfOsIo1CZ0gevKrL5uukEmGBYcrASg
 rUMiYMYBXqiI26YKRsuL2cgstwnDMAjpHSNn6qiW46Xn6co49or/Tlbx1YOIU5hp3+QrXhw==
X-Received: by 2002:a17:902:ea0c:b0:224:10a2:cae7 with SMTP id
 d9443c01a7336-231981c93b9mr40588155ad.40.1747213468213; 
 Wed, 14 May 2025 02:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0mB8243C0oGwLJIN7skOL9bHz5aUZXLW6SbMbNb//ZN4s8yZxJxotRgQhlSluO0MCFV81W6KIKTANUwiNknA=
X-Received: by 2002:a17:902:ea0c:b0:224:10a2:cae7 with SMTP id
 d9443c01a7336-231981c93b9mr40587855ad.40.1747213467905; Wed, 14 May 2025
 02:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250416191645.355088-1-wegao@suse.com>
 <20250428160421.3457215-1-wegao@suse.com>
 <aBt7ck35Dq8GIKHc@yuki.lan>
 <CAASaF6y+e6eKMONT2FdgsLJyhGzZPswQNqthQpneEqpte+-6pQ@mail.gmail.com>
 <aCNox5FGkPsLWGf2@MiWiFi-CR6608-srv>
 <CAASaF6yRO-_dX-ktapqAcWyqU-jwf2k8cJ9+Q7XAN7sqkngz8A@mail.gmail.com>
In-Reply-To: <CAASaF6yRO-_dX-ktapqAcWyqU-jwf2k8cJ9+Q7XAN7sqkngz8A@mail.gmail.com>
Date: Wed, 14 May 2025 17:04:15 +0800
X-Gm-Features: AX0GCFt516GgyQp5gWXEqTHsrpfrtaLyo9dkzHzNb9wINwh2d6AoD193rWeWeZc
Message-ID: <CAEemH2dWyGyHXngTSghnAUmyF+DS0GNvKatVR9CuTpMEZc-rPQ@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: srM2VBRHkVemDkxrvTdKK9iTdt4I2RY0ZBjWN3q0KEE_1747213470
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap22.c: Test for new MAP_DROPPABLE flag for
 mmap
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXkgMTQsIDIwMjUgYXQgNDo1MuKAr1BNIEphbiBTdGFuY2VrIHZpYSBsdHAgPGx0
cEBsaXN0cy5saW51eC5pdD4gd3JvdGU6Cj4KPiBPbiBUdWUsIE1heSAxMywgMjAyNSBhdCA1OjQ0
4oCvQU0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgTWF5
IDEyLCAyMDI1IGF0IDEwOjQzOjU1QU0gKzAyMDAsIEphbiBTdGFuY2VrIHdyb3RlOgo+ID4gPiBJ
cyBhbnlvbmUgZWxzZSBzZWVpbmcgdGhpcyB0ZXN0IGZhaWxpbmcgb24gcmVjZW50IDYuMTUtcmM1
IGtlcm5lbHM/Cj4gPiA+Cj4gPiA+ID09PT0gbW1hcDIyID09PT0KPiA+ID4gY29tbWFuZDogbW1h
cDIyCj4gPiA+IHRzdF90bXBkaXIuYzozMTY6IFRJTkZPOiBVc2luZyAvdG1wL0xUUF9tbWF6Q1VM
Tk4gYXMgdG1wZGlyICh0bXBmcyBmaWxlc3lzdGVtKQo+ID4gPiB0c3RfdGVzdC5jOjE5Mzg6IFRJ
TkZPOiBMVFAgdmVyc2lvbjogMjAyNTAxMzAtMjUzLWc0YTBlM2E4ZmEKPiA+ID4gdHN0X3Rlc3Qu
YzoxOTQyOiBUSU5GTzogVGVzdGVkIGtlcm5lbDoKPiA+ID4gNi4xNS4wLTAucmM1LjI1MDUwOWc5
YzY5Zjg4ODQ5MDQuNDcuZWxuMTQ4Lng4Nl82NCAjMSBTTVAKPiA+ID4gUFJFRU1QVF9EWU5BTUlD
IEZyaSBNYXkgIDkgMTU6MTc6MzEgVVRDIDIwMjUgeDg2XzY0Cj4gPiA+IHRzdF9rY29uZmlnLmM6
ODg6IFRJTkZPOiBQYXJzaW5nIGtlcm5lbCBjb25maWcKPiA+ID4gJy9saWIvbW9kdWxlcy82LjE1
LjAtMC5yYzUuMjUwNTA5ZzljNjlmODg4NDkwNC40Ny5lbG4xNDgueDg2XzY0L2J1aWxkLy5jb25m
aWcnCj4gPiA+IHRzdF90ZXN0LmM6MTc1ODogVElORk86IE92ZXJhbGwgdGltZW91dCBwZXIgcnVu
IGlzIDBoIDA1bSA1NHMKPiA+ID4gbW1hcDIyLmM6NTU6IFRGQUlMOiBNQVBfRFJPUFBBQkxFIGRp
ZCBub3QgZHJvcCBtZW1vcnkgd2l0aGluIHRoZSB0aW1lb3V0IHBlcmlvZC4KPiA+ID4KPiA+Cj4g
PiBJIGhhdmUgdGVzdGVkIHJjNS82IGFuZCBib3RoIGdpdmUgcGFzcyByZXN1bHQuCj4KPiBJIGRv
IHNlZSBpdCBmYWlsIGFsbW9zdCBkYWlseSBvbiBtdWx0aXBsZSBhcmNoZXMgKFZNcyBhbmQgYmFy
ZW1ldGFsKSwKPiBtYXliZSBzb21lIGRpZmZlcmVuY2UgaW4gb3VyIGNvbmZpZy4KCkhhdmUgeW91
IHRyaWVkIHRoZSBvcmlnaW5hbCBzZWxmLXRlc3QgKHdpdGhvdXQgdXNpbmcgQ2dyb3VwKT8KSWYg
aXQgc3RpbGwgZmFpbHMsIGNvbnNpZGVyIGl0IGEga2VybmVsIGlzc3VlLgoKLS0gClJlZ2FyZHMs
CkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
