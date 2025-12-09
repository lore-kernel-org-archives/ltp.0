Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840D9D3B7EA
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 12:41:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E1A13D027D
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 13:41:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AECC3D0274
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 13:40:59 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4DF32600631
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 13:40:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lN
 iemT7n6hZMJp/q9oB+JTd6ejkmAIRqyPGT7UL/E00=; b=Z5jmVWkOY1YXpEIafW
 f4FZCDpSsi2Fez4EMP7pEMQJ491JWlvdbCCZYuWH94cEXe/0R0oiKg1DXXnoM6LI
 ICy9nGkGKy8nikK7OTT4P9rCwK1nql3EfbcZfoLCMc6VYtHcRnZFufww7oXNe5QU
 IRxgr4HytdQrz7DUOaCQBrT+w=
Received: from localhost (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgD3LJjUGDhptuRoHQ--.4030S2;
 Tue, 09 Dec 2025 20:40:52 +0800 (CST)
From: simplemessager@163.com
To: pvorel@suse.cz,
	ltp@lists.linux.it
Date: Tue,  9 Dec 2025 20:37:34 +0800
Message-ID: <20251209124041.216542-1-simplemessager@163.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251208150542.704006-1-pvorel@suse.cz>
References: <20251208150542.704006-1-pvorel@suse.cz>
MIME-Version: 1.0
X-CM-TRANSID: PSgvCgD3LJjUGDhptuRoHQ--.4030S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw18urWDCr1DZF43ZF4xWFg_yoWfZrgE93
 40gr97G3yDur9ruw4Iywn5Xrn8K3ykG34rXryrKrn7C3W7Cas8KwsagrySqr4rW3yrWFWI
 qrs8Zr4agr1UZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU804iUUUUUU==
X-Originating-IP: [36.111.64.84]
X-CM-SenderInfo: hvlp1z5hph22hdjh2qqrwthudrp/xtbCzRWjO2k4GNXc3QAA3d
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] safe_keyctl: Skip with TCONF on EOPNOTSUPP
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>At 2025-12-08 23:05:40, "Petr Vorel" <pvorel@suse.cz> wrote:
>Hi Meng, Mingyu,
>
>this is another approach for your patchset
>https://lore.kernel.org/ltp/20251205031719.53914-1-simplemessager@163.com/
>
>Could you please test it?
Thanks for your suggestion, it's better when we using the SAFE_KEYCTL
interface.
I have already tested those two patches. It always return TBRK as res
variable is not suitable for our purpose, so I modified the first patch.
>
>Kind regards,
>Petr
>
>Petr Vorel (2):
>  safe_keyctl: Skip with TCONF on EOPNOTSUPP
>  wqueue0*: Use SAFE_KEYCTL()
>
> include/lapi/keyctl.h                | 3 ++-
> testcases/kernel/watchqueue/common.h | 4 ++--
> 2 files changed, 4 insertions(+), 3 deletions(-)
>
>--
>2.51.0
>
>
>--
>Mailing list info: https://lists.linux.it/listinfo/ltp

And sorry for previous broken mail, I spent sometime to figure out how
to reply this mail properly.

Mingyu Li


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
