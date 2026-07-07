Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00135C43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 03:25:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6168A3E5DFF
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 05:25:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22B163CC6AC
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 05:25:17 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BCD82200751
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 05:25:16 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc7ef596c6so5925755ad.1
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 20:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783394715; x=1783999515; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lVq1kD8vNrY5OjRMHee1tx58nDD98Tn9YRLR4klfNRY=;
 b=h71BNsy9TNVXcb4pstCaZjzXoiHQh1zVRrrcY+tCERV+it92btZgjJ70wmMk/yP97g
 89odH+fNUbhWr94YosBcktmIorHZSYycYYWpK7Dk+bCMWEkf1je+MPr0mWmow4NAswGw
 joXSNd9o2rcxnDhYpgyLjPhxluXE10OPG3rZrodydYreCCcegVrJbfAEppi5t9yVQIA2
 8FNvjkU/RGpZg6pbHdzobiu6FtRc1wgLDrTLbnGRImQe02TVCn3TIRYTHT8QZ6c0cWgO
 TxI++4pqg4dCvPzXcbmG81XVWegyaFck9Srd3yXFXMBzfoKgLmQ23hB2dO06e6PLb3ST
 W7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783394715; x=1783999515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lVq1kD8vNrY5OjRMHee1tx58nDD98Tn9YRLR4klfNRY=;
 b=fxHo6nhvDWZ23wtWlqN1CszGXtjsNbloCh6p0c+jYpWNslNG2QmuVIUl1Lv5xS7usG
 T5F4N4c7DRQCjhPWUx1+eEdQ5dAw8QGvBPUTpWiPYY0UPFkPBpIwFnoRyd9VTa7pOtBU
 KGeYWstM5UOPK4BXQsp4ylbWuJqumE+nYh9qMWDcz5Ad4BOHGa2VsEQcUutjmyGvXYe5
 18VWST21/7Ms1Q7NxhEJIW0NeGA+H/xGUxYaD26Ph+aez8aAZOKkhqEcKtI5zscJLavy
 ItkNGabRp+NGCx59zymkB1qY4eCO8C5jm4orAxlnLRalNmpKwuq+FTSy/OW4A7L8p8Sg
 ZhXg==
X-Gm-Message-State: AOJu0YwHfppah3t9W+BMY1N0pui/Vq5Zj8GHEMYnitoXIt/nKdzoFRgQ
 x+pCiDB2jnUgavtF2H5Dapg0rxyABcYq8UHn/6tAOiXDnLAxKyzyTz5sUi+dPTan
X-Gm-Gg: AfdE7ckitFgMNPCT1mJnkLg0OK7ocRc0GkCl3kghJqJd3s0nOpe+pAZDG7mEpdd3FUO
 2rOBNoHFCh5gY8Z85thKT+AeFdv9Hv7fZk1T7S4CL7vGsusYzkHKhzS6E6DEnAxbDBAtHghLILo
 Niw3JsRL+WCSizxkVjhbc9x4qNEQzMdBn5l5D1OQ30ogLUSbBkiex4MbJD/6Mg0fcWPafdrwgxg
 CV3oriyQGSlpRZAES7hkdbyGAdaA7rPf2XvpWBO+En1iuHe4JmBM649/H/SXc2kZNOGuYq5B0u5
 MkcYPc6t5ZBw+4xgDNPafGGqDz3yQMDuA57Op4Tv0BP8dIr4bxS5HZR0g03Kx+bhDcTUmaUXMJ5
 BqAQNXJJxvkU8VVdVWj6PtIEaoKrhQrDGOl9RTaEhBUTBvNFABiUL9VsSmnamZh00AcOTLzNmrr
 NtiDe0lwTl1dsmRHKLIymp7z9Pe+IrBCuuOKVGEQmOmRpLa2mzy/CTahf6N+wdKbnzwLl4vbsC2
 DSjVBkCJq3sE/kCSX5Fi5VVNkQZ
X-Received: by 2002:a05:6a20:748d:b0:3bf:6c08:fb99 with SMTP id
 adf61e73a8af0-3c08ef84f89mr4031069637.59.1783394714872; 
 Mon, 06 Jul 2026 20:25:14 -0700 (PDT)
Received: from
 runnervmkkn4f.gexnsyh2vmnunk3efdqa0pb50d.phxx.internal.cloudapp.net
 ([20.172.6.68]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b658a99afsm2985556c88.0.2026.07.06.20.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 20:25:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue,  7 Jul 2026 03:25:13 +0000
Message-ID: <20260707032513.4057-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706234000.23719-1-wegao@suse.com>
References: <20260706234000.23719-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] connect03: New test case for EPROTOTYPE and EACCES errors
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

Hi Wei,

On Mon, 06 Jul 2026 23:39:49 +0000, Wei Gao wrote:
> connect03: New test case for EPROTOTYPE and EACCES errors

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
