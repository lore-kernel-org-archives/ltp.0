Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D94F8D753
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:47:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6888F3E5DB3
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 16:47:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 790123E596F
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:46:51 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 08F401A00276
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:46:51 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-c742d4df00cso299379a12.1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 07:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776350809; x=1776955609; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFaMZvIrcFc71JmnFFqmDhUdPJ0rUZ4wiTU25laPrXI=;
 b=myW7xbODlt3WiQHFgh3QNZVardSYbzoeTonFbhDWK1NB92ODQRDgy1qTIy/5Bq8QJy
 l6HXNrMIlDcHxw1hC4m0xxMgfJQD49JkBdD6G8QsqWnKzQ17yNcF9mTXvsj/u2qcuBnz
 LQDHbpWolOpiN/uHYguTFJigZ6lIM/R6Plr5OB8xwwvhWni1Zv9bsOOcIxyoWIJ+wY7R
 KwA27Qx2mLOdvX3lFGCI9D0HLWuK56CcbVhaHew/ItTzY/tO88Op4AoyqsLIc8UwpYxm
 n/dSvEKDsOsnfyG56FQSxzSKlhj6Z/pRcVbYqn/9R33EgrUyod/yO8NdV+FsiuTbYBFT
 /IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776350809; x=1776955609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HFaMZvIrcFc71JmnFFqmDhUdPJ0rUZ4wiTU25laPrXI=;
 b=esPxp7w1SxYTGCq9eg+dflXkMSF24HthogqdAFsyZhkSwEIctwcHuvmgE/mWqFxV/a
 QK7q4OHE9kIsIKRnbqt/Y6rCibfgOCSG3veMnrXUie6qgG11oBm3ahYod/Igt86XoaBy
 Du/JWm4LrTgo+H4lqk+Z4kl411Feq1O2CobI4e6HTLeAHoxWYFRkLkoOirHe1Nfemuyb
 yWjvX8C32HqkRdd+07cEtYLHD8dY8K+vqcDkcwj9zS2ovkh7XMkB7Ka9S7rvrbC7GAGx
 layL6blzsowr12wCkiWSMs1ecd4EamLMiqiBoiazmNJ8nQWj96FuTI84GoUsgEiNClW4
 rHIA==
X-Gm-Message-State: AOJu0YzpmCSh4Nct2RV0Bz0Ng2kSXluoKnsCNzC+MNPRG6LktFvx/d0m
 3/mBEcNyZdHom5+WhZqAO6hFfuTdV7kHsTQsfPtUmrMjWOZVw9tA/PE=
X-Gm-Gg: AeBDiesLfrpihoSNfToO88EG+9sNJVYOrcaovx5XbHGBc56ew4/jd7adMXBOb8/YXEG
 s2VwgigAt4GDF/waOb5zjPDHWlVslWwuI+bYrdOKsNclEV1tp/z1fMZOoxcop/FMRSnr24f+BjV
 HMs26asvdc2Q/GRVo6EYz7lKp+lSclb1UYUo/lpGtR6vwWn9a7wWusT9j5lVdLiqZYEaBeKb6W0
 qJtkZQRmcCvihmJ3SAGiQtru2edgq+3XeeYcqE9Ii/ItZliXRy42y3DAXMK5HY8j93VXR4l1ZP0
 2eyO7BoDuorNUTLiRVy9kPKbtVxYBA5CTRvxMh1S7FhPPkEw4nIQqosLFuvror2Nl7oc2Rbmrm5
 bCLLNrCj83T3pdOXiNbtqDNwVU7WU2annlpifvNh32zRTV5kkGKTrEUKvz8S+M8xzoRpPa+WVZK
 Fps8AwFzsb0BkVmHimGntwzvQuAqjA6Yywb1uGQthEM8Xj7LJM7GIqD48e9BNmnqOh3Q==
X-Received: by 2002:a17:902:ef8c:b0:2b2:5168:2f82 with SMTP id
 d9443c01a7336-2b5eab1b03emr24137655ad.24.1776350809304; 
 Thu, 16 Apr 2026 07:46:49 -0700 (PDT)
Received: from localhost.localdomain ([211.196.223.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47810ae96sm74963805ad.21.2026.04.16.07.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 07:46:48 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: wangli.ahau@gmail.com,
	pvorel@suse.cz
Date: Thu, 16 Apr 2026 23:46:21 +0900
Message-ID: <20260416144626.6037-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANgNiRztOnor2mgLyfGxiCE01qyBwcsnZcrv1ZUi14KeFzctQw@mail.gmail.com>
References: <CANgNiRztOnor2mgLyfGxiCE01qyBwcsnZcrv1ZUi14KeFzctQw@mail.gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] include/lapi: add leaf Makefile
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

Thanks for the review!

If we switch to generic_trunk, the current directory is not checked;
only subdirectories are traversed.

For example, running `make check` in include/ will descend into
include/lapi, and running `make check` in include/lapi will descend
into include/lapi/syscalls.

Thanks,
Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
