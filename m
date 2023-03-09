Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650D5C61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 11:18:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BAFD3CD868
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 12:18:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 099CE3C1047
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 12:17:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 572171401110
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 12:17:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678360670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZuCnBs0cISD7si6kpqKStmEbIas8VdvVTdm+BHW/BxA=;
 b=JxIIr2p42NY5mFRKDDXAzVxXi9lbNGi6g6+/TZoLrcIm8+xkaawb9y/4ifzvbAPERdk81i
 2ou17DTT2xgWidEPXGs42FtmYfi7jX6HfSIwAJlDJdODH0YARqTcZA6kVBoH9nh1+BhKj9
 Ie1QkxrhLLEhPnPLgz032nBxDLuriyQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-haikGBxeMxCJ07FhIFUP_g-1; Thu, 09 Mar 2023 06:17:49 -0500
X-MC-Unique: haikGBxeMxCJ07FhIFUP_g-1
Received: by mail-vs1-f69.google.com with SMTP id
 b10-20020a67b34a000000b0041f71775311so499685vsm.23
 for <ltp@lists.linux.it>; Thu, 09 Mar 2023 03:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678360668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZuCnBs0cISD7si6kpqKStmEbIas8VdvVTdm+BHW/BxA=;
 b=L8T8lVXSND+aSoWweSnrae3pzZ8YH5ozDRXAeuoAZ/Jh+WiOuWM1mJZVWW3mWkdopm
 pzzQNsZ9fz/si49b2+Burhz470dOOm9/xYUx6EdocwsfjDs/UWxGlrn2FnQ2tmw+j0Fr
 2QebydoHsx9h92jwSb6EWthh+YIg88H+1vuwLg0zaj1DUwiqyE6qTzclfv/AhrOJ4EB7
 IDEsNJ77S7csNdjl+sLW0eJ3Ay2ZF4le0NUKTvysMjoknximCkLZxozs5qth/XIPeN9e
 jHIAWC+zHAhX+Zfec9G89gU36E9d1Uh/LProPa5/sRFLyB55o1gAaImVtg1msOGEC4qH
 wG5w==
X-Gm-Message-State: AO0yUKWHDhxjLAPSCm9L81uR25ajx0r+xi/HP7BSlQGM9gm9g1nXu7v4
 cudBwmNDzUsXZke2Qi7RbPFWx+J27yhqTZ8gH2Y0WOMjmenUzhz8sVxfA6gNX/yxRYagW9Pytn3
 T/897M43YGuYUmOTWB4gKK/QjAMw=
X-Received: by 2002:ab0:4a5a:0:b0:68b:716e:ed8a with SMTP id
 r26-20020ab04a5a000000b0068b716eed8amr14596599uae.0.1678360668632; 
 Thu, 09 Mar 2023 03:17:48 -0800 (PST)
X-Google-Smtp-Source: AK7set+k7zcg/2KMFjX3OpvU96bIMCB5d6m6XesU8E/y5WaCFILnC7KzX1cu18MrECoMQ8Fp3YfpS2HOB/jWyu8bZDo=
X-Received: by 2002:ab0:4a5a:0:b0:68b:716e:ed8a with SMTP id
 r26-20020ab04a5a000000b0068b716eed8amr14596594uae.0.1678360668391; Thu, 09
 Mar 2023 03:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20230309103346.5574-1-pvorel@suse.cz>
 <20230309104418.GA6311@pevik>
In-Reply-To: <20230309104418.GA6311@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 9 Mar 2023 12:17:31 +0100
Message-ID: <CAASaF6xDJskSnQRpocnz8TWXGbdvmxxRkS5ZJC1em4d_0ckP6w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] endian_switch01.c: Remove useless
 TST_NO_DEFAULT_MAIN
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

T24gVGh1LCBNYXIgOSwgMjAyMyBhdCAxMTo0NOKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEphbiwKPgo+IG91dCBvZiBjdXJpb3NpdHksIHdoYXQgaXMgbWFp
bjQoKSB1c2VkIGZvcj8KCkl0J3MgZnJvbSAwODZjMTRmN2E0NjUgKCJUaGUgZm9sbG93aW5nIGhh
Y2sgZml4ZXMgdGhlCiJlbmRpYW5fc3dpdGNoMDEuYzoxMTU6IHdhcm5pbmc6IOKAmG1haW7igJkg
dGFrZXMgb25seSB6ZXJvIG9yIHR3bwphcmd1bWVudHMiIHdhcm5pbmcuIFNpZ25lZC1vZmYtYnk6
IENBSSBRaWFuIDxjYWlxaWFuQGNjbG9tLmNuPi4iKQpidXQgSSdtIG5vdCBzdXJlIGl0IGlzIHN0
aWxsIHVzZWQgdGhlc2UgZGF5cy4KCkFzIHlvdSBmb3VuZCBteSBtaXNwbGFjZWQgVFNUX05PX0RF
RkFVTFRfTUFJTiwgdGhhdCBzZWVtcyB0byBjb25maXJtCndlIGNhbiBkbyB3aXRob3V0IGl0LiBJ
J2xsIGhhdmUgYSBsb29rIG9uIGEgcHBjIHN5c3RlbS4KCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0
cgo+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
