Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AC5CD8C88
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 12:37:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C62033C96A5
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 14:37:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A00E93C2666
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 14:36:45 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 070F114001F4
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 14:36:45 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8cebfb15413so38582836d6.0
 for <ltp@lists.linux.it>; Sun, 07 Jun 2026 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780835804; x=1781440604; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6DENwu6rC8fDvVpiL+zUfm5QiRLHOhs+Hoq35MCMSo=;
 b=UmNIvcZClN2c4xYCiQEtglxSzrn28LDVnY5W8QJ2FUcY6gSKT+cfORhYy0XKSR+fLE
 fE0deO+6wIbR4XQ6qK0d/VYeApp9ZY9K6lVKmnRf8hTZFimW0N4s76TKg05DO6Jrh20x
 ujeKp0+BTU+PeyAeGmkiMrb7Xc5TAeIAw/ia8hrAn0Blxm+hDOT9v7dnTiKQT40vxS7F
 HDr9D3e2pco9igdHlL/IWM0lhQydy8KlZRsFz3yOyN1zp8U+y9FsBxi9UqfOdJtwcHBu
 /QpXV4bQ89IWcfoV3lZ29+aujBbDNYKzO8+8h8HY/ENr/M5vfSOClimoIGQ6pe+d+iOr
 JkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780835804; x=1781440604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v6DENwu6rC8fDvVpiL+zUfm5QiRLHOhs+Hoq35MCMSo=;
 b=oFRzMvmiYdxsHh/RPhz3qlf3kXz9L6v1YFEkNE11TB6ccS7DZQeawiN7Qmlz4Pa+l6
 oFkUdxn8gI2P0rH2HSVJU7XVGdQXSQbxIJmv1C6TdYOt3yiyLWFAzp8bhv4z5/jIE9x3
 7GNpVPesG9wqq74mEOOXH9Z8m5q4YVmJdTX1laI3CLqWUPrG44UUKNAQAKAu+yRtZtNr
 WAqsYibi6AGQx6RKRqACwHbhcdiAVpCbSjHIx9vBJ3jXT3Wm09s4on1Fwihcxpv5fAkP
 M3Uc4DoBlj7AjT8Fmg50gvUzXXnKtN2mPrOHe0ZdB84/5lwSxHk4PzEaJXBtN5gK3vgs
 N11A==
X-Gm-Message-State: AOJu0Yw/menFqzFjfTl9L8ItFJ9Y6rW5GpnyCYdMTzdEums3/9lufCOC
 SQdRsGa1zU/iXzN025BjEZmmemFRxnOpyk/2+bp5+/ian8/j+5yymfsHfrGKtXMi
X-Gm-Gg: Acq92OEBBz15kRmODT9HkfiZzmr7Sj30HbRDLmVNKHLZlAsC9mexbvbjW3o5SjnxYvk
 HrLnGv/fhMRg/RTX3/awtuHf/LwJ5SUAChANvuf1y60qWBwvPxpe39OEnq595RAW5a5NxoEFSD/
 cOzQT4NiyY3557ZxXMQPpAW2U3kb2E3jRaeHhvR5Sc0+wFG8qTlqF3jvtlzmCIl1XGS6C0MMrW/
 4d7K+QbuCChu0/kaCyUwnTG9oROzNTlYhoOl7aIR7T2gX+Rjy3zVnU2O9iOQOtau/jTreVcUpL5
 Dw2wBigdhyrOC590wMoBc0q9Mv89/tlcH4ZwMRciqSrCOC28EQLeqaOuoMRBU6rd87Aob8tEreP
 8FAoiwtTRimAaMXDaHHFRgCi8PCsfdBrrUZ1TnHOI1j7+Guoa7vjmMJGz5QERBV5jWso7CbKh0x
 Tbhx5E9RHVz+56JSYCprgNYHXBxQKY8FrJYERiphu80UoBbk+jkzHklHwnl2eiUsPgYQnDqRyKf
 LlUpFC6cbCIEcB+Gm0uUs7txO6xpR+xHqzGqs8nnB5khFBbNJk=
X-Received: by 2002:a0c:f146:0:20b0:8cc:f074:95e with SMTP id
 6a1803df08f44-8cee61337camr147970996d6.30.1780835803629; 
 Sun, 07 Jun 2026 05:36:43 -0700 (PDT)
Received: from
 runnervm3jyl0.ipqzque04imezfhyn235lw4voh.bx.internal.cloudapp.net
 ([172.178.119.36]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccdc91cesm133284036d6.19.2026.06.07.05.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 05:36:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Sun,  7 Jun 2026 12:36:42 +0000
Message-ID: <20260607123642.7543-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605-doc_add_missing_headers-v6-1-678aac302a60@suse.com>
References: <20260605-doc_add_missing_headers-v6-1-678aac302a60@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: Add missing API references to api_c_tests.rst
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

On Fri, 5 Jun 2026 11:17:13 +0200, Andrea Cervesato <andrea.cervesato@suse.com> wrote:
> [PATCH] doc: Add missing API references to api_c_tests.rst

--- [PATCH 1/3] ---

> Fixes: eef750db28 ("libs: adopt tse_ prefix for extended (non-core) library")

The commit eef750db28 referenced in the Fixes tag does not exist in the
LTP git history. Is the commit hash correct?

--- [PATCH 2/3] ---

> doc: Complete struct tst_test table and shell API docs
> 
> Add 8 missing struct tst_test fields to the C/Shell API comparison
> table in writing_tests.rst: .filesystems, .forks_child, .min_runtime,
> .needs_abi_bits, .needs_cgroup_nsdelegate, .needs_cgroup_ver,
> .needs_hugetlbfs and .runs_script, and fix the alphabetical ordering
> of .mnt_flags and .min_swap_avail.
> 
> Add a shell API variables reference section to api_shell_tests.rst
> documenting all public TST_* input/output variables, checkpoint
> functions, and retry helpers.

The commit body describes what changed, but does not explain why the change
is needed. Could you provide a motivation for the change?

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
