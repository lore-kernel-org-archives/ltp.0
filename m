Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFD0EF5872
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 13:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771334988; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=eXEbAnXUTPUsY4m9l+im+4v/5XHEeN0JdwKYYUpVa3s=;
 b=LNpShKguHZgPkk39EGcYSD8Anq0K4RX+xycH5HTlDV+UgZnHPF3JVR/evf2mk7LZu7T9Z
 LV3szJbq19DQ44Lhq/lxMw+2IgEmG41y4c0SnRhYPtfif7AIJq0CQsNiaHxwHuZgsxBuOaZ
 fzoCZ6H5xdXFACMTTEmKhKf+qzMH3xc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8919B3D0633
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 14:29:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 067983C5720
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 14:29:25 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6B2AB2005CB
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 14:29:25 +0100 (CET)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-437711e9195so2951735f8f.1
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 05:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771334965; x=1771939765; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q4iY3neWYZA0ckNlPyVbQbUb5YLUaeMoDo6YEqaJ8FY=;
 b=ZdcY2s5zRqLGzoJi13LJb+thTqsPHlnBjsACkNDkXYTfguPavGRH0L3ZRGiP0fjYls
 rA1fDk4o9VJsHyg7iqCE9ypCJN7r9UoE6k1NwY/Ppof0x1JRncFjqsvPP1W34xzp9nwl
 /ZYCc8S8GlVfQRx0Xf8LkdF+ikPJ+MjCLHNaNFoTdsyoQdDjh5WH1uU1u8L1BBaf+oId
 k9cUL/1YCL0q8uCEtoGvHqX18WKM4MVF97JreLg2+n8sM8lybMFHiLU6EZL2+eI9OI6X
 JjKvNREIhx0O4S5iM7GXaoz3pEu4uSWxfTumFML7L9PiH3MDm0ASi6n7Wz1BW6A75tPh
 LCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771334965; x=1771939765;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q4iY3neWYZA0ckNlPyVbQbUb5YLUaeMoDo6YEqaJ8FY=;
 b=hou+1QSW64mbwtZsVDXRLvTfr4nJVu2MieX5fVLOtyBww7FPPvZmd8GIJsXYXCHLKi
 ppm5WZC/KWQDIiUhOe2b1nXGVFUejlHJ1vuHz2AdHBOd0ndIA+no1/IicvuVRAE33+x1
 ZVBqZXhgGdTnEzBG9bdF4WAjSBmJvI+Q7jC6DDSqYI6s1dN4ZKz4EETlT8eV5my47Dhz
 kGe6UwNoAZPCqRJrg6tEDU07lm0CguA66GWMvukCMZNggC31cpasfHgoyEI0FLw0haYK
 1TJFUD+Bc3LpOt7GX7FuqXadHh9sfx2IhkH4o9ezTbovAh1Yv8aYDYcfrIiab92qCTZU
 l5Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdaRBQCTJB5S61lBxmCGdLHmLW0Ji1ytRopSzXA0M5q10avAt48IaYAWc2ITUhzDMXuSE=@lists.linux.it
X-Gm-Message-State: AOJu0YzYWjcgf5eGo2x6y1z5xEFZTJ5aHC+l3+Be3qwqD1vOUgQpWHBQ
 ddQmcXFDufDhHMcoLtzgXJr3Y7nnn1SWDtC5IJZrFc8VidVBZx9u5ffimoquzpkVBwA=
X-Gm-Gg: AZuq6aJMGkRrg4s0UbgRWxXU0s/jh0L2cxuhE46MwL/pdAWjylKhy6Vo6W5/PURHCUm
 aSBIPRpc5LcLfxwFU69C1sCndhoc1cBzR3V6iG18Uzzr4EMXZOdpdFIkiXORIZNWzwDpVfF4xyi
 Kuk74rC1iYwQFTkFMpZp+sDwkudeNIlSeikzA7FwMITd6cNY9X4oX8Xv6appjpEPlo1gcEWbige
 MWnvc6MrB+5Dst0eU4qfCb46jPzFXuUKrgSqxFUneWTW2cFNk9OcrSCLy7U/xyB4VsDKA3ENHJP
 C2jQxx9tvjkpgdDXobk7f41+7Acq2BXyGK4UWEO5wyDuYDXKk+nrvK+mUVb6DVEV8WoUXmORv+y
 rnZK0S49BRHCdhWidI4vUbcJIZS+2Bow0MnWyfkHs99o3TFyaKI8opZ94Fzkr4LFMynIIGaFwIE
 LzRyVlkot58TEmsEv7WnmnTy18Sf/y70Mmwgay/W//DyxLsoYuLkTERLSoNGKl1xInURY7KQntQ
 GYpE/NYL8rVXmGv6oBHlbTJF29tkQ==
X-Received: by 2002:a05:6000:603:b0:435:9d70:f299 with SMTP id
 ffacd0b85a97d-43796ac2063mr23530481f8f.22.1771334964684; 
 Tue, 17 Feb 2026 05:29:24 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm31687625f8f.37.2026.02.17.05.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 05:29:24 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 17 Feb 2026 14:29:23 +0100
Message-Id: <DGH9U8LALY49.15D20CTE4T52F@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <pvorel@suse.cz>,
 <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260216102039.GB136260@pevik>
 <20260216165015.1710-1-always.starving0@gmail.com>
In-Reply-To: <20260216165015.1710-1-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inotify: cleanup - limit masks, use SAFE_ wrappers
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIEZlYiAxNiwgMjAyNiBhdCA1OjUwIFBNIENFVCwgSmluc2VvayBLaW0gd3JvdGU6Cj4g
SGkgVm9yZWwsCj4KPiBUaGFua3MgZm9yIHRoZSByZXZpZXchCj4KPiAtIGlub3RpZnkxMi5jIG5l
ZWRzIHJlYWQoKSBiZWNhdXNlIEVBR0FJTiAo4oCcbm8gc2Vjb25kIGV2ZW504oCdKSBpcyBhCj4g
dmFsaWQgY2FzZSB0aGF0IG11c3QgYmUgZXhwbGljaXRseSBkZXRlY3RlZCBhbmQgdHJlYXRlZCBh
cyBJTl9JR05PUkVELgo+Cj4gLSBpbm90aWZ5MDcuYyBkb2VzIG5vdCByZXF1aXJlIHRoaXMgZGlz
dGluY3Rpb246IFNBRkVfUkVBRCgpIGlzIGVub3VnaCwKPiBzaW5jZSBFQUdBSU4ganVzdCBtZWFu
cyBlbmQtb2YtZXZlbnRzLCB3aGlsZSByZWFsIGVycm9ycyBhcmUgaGFuZGxlZCBhcwo+IFRCUk9L
LCBtYXRjaGluZyB0aGUgb3JpZ2luYWwgdGVzdCBpbnRlbnQuCj4KPiBCZXN0IHJlZ2FyZHMsCj4g
Smluc2Vvay4KCgpMR1RNCgpSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNl
cnZlc2F0b0BzdXNlLmNvbT4KCi0tIApBbmRyZWEgQ2VydmVzYXRvClNVU0UgUUUgQXV0b21hdGlv
biBFbmdpbmVlciBMaW51eAphbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
