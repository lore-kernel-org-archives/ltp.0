Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C759E7719E
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 08:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736756232; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Sq1A+vRAAzwurD19XeXrzCIkbB34LyitoNrgPQk2ur8=;
 b=WbVOdAo6Xp62kmdY5fMThJq1Rp1PBGmgA7DF/gzpbFfmvV6OZVKeSGnRsn2iyobCrNBgX
 qQfwFU2lUa+WM20oEHle/L3F62Kfcu5PdN4BxXZBn14WHyBNhQlESjHUOW3zeDdVxRcSa8P
 kCNONjl0agCYZNgsQfM2eyVnD/meBEM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EDDC3C7708
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 09:17:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 266273C6BB9
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 09:16:49 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6339E140DF8C
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 09:16:48 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso28075115e9.0
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 00:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736756207; x=1737361007; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wbcaQgYRpR+l4Ay0lWbasGtBBumI0oAxBMOZewcK7E=;
 b=VtiMtMnnOxw6XImk2Np1wzkRr4xJxSDSxMcFls1FTGnxhvQkqymwHbi9KXdnclXxJp
 Zsp9G+U185wvRLpQBaQ8mta+YrZ9JsVw9LewKcSdyEpuaq1saq8D7Lvt8OnV12g9gyvu
 cwCS02EYm/5zqQ76L0SPCoO+vW6VMn4H6+XsEWcRVD7nkuQuWoP2yNmI6mXVDW7kkLnW
 06xVp0QZ6riuljoVYd2SmjVQL9ug2KCPLPZun1kfrfGaJgkaq/6l2CcD6SLeqwyKFEus
 yxtGfiTyaCjB6+GrssvZYkhCShROzFeGzeo8XKcSkvqYONOyi8QyvNZ2Vy6ur++s3OAZ
 cLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736756207; x=1737361007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6wbcaQgYRpR+l4Ay0lWbasGtBBumI0oAxBMOZewcK7E=;
 b=AWJU6+PPeKsXIiP0v44fcpwZ8y9z3l7TQS+qW9GV+Kx/Xuu/JsoGyiq4zyWt4KYbhH
 0F+3YiZnvxF4ffX42nq+mqlhSvtHFq45HY78v6G4qky7Nfx3hElK8uG4M4VIJfOFRhKx
 CpuZOb7M4Pc4H8fYBuyrL00oDi9ktrkedMqUdPk/CzSB7lB8rSrnTm85KUYQvUUCheSH
 aAtWSAffC2HwDQmObPZ0sVdXieJcA7OPT2obMEvJxW5R4ZBDAgKv/UqNxRtg42yLgJ2x
 Dclz6dMd2hFCyoJnn5pTN9uD9j7nlpSnXjojN/nFXiv3+nYj3IErxI5S03pf8osNvLUf
 h/lg==
X-Gm-Message-State: AOJu0YyH0phA04+DP15eJVvE28+YYaNpJP5VbYswsLTc7A768RlYzDcs
 Uai/z5jT+DTjmLtXk9EUK4RwiQbgAIUCJQhmud+o3fakZTcH+9lwwOpMUUNYvS5V7HOj6gG0+7g
 3KA==
X-Gm-Gg: ASbGncsNkKenJMRMYbFJMc8pTDgRfGE2HxQx7zala4Vn6mSre8y6p/9Ku5/rAq21Zaf
 3610RRNWA+ilmXAmLQjIPE5aPFRf72876I2wTQUogoIeZYHjP5NUfrW3xtMBN3UHCDhfkAkY3Kv
 cPBOMUUhRkPXuOnCOObTXMvIYUp9H4skEGIgmLkAN6Ui6/629vIGqjaUrN7YYOhKySOEoPjbgXU
 p0pA02vuS0HQrnZaL+jA3+W/7zgK7ExLAnEucALFUhx8A==
X-Google-Smtp-Source: AGHT+IHppMiJiOD8A0f3PFcdpwKizyfz7G4F8pzWfOc/DeYfC2wTdwtel7rxFVNv+WxWBr8/ErFwxA==
X-Received: by 2002:a05:6000:1fa1:b0:385:ed20:3be2 with SMTP id
 ffacd0b85a97d-38a87355790mr19296784f8f.48.1736756207663; 
 Mon, 13 Jan 2025 00:16:47 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81b1sm11732799f8f.66.2025.01.13.00.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 00:16:47 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 13 Jan 2025 03:16:20 -0500
Message-Id: <20250113081622.28942-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241217061636.16366-1-wegao@suse.com>
References: <20241217061636.16366-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/2] ptrace: Refactor
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  ptrace05: Refactor the test using new LTP API
  ptrace06: Refactor the test using new LTP API

 testcases/kernel/syscalls/ptrace/ptrace05.c   | 223 ++++--------
 testcases/kernel/syscalls/ptrace/ptrace06.c   | 325 ++++++++++--------
 .../kernel/syscalls/ptrace/ptrace06_child.c   |  16 +
 3 files changed, 260 insertions(+), 304 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace06_child.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
