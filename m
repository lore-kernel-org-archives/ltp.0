Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1356CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781530107; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=2QWLzPghjplkqKsXMKGDPPRjr7ljaB6uo/ziC6xZ8lc=;
 b=lGkzO0HTDMG3/MdTlQyn9nImKm4KqiR3d8V+yZvH7cuJ1qZ6Ifn51hxGXfpW6j7UpqT4A
 vE9GwLtzC42p+fIDEOg9kItcsjKAnbnVpDz/Gm54F6mhcdjxqsAaSBXXNCPpDCJenCcKvkY
 5kNBw9azbKtIXDxSS2lxsWrHk3Tgru4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 519673E5C70
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 15:28:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0450F3E202A
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:28:05 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 48D111A0016F
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:28:05 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-460662fcb4eso2226473f8f.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781530084; x=1782134884; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mQQfjb/HLmfklef2BKMb0up8y9v3IfnKPvAn1FpxUMU=;
 b=ci/qmMbsXrANykTqA86M9b6UAxLLU/k/7vbsN7SW1ZTdgMDajgHx8aoM7r+qiYjQ4J
 3K7tUY8hMXwh/iaFJQGTQWolIFmKUcxfpSIJoPIALtcgZAnYQWFHex9BYQnxtqBaHXB+
 teb079kBhCbr0QWyVjIvYTUoh6uKNIX6gyYvkP8uG/gXanLw6ghWUsgpuLQnLJVMM/XB
 wHWz8mFhHlSBLpnLz/GUYUa6WkGDTQUYOdb/iajNk0HKRc2BxMflcrpPPqvB0RvLo8HB
 /CaC45vc5deY532SKN6l32fQ//PPtpXQtzE55QmTNxQmwj+24JxAK0DlZnMZPyO1HE6s
 pm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781530084; x=1782134884;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQQfjb/HLmfklef2BKMb0up8y9v3IfnKPvAn1FpxUMU=;
 b=sVqZ9hnywEoniwJdzflHkBqOe59gyRg1dyg6rEMaxMdhbEJ0Kou/QWSDPvX+GtJP0L
 kTfFY87cXlYnZqO4+PA4vRnw7iLA9drLOLUtk7CFLTgCYNl4P3jllpJwBAuurR/ilyjX
 ePQb3dwPBHDJ5Vjz5lF1tbeCj7tqsC4k4VW/H0Q8KsPGSSzlr/H5szZh5tDiobio1BlO
 BMN5v8KyNvxR8Mwht8Q/L3+BEank4Hz1TBR6EgI3Uhyl7A/OKv7PG+RX9LpO8rIo8T6w
 fhQbTJMeiMin/mWcupxtfNB7Z/t9u4LGsicWaBOahVEEX0EpLRe3fnADrdGF1OiZsLKz
 jGBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MjDesbiL3n3I6E/2KP+/FRNnfr/ml0z2nn+/UfjoYabz7TZgGtRrOnamptzlBb2ER3FY=@lists.linux.it
X-Gm-Message-State: AOJu0YwrX7kxqGqqEbHWZHz4VXlIe/1aHAkoftxJ2HrfxCsfUXv//d07
 9xseHuFR/VqGy5UdnkIc5gLVgw5IwHFJEru8K4YoKX++11+c5O6iDTwFfNn5QwYUp+EaqBx3kJd
 8tfId+do0uQ==
X-Gm-Gg: Acq92OEyOXW1PLOAm9+OtqHa3eIU9hje2LBHuUaYxuDOfYLDm/PkhTL3ZbVahJVMs1Q
 j5VKnRLqBMV0Okf9zxwiVRZauMnU7UGtasf3taH6jBuYmOTI35h17sw950r98/G6vccTuchxoTQ
 LPzr2BjiQxBliDR/OtidPhuVbs+++6YgGKgRKNjPEUQ04xR21aiH38POzOrvACuKIIZXrt97Hpq
 cGXIQH9nbXV6rJDHJ2LbOaOZTxmNKke6Jy7bf5cmSVi3tKcXRrDQqcnHiAhwAfBkseP4Jkr7OFX
 GMBrSGxUTyvvIuAzjVNyjUuzDdu/f1q+2h0w5PKu0eFTWeaWSOrP66rkM2yyjrO7wrlwPnRlODj
 vWccLrydzKa26wVoT6Qca0dF8elSGTwSYs23/pBr8NFTbZt70rirXLtI+85rczS80BQJ7n1n7ud
 e5WDS2AQ2DanF5t41NVKYsVb21seCxRx0ONOn9eCrPx5IYeqZsOLtf2n3zPObcWlwDsy7Ca1xlL
 8gfKE/zUbE=
X-Received: by 2002:a05:6000:2087:b0:45f:f142:d569 with SMTP id
 ffacd0b85a97d-4606db8dd7fmr19352720f8f.15.1781530084377; 
 Mon, 15 Jun 2026 06:28:04 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f450sm37471602f8f.10.2026.06.15.06.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 06:28:04 -0700 (PDT)
Message-ID: <6a2ffde4.a08f2e7b.13a326.b994@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <be5e45fe-01d7-45ab-b6fd-78e52a82a932@suse.cz>
Date: Mon, 15 Jun 2026 13:28:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] pthread_detach_1-2: Fix failure on modern glibc
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
Cc: ltp@lists.linux.it, Adhemerval Zanella <adhemerval.zanella@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

@Martin, can you please send a patch to remove this test?
I will move the patch to rejected state.

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
