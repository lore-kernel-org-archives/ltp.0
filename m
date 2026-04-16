Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3637F8A157
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 11:11:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BAB13E2DEF
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:10:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46B353C2B4B
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 13:10:40 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1A5EE600B48
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 13:10:39 +0200 (CEST)
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-50b2b289925so64218541cf.2
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 04:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776337838; cv=none;
 d=google.com; s=arc-20240605;
 b=LVvk6MXsuEHS4fl+kXOnFLaKc0xznc8kBLEni+dgYyEVDvM53ONe8z8ypbuEsU3vU0
 DplL9rYizCVeI8uqZ5WmizrB0gJjXPoW4b+GypcqpkdIhF9aAumPdscBNADVhTOkgTOI
 TQZySyXywpolr9jk0Eq/B6ashSYoLExakwxFxSnRoiXCNOpZiXMGhqu7OqECJjeCCdM8
 5vPap3V23LO18CcG00hOzGijhj3JZWoyEQ2++gYXfY55OZ8MyGg5JX0tm5SYc/IdvsuE
 NpBeUBFPSX1rRtyeB7eqtQn2M8D4oJomGL0ZLUyNRbhwPh54cr/df/pRrzh4sd1icGWe
 8ysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JShivHKmo3U7qH3IAoIhHoOLTNhRLUX9KUYnfEk+Xlk=;
 fh=rTdmf/AcwvZsUGL/eqRYryla0NsENRbBxBS21G0ktrI=;
 b=U8ot1+QiQgRBb/p98rZYpBHZ8Mw+cdFORrMaWnhwhWue5fhydTFelVg9lsv8uCr9Ay
 NT8AmzZ0yfSp5cK5+rtIObpZQD7EjVyL+5lHPvSjYCrlxwZWQmbkLTe4IwS44xjqHXWm
 EaoU3ckxXVu558D6jk18JFtgsLO7OH2982E/L1/p0xV0RX4uq8icHMNU13L6BPINXabo
 r9ByaBOuk3lKB/81u1pdQ+aRHxJiM2ObkPeP0FvcLmFPXZV3EgFTFk3rJ2tbeMB2NJjV
 CUMFt6MCYVdrsIW/9OwtAhiFFf0Uy9tpObXuy/U0A/WPaqNn3fwZ4CDh0ejLFTzd6sau
 6zHA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776337838; x=1776942638; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JShivHKmo3U7qH3IAoIhHoOLTNhRLUX9KUYnfEk+Xlk=;
 b=Kdjav8S0f3qn7YsGrVaf9OIgAy6bQgzAoPnnlrlRS6nCBGLXAAf+BguKHLTY+9YTn8
 u6i0YBwyL5hC0lMzVVJgCP20uF0y+T6o6R4snUkHaWQcDBOt5rBRipqr+41EeOtupaja
 soZV4ZnmSQeCWG9FDaBP7N32CuBJHDMVj4EBEeNQGur4W8OcN8jo4xfbhyb+rVag2ieR
 HzOnjdeEd69+YZXDfwgIHYve1Yv03g6zsZ/ZZfSo6MFCLTURmRzNfuvYFJoXEEquxj5q
 Sa/bWCVSn/AP0q+irZnDUkmgfSj2dnyYVbR882570R9q536/5HVB4CQIqmoOb3o087Lq
 it2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776337838; x=1776942638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JShivHKmo3U7qH3IAoIhHoOLTNhRLUX9KUYnfEk+Xlk=;
 b=l0v/kugHcDbR+57VNej3zZQwXDmQn15hQOTDW6xQnCDuX64TbD5/GFkUrDhn3HzUUG
 yN+J91axPe/34CjOyg/wBesdI4JM3cYZL6tS9CI/6FTD+yQkuHd5Bm6dxQK4MWux3ZBb
 Ab5zIuXMEBkxuGfQU+jPJRdoLgbGdYDTeChi0sR4ufY4kOT2W8rH47FOcxwhKqpgr2Vi
 zJyYChWBPug2evMaI6s/VHlOmrKW23hZnl3c/XPM+ddG7Mxg1r1WSeYQd/St+ImBAXN5
 363QlPNbjeK6iE+FqEXM9wsN5ryluESVWWJiIlyfGFVRYv+R06qSTTn8RPaouYPq1tFU
 LZFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+rYoIrIZIqRvJeQ2OQMEb9Yykga73z8aGjShV2O3g2ayfew2EnQVBWMJTJ1dn1TzsEJvE=@lists.linux.it
X-Gm-Message-State: AOJu0Ywr1Msb7p96ztvBaLzLrdvKQWJCOGMFcXI+k8yM4E4Cyj+aPCow
 +4ydn30vd1Biq/pZzXAMGqMr2ClyG8LCm9asGKORjNWgY8A8+NOD3mvX9gy3hbhsrRN/0CwS6Rg
 m5salrgeuDNRDk3Fqt95moM+DsaOJWQ2XTSmByEmXBFPEjw==
X-Gm-Gg: AeBDievHH1KsShUSOiz4D/7UXEiRCmYz9P8EtVDz0Emar3qfxfgTFrzr0bv3NsDO5mW
 ADHznIzh6dwRfBWODMwPtQLfFxaAcrBuhougHUPoW+EK0R0YD/KD+rwjvtaPHyTA1TabOegkLtp
 GgoG1RIACqc832LQzZTNO9yl/6Py0eyDgOk4F/N482h4ILS4sMVzmBQk3XnA4Joiz3mYAPZjueo
 yG2AU1TtyRNo3ENjXKGQxRn3QrZTKZ6546i7O4NkfpwHjvx6PER/df4Rqz39FinEPbbtdofoPjX
 cWIczg365jQMpE1lNjbJIdTX1dE=
X-Received: by 2002:a05:6214:4e1b:b0:89f:9bc2:20d1 with SMTP id
 6a1803df08f44-8ac860ba59bmr360819846d6.7.1776337500933; Thu, 16 Apr 2026
 04:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260414-ci_fix_missing_builds-v1-1-c5aee6b80507@suse.com>
 <69e0b62c.050a0220.2631f9.3cc5@mx.google.com> <aeC-WNVQb0yGZ2Se@yuki.lan>
In-Reply-To: <aeC-WNVQb0yGZ2Se@yuki.lan>
From: Li Wang <wangli.ahau@gmail.com>
Date: Thu, 16 Apr 2026 19:04:49 +0800
X-Gm-Features: AQROBzDjUT7mNSEryzENqg5TPMlIZBjme6zFKy_ztHtHkHf_KUpDpMxsSuG9zwQ
Message-ID: <CANgNiRx-Om37TC8DYjGWqB++AGoxZCrXam_Vt5+H1d9j-YaNzA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] patchwork: Use last successful run timestamp to
 avoid missing patches
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBcHIgMTYsIDIwMjYgYXQgNjo0N+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gUGluZywgdGhpcyBpcyBxdWl0ZSBpbXBvcnRhbnQg
YmVjYXVzZSB0aGUgY3VycmVudCBDSSBpcyBmYWlsaW5nCj4gPiBxdWl0ZSBhIGxvdC4KPgo+IE1h
eWJlIEknbSBibGluZCBidXQgSSBkbyBub3Qgc2VlIHRoaXMgcGF0Y2ggbmVpdGhlciBpbiBteSBt
YWlsYm94IG5vciBpbgo+IHBhdGNod29yayBxdWV1ZS4KCk1lIGFzIHdlbGwsIEFuZHJlYSwgY2Fu
IHlvdSByZXNlbmQgaXQ/CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
