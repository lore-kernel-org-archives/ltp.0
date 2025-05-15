Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA1DC54754
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 07:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747294896; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=m+PEZfI+jCZxrgvvm9j1r0029F8H+CskJz+l33uYjPw=;
 b=oPUp866qPm39LPlK42RI/3yzK/o6yRwGy1Z15dIlYeBcgVRFersfRR2Xtvxp/h59463s3
 /ouxkvgyTkjnRciQ4G2DjoLcyIwj6MmH0lsue6ltN4LCilA52g9RNd20+d+xDzqMf/EJhXl
 UrkYdEbU6TdzKCkmaO4Y+0Qvanr57TY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64C7E3CC470
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 09:41:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9F593CA548
 for <ltp@lists.linux.it>; Thu, 15 May 2025 09:41:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E49671A00359
 for <ltp@lists.linux.it>; Thu, 15 May 2025 09:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747294867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z9Ds2xhniyyP9picndpLsC5Mwe4d7Nz9+AvQlEajQHw=;
 b=CqYfkjnie3+Lsh1MSl2wkj2uqidIClx3+pJNXka6+JdXrB00UFDAKNa3NIGgo3h7nU/s4V
 sQ3VG1P6F01c8XG/7ngJATN3C5SWfzrXu0zVnVs1P1n8cV+B7dJq7n0mE7Fj27ZfA8jFAG
 3XyH5pbJpjA7aqq/A7x29TCnwISAI9A=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-hDeXDGyEOT6U7A88ktfhBg-1; Thu, 15 May 2025 03:41:02 -0400
X-MC-Unique: hDeXDGyEOT6U7A88ktfhBg-1
X-Mimecast-MFC-AGG-ID: hDeXDGyEOT6U7A88ktfhBg_1747294852
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b240fdc9c20so640158a12.3
 for <ltp@lists.linux.it>; Thu, 15 May 2025 00:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747294851; x=1747899651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9Ds2xhniyyP9picndpLsC5Mwe4d7Nz9+AvQlEajQHw=;
 b=Sy1b607QVI+8hPLQvz5h+wBZ06OhIQW9hKysqdcJz9IbbjelTe0OLYptshhsoZEuIk
 YyaXk2G7ciejWZJgU9yVgoLhHy1gZvld58uU21+Bc4RaHzFcobnbxUpFuU9QCke1fSCQ
 KJ0UDpDv/+9CIzDyTHzySo+D3als0dNs0je61ztfp7gmSkCcexodk3oWTtMBs17pc0gh
 hoGcM8AcUnXUpUjfxvLhDaaq6mKCsuSGPKvEXuLWCJKmomGlMgPSaDKO3TYhby/Cv68x
 09wTuqi9JvGejwhSAVfsVmTGvVMIiIaXHx2f5HughGeBmU5zclW6EFrhfHtcfV502cz+
 vPnA==
X-Gm-Message-State: AOJu0Yw+FtY1h2spw9lvEPBRJgYzosPv48IM1cKdJpQJ0SySKMBeaLIG
 rzyd5DLsQuYo3NJv5OfqpYZkEqazmzV18U4i+QHSP0Whc9XK894GmRVnBRYRhPs47Ql8xsw+uos
 r3z4jyQzwAGFgc6fSUHwYuUJC21TMolQs6J4ZGmB2rS0ah4D+7/vCFfYI5UQx5xf2cGsm3CHRrn
 riZnTxg3q+XUqNpi8qz50hEHCizvdocM03YA==
X-Gm-Gg: ASbGncv62VPh6yAjKj2b9xhB8QWz8RiDtJUcHar3nYEx3TzFrkyHkqwXxEJ/zeIg1nE
 Ib1TcSQz0d3qhGCj8Pi6u6UMCTzQ8yEGzJdwtchvrkl5JenR3/N/NJVX20UJfA325lhMbXw==
X-Received: by 2002:a17:903:1984:b0:223:26da:4b6f with SMTP id
 d9443c01a7336-23198120406mr94667175ad.14.1747294851153; 
 Thu, 15 May 2025 00:40:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8f8G/Rr50kPG0hc6qbsKc+FXngxEou/ALFZYszAKfiSVzhAVi2x8qpw5NSRsluxtSEhFCbX69ba5FX0WPUvg=
X-Received: by 2002:a17:903:1984:b0:223:26da:4b6f with SMTP id
 d9443c01a7336-23198120406mr94667065ad.14.1747294850828; Thu, 15 May 2025
 00:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250515070217.453359-1-pvorel@suse.cz>
In-Reply-To: <20250515070217.453359-1-pvorel@suse.cz>
Date: Thu, 15 May 2025 15:40:39 +0800
X-Gm-Features: AX0GCFt-pHWjDVZ5gzUmlQwPE56e28i7POcwwKdRSLBYqKFiBAQpR7a6w8M8rQg
Message-ID: <CAEemH2fQCv0iO32W70wZQh3VN04j5FUQ=NJNjokSRzXhvVjQXg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3v5EGtehMTrTS-W0o-UAwRxrOzmfHugBb-s-Gn21R1o_1747294852
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: old: Update TST_SR_IGNORE_ERR description
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
Cc: Aaron Knobloch <aarondevelops@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXkgMTUsIDIwMjUgYXQgMzowMuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IFRTVF9TUl9JR05PUkVfRVJSIGhhcyBhIGJyb2FkZXIgbWVhbmluZywg
aXQgaWdub3JlcyBhbGwgZXJyb3JzIChlLmcuCj4gd2hlbiBmaWxlIGRvZXMgbm90IGV4aXN0cyBk
dXJpbmcgcmVhZGluZykuCj4KPiBSZXBvcnRlZC1ieTogQWFyb24gS25vYmxvY2ggPGFhcm9uZGV2
ZWxvcHNAZ21haWwuY29tPgo+IENsb3NlczogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3Qt
cHJvamVjdC9sdHAvaXNzdWVzLzEyMzkKPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9y
ZWxAc3VzZS5jej4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCj4g
QExpIEkgcGxhbiB0byBhZGQgaW5jbHVkZS90c3Rfc3lzX2NvbmYuaCB0byBvdXIgZG9jIGFuZCB1
c2UgdGhlc2UKPiBkZXNjcmlwdGlvbiBpbiBrZXJuZWxkb2MsIGJ1dCBiZXR0ZXIgdG8gdXBkYXRl
IHRoZSBvbGQgZG9jIGluIGNhc2UgSQo+IGZvcmdldC4KClRoYW5rcyBmb3IgZG9pbmcgdGhpcywg
UGV0ci4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
