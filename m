Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59ABC0219B
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 23:30:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 188523C9997
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 00:30:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26E063C9967;
 Wed, 12 Feb 2025 00:29:55 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0DB99257994;
 Wed, 12 Feb 2025 00:29:54 +0100 (CET)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fa1a3c88c5so8126947a91.3; 
 Tue, 11 Feb 2025 15:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739316592; x=1739921392;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:dkim-signature:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JxFMr/7gfexBxB8SYyp8114zRCVw/pi91pu4qmM/VZ0=;
 b=JzfQMCGAHd3Sq+CgsSVFVlAHxNamL/+AyE5DC684QekSjEaePpXvauzDU165EpQyEs
 +pDxBkMtA3AP6SohU+pa8CknWnbY93SnkL50CSAEJh+8urBkrRouNUQVAxxbGRycO4Hv
 H4jIvMMJXSSmP8f3y5rbyyYFyUiegJ4aAELAdQqYIXhm19yM3F2B4kbo8OrfYH6D8mpM
 wR3vxHG8seWRrmhXDP/ghHrwmZ5RHNjCBrRPpbHipIJCNs2/670c3WmtgAqoRCUG/hRC
 T/Z4TrHNbFUmJ7TVWEOTNeAHv6Fj1o/jRKcV40UEtDPGmxLonQP7lL+8vSYd3xmEZYf0
 0ecg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZsNg76Tnzo0ipQuio3mqG0e+TDjV3W6kgQ0+lixcdNTzwqbqvZUNmD/P5rDU+dfgSVTU=@lists.linux.it
X-Gm-Message-State: AOJu0Yxu8xcysbAXDMWl64qFFqOD4iKLREGJqCvVQZ2MtfEevczcj2nN
 yEwcweoGpkkomI6bU+Zlr/yj3fKIwch+mk4oo/SlMROK1poq8GKM813wnQ==
X-Gm-Gg: ASbGncs4CUUs0JkS+JhXsOEiVXgzBB6pthih7+cS+9mtFMpNP5zPOYes66GBbCwwLdb
 +vIYqkkNElMMhuMS1kAF/n21weCmHM9ksTxqHIucQLSzgOqUuj5FnSc1c7vUIPUckg5O6Sc0h4q
 B6Srn87lPpV9shWMFPooAGeZgLKN0SL2we3JyZeLvHHVzzjwC1B3/XlS0COZWrDy+srLWu7/z5i
 YttN4jOEBS5cBQwsfuj8IKnfFOEEhJJXgTE02VMrO3EGecbIS+/0NXJUKl1aYo8BB3CLPlejh63
 bMtD9D3/msqQFZ1D3LoU5MUkFtWhzrN0
X-Google-Smtp-Source: AGHT+IGa1JP6i/CJIHEXXU5ol5bJ2M6/asiC+HZs7fCOWJWIfrkG2AODIJARUF5vYjjYFIEg+pO93g==
X-Received: by 2002:a17:90b:364f:b0:2fa:1e3e:9be7 with SMTP id
 98e67ed59e1d1-2fbf8957ef8mr827333a91.5.1739316591865; 
 Tue, 11 Feb 2025 15:29:51 -0800 (PST)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98d3d16sm109106a91.13.2025.02.11.15.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 15:29:51 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739316589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JxFMr/7gfexBxB8SYyp8114zRCVw/pi91pu4qmM/VZ0=;
 b=BYwI8CTWVsqdtLDtfw7jH4O6kccaVFrf3V+Ug/SF44+fCK5Wg32LPDUdG5CTkbw6eVqipq
 37aa5B3p3MdDMiXLfS+B7sgepiKhCpKWU3KPyUfYYzN7BU5PIdteN1kW1yTMeZsk88IGQf
 Vi6KpJA9k4VvC6wRMI0bKApPWIS3KuWUkbfXsSundpy1W+JNk3LjmYFJStZdcLl+RlWkQ7
 KKqMeSImgJ7zdcGqDTA4OJRN3IIirJcODKyKgEljpjEDXIQqoEiWe9e6nKrYwRwjPQ3A1P
 9NfcJybHyJfv5zMlw2vuK7cg6XqD2zmNCml5ZrZfz5+lhLbZVsmh7kuTpp6qZQ==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Mime-Version: 1.0
Date: Tue, 11 Feb 2025 20:29:45 -0300
Message-Id: <D7Q09SHWBHIT.2WONG36CPPT07@marliere.net>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
References: <20250211223156.1974651-1-pvorel@suse.cz>
In-Reply-To: <20250211223156.1974651-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Remove [Description] title
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIEZlYiAxMSwgMjAyNSBhdCA3OjMxIFBNIC0wMywgUGV0ciBWb3JlbCB3cm90ZToKPiBJ
dCBkb2VzIG5vdCBhZGQgYW55IGluZm9ybWF0aW9uIHZhbHVlIChpdCdzIG9idmlvdXMgdGhhdCB0
aGUgdGV4dAo+IGRlc2NyaXB0aW9uIGZvbGxvd3MpLCByZW1vdmluZyBpdCBtYWtlcyB0aGUgdGVz
dCBjYXRhbG9nIHBhZ2Ugc2hvcnRlci4KPgo+IFJlbW92ZWQgd2l0aDoKPiBmb3IgaSBpbiAkKGdp
dCBncmVwIC1sICcgXCogXFtEZXNjcmlwdGlvblxdJyk7IGRvIHNlZCAtRXpyICdzOlsgXSpcKiBc
W0Rlc2NyaXB0aW9uXF1cbiggXCpcbikqOjpnJyAtaSAkaTsgZG9uZQo+Cj4gU2lnbmVkLW9mZi1i
eTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgpSZXZpZXdlZC1ieTogUmljYXJkbyBCLiBN
YXJsacOocmUgPHJpY2FyZG9AbWFybGllcmUubmV0PgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
