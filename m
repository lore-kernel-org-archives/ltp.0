Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4B2F94CBB
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 06:44:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA2AC3E28DB
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 08:44:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0346A3E2588
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 08:44:08 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 789D01000421
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 08:44:08 +0200 (CEST)
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-50e63771eb0so42997531cf.3
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 23:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776926647; cv=none;
 d=google.com; s=arc-20240605;
 b=hy6ioCczWVcQT4IixukfVXkSIrUjtKkPGT6JmgpAshLm2qCm/5X6KfGkvjiv/sJ8pn
 iH504WEze6MhuECTrLWaorqiJvgZX+7R+rIJMMi+8uTH4xc8b2ZB6a0Is08mAxH8tDP+
 vFFiABLtkMglD5K5urWFbglwmVJR2Tjc07z/2QJyAJs0Ru6pOFJyI/oUCgVqY6tK18zt
 526Un+2a+0TZGWk2Vji3g0jhl13pr11Hq9vOX9N1KlhYFRNO7zRN0HPvYxpEByfgZxD3
 LC/9uFSHh042BZYROP09bWIl2Z+5RIk+UGIvY3eHmV+NKIO7lDaZhxPBRVdMvXsUjwPz
 jbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1u3bB43JQiZuo+K8GboRAZPWoPgfjKGk3LjK5qqP5Xo=;
 fh=CuExz54ljsO/o995PG49UG+i4lYrQxd0nQjicfLDGOA=;
 b=SOGfVwnbevlEkffJK9J8aaOdg/9UJS8I6ae67IRukJmbpyGJBaKNwJt5ds6MpB20SY
 uWbzSA5oigPwfryVU1h9yRo7e4ZnVVaCmtr8zkTwAxe4h172IzXNQq5xuK44o02psoDR
 MgIGOnmqWdueE+bo2IbDwXxqkjYRpEouMG7Sryl8Eu4p0gPqdEX6nSuBedl3htHM9Lhb
 da5gkPIEbraoGpsSDlZJZaEF0WYZps5Bort/+Moz284pO8jxqX+U6KYCZ6uySeXjAF9R
 hcxsqS4EnLCdLm59V33fZfG14Vvb5gu2kpAr5YPG/hRehO2vG0Kvtl/HHYzwFY1Gq/rS
 sxyw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776926647; x=1777531447; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1u3bB43JQiZuo+K8GboRAZPWoPgfjKGk3LjK5qqP5Xo=;
 b=Ube5hNSUACOcRkJGVOJixJkkGYY+sCdIa+Q32PdMt6JC/19YI5qM4+hAw2mQ6oXr1z
 jO5hY/h1LO6xPry0phTaPj2K9VbQUZvoj9y/Uyoy/CzF7gpdMz8Jf82ZxFiSL3UIceVB
 gDhq5o/fP5xL4GkfipeF4zmO41314L4K2kuR/NInyqowgEM7d9gcVfOwzBcdB50XTzfA
 zhxYQtBS0SH+/a9FZlJqRFHygZs0tLoeerCl24SZ8owe3SS4wLUBGShWgDwrQ1+k+XV1
 fynSrIaP/m5uiQww2VyVR75aFWcUwgxHoRn9+o72/Uh2wXPGBjVY306hFtc/QCKb7j4g
 ozGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776926647; x=1777531447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1u3bB43JQiZuo+K8GboRAZPWoPgfjKGk3LjK5qqP5Xo=;
 b=mSIFUn4N7bolutgtxg54f9TNl6CmgnM9C2eDN36UaaxjnoALq7ED0DM1pKxOg2K/wv
 u6fqeA5GXt18nRpmS1BYulvyC4izk2DgIrZb0MxecxMd2DXdgBiCFUs4+akxpzKH/i+f
 a/GuxV4mSb6AO4akKIpj4P1WZlT/I+NsShVfd0LTRwK/0ID4mCAXwxmaw2aBozvQA8Sv
 IK9MBkiaWccBqqqV8NaSX0j1EthxgKobnJOmhw8OD94cuO7z3YEXmdlJy21grb9NwGPu
 AodO5Ne0yCxOmlMLBp9euq/u3xT+AN0eQI7viqt5uAFwUjhgNf/cHp04Vn0eAQ3DlinG
 SCsA==
X-Gm-Message-State: AOJu0YzHHVZosflz4NcLb9De3NYtZnXpb561FrAxFnCTARZZmRrBKc5i
 o90YBOyt7eqNyyvYND6ItZIBnS8/aqN04TOxgDyddGpqnVr6cjPbH5qleW/izfrZVFj3w7FIMI1
 bOLWs5e/BTlIHUjlF1OCD1KCJNO9x4w==
X-Gm-Gg: AeBDiev/V8WytwDbyWT8sDM2Qm+rrr3e/b+6mn3++KpXmlNiwswxmfLNcZfAJejbe6v
 cglV1U4+v+7YpzwjVUsUCAH/PUFphXp0x85w07ILQchMLUSje52k7yBPdsT9B5KTmYQO4WyBDp8
 YdT2Z4EIPpPiR6kcTCgXuT5yy4FBDNg9VElrZTf0fD+kMYkF8tASqjs423YlNnR0FV1c31fvNuB
 QDyZc5p696k+29cRL3//+yJNAWoKALZo12VHWq+kCd2reeEPfMUBS4QYQxYuiCPOxBa1zw82i1E
 dROiVgOD2ztponOY6A==
X-Received: by 2002:ac8:5892:0:b0:50b:5146:8803 with SMTP id
 d75a77b69052e-50e36b41019mr401306401cf.21.1776926647200; Wed, 22 Apr 2026
 23:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260422141234.632195-1-pvorel@suse.cz>
 <20260422141234.632195-4-pvorel@suse.cz>
In-Reply-To: <20260422141234.632195-4-pvorel@suse.cz>
From: Li Wang <wangli.ahau@gmail.com>
Date: Thu, 23 Apr 2026 14:43:56 +0800
X-Gm-Features: AQROBzD5tT41X0L6aHdjPpUw9O5fxEASvvASm1UipQ0QLk6bntzAjFQNcsqlvEI
Message-ID: <CANgNiRwFV2F2hG+7+v0NyrTa=ejhOSxSLrNt=5jKpd7VU62-cw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/5] lib: Prefer LTP_DEBUG over -D
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

> Environment variable has usually higher preference than getopt.
> This includes disabling debugging even on -D:
> LTP_DEBUG= ./test05 -D2 means debugging disabled.
>
> Also reduce duplicity of "Enabling debug info (level %d)" message and
> document that on -h and developers/debugging.rst.
>
> Fixes: e434de62b4 ("lib: Extend LTP_ENABLE_DEBUG to support verbosity levels")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <wangli.ahau@gmail.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
