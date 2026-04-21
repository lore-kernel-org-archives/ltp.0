Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8C4F8FA8C
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 15:25:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9EBA3E4A89
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 17:25:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FDA43C5376
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 17:25:01 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D37C01400BCE
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 17:25:00 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so4109331a91.1
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776785099; x=1777389899; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXL7SpaZfRm6KBFvyOCe7+tK3xaok3mkXfZuQf7STTw=;
 b=AMQIrLZFCg/Mb4eQ7jgCgb6hApPK9RCs7/ehgH6ko0nkGxLmEfhFOD/CgTveu2S4c4
 4qvdJLLQIgyZrJwfJr/pHPWvM+/TWvuTfxOa+EbBW5WJc5NQfM7xFnZ7s7ODWuOyDk5n
 sLg/PSwsknS4E8htahMJ09tJKRpbN8tzdCrAXXTlDu7tb+jF9IaNLuFG8oai28AvNhJy
 KH9XB6aPwprBegIxejHCvtGEzvv0z0SCG8biPSjRKjP7iv6YRvtvIgEPXi2A9YsCyBi6
 txXg9mlEJnoLUJVHLqomfqPtFGgfAKX+Fh1J0Ivi29uRqo46ppW1JV0wMQDYps03OLAk
 Fkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776785099; x=1777389899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mXL7SpaZfRm6KBFvyOCe7+tK3xaok3mkXfZuQf7STTw=;
 b=cKJclTRiLzrYc5cWuyMU88u48xfGNbQd9JnEzmm7WYIP2ASbegdV809KaJDwLtRgef
 DiEQDMkyKCRV4ryGGGOFHH9dKAvV8ABmdqSSKhMGVfa+/aifqj6aHdv9Mmfp6D65kOo3
 251fq1f6G2S6OYCd+Nj9TEVSNon0hpGL/xG40nfCuuq5Q331Qbam6McBCOI/dlw/rJXW
 7lDdJgnmkyiYvvk2hd/BHenA38KnZ2XBizWzK2B9RUc1uYwa0oJdjkixN2Q80iQN09o1
 ol73z1NHzRirtjugvdPge4lOVk4AD8r/J9LD2bBzN1hd9vMPHsTGFRblJtKO9AI6O5Rd
 DC2Q==
X-Gm-Message-State: AOJu0Ywsu4xb1HD15BsjvvP+4jVhtIRvEXm99bM9tm7yu/M6ElQXZerq
 QqK1N8rhdnnbADhMUZIffabABrRC3znqxhmeazsbTRwaooBwUsUYIV/B5ep+0SeJIkjh
X-Gm-Gg: AeBDies0pGZqSPfh1lkX88zbANu173EEH/kKsbE7df8HxKz2kgkuqmN1Yz/mvWuvjHJ
 BunpWPDX6nq/Qz8q3PX+x+aMhp75CN2KUBl83vUSfCzyufduGqz4xPidWSl22az+QuQEYM7vK5R
 QcRJJcaUz1CGouiF08MQ79iwDo6W672MsDuG9Mrb71j7EDytK+X0b6q+2vNJDkNkaD1RtV1Mfo1
 Cq2e/zc9eSgWgFORhb47+/XjlRzrB+1Mm6deIYpni/kIEPWfIF3HqTUWGxS1GLN1WT/+Es4TfrP
 n37niW10iDBw6CvPHfVEsxKxnM2LpdPaMYrEsILiaNsn7mt5E1ftEbqUOT8nKU2FBbCmXSPF0Jj
 z+ymxgKVpOBjdzrKkaGSPfZ+ZQuyLIrdLuZui9Vg43vmnAV0N3BETFWAxl7cWwZLeyXk9JzbFFR
 pHj9YUSJE4WVWb/ae96Gar1SRLfJmIulIhh+P84w2SX1tPN6nBKoXKZt4=
X-Received: by 2002:a17:90b:3b47:b0:35a:329:73d8 with SMTP id
 98e67ed59e1d1-361403b01cfmr19033553a91.4.1776785099044; 
 Tue, 21 Apr 2026 08:24:59 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3614195a8f0sm13695089a91.12.2026.04.21.08.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:24:58 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: pvorel@suse.cz
Date: Wed, 22 Apr 2026 00:24:33 +0900
Message-ID: <20260421152435.2871-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417105759.GA395133@pevik>
References: <20260417105759.GA395133@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] fstat: add test for multiple file types using fstat
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

Thanks for the review.

S_IFLNK is not suitable here since this test is based on fstat(), which
follows symlinks. It is already covered by lstat tests (e.g. lstat01).
This was also discussed here:
https://lore.kernel.org/ltp/69b42eee.050a0220.281abf.2706@mx.google.com

S_IFSOCK is also excluded since filesystem sockets cannot be opened,
so they cannot be verified via fstat().

I think both cases are better covered by lstat/stat based tests.

Thanks,
Jinseok

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
