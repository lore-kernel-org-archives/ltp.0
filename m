Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76798C0218E
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 04:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737346549; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=UebyRdV58UhYPqzRcEkxMdgh30hM2565/GVGdULes2Q=;
 b=n9MIg5MSMvCrzwaT4ZSwXg0XpSkLdLs+IB7mPQL6GW9FHAM3XFj9guTRl12OM4WhX9TkX
 dHWva5B+tmBM/NuEUbHm+snL1eVYf4Wx4jDxO1JR7V3Pm4e/bdwqQEAJjqyj9MUhxbFfGb0
 HW3K8J03hiVWnNLUTQVmbmSsDmo6isk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A63083C137A
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 05:15:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F3A13C17CE
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 05:14:54 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EE68D654A53
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 05:14:53 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so2712405f8f.1
 for <ltp@lists.linux.it>; Sun, 19 Jan 2025 20:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737346493; x=1737951293; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFH4vyeYw7q6Q8YYWJR+AG1CutAK+NLNFjk60GxXe5U=;
 b=IjonEq7UqrzMDDTt1jEuNHel+HGF4OH5QOHqBpH95Lzf30GlfasEgAtqcEizwD2XUH
 E58RU0EwcJJInPpOG0TJAM4nCICoI5qvII3mwfUt50j+ScNjVIiqCDDGuvyDxHv/iGoi
 ccK6v4VxFyxdefV+EsQEBUodEPBWnixfW9N+Da62bpd/uB1z3FMDtvUh5E+nrOnzcth4
 1oiAOrSi+jH94Y8DwaHaOTVephbxDngCqM8ehqcS8bgwMSHvKQNjXBDXpWgmSDzIIL7h
 3l9drysnPz8oWMe3tgSzJAqUyuaUn7TqbVDeX95hAv5AUFXihaXHmC+fJOA4Surz4Ybw
 J7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737346493; x=1737951293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFH4vyeYw7q6Q8YYWJR+AG1CutAK+NLNFjk60GxXe5U=;
 b=YFFDnBYywrAR0SPF/tUfCWpxev8DGTfUzOb1TMpXKkR1A2mfuIU1G8VuoJzP+v7gFJ
 fVnm2Gv9rmjk6BravWMhi+Lw+A7BEshxx0rf0Lb5IvKYS0QK7oTUOfxefM0JeQYL0Cn/
 9QMStkF2oa5MDFy40Rf1MfDgZMvvH9WGffr0F9M6zJtRqUXgpH4MbWlvmVqB64J+VRtB
 a8jRL32iuJJUKqJf49JgV5+Emo0b7meDLOJanyuEXmrMzTMhsW1/EsX0Ql2NrmSN5EOu
 39dsfmNgZd393vtNq9ZMZrVFhLIqT8pHs+jtpTizQNFAup1h9T+FgAS35pmimj8BfDwO
 me5g==
X-Gm-Message-State: AOJu0YwSXDp0xpxWntqiKvjO1A1WlYrzwVC8+K3gKA6MHd2v6oynEKTU
 nK1/EDaDyEW97QnzwYSb7vjmTHHwsMS9jFc7Y3YM+QoPeMEYMSCGjxqrepEzNdhJ8sBiCtm1km8
 =
X-Gm-Gg: ASbGncueq6oz0rnBKU0ZzPdX2YxLWQe5HN5GPPAc2peTiupMzhS6Z81N2s7UXENOBYB
 vwQPGEJ5mSEwAC6nzQmwOXn5bUfuep18xEG6Wn8AvfbYseczl9RCnESo2TF+J+dn/qJKbLQ9fYP
 oPJHh21MJW1Ow2F1oZ/ASNMpCQj8/gr71XATMP3d7i6H3oEP1GBOkmMHfJ+/8FO3VBi52Nx15gc
 oJk0x4P99xXrO7P64rV7K7bGBtzGsDPHUyJOgu4RDsOaIqEdr7dTMbv4W0=
X-Google-Smtp-Source: AGHT+IHqH0rKCFy/DyP0akd2CeGUUQR7XRmdJpudNxXWnLZSKtkbxB97sDQ06CA4ODtDJWvM7WhfMw==
X-Received: by 2002:a05:6000:4013:b0:38a:906e:16c3 with SMTP id
 ffacd0b85a97d-38bf5ae184fmr8815631f8f.13.1737346493240; 
 Sun, 19 Jan 2025 20:14:53 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3221c30sm9274626f8f.32.2025.01.19.20.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2025 20:14:53 -0800 (PST)
To: ltp@lists.linux.it
Date: Sun, 19 Jan 2025 23:14:33 -0500
Message-Id: <20250120041433.22399-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250120041433.22399-1-wegao@suse.com>
References: <20250114143217.21018-1-wegao@suse.com>
 <20250120041433.22399-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/2] ptrace06_child.c: Remove unused
 ptrace06_child.c
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

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/ptrace/ptrace06_child.c      | 16 ----------------
 1 file changed, 16 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ptrace/ptrace06_child.c

diff --git a/testcases/kernel/syscalls/ptrace/ptrace06_child.c b/testcases/kernel/syscalls/ptrace/ptrace06_child.c
deleted file mode 100644
index 350b0e8df..000000000
--- a/testcases/kernel/syscalls/ptrace/ptrace06_child.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2018 Linux Test Project
- * Copyright (C) 2015 Cyril Hrubis chrubis@suse.cz
- */
-
-#define TST_NO_DEFAULT_MAIN
-#include "tst_test.h"
-
-int main(int argc, char *argv[])
-{
-
-	tst_res(TPASS, "%s executed", argv[0]);
-
-	return 0;
-}
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
