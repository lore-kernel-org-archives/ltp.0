Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ABACD6E57
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 10:00:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F07C3E548A
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 12:00:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA2E63E1DDE
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 12:00:37 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 84E77100052E
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 12:00:37 +0200 (CEST)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4863cd278d7so334667b6e.1
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 03:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780567236; cv=none;
 d=google.com; s=arc-20240605;
 b=NYv+iTJzBm9IhnzVMjDHCyAquSE8nekearIrN5tiYiurERNYgVEdU2yNpJdBLSkgW1
 QUwQ9h4I8KLeyawz8sSbNi62M8KdrAW5bmCV9OvzinzJuJBaMHE/LOq1QDwF1iYLvGtH
 w3ACbotBbbLE/dVCNX4m1+9f0RHY/u32Y8GLQroXUl2KuUqedqChZDmuhmPvEtbC2VzW
 KLiKeh5AFv4ntsVJ/0OQYl2iYNc2dHX8EA+SFrvD6DDfC8HQaaIaPv6fz2m5GQNky+p9
 o4cxaGEnofFFQ3d1frZEMPAg5ie/e/Db6kmnJ5d1jkH+UvNij/gknOUbsqEj0P82hJoW
 PDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GirRFJW06tQWpyQav+nQW/N64iFalwEVlkcMbBoS68c=;
 fh=CtANDuKPIj0v88UI/q53VwcIw+6Tu5LcBkgNvW2iY8U=;
 b=OJOKL4X2c6UieUKfYuUMFLlRnaYRFbBW5+12EQQZCOORkwgH3ta9fIxCuVaJ9/Ql9o
 xcwO+8CgX78iGIQJFGloxY+Gfh7GaoU7qFj8hBYWD1gU0ERdrg/eaRyCOGhDbzGxpGgo
 a95soIq9Z/H+08bll1dE882bDOM1gn4WjbQ40Aersc3n/40yRxiUShvAeCN6pauhNXAM
 J2IfO78L4cNfmvRGHh6cGJuUrmpk1vmbdeq/iDtDYuH8mlxD85rHtV2yRKTC7RUkN7Y9
 coPyso09bXKtRvkLK2V/nVysiHnXcCMHk+0pKDrL7fA0YFaP2BphYVUA1m1auvaM8hRc
 nU4Q==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780567236; x=1781172036; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GirRFJW06tQWpyQav+nQW/N64iFalwEVlkcMbBoS68c=;
 b=kgOBCOSdS1rC8DQpJmCAD+/yU1mxHPUHNUQoFa1RqOV+yCsOMoNf28DXWZVKVXLBL4
 TDZomGcm2ctLcs4hgW1ZLmQL5fc77hdoBnkLki1rqQRszfyGHHk55jIASFi7z9sYJrJB
 qlxYdXMpv7Kj8PU3YB+1PTy2t7psiCcH0CUs3cnOIMKzbFiVs7uHlbl5DiOKOR1i4AWC
 9z6jLU0os/EsBMj94N2ZEGGIvlry+8fDS+ZIy9LaPdTZjNqZ8mF0f39sezGB46v66tUU
 guZKvby57U8VORF2Lsi8e3fiZMFQOrhaeppdilisCrtmipLCsL/G0zOH92WNAQCysDog
 3Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780567236; x=1781172036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GirRFJW06tQWpyQav+nQW/N64iFalwEVlkcMbBoS68c=;
 b=b95VZR1uETdHN3gpSPToJ/vgbUHVEGAOROhuAQRu7Q5+Vdbc9Bhcl44NiwCOWH0QKE
 t5ar504jL5gb7VFLnyJJXSFBjPP5lpniVdIw5VB4OuEtAzHX83alCSVsV+i7F+/jmHgX
 XsUA3cG/5S0WpdZXk6iJIUaPqFHiablLL1Qo/HVwCFyXOL009L+3t41qFLELZg73X5zr
 dC8dK4K9dlNzaCHeTcW/bcX2CGefwzRzzMV5jhZd86hJrQ79LnWgv3jbkVqjQCDqba4S
 R0tMwyAciEpYNW2kRABqngMBKhlukaeTkXFMYxsrw615doHNRK4miCyOkYZP2naQaQ3a
 dNqQ==
X-Gm-Message-State: AOJu0Yz2Jek/SjW/y6XaOyCxZlEb/22Dk1JUWPLKlUv4JRn5MtXlQMEZ
 qvDGAYMCbaBW7oE/zQ4vhxHmNlAPV++h2pV2+7xs6m3Y8adcO9L3hF7qp58n6NKbz6x/CEgCUQI
 36IpU61itdklf3ZkXiuMH0XZGu0vjUvspVO+LhoHwHQ==
X-Gm-Gg: Acq92OHADpaIxCCbo/Dyf5xSp/pgR7jwFFFLkIaFw5FykHYl0cd9EM6GxcgdVJM1+Ip
 zpr/3lBR5FPsCyiSskgtSqkrWU4SStXbFi02K0HGEBKq+/N8bTVkyMzKiflygDobOFsjLEDVqhB
 7vIWat08DZVNeicLbKEm5PS19caiK3kegJjABh/BAZqjDI9nKPcYZvJpCGzCdZtjZhqbntW9rOx
 a5MdiFK7ILkI8lN3CBZLQaV6MhXcfD6OuPpa8Qn11RReUGTdiHhwb461aX1rSSyC9TD+sbPAKAh
 XBxKo1mAppUea5wMW9aHQc+fJVFaGXejZOroDGeft2zEZyKI1ifmfUQC/g==
X-Received: by 2002:a05:6808:17a2:b0:486:5115:6c0 with SMTP id
 5614622812f47-4865aa254f0mr4403564b6e.14.1780567236057; Thu, 04 Jun 2026
 03:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260602064442.718507-1-wxl18715129466@gmail.com>
 <ah_65vifTFw0LNy0@yuki.lan>
 <CANJThoG6kuQ7tAqMr3JVMuu7qu8QZXMqDTU27skohpB37k8xJg@mail.gmail.com>
 <aiE5GFLKJ_q7NEK5@yuki.lan>
In-Reply-To: <aiE5GFLKJ_q7NEK5@yuki.lan>
From: xl wu <wxl18715129466@gmail.com>
Date: Thu, 4 Jun 2026 18:00:24 +0800
X-Gm-Features: AVHnY4LvDvfXg5Lv5SaLto0hZ5Wml6Mc4jgLCjbZvi5XFgh9UhIaCDPRKhKmsfI
Message-ID: <CANJThoE=Grdsq6Nr7zHAqYDtBiMJ1kvFXhR73GtF9wn8oucH0w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/unlink09: report unsupported inode flags
 as TCONF
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

Hi,
> If we do that we would miss a bug when the support would be disabled by
> a mistake in one of the filesystems. So as long as the filesystems that
> lack the support are filtered out it's better to make sure that the
> functionality is there unconditionally.

that makes sense. If unsupported filesystems are filtered out by the
skiplist, keeping ENOTTY as a failure for the remaining filesystems is
better.

Thanks.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
