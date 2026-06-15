Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F23CD98DE
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 08:33:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6B183E5B4B
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 10:33:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 000BB3E202A
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 10:33:25 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 60CAB1400BCD
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 10:33:25 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-304cf518c9dso4805095eec.1
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781512404; x=1782117204; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZQ+qEhfteZdJjyuiKSVQiUrLYfwmpMMhL+PwhHYyjA=;
 b=s3hKqZHMJTwnWIllnGUaeZwBq25/Y42xsu3jXMVbNingvWFT2GWbQA1gGs/jy9ZAIu
 dN/BEZx3tjzRgajB65Orw5IuywDuYiG3zBjArGzdoU7bdt13oW2OJb+C28yo0JETkxgg
 84J8hiI+42k7bo1RnjwAh4pqzqy9xq7B99q+K6PI8V6cfw9l2A7GksUBN/DBXed/FQMk
 nw19BJll7xkecAROAzQ5mNZZxDray0Y9zn4mPy4V2HP2349iQvkQcFdO+qYhy/PWvJ+A
 RopvgU0Hb5BOgdIEvs03Ui0LtUwv1giepKYulBggb8kb7toF/mchpixvpDKSoXEm6Vdg
 g0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781512404; x=1782117204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yZQ+qEhfteZdJjyuiKSVQiUrLYfwmpMMhL+PwhHYyjA=;
 b=ic7atkfgnTxNJCsOHkyX6EGGpbnrvrBy87rUo6ZviPsSeHvw7OFzgnLHkp/2LWOOyE
 azNsjNADMzYtKjAw34LN1a4/2/i+YzWBWXK9GBPDE5jzFuOz7/KlpWl1NhfpoQKHxobc
 IBdWLbEsoZGqgrBwCe2kTCU+bjFl1B90D8YQ5UQat0WcxVOy34xoArqZRzNg392WziYU
 j5N0kqTM97ySaqfAJ9Z1eQt+7qCGhD6av1PmTvsz6hE1Ko0ChZft/dyZumHyAO33+ZlH
 IL27OM31X4XBI9rT3i/klOzuFP5Lo5ZNre60i05npaiqutE9s42Kx7sa1aJXJIHxXHnt
 oVjQ==
X-Gm-Message-State: AOJu0YzWR8dp0frFF4eJO95jczR7X0cJ7ik8/KPYOINpxJSkg/79BBD4
 XVafMI/nGqDlB3nGwdQ9IRyuuo8+6K8M6terxeQ6AGPn6OM7CMV8n5sw
X-Gm-Gg: Acq92OHQPYD0EQFU7hZ5f06vTDp4X5kTmtv5xOAbWAaarHBqZOzCiXojOA3uFNkk0jA
 3Sx0+Ae/rxkeiYEZ1ihkcuSy0718T6Ca4tm+jKtMzu3ZYUG7/szAVmGmHeRe8aZ4cBPI5tVw5gG
 6jPHtGv6RT2nRZPL3eWXCTd3IUKvQU6fBUGMN2o1Y7Jt3GtqjDxZrE4zDA8yhokzDys5PQzQ/F6
 kSkqNvrnMg6DGlGVd6z/ow0z6ieu7nqKQYfiTacWHfRmmGipNJyf6ANBovj2qcJREGc/AdC1o+D
 CXfmSZ/kRbJON62yozLHxH2jyFHonhoykPCDi5wUZRLpUJIIWKALD6bRr3ZehWP5ZZ8OjUFFMtT
 ZO2ttdHrmizUArXx1QCm35vufjPotI9U3mx8V5ImKKT8OGxgVbkH6TOzt2xKAZQvUdIyYUmbcSM
 4RYD/SLHd4oIqo75H/g5qKzX6a2Gl+1UwMyO6kv9bQd8hzPO2/UqkzV+eSbKVOISmEOderOlUhE
 cS+kLgkwJwKwOQJHGqSLXU09g1CN8YTHAWbM7XtmQ==
X-Received: by 2002:a05:693c:63d4:b0:30b:6191:7f96 with SMTP id
 5a478bee46e88-30b6191bf72mr1967720eec.30.1781512403575; 
 Mon, 15 Jun 2026 01:33:23 -0700 (PDT)
Received: from
 runnervm1li68.3eoktrvvyoyuvprzmixvrumbeg.yx.internal.cloudapp.net
 ([172.215.216.197]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95342sm14093599eec.29.2026.06.15.01.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 01:33:23 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Mon, 15 Jun 2026 08:33:22 +0000
Message-ID: <20260615083322.4126-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615072514.53026-2-sachinp@linux.ibm.com>
References: <20260615072514.53026-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permission test
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

Hi Sachin,

On Mon, 15 Jun 2026, Sachin Sant wrote:
> fs/acl: Add ACL_USER_OBJ permission test

--- [PATCH 5/8] ---

> +static void test_chown_acl(void)
> +{
> ...
> +	if (acl_set_file(TESTFILE, ACL_TYPE_ACCESS, acl) < 0) {
> +		acl_free(acl);
> +		cleanup_testfile();
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF | TERRNO, "ACL not supported");
> +		tst_brk(TBROK | TERRNO, "acl_set_file failed");
> +	}

The errno check for EOPNOTSUPP happens after acl_free() and
cleanup_testfile(). cleanup_testfile() calls unlink() internally,
and POSIX does not guarantee that errno is preserved after a
successful syscall. If unlink() clobbers errno, the EOPNOTSUPP
check silently fails and the test reports TBROK instead of TCONF.

test_chmod_acl() in the same file checks errno first:

    if (acl_set_file(...) < 0) {
        if (errno == EOPNOTSUPP) {
            acl_free(acl);
            cleanup_testfile();
            tst_brk(TCONF | TERRNO, ...);
        }
        acl_free(acl);
        cleanup_testfile();
        tst_brk(TBROK | TERRNO, ...);
    }

Could test_chown_acl() use the same pattern?

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
