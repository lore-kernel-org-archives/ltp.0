Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AC0FAD41B
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 06:45:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 219CF3E2598
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 08:45:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 753CD3E2588
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 08:45:37 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 62280600541
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 08:45:34 +0200 (CEST)
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-89fc4147f2eso70776516d6.3
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 23:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776926733; cv=none;
 d=google.com; s=arc-20240605;
 b=hW8Bw1ZkYC5Ze9fXiODnv0IoLBx+fR5yLt5o3w2iIjhQ76AKQVz7Uuzps2qO5+/sOH
 lUjLhIiSq1s9h1K7SvA+kwN8jVf2a4JnMa1YqEe+drsGRVu1u6BvVtKAVCnCwinG2Zc9
 MsaKqo9cHjWh3Czk7SUAlDK/It5P/nDSzTn/ZbrfYsiHgtu+R3aTNmNeO6GbUDCY0MK+
 TAes1F2GZ2nTD8kvSKOM1raTEHzCizTvFZf0DIIoX8ah18zp7wQG6ttpxBHFK2ZcbMGh
 WGcI0EMMYQSb7WSPsKjoohHMj8AA+IxIHL31R+TwTXFY1tuZQD8YLHsRvojz+L1ukXs1
 f4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M+lbAirT1jVIbgrxOmvlEhy2lOJ5eyOq5jOP0hubIbo=;
 fh=CuExz54ljsO/o995PG49UG+i4lYrQxd0nQjicfLDGOA=;
 b=RMYH+wfmh+FFjExRaQt+aUFxw4PHsUNIQuTlaHJ00PYLU3vyynqGP4fLCYRf8jpvE3
 EkX/EZCXBiAzPGO4Co0tuAjKMSmoTXk6jVWabApvC4MywngXj2u44f+iVFq6vO0lR8Ol
 AXeccYQn074yhuN7fBvn1fO3iOH4dK2HU/TBupfW1huxHXYk4yTo8cHlIY3gHw9f1c6L
 w95S7uIku/K8qjzMAqza2/gCj63dIomrN8gBBWYGxWG1eRNStf0D89AQRZDarVJIkz9s
 P25k7KlYu0K2sNGzwUGuUNNJbtvB01K4du9kKU3U2d6nz03nlSgF9B5Bu9Vpg1boD/PC
 opYw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776926733; x=1777531533; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M+lbAirT1jVIbgrxOmvlEhy2lOJ5eyOq5jOP0hubIbo=;
 b=bgH7I4NllFg4BOAu6QbJAUjpaYA9F8OVXVZr40I8kc/p4osOvuXyyUVwA1r9n1XeqV
 35eJbfYk9HBdSAsxGjaMqbqJFRBkVmYPXouNmVjYPGnnGccH17vrv0CqTAN8hA5+fAJ5
 tztaLeuL0X52opRYb5jwN5RbDyEBf/Y/DC6FaECBOiUOg269i2T7QdFSxkEoGu5y6EUL
 NUWPIAKxyEMqdq4hrI+1yXD35x07NcmYZEvZPJSPBJslQa8Irtm6ugJE4AGQ6spQhf96
 kjeUqQ8RKevn655mw95WAeu9XsXznro+NpQ5jXwUiofxnxpB4aa1BHyP4TGXQWgoA4Dc
 1M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776926733; x=1777531533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+lbAirT1jVIbgrxOmvlEhy2lOJ5eyOq5jOP0hubIbo=;
 b=jQ9XSiQHvq415SHQ/xOqCI8DYY8x1pyvmp3OfNVS14KJRDBiJnsjmJv2FivfiqJP3T
 IV4DqvofvsvLhrTmlC+ovlJlFdlHdNBK0GlbEEEod5ZQAlOkMHbQWAQMOokhFLY9i6i2
 8+FwwFuoQG8VdPU0J8plRCkwzUWHyeADf8L0tGFTsnVZPQ9P9lDAKHmgx5PRSAnCaTV8
 3waEznBIUQyDuWe+pRjTVKQUtuFrbREVM+e+8CmwxwqWxMAJie3avFVHaVzrPrHETWnM
 s/x8kPr0iaFX+akB0xbn2M08Aw7pMEuOF+mGKwQj66bWaIKTf3hFcRz+sfJijjhktcKD
 wbUw==
X-Gm-Message-State: AOJu0Ywtum9yhd1/nnOLXKMJzDpVJpErOFel31a20c/4/tWiVF6vR7Cl
 BhcF4w7t9gIhdCyj4leOp2MyZ5bz+oUL4jsY6rNAXe8M9BuN8Ns1hNHL77arEBFLWMpadNIWIbs
 vV98QT6+7zfv+HBzUrnEjmL2C9CjZtc0vEQwYLmLnIbw=
X-Gm-Gg: AeBDiesie/EiMlebzcDK//nYo+tRSZxWXcOGdodqL6hpAuNDViZQxeZ2ugmwVFOfQeD
 s240VcVwwtVLIyK9Goi0wk8lXLVlPw7xknjv8fgvZgDW/itww53AlJudMK43P/2dRSc65SIcLil
 Z3cu31Se08+pRQjWawS4k5vYi+uAUxbqtFYmqRqFjG9LKTLAnWWLx1Fl2PEIVjT8C5Bgqtju53D
 F12+QHDhxj5mtkrmW0NvGkt0UXjGRqeQmasJFBXLTkBCRxT2MFvz1IoS7LiLWrXD9aT06cCPt+P
 fxeQCWIS94GMbbEa1Q==
X-Received: by 2002:a05:6214:248a:b0:8ac:a6f7:8a6b with SMTP id
 6a1803df08f44-8b02806f829mr422070626d6.19.1776926733172; Wed, 22 Apr 2026
 23:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260422141234.632195-1-pvorel@suse.cz>
 <20260422141234.632195-5-pvorel@suse.cz>
In-Reply-To: <20260422141234.632195-5-pvorel@suse.cz>
From: Li Wang <wangli.ahau@gmail.com>
Date: Thu, 23 Apr 2026 14:45:22 +0800
X-Gm-Features: AQROBzCSWJf2hqqtEOGIXmokkQryT5Y74GDcayK0x6btMsncFIhCisoFGfnwXno
Message-ID: <CANgNiRz4VrRVUXqxBowmLfp104=kBdKyU1jgnsjP4ux6HGV8sw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/5] doc: newlib_tests: Update debugging
 parameters
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
Cc: ltp@lists.linux.it, Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel <pvorel@suse.cz> wrote:

> * Improve wording in doc/developers/debugging.rst. Not mention 'y'
>   (enough for user is to know 1 and 2 + 'y' is mentioned at -h).
> * Mention all -D and LTP_DEBUG parameters in library test.
> * Keep info about the levels in developers/debugging.rst, link page in
>   user/setup_tests.
> * Remove values from old doc (we have enough places to sync on changes,
>   let's drop the old doc).
>
> Follow-up: b415265cb3 ("doc/setup_tests: Document LTP_ENABLE_DEBUG=2")
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <wangli.ahau@gmail.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
