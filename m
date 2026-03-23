Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A775D58CDD
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 06:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774246154; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lUm1PlKzCrDmIE7e9dgZSe6AP2la+gnHAXGTUjKPyC0=;
 b=JpC1Li08sYwPXGW5nqTzRz4eJvqAc/me8bkH3Au6p+HWr3Vlwjf4VeYhS0OMXpC+FcUW0
 +tIhAG1hsmRF2j7ef5Hz0Uj742nn2OfOLZs9ZtsK/iUQIADZYvoPjN1HIS4ZhaX91RLivNd
 Nhc3ghubvkANlseLZcM8Lr2p0oXsLLw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C92713E1410
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 07:09:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2E813C6147
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 07:08:50 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 624512009DB
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 07:08:50 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43b49819938so1397751f8f.0
 for <ltp@lists.linux.it>; Sun, 22 Mar 2026 23:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774246129; x=1774850929; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4ucUIZc7z5lCV5iywJonL24XJdOcuiSVTpbfXFgnBc=;
 b=Ls7sehY2ZJzYFFfop7ZxIuk1IVzMHLt1jClf8Xy1dLST3y6gGWPOrBjt9fFEMMlm7D
 ey8ZX5DrtHIOsPBuV00jXprsljK9LNH8WbZ1d7Djim4nFKDcz200mimtsoBan3116DHp
 X8MdjndbnOXkcTRYiRfO7qyDcf8NeLH8N2bWjJG729seyCRkZberVmg0d6EkOs1fUsAd
 mP2tlvtVTiVfyr2iQdEVEhV/xJZVxbDrmwUp5rfmTCnWiOZzLmF//WoMMHZDguK9rm79
 oPf0G0bZ3tg5SNbN3rS6tKkrCUbbks1aNrMaDZILGBvHz7NcEdb1nFl4Grij0PZqEKO7
 hWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774246129; x=1774850929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H4ucUIZc7z5lCV5iywJonL24XJdOcuiSVTpbfXFgnBc=;
 b=F4ditt8/Ab/uMZ8TzOZqEPVRWcpLxF8MgttE4pOEPKZSKljCwyBtqXzydz06PAJG25
 5eF59oumha4WW/cL3DvEEd+fbHvQC8h8oUF0oUxIeirmFe4060lDk5GXEzUILO0a08b+
 Ijm+2/K/qBE7NT2P6mja7ttZfQm5B+xxWs3uHkSPz2L4LvBFx1B9+LovnBVi8tJFmwly
 Hyr0Y/D6+nlTK6ICwruaz3MEpJzCg0W8Xi+m1a5jAV/A5sgJpMsZ/OhmvonrybcE1FsV
 zQBBxGh0bNGTSw7d+NH+UEu7OmH5IlD0b5Uu0EHKVxU9QPuzLLHEioMkujLNwQCKPFXG
 NPag==
X-Gm-Message-State: AOJu0YyoYiprt8skrxEHHgVFpGABlHDGbNQe/G+pMdM0XL9K8oUaHuZu
 8BRRZ1KP7WuaRsQKNiZm3nlur7UEAtTn52Nvh8JHEyzraiVjQ64t/bmUIZrWLCoQAK74RU4l19D
 wX7M=
X-Gm-Gg: ATEYQzwVNbeSomHpy5sLsrJXaSAeBVvrp7+Pnu/2bwktZNU0T7tbhepcsPpxLUJe5d8
 a4l4vG5EYSTCdqMNXoelloIlpFQIGof0C+RAtKcQgfqAc+rhiB43W8s93JuEiyzl5NPMETNBHHm
 tmF/j4mZv4mc1IrOyC86UEeQoJ7+RTn1d61aleLiclfcyQJNpRmGSrq+qioDB2+QuGjyB3GXcrC
 Ok8iNHyC7fwS+CF04+Ug2IggtOGJPk/DlVyOCIw286k1cKm+Q7JmVFbE4ZgVp52OGEUQRKWP94X
 7L8ojDp5inD896fSQJqXeO5J5sonkox+IRzjdarlLtjK6JKM+43M4g9ZE1vasG1VlzBQuqP86h7
 8p2L+1WC+tyvHS+7KMPt8bdZf184m69kIMWIx3CnL5psBEcYA2mj1P5wdj3GyQeMytTThFg37mh
 jzV1Zs6djCNpk=
X-Received: by 2002:a5d:5d82:0:b0:439:d8cc:3626 with SMTP id
 ffacd0b85a97d-43b6428a9a7mr16979686f8f.48.1774246129087; 
 Sun, 22 Mar 2026 23:08:49 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43b6425eeb4sm23549271f8f.0.2026.03.22.23.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 23:08:48 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 23 Mar 2026 06:08:29 +0000
Message-ID: <20260323060846.4675-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226022536.20175-1-wegao@suse.com>
References: <20260226022536.20175-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] mseal02: Handle multiple errnos for 32-bit compat
 mode
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

In 32-bit compat mode, the overflow_size (calculated using a 32-bit ULONG_MAX)
does not cause a 64-bit integer wrap-around when added to the start address.
Consequently, the kernel see valid range that points to unmapped space, returning
ENOMEM instead of the expected EINVAL.

Signed-off-by: Wei Gao <wegao@suse.com>
---
v2->v3: Add compat_err replace hardcoding index similar with dcf0c145d9
("setxattr02: Adapt test for kernel 7.1.0+ socket xattr support").

 testcases/kernel/syscalls/mseal/mseal02.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/mseal/mseal02.c b/testcases/kernel/syscalls/mseal/mseal02.c
index e11d7dbf4..5874e108a 100644
--- a/testcases/kernel/syscalls/mseal/mseal02.c
+++ b/testcases/kernel/syscalls/mseal/mseal02.c
@@ -29,20 +29,22 @@ static struct tcase {
 	size_t *len;
 	unsigned long flags;
 	int exp_err;
+	int compat_err;
 } tcases[] = {
-	{&start_addr, &page_size, ULONG_MAX, EINVAL},
-	{&unaligned_start_addr, &page_size, 0, EINVAL},
-	{&start_addr, &overflow_size, 0, EINVAL},
-	{&unallocated_start_addr, &twopages_size, 0, ENOMEM},
-	{&unallocated_end_addr, &twopages_size, 0, ENOMEM},
-	{&start_addr, &fourpages_size, 0, ENOMEM},
+	{.addr = &start_addr, .len = &page_size, .flags = ULONG_MAX, .exp_err = EINVAL},
+	{.addr = &unaligned_start_addr, .len = &page_size, .flags = 0, .exp_err = EINVAL},
+	{.addr = &start_addr, .len = &overflow_size, .flags = 0, .exp_err = EINVAL, .compat_err = ENOMEM},
+	{.addr = &unallocated_start_addr, .len = &twopages_size, .flags = 0, .exp_err = ENOMEM},
+	{.addr = &unallocated_end_addr, .len = &twopages_size, .flags = 0, .exp_err = ENOMEM},
+	{.addr = &start_addr, .len = &fourpages_size, .flags = 0, .exp_err = ENOMEM},
 };
 
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
+	int exp_err = tc->compat_err && tst_is_compat_mode() ? tc->compat_err : tc->exp_err;
 
-	TST_EXP_FAIL(tst_syscall(__NR_mseal, *tc->addr, *tc->len, tc->flags), tc->exp_err,
+	TST_EXP_FAIL(tst_syscall(__NR_mseal, *tc->addr, *tc->len, tc->flags), exp_err,
 		"mseal(%p, %lu, %lu)", *tc->addr, *tc->len, tc->flags);
 }
 
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
