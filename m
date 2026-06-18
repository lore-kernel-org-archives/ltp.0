Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61C7CD98ED
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 16:41:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 564343E5898
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 18:41:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A59AF3E1EB4
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 18:40:36 +0200 (CEST)
Received: from mail-dl1-x1243.google.com (mail-dl1-x1243.google.com
 [IPv6:2607:f8b0:4864:20::1243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3A8C260086D
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 18:40:36 +0200 (CEST)
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-137dd4cc208so982485c88.1
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781800834; x=1782405634; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhSpeB4gghbROV0E5r8mJ5SAYkgxpEUzVuKQOqGYnT4=;
 b=WxxZ7AjPt+NuDaPA8REzyX9NUG8BPK/xJs6ESNTvq23qfGgnpw6u061lTGmifYIu57
 kMrr0lEn8YNmX5ZXKnfoQpT8drwwib/oHYU0JUgDuSC4Ojs1S5JHW/VWQ/VnrquyKRTw
 CDDo6yn+ojd5CkNWTZPhUKFJr18Bm2v2AoFcjVd4qZqY5z0QT80pJqRQjCaf8J8t1c5f
 WYVtWzrdBsbf7tJZFVR/C37lomar4HuUBRP0wN14bic89kEM+069rIBc3e0XdDcPdr9V
 iB+qnWeM+uuSDd4fhoqiTg+WXu2zhG/Olll9MsQvgYszdeRxDGf+9gR5Wixgstgx84U/
 XkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781800834; x=1782405634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KhSpeB4gghbROV0E5r8mJ5SAYkgxpEUzVuKQOqGYnT4=;
 b=gickiwbm8Udh2gW3TCjGsY8nlL1LYkz+oSpG+g1rnsEmiW3zisfWwLkHetnWYZb8qw
 yGxiTkBTWFih9OYUNWevSLJT91EIWfQstLUOl6tgO7TxBTbYwi5xWfyjH19Ypi3lUYp3
 EmwQCxIis3mPTC2ZgLrtP9szG6Rjyl5y2bWvXsGBKBfIoC6KEs3H6ISF49OJ9/f99nU/
 e1EtNoIW4KxR5xm58N1BfMD1JZhnkBTWq6e5Np+lIvNT0GDH2ZSK7VC8Go+yXy4/Ns6k
 tdBotjjsR4tXtE5wM5U16FexIlbo4IDyPgPF3M1XfGO9LSRhN+ylEbCaRgQ6fhUB6Esw
 byew==
X-Gm-Message-State: AOJu0YwVGl8CzQ86QjVbWHYgczRURSF0CxXUuEyvSagNYOMd3rkslzgQ
 OWWD/a/MDGyCfA+sLrm/EXhqquzJuuXhFiGCepdtY5F2n4euazJpZ/bj
X-Gm-Gg: AfdE7cmv8z8c1HytoW1dj0LHJw5zKl7qLMawqg8SMRJwQUJYwTK0FnfliRcQspRWjrC
 KNvlQLYsyuEfi9+wnzrgql5z3eHiKp5vL4WWhgNZwh3qg90zBtYFzXP3HSMXa9hs93tWbl5Y/lG
 wQLCcn1olH55wEiwwkDerAhesH05LvE96U9QkZL/QQdA8tuDw6eyQZLVIAkkPYprhuz4ImWjiKO
 UPKRI3EbovxGQDY5uUHfz6Rb/cPF0mz2fMK/UHnkv6wEb6VSEQoKiH2FV4WZ7ixqp81Td/5cmNI
 drK+5pCmVI2HHdu8bsgXHoaGAj+oUXgJWZH63A3VqTigHAbBidWQ+NxH+zQQwdEMsVQoXAkzwtz
 1BzFj/3gkLwSNsUO5QxXzjdRZ2YJdNGJ/gba4JAlAS9pPk4QSn2hdgSqwu73vstpzjuHe75ZaZN
 2TDQGoRFD7Vt6kMQMWW/+Id+Ss1AowMMrujGUHCZ7q2yIIHBL3P0ujYEnGVDo+Y8b9lNtO9oXQT
 XIB1z5wpXfOGQfUETz8sESaAUHw/A==
X-Received: by 2002:a05:7022:662b:b0:138:40b4:6cf9 with SMTP id
 a92af1059eb24-1399725ac31mr3169129c88.19.1781800834400; 
 Thu, 18 Jun 2026 09:40:34 -0700 (PDT)
Received: from
 runnervm7b5n9.olavzxkizpmejmmuser3fvrntb.dx.internal.cloudapp.net
 ([172.184.211.64]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b964853sm18915624c88.11.2026.06.18.09.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 09:40:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Thu, 18 Jun 2026 16:40:32 +0000
Message-ID: <20260618164032.4133-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618131203.87824-2-piotr.kubaj@intel.com>
References: <20260618131203.87824-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] rfim: add new test for verifying RFIM sysfs interface
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

On Thu, 18 Jun 2026, Piotr Kubaj wrote:
> rfim: add new test for verifying RFIM sysfs interface

> +#define RFIM_ROOT "/sys/bus/pci/devices/0000:00:04.0"

The PCI BDF is hardcoded here. The proc_thermal driver matches by
PCI device ID (PCI_DEVICE_ID_INTEL_*_THERMAL), not by slot. While
00:04.0 is the typical BDF on current Intel client SoCs, could this
be discovered dynamically instead -- e.g. by scanning
/sys/bus/pci/devices/*/driver for a proc_thermal link, or by looking
up the device via its class or vendor:device pair?

This would prevent a silent TCONF on any future platform where the
thermal device appears at a different BDF.

> +static void check_read_only(const char *path)
> +{
> +	int fd = TST_EXP_FD(open(path, O_RDONLY));
> +
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);

LTP convention is to use "fd != -1" rather than "fd >= 0" for fd
validity checks. Same applies in check_read_write().

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
