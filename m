Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A27CD4851
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 07:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778656103; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=qM09fmcA+92PcHaOIg8Dhv7a8vYs+YtpgNHBjpzMOqs=;
 b=MFxzHzjJtJczS5ZYZuyFu9OeQOBNh0UFYH71Xd5qi26EltVlpg5dc9HzarfHeU+HZ83PJ
 biJFGlZgfhwNtufSSA3uqLKl4KHFji1I5o6LK7jeZOreV5RawVJ/d/1pOwOfIZ9CURqXk+G
 I6+/BG3Ezifk508sDBpKMU2Dk9KV79c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA4ED3D7A74
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 09:08:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B88C93D04F9
 for <ltp@lists.linux.it>; Wed, 13 May 2026 09:07:59 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EA978600A3D
 for <ltp@lists.linux.it>; Wed, 13 May 2026 09:07:58 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-453903ee4adso5516321f8f.3
 for <ltp@lists.linux.it>; Wed, 13 May 2026 00:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778656078; x=1779260878; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=iSa9swsDVOAba7z0av6SPWSgPX9IGpucH/qaKnFk/Bg=;
 b=f9tUuvkHu62AhBd1tFCPRDV3KNkObBcPqACqTNpYlLXUewY/3pLlLRRSLiPxC0+HWu
 Fp44ddr+MRDtfya7wG1vTpvZVP3boBiuOlTcpMcaaGCC91ENoesC9uYwVMof5ZzsbTxA
 Ehh9h9s0ob7yFf+QeN3oAJohLw4sEoMDkulfGz2uU8k+MOqRwSpe6Rq4zd3DSdu3QdJf
 3fFDSAPKDDTz9CHup6WmgYP3RwtCF/A0h+zUsAXabYWFVEzfkQFjAMto9gf3br+BRPRG
 +xTqpQcvOzS4GBwa5k1joGfTsCYubUL737DCiUleXHEjUKFctL1K3klA38qtNwZ+oqyG
 x2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778656078; x=1779260878;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSa9swsDVOAba7z0av6SPWSgPX9IGpucH/qaKnFk/Bg=;
 b=jQ4EcZEjdOfd0qcP3LXH9YjWOmJSVCToLMUzXPLnI6ctKPQdQYAog5V9DD3U4GGsfw
 kGPu+oMofDbGTjKlfON2Ze2/HYb5NpxdkAC8Gy2BFlBt7immUAygRGGdIDp7bNt+iB4D
 QJ7Ceo9cNReacY7BvuqUnfU52hHlkN8FasGbmlkXmQzv3mgXA0gZXosBDzpOCZwR/xKY
 vUSSrM+dRcgzc2bPQQwFbaoedoqW/p0xehQaWMSod4VmkxpqulaBF85Kyafck03xExOd
 P51lYFfeW9CJ/yHclzp1k/fvhNuvJSzdbp5KZ1XsM9f/pEbXsAWcuwV+5tz4tNOvPogn
 8fhw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9d6Iyfxar2HwKB3Z/Y5VdxonmhS7zgEOFAaKg1t5oyxj/4/NdDD6r1nrm6YpmM4BKR6d4=@lists.linux.it
X-Gm-Message-State: AOJu0YwXmys8E0Dkeo3ItJANZHKU7M6lu10cPq18JmVXGp2fBMbRRrUK
 a6rNmk2zkRpbhNT35OTpVBdqX4hgGytL6FhTjfY+Ix+1cGmbqHXzvvy6C36zdJft6CA=
X-Gm-Gg: Acq92OHId5z7cu552pdi8r1kmTCNCY3soCldBaMyoo/fvouFxMC+0A6RActW2Op2cNe
 bCY0FEdR2F7XFwSK/77NOzN4IsaV+hNVaPzY1nOSQFgC/n2TqhRE8L8EF1r55/1D4XD87tmhhGP
 1OUKBqsoWBBoylh9oFWd0pW/0rMCL1BEldp7sSXOhFYzTWDALyrzf7hisup/T7REAT0rYgp1ihW
 GsfP0qL8634oGp9NC0szcrdVoHWTOJjzOQllyTRWCVyUJuV8HaXMz1OshbR2Y2q7jm9Xclz3gXa
 7JFkhGrWBgjWZcuB1wbhNqesmL8Wqj4MJ4cEda1FTnzjCg0YH2/cO2ZUU9Jtn0UfEO/jMxmRrVr
 +ECyepq8Z2kNgme0p1bYRtkPdv4CZ9H4/lyphUL+Lb3n2IOa8QauBGBjveEcxSD29JJ3bsLjWAa
 j/GNpk2YG68J2WFWMGb+nwntFosUzbvI4UlXlOM5SqAX9/e5Y6A6+kLb1w0JpgYSAfdIJ8FhX+E
 HK9EEAbQcC2Nyjo0kXoYmMXDqH4E9Qflek=
X-Received: by 2002:a05:6000:2dca:b0:43c:fd7e:72eb with SMTP id
 ffacd0b85a97d-45c5aa655a4mr2853123f8f.41.1778656078243; 
 Wed, 13 May 2026 00:07:58 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120f1f9sm38934497f8f.24.2026.05.13.00.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 00:07:57 -0700 (PDT)
Message-ID: <6a04234d.5d0a0220.c20fc.4c55@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260512171536.3962-1-linuxtestproject.agent@gmail.com>
Date: Wed, 13 May 2026 07:07:57 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] close02: add test for double close EBADF
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jinseok,

> Hi Jinseok,
> 
> On 2026-05-13, Jinseok Kim wrote:
> > close02: add test for double close EBADF
> 
> > +static void setup(void)
> > +{
> > +       fd_closed = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
> > +       if (close(fd_closed) == -1)
> > +               tst_brk(TBROK | TERRNO, "close(%d) failed", fd_closed);
> > +}
> 
> Use SAFE_CLOSE instead of a raw close(). Since SAFE_CLOSE sets the variable
> to -1, save the fd value first:
> 
>     int tmp_fd;
>     fd_closed = SAFE_OPEN("close02", O_CREAT | O_RDWR, 0600);
>     tmp_fd = fd_closed;
>     SAFE_CLOSE(tmp_fd);

This is a corner case, please ignore.

Reagrds,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
