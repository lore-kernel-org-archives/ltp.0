Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11EFC5ACAB
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 13:06:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A8443E7018
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 15:06:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D96633E7034
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 15:06:03 +0200 (CEST)
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A1CE51A01060
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 15:06:02 +0200 (CEST)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-4511f6a63edso183392fac.1
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 06:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786107961; x=1786712761; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7lIvWjiCTl5qTxkmVqQQcLrBBYoZgjMGo2MNtvuBpak=;
 b=AE/M0qN0qSNbFm9cFQ6lGARy4SVqvJOlMU3PIlv8y3WcV3+q7R9BSv7hCtTHAC76uT
 XsgtOwdQ0sZdmni9u77RZRDCWnZCMbNztHQ8RMWBhzwFKkic3hzWB7YOIQvXdVZ6caHN
 PUj5Wi140HZhCEurHLfJ2cj80+vt4kzdCTpio+MNECJU/JBbj4xAsfR0n0s/MAOttB9V
 WncEMSt8w1oQYSn2h70eYOZMNpKq/i/cH5ItDLMBI+CulLyvgkndAze+srQNXLJXzI7l
 Xjmx1WRez8InZU41dt2xlFhTivxlGMXiR2jApZTVS3wJuV/PYZCtNmW6QZkDMggtd1Sp
 IDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786107961; x=1786712761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7lIvWjiCTl5qTxkmVqQQcLrBBYoZgjMGo2MNtvuBpak=;
 b=oujZdcTQzm+fvCPywoSc1d76ffT9fdWz30c/KOfIre2SKKq/AI26HBwOfjgfXV9i1W
 E8gRrr59DRqJrSwMcy5QK6RvEqz36flrzUkObytJKLA2xNxvUpu23R12X+OC9zO7bVwC
 TZc/9W+Xfq3O51REV3dqwrvZ8HC6U7dUh6bvJHnXP6EbYCllOjvywtc0yfzbpWhILoJp
 ahH7wXl5HY+B5fX8oMUdb9LsY+IhAVA/ayBANB+E5OM3EIOQL72m+K1/XuwSaGKopZCx
 tyl13B/00ksWn0krnKy90PyvjK1CvzgirBVYVeuD0/dqNakApiUmrQlK/lIJXdrlxniJ
 sBUA==
X-Gm-Message-State: AOJu0YyaPseGM53Q5VYtdkw7QkFkJhJehZrjid39GVXDXOfiJTuTdyc4
 rgcyG+RAPuhcTHoiT3fsn8aSR/Y5E5DIZTuCiYBhAlAqZHDAQf/wh7jK
X-Gm-Gg: AR+sD10p6zfPxIjQLzUsZlzQaptmxXLWOYf2fh63GFR3JqjHGoqhoumLcl3OHjMdWsd
 hmefhplgHUvXR3a/qUSI7BuKFi3yEPxAceA6+8Z9k4f4RSuNTJn1hbJj87vUA13cXRUFjiv5zom
 TFdIn9x7+19Hn7pDrOZzQBARKzsISE0QIqEBwdrTJDsYySfmietteRscBekCAfG/LmvpokgjPG0
 Uy2CQu4k2j/pcPA5qko/GsSwUPAHMVExg/zAjizkKUfLW45YYUs8eXqXTuOLy5FhpNwgoCoTZsZ
 X00wx49p2F9kDBvqv6uAhvX8dQ/8tLspc7Nh1gprjCcOiYB7574E3IYawxeQjzraA2xq4atiSVu
 t1ypzQSbTxQUTMmahgMA2S6LwUj3eUKM7ZjdkSXoaeTAcw+KCmB5dgJtvRvz85RUmujhJA3pAtS
 25B2BCs+emlszZ1U6AsbqdPcjndLrYlG/GiFb2BoWAQYJ3Dj8uUwmVbXxG4/kU0jqWSwRa8zoZ3
 rKxu5VFKzXBEXhifdSbYXi5ig0McSdeqVSYjT0DMq3uAkYApBQzPPqwW0FH6WanFkqFvwVlBrMo
X-Received: by 2002:a05:6870:a786:b0:449:bccf:bb67 with SMTP id
 586e51a60fabf-45a0efb002dmr193663fac.5.1786107960938; 
 Fri, 07 Aug 2026 06:06:00 -0700 (PDT)
Received: from
 runnervmvrwv9.hdmk0zmo1nxubn2t0wytbqw1ec.gx.internal.cloudapp.net
 ([20.46.239.183]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a76701sm1919173fac.5.2026.08.07.06.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 06:06:00 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri,  7 Aug 2026 13:05:58 +0000
Message-ID: <20260807130558.8420-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807-rewrite_mremap_testing_suite-v3-1-dcca6d4ac0f1@suse.com>
References: <20260807-rewrite_mremap_testing_suite-v3-1-dcca6d4ac0f1@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mremap01: Convert to new API
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

Hi Andrea,

On Fri, 7 Aug 2026, Andrea Cervesato wrote:
> mremap01: Convert to new API

--- [PATCH 1/7] ---

> static int verify_file(void)
> {
> [...]
> 			tst_res(TFAIL, "file[%zu] == 0x%02x, expected 0x%02x",
> 				off, (unsigned char)got, (unsigned char)off);
> 			return 1;
> [...]
> 	if (verify_file())
> 		tst_res(TFAIL, "mremap()'d region did not sync to the file");

Could verify_file() report the final result directly instead of returning
pass/fail status to run()? A mismatch currently produces both the precise
byte failure and a second generic TFAIL for the same check.

--- [PATCH 3/7] ---

>  * - Obtain an unmapped address via ``tst_get_bad_addr()``.
> [...]
> 	bad_addr = tst_get_bad_addr(NULL);

Could this use an address that is actually unmapped, or describe the
partial-VMA case that is really tested? tst_get_bad_addr() creates and
retains a one-page PROT_NONE mapping, so old_address itself is mapped.

On Linux 7.2 this returns EFAULT because memsize extends beyond that
one-page VMA, not because old_address points to an unmapped region. The
description, algorithm, and commit message therefore claim different
coverage from the executed path.

--- [PATCH 4/7] ---

> Rewrite the test to use TST_EXP_FAIL_PTR_VOID() to verify that
> mremap() fails with MAP_FAILED and ENOMEM when growing an existing
> SysV shared memory mapping in place
> [...]
> Switch the Makefile from libltpipc to libltpnewipc

Could the commit message be updated to match the patch? The code replaces
SysV shared memory with a private anonymous mapping and removes the IPC
library dependency; it does not use libltpnewipc or GETIPCKEY().

--- [PATCH 5/7] ---

> Convert the mremap05 test case from the legacy LTP API to the new
> tst_test API.

Could the body explain why this semantic rewrite is needed and mention
that the positive MREMAP_FIXED cases are split into the later dedicated
test? It currently only restates the subject and does not give the
motivation or explain the series dependency.

--- [PATCH 6/7] ---

> static int check_pattern(char *addr, size_t pages)
> {
> [...]
> 		if (got != exp)
> 			return 1;
> [...]
> 	else if (check_pattern(ret, tc->new_pages))
> 		tst_res(TFAIL, "%s: pattern mismatch", tc->msg);

Could check_pattern() report the result where the mismatch is detected
instead of propagating pass/fail through its return value? Reporting the
offset and observed value there would also make the failure actionable
rather than producing only "pattern mismatch".

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
