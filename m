Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8ACDC43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784017239; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=oo7c5zdz76reSvvOCdtj/4pzs+bOFwSj7CGpameNBEvc4wN2Nc8wo7ILhHVa4O6cBNrHM
 7s/EughLOsxGPPD+PRVrgKrd6JpEzOlNHucQaAKS20Oa2AXCMzsWCZ4k5zrNEdggSr2WOv6
 A0Y/x14QkP2OoxQlJ+ZGtCCEOnJCh8c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 221463E2325
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:20:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30D803C018D
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:20:20 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 751A71A00900
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:20:19 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so654087f8f.1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784017219; x=1784622019; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=NgEbo/g9NrISt9XtUg5pUL/2W1neEYB5eRzk+9tDqRMd+6iR3zteAbjnQ6GiuPWaLc
 Z0TW4znPuByUeSdkB/oCBIoP/2zy4hWgoHnctsrRvG14as80cCF1RdNvm/VmlM8V9wHA
 q6PH7iUpf3FGoVik0oYFG49SSLW80I5qgGnPlAcKsd2hDOrICIDgFgF1riXL/go4PwVx
 DFRDqYnIWEJESb3PU3oxSpgSs6iMspod+la4R199rf0d5vPdzQEFa3tj6dLrE0QgkB4z
 kn/E0qtGX4T8oHlkSLll2WNdKVJB4VVZMk3Cn80FIIWfbqmrQ/XTDK6SlUmVTdZQFO4f
 lsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784017219; x=1784622019;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=hs/BpatXmZvAkfOM9a5M5xfHiQWZj/Ld8t4sNN2eqUCTkUoV/GAzZjPTsLcAA8xdbz
 QdFGFDwyGhpHSUkDE4AuhgH3Hc2ZzQCjNq4jwYdFbtGc7bfvTp6DiG5SfcDO6oxpNXGX
 wd2dcHM7/YPWX22fzslkYICq0v+jFSKxhEQgU/lm+cxTuzZd4+TGGFfl/wd6lkRuHFVR
 +T7MsjB7QDrsdnuJZvoDxBmrzH5Y9FlwRW3gHMQ6cP3ZyBnKRBRlQWJtJoCjSdlmfGXh
 dIszedkmsdIvg6i08VW8y0B81dEVx6c4oT22Ge4dtqt7McjsRTM9ggqgZKW66VFyyvn1
 cHdg==
X-Gm-Message-State: AOJu0YwhhjGaRrXXyK6M+6L++TdBf7Y4vR/dE+oij2U0Z0LwKtf9iusk
 oqma8D/GvoU26ce9n42FBjY+DkzHHX5h+lb4vT5q0HGq+mP4nYCplAX9GKregLxCGCaTrMPRSGJ
 ukzgKkx8kNQ==
X-Gm-Gg: AfdE7cnCLKkgIHwFTAQ0weyDULtOwJDevKp52sF5RBMzctsJCBCJEWvKMe0Y/e2mQ2F
 L3Vp3U61PwSNk5LXELcJi0QxtQpSswc1kJemGdlCcgkyo7mwGCfgU+FrdEWF7ts/j7ZJmWUdoQK
 HNBNfwL95nGYtcGQFpVjxlUWyESBksnrXKB95WffOmUMIMDDRPjJ6J8hMC9q8tYFEkoQYQzgoyi
 Zw03Lf7Rbbz3kA60TK+YAkzdpwvD/59iIE0CH5KVHVsEz62vm/5GhVfAZBSBw+6bj/79KSLbpSK
 4xsjQMYYewV0jC6ZatdIA6bjHlh2wWhbf5LB3ZwOqe2JH5gMBhKjiqjP7eIZpIYatIiUXK90PsM
 JqjJZpzgwtX9VKXHhnMHWYuzL4hSoBiYLyJYqnxJOM+NUscPmppzZ8nDHYSyk9ZbX51gMXhQiOa
 9x2fj22g67Cy2BKorV6t7KzhmN1uuHk22IMoEb
X-Received: by 2002:a05:6000:719:b0:475:f100:35f4 with SMTP id
 ffacd0b85a97d-47f2dd37a6fmr14314387f8f.49.1784017218656; 
 Tue, 14 Jul 2026 01:20:18 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464b7f09sm6177498f8f.26.2026.07.14.01.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 01:20:18 -0700 (PDT)
Message-ID: <6a55f142.c799ffc2.29dc52.cbdb@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260710062921.1145948-1-pvorel@suse.cz>
Date: Tue, 14 Jul 2026 08:20:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] checkpatch: Ignore USE_NEGATIVE_ERRNO
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
