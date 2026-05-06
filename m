Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925E0CD3436
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 12:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778069532; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=0jXAKlgyXOeaVvnD2taWGSWa1tfHebTkXNvR1AbS298=;
 b=oekAXP8IpQeQJLRn8e5jS5uczNHISb9DujeUiOK6aT9DGRuORQjaXUnRqK9Ll2Y2uPAKi
 6brDsGIPofFNSkZml9ZRN/Uo0TRDT+C0dKBq3ZEtQ/TVbDsvsW8kMMHuvSCvMtNc+zNqxdm
 IlIEABH6GEppR03KiUn6Dwy+sTaAgC8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 464F03E65B5
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:12:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07EF53E6155
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:11:48 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6E605600958
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:11:48 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so90610095e9.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778069508; x=1778674308; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MNG426lHedC/nu/E3BmARPMpHNmB+OmNHHrfs+xjXUo=;
 b=bO/nRhBQgoy3+UZcL6SmLmnfz24OPXZaQtcZ/FFrJo17VzNF0rzuIyO3TbTaAeO/bU
 vGPoW9kr7Hr30/iA5EXcKWAqNo1IV+v5PuWufn2Ktd3eYNrh8KN8gDN+dXIi61/bCKRF
 WWu7Qk9MMEw+lloAJvSvmyEb5Q+UmzQp/o3+eonSkzop4Zd7XnlNrUFM6wB2vve1snMo
 ejB+epNTcDTbmhmYsFKLNbGgSh8A9uUHQ0kEP1sQ5VCD81N54Hsp334u/48UZ07wFH8Z
 z/ALWGBGOcf9/G1oABi1fUzFkFpHxMr5f2tOQaOYRtMpov7m0vl19PQCzLSY++RD9IcY
 gy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778069508; x=1778674308;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNG426lHedC/nu/E3BmARPMpHNmB+OmNHHrfs+xjXUo=;
 b=G7T3vYowHauSV3T/9LDBqwEE0lr8vrGQHYYlZJH+8AVQ6PEjQYhjMi5pKMQURGWnM6
 cZtrxCJsChQhzYYD8fkxA4NgmkiKR3wW4fFBaINQjiWTcnf/UcfkDS+UiNFXsTLHPFxE
 Yx+NFaeDu4niJrwWizqX3fFUi0JuPAeZlYRqSoILx98c6gq6v9qs/B50Cb5UTsT9JwR5
 mbvzREj1Z5Z4zuDfyIzfUkG4vpp53XxDzBQg0nwLmj37WkoMkBpwf4G31FKpDUkleun2
 mjws3DvYTu3Wd9oPG1IhYzqTJ9ECP0Z8unmjLR5pKbxlw87yfneY6FxU5O20VJVQPZvt
 h3HQ==
X-Gm-Message-State: AOJu0YwmIE7blVvpahUsXMzL/UyL0kwi9R2byfthrnuElU4+fyLyYi9/
 yazyHAJFdMyFl2QgZHX0FK8pDW2H71nUaFxwgRCNuy96KJHuYB9zdWAzSouyO2i+PoLj39MC3P9
 hRUQkZYW+ig==
X-Gm-Gg: AeBDievLH7xEKI8SIBb5PrCZfGMVbLKzQ5nM7qxHk61v2cVjhYNxHebSJoQNPDZS6HY
 yP7fOteX7WpGFXuBQmiVgS2XK0H5pSa2aXhmE7I7WkWr+7KUFuwQjrIMTy7FKTehKaWBZciaOj4
 LCEzMFA5RTTWnNNEAtL/wNUs9qAu6gPVKxuetB9BLd1qiC5zkoKWU3sh1sx9k4e9CrJ7Cbey1fi
 QRspWzi6lukVK2jk/jmepLAZCralx21RJWC5ULEV/NoYfHSzSCggjUW1tjPPvv23SIHqjXJKmUH
 BW6IOhQ6FCXKswnnpbdLiKom8AdRjMNOsf+sRZuFyzj0OyvZ09mFKQ8FhFWD6U2AX3mSulIDz37
 jWt7XbWt+V+weIeKVqMKdioFAGZ1LYzp35+cDwTYWKFJxKf/6fnUx7nj9GY/ud5qTtpynsCyM5A
 9T3gH+6Gf9EDrDePGI2RMBrCZBsDCyhA7EYPJwfp3dEQ65GyoCTL49w7m0Qf0HfzFZJbzDu6zMV
 DHn10i7ZQegqKfS0ymA0CvgyVLFvpRJgx9RbnVnAfDn2tSaD/sUg/Ciiw8pfc3Wbl/Vz8avIeHX
 xLVi5iKNMj4l
X-Received: by 2002:a05:600c:1d18:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-48e51dd689fmr54466765e9.0.1778069507756; 
 Wed, 06 May 2026 05:11:47 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538acbfcsm40813545e9.8.2026.05.06.05.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 05:11:47 -0700 (PDT)
Message-ID: <69fb3003.050a0220.340685.6487@mx.google.com>
To: =?utf-8?b?4oCcU2FtaXI=?= <samir@linux.ibm.com>
In-Reply-To: <20260407050634.124265-1-samir@linux.ibm.com>
Date: Wed, 06 May 2026 12:11:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] hugemmap37: Migrate truncate_sigbus_versus_oom
 from libhugetlbfs
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
Cc: =?utf-8?b?4oCcU2FtaXI=?= <samir@linux.ibm.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Samir,

> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + */

New file; please add a 2026 copyright line for yourself as the migration
author.

> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	SAFE_FTRUNCATE(fd, 0);
> +
> +	fdx = tst_creat_unlinked(MNTPOINT, 0, 0600);
> +	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	q = SAFE_MMAP(NULL, totpages * hpage_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> +			fdx, 0);

If the second SAFE_MMAP (or anything between the two) aborts, p is still
mapped but cleanup() only handles fds. Move p and q to file scope and add
SAFE_MUNMAP guards in cleanup().

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
