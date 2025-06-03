Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D776C5AD49
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748954365; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=98/jGQtpIoYkxRE+Jk71haLIu3+YqA5CnDHm1alSOys=;
 b=SVZ/6Mj24GVBL24Fx9hrUPGAURaoQ6Q6vxo88UyTffS1jQDfLEQKf64WQZ/2qaY1OxUKW
 5THyta6fSq9suqMX7R2/YkcpXVbiv1SY869Wc3NHdvntrS34TakEZF9mpkQyVrXZf+bZz5e
 dVOzXXvPBXrV/G7NG9rAret1qGwSJWY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E5853CA000
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 14:39:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C79923C0546
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 14:39:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C91ED200A0B
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 14:39:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748954339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q3+PRkMy9CKE9FDDbBWCOy1rtu4+LJCsIf4C8yVAAuc=;
 b=G1YmNDNOAq7y3ZzrUkEbYTLvyKkEV+8R6zuUFeDCjAmh/9X7WmFsAINy9UHpp3a2cOTHb7
 O48wNDCWDH+A6w69wlqeY1L70YYZ1apwcROTmoTpnRNVxsO1EdczsFdjw7ei1dDARz3pc4
 jPvFJqFXF1b9JXo6qJLiSk/STO69izs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311--zOnDfkQMIeg7Dh-GJYrxg-1; Tue, 03 Jun 2025 08:38:57 -0400
X-MC-Unique: -zOnDfkQMIeg7Dh-GJYrxg-1
X-Mimecast-MFC-AGG-ID: -zOnDfkQMIeg7Dh-GJYrxg_1748954337
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so28852315e9.2
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 05:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748954336; x=1749559136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3+PRkMy9CKE9FDDbBWCOy1rtu4+LJCsIf4C8yVAAuc=;
 b=GbQ/3YPobggQNlaAYbmnJMJ0H/N36qeJNvMhbpsZio6JgYTmNE5LKf3k0n7BQljvgE
 XGgKFxJIG+3ylwrjeGYrPwAKes4unZrbL7BrbC7Q8e+vk92VVXWx3i2EDBLTOp1V29s5
 GZqD+Jv4fxuP6s89TsWQq91F0PsrtTeDwh4cGrfQKXQJJPzwZfjN0W/SKNYW2e5wKaY0
 uYttY48R+ZUgdq3We7Tjjkf1h11kyp0xSVyanF+VhPl32oJZYzqXx+GN8bmgMy5ERNos
 j49f70YxcxZyzfcOCYdtpLSGuStnqw/j9P53Sx0PXx4q4hj2Xu1fxirdgDCkGaPFhH5R
 bF0g==
X-Gm-Message-State: AOJu0YzWPvVL8WzniialZmMgfM8rm6xV02WR+dqI1FTf1kOCDekXnTxB
 Ee1STVbjzBfTef0LXowD2nTx/9Tqrb7XWfD+21CSVZH7/xprxtgYi8TfvdnTSyyEes7zqnYjBJy
 2XzmNMpwGHVmMM7Ea7ASn99FcNW1QXgAEBWJtpCqRHm6yTzRJ47q+XLD62N7N9Y4hv1LBfvLXJE
 ULRp7Pm/2ImJMJTeIWuIRKFvJ9vp97uy80x0w1AQ==
X-Gm-Gg: ASbGncuF2/wwZJd4VU4XrZWEZQkvBcAo6xDKQejnUKOr85yvQUvrXHdO1HKX6bEEIQF
 CflWHN5Ml5qt0XyaLlIQfE1Wt/2joCn3sDiCoZpfTCS9+cT8LELS6X8sRFNS2+V2BgqaL
X-Received: by 2002:a05:6000:1449:b0:3a4:dbdf:7154 with SMTP id
 ffacd0b85a97d-3a4f7ab1311mr14328652f8f.54.1748954336581; 
 Tue, 03 Jun 2025 05:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgXPxtcXpz1kyPszS8vbhtyPJkSbP9wD6qBkhtycRm8vJcKOl21pvE6+BYFc6hT5qGqekTJ+hS4qqu0Z/Ldqc=
X-Received: by 2002:a05:6000:1449:b0:3a4:dbdf:7154 with SMTP id
 ffacd0b85a97d-3a4f7ab1311mr14328637f8f.54.1748954336283; Tue, 03 Jun 2025
 05:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250602141919.329370-1-pvorel@suse.cz>
In-Reply-To: <20250602141919.329370-1-pvorel@suse.cz>
Date: Tue, 3 Jun 2025 14:38:40 +0200
X-Gm-Features: AX0GCFtjvcpV4PYSR7csdzpSmmkwmnknOzm3fI9wX-wiNcNRIzHv0mzHbMIXsi4
Message-ID: <CAASaF6xQniHz7c_mTqgj8gVS3DM=V+4j11LkAfMvMgZMx-_6Ag@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: neLMEwxr9T7XqOQEgAPqYzkvdJtzU-6u-W-MHw4gOdo_1748954337
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] Remove kdump testsuite
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMiwgMjAyNSBhdCA0OjE54oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+Cj4ga2R1bXAgdGVzdHN1aXRlIHdhcyBhZGRlZCBpbiAyMDA4ICgxNyB5ZWFy
cyksIHdpdGhvdXQgYW55IHVwZGF0ZS4KPgo+IFRlc3QgdGFyZ2V0cyB0byBvbGQgUkhFTCA1LjEs
IFNMRVMxMC1TUDEsIEZlZG9yYSA4LCB0aGVyZWZvcmUgaXQncyBub3QKPiB1c2VmdWwgbm93YWRh
eXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KCkFja2Vk
LWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
