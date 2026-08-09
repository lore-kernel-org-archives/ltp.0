Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ED8C5AD5A
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 18:42:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 445A83C8FD4
	for <ltp@archiver.kernel.org>; Sun,  9 Aug 2026 20:42:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C5BF3C5480
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 20:42:11 +0200 (CEST)
Received: from mail-qv2-x01.google.com (mail-qv2-x01.google.com
 [IPv6:2607:f8b0:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B580A1000485
 for <ltp@lists.linux.it>; Sun,  9 Aug 2026 20:42:10 +0200 (CEST)
Received: by mail-qv2-x01.google.com with SMTP id
 6a1803df08f44-8ef118ead8eso6488306d6.0
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786300929; x=1786905729; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U4TlYQODqgMPgVv/PEonxtpoBFEXJ6/6EU3ASln0ezY=;
 b=s1S8NACfz+SO90y5CWwaSx2BY8hBW2GnKb6JyU/rR5gtcH7NV0UlNAK1O5fV0nz9W5
 Tpkm/5Cvm9eehJJ6u4WCy4HrZ2PiPUwt0EgHYFIg+ICBGlEeoJnQe1TzuRHaPMQrhLxY
 7Olp743ioTtoHQtLUXLyFhl9rTDj6bPyv8qGvNheRkqumiPgOUI6M7coOXHTSn82JeXp
 hfs5k+HT0/sntozHk+QFijWLX6198kLGfzE1N8fTpcPI86CcxdJ2lCoTJr6iPF9aPDc+
 FjOCyAaDZ8zpedrh60ih9033ZwSDPJMMz6/tkkugdMlv4bIqLm9zCon8O2ZzLxOOcvQU
 +nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786300929; x=1786905729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U4TlYQODqgMPgVv/PEonxtpoBFEXJ6/6EU3ASln0ezY=;
 b=eZ5sKSQ0WGNYWh0jjDpvKgNojRtq9XeHyO33kLgmV7bNSEcYI0WaE/kIw6OBIHM+kf
 Oyetaj2snhwUbDgM1uQBGtbCWU3uAXDBm8P8UlA76KnXIi0n8O8fEpZNsB9RsTKT+rJ3
 fvgs9hK+PS26WdmhF/JA3cUOhTxJQDVXLQksIq0AyI4TqHdw+8LZYQ83NH0VpSyfxTft
 1HZLujzJeE6hrQiBOrH1ylG4G2z9d5IVDyV1dmhb2J7on6lkybz/aGucp3RRWb/7vQc9
 6irfwDiVymP6kU+vEYc5rFfD8K7OLjMgCnBNBdwIhmr2t4PVmx3MWGvUwvXBD3u/iU0D
 U2pg==
X-Gm-Message-State: AOJu0YxnghmmqzMS0Eczsc49mKRA8fZMpb0WFbZMMw+XgM0Z7+cjdhry
 cC+HBheCylIwRAnVCHqD/i89oNkXXF7d7zAwQJywj5LaiY73z/e+lA5a
X-Gm-Gg: AR+sD10T7w/q8Zc0+NEFhE2IkMhAhfdzA0KAj0XdRqnICv16umrODUQZBwhA++4OtQQ
 nNcNTQqqadVcUmwipEtXZpMq4kWfnXw9b+3wWR/eoPBSGmbNP6A6ZJxUjcoMslAvmejpoPCTPPX
 +E7Kz/uibLYmwsnW9KTCT1w1h9RYoqhQgoKk2u+l/rxQB7pYp6qFyEYCO0GLxXszbUY+2GqHSVK
 FgFxfmUGgo0NDnW7EgWvpZj3lBzRCN4nPaX6o91sXprCj8lYkPgkMCTEjhgZ3LCK5QUhqjeWoaV
 fMdlNUqSfw3fsFSQnLpGqIi42qi7JnMH953Rjh73lCdHF0ZlaMA1trQrdaSbMJ6OREmqc+P12Fx
 W+mfaLDWsbx/cmcedZplE8x5vdo9F/Q5MIN/fjMLlFzoCRgkt/K4o6qH9buq2WzofrgNJEY6LFC
 JuA9ZXdx1Q7BoROh52OXFvKLpbRha0kI3WkipbBRA9u925cQ9awQ0CeHhWFzMBkfRZOG4e7AoX9
 g9Mp9tPK8jIT8APsH1o7ZLwxahdCaa7VpRwxhHpifExKgkXEswMP5IUC2+lnx0kPqzcomBbpl4=
X-Received: by 2002:a05:6214:2b85:b0:8f3:e0ce:611e with SMTP id
 6a1803df08f44-9089b60857bmr295607456d6.19.1786300929509; 
 Sun, 09 Aug 2026 11:42:09 -0700 (PDT)
Received: from
 runnervmvrwv9.n00m555wnkxuzl5dvgxei0gxwa.bx.internal.cloudapp.net
 ([20.55.46.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a91b4a6csm54808576d6.15.2026.08.09.11.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 11:42:08 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sun,  9 Aug 2026 18:42:07 +0000
Message-ID: <20260809184207.9049-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809174900.1847247-1-pavrampu@linux.ibm.com>
References: <20260809174900.1847247-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota
 accounting
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

Hi Pavithra,

On Aug 9, 2026, Pavithra wrote:
> hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota accounting

> +/hugetlb/hugemmap/hugemmap33

Could this entry be placed in
testcases/kernel/mem/hugetlb/hugemmap/.gitignore instead? New test binaries
are required to be ignored in their own test directory rather than in the
parent mem ignore file.

> + * MAP_PRIVATE pages and MAP_SHARED reservations.
> + *
> + * Commit a1e78772d72b introduced MAP_PRIVATE reservations at mmap() time,
> + * so quota is checked upfront and mmap() fails with ENOMEM when over quota.
> + * Before this, quota was only checked at fault time resulting in SIGBUS.

Could these exported documentation identifiers use reStructuredText
formatting? MAP_PRIVATE, MAP_SHARED, ENOMEM, and SIGBUS should be enclosed in
double backticks, and mmap should be written as :manpage:`mmap(2)`.

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
