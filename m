Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078BDC61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 09:06:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D97A3E5ABF
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 11:06:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 027683DFDB3
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 11:06:35 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 55BC11A00163
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 11:06:35 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-90cd4631090so37100846d6.1
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788167194; x=1788771994; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LoitYd6nHyx0XoXa19/IQ21mMGh8E2znFueuF+tVBNo=;
 b=Hk0TkK7oEKA8ish/y1TOz1wjU779UJR5rHV/xpjkqXVsH3ozDKZ60xT2OWPGFO9Axr
 wX294GzbfiUU5RxNrkW4TcFPwT75A5k5Epr+sa3mb+p1ISBHskWpUVLmbVUTjpGiG6Xf
 aKZiWh1Ej07IbZnjbFCo7U1Mz6pbvFgYODiwL28Z44BSNCNYl3Y9Lmahz8KrSWGtmFoY
 6k4WVj3sejJ6fIHz1K0Mr4D+REg8R4a75VTnZ9/yZGFhozmqTrFwfznzx5+rGMrmvY18
 3CmCYFtTZfbKnlNnUnEZ3xothDdX/dVXqe5GCdzGCA9t6DL0O2dM/TcmKXpJ4bM4b1GZ
 pphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788167194; x=1788771994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LoitYd6nHyx0XoXa19/IQ21mMGh8E2znFueuF+tVBNo=;
 b=m/sDfcG7LLCbElrkEZZwOpd3MHj6VsYgWlTRK0FnDnNDM2HPB7vxcs7Y0EzLsd4lui
 t/aPq/mTAdhrRbOf/363i1XB5h9Kb85mBOnTlqc6AzqfjVAJ3M0tF3F9q9WjQJ360OsP
 iGRsfQiG25jxKkFkLEGmqPFFayEVcZLJHy5xicFeF/4+HTtg/v5NTzs2T3Gkv8UQOTd4
 u27jSc9NQ0QKZB2b7+C+0z4MXW9joXVI1kvDq+GTquqHekWIH3IaRhddpoUlXeavlzFQ
 WjkFOSqpJZcswQmTLfxxPH8Us4gYO7z+RkbVMRd4IkqRqj7ViO0kRSFvyZ9q8ZZiwXJE
 64FA==
X-Gm-Message-State: AFuF++lk28/Qshh50fEnoFfNnzpI3s4a2wlh9jQYVGG6Buq66L5s84n5
 Ve11yNU0EXc/0ediHiJB071aK5YLZyUbQIV+K2fzTHMrGDwhbmLtJO6s
X-Gm-Gg: AYBFou19JrqXuP8WmVkNTQ7SxAS1zjVgsiGQ/yJn7km+vnhkkUa9sFKO5d9gS2chvOL
 NAD2M4FH9SQiMNeJzkY3/Z6z2PgVBV75H5INa5lNfAcJIpZK1xL2G7sTr/+lQje4B/GqJCw8iMF
 w2sayRDlhMSyqkoCNUBhN/3bgBEk/KZSS+6DF1KEFS5f1myjzitQ27YvFVo/xNtNq9BOK6RibBx
 gFH9r/Wmuaiq23hlx3AlVrJuOrKybKPUPRei7w8uK0yaK7UZl8C9Zk7eUk/q94WIS8Wg5EvV1bp
 fD+lQlZkweMIAZyGCvRsz8dgqnlj+lwZoEWbZKGxbkLypllM4m1IUeLAFJqSFQGy37ZtfDYIym+
 zqXXf4pajiIEjoAKtW529IDMW3LdISfv2vKPT2aq6EFTQDiG90eXPFBNd1I7bvC2mg64e5pDi6G
 eIcvF3ru4dED8BaJCSInNwAsPDOAYwsvmx42i/DEzpTR4py5RHCk4ccqIV+rkL+uXp5F2/SlGp/
 534HxW9OK3trSWfaUdtPXoLgM4RUE1aPqEAlV22szJDKCC80cK0D7MmTcE8ZpofMjl5wFwrqoz6
 px4=
X-Received: by 2002:a05:6214:5901:b0:90c:d1c3:534f with SMTP id
 6a1803df08f44-90e8702c62dmr90100526d6.4.1788167193992; 
 Mon, 31 Aug 2026 02:06:33 -0700 (PDT)
Received: from
 runnervmgx7h7.5qj4ms43gybe3fet3unmniotwf.bx.internal.cloudapp.net
 ([172.203.254.215]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90ce4460e0dsm79828786d6.11.2026.08.31.02.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 02:06:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Aug 2026 09:06:33 +0000
Message-ID: <20260831090633.9495-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831-fchroot-v4-4-57cceb68f927@suse.com>
References: <20260831-fchroot-v4-4-57cceb68f927@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: add v7.3 syscall numbers
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

On 31 Aug 2026, Andrea Cervesato wrote:
> syscalls: add v7.3 syscall numbers

--- [PATCH 4/16] ---

> +fchroot01 fchroot01

Medium: Linux 7.3 is stable, so this released syscall test belongs in the
regular syscall runtest file rather than the staging-only suite.

> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};

Medium: Add `.min_kver = "7.3"`. On older kernels the direct syscall returns
ENOSYS and the test reports TFAIL instead of TCONF.

--- [PATCH 5/16] ---

> +fchroot02 fchroot02

Medium: Linux 7.3 is stable, so this entry belongs in the regular syscall
runtest file rather than the staging-only suite.

> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +};

Medium: Add `.min_kver = "7.3"` so older kernels skip instead of reporting
TFAIL when the syscall returns ENOSYS.

--- [PATCH 6/16] ---

> +fchroot03 fchroot03

Medium: Linux 7.3 is stable, so this entry belongs in the regular syscall
runtest file rather than the staging-only suite.

> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};

Medium: Add `.min_kver = "7.3"` so older kernels skip instead of reporting
TFAIL when the syscall returns ENOSYS.

--- [PATCH 7/16] ---

> +fchroot04 fchroot04

Medium: Linux 7.3 is stable, so this entry belongs in the regular syscall
runtest file rather than the staging-only suite.

> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};

Medium: Add `.min_kver = "7.3"` so older kernels skip instead of reporting
TFAIL when the syscall returns ENOSYS.

--- [PATCH 8/16] ---

> +fchroot05 fchroot05

Medium: Linux 7.3 is stable, so this entry belongs in the regular syscall
runtest file rather than the staging-only suite.

> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +};

Medium: Add `.min_kver = "7.3"` so older kernels skip instead of reporting
TFAIL when the syscall returns ENOSYS.

--- [PATCH 9/16] ---

> +fchroot06 fchroot06

Medium: Linux 7.3 is stable, so this entry belongs in the regular syscall
runtest file rather than the staging-only suite.

> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};

Medium: Add `.min_kver = "7.3"` so older kernels skip instead of reporting
TFAIL when the syscall returns ENOSYS.

--- [PATCH 10/16] ---

> +fchroot07 fchroot07

Medium: Linux 7.3 is stable, so this entry belongs in the regular syscall
runtest file rather than the staging-only suite.

> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.child_needs_reinit = 1,
> +};

Medium: Add `.min_kver = "7.3"` so older kernels skip instead of reporting
TFAIL when the syscall returns ENOSYS.

--- [PATCH 11/16] ---

> +fchroot08 fchroot08

Medium: Linux 7.3 is stable, so this entry belongs in the regular syscall
runtest file rather than the staging-only suite.

> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_tmpdir = 1,
> +};

Medium: Add `.min_kver = "7.3"` so older kernels skip instead of reporting
TFAIL when the syscall returns ENOSYS.

--- [PATCH 12/16] ---

> +fchroot09 fchroot09

Medium: Linux 7.3 is stable, so this entry belongs in the regular syscall
runtest file rather than the staging-only suite.

> + * back out require ``CAP_SYS_CHROOT``. The remaining way out is a pre-opened
> + * mount namespace file descriptor: :manpage:`setns(2)` into it resets both the

Low: A pre-opened directory fd also permits a privileged process to escape
with `fchroot()`, or with `fchdir()` followed by `chroot(".")`. Describe
`setns()` as one escape mechanism rather than the remaining one.

> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_tmpdir = 1,
> +};

Medium: Add `.min_kver = "7.3"` so older kernels skip instead of reporting
TFAIL when the syscall returns ENOSYS.

--- [PATCH 13/16] ---

> +fchroot10 fchroot10

Medium: Linux 7.3 is stable, so this entry belongs in the regular syscall
runtest file rather than the staging-only suite.

> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +};

Medium: Add `.min_kver = "7.3"` so older kernels skip instead of reporting
TFAIL when the syscall returns ENOSYS.

--- [PATCH 14/16] ---

> +fchroot11 fchroot11

Medium: Linux 7.3 is stable, so this entry belongs in the regular syscall
runtest file rather than the staging-only suite.

> +	TST_EXP_FAIL(unshare(CLONE_NEWUSER), EPERM,
> +		"user namespace creation blocked by the failfs root");

Medium: EPERM can also come from `security_create_user_ns()` or a policy that
disables unprivileged user namespaces, producing a false pass. First verify
in a separate child, before entering failfs, that this user can create a user
namespace; skip if it cannot.

> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_USER_NS=y",
> +		NULL,
> +	}
> +};

Medium: Add `.min_kver = "7.3"` so older kernels skip instead of reporting
TFAIL when the syscall returns ENOSYS.

--- [PATCH 15/16] ---

> +fchroot12 fchroot12

Medium: Linux 7.3 is stable, so this entry belongs in the regular syscall
runtest file rather than the staging-only suite.

> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +};

Medium: Add `.min_kver = "7.3"` so older kernels skip instead of reporting
TFAIL when the syscall returns ENOSYS.

--- [PATCH 16/16] ---

> +fchroot13 fchroot13

Medium: Linux 7.3 is stable, so this entry belongs in the regular syscall
runtest file rather than the staging-only suite.

> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};

Medium: Add `.min_kver = "7.3"` so older kernels skip instead of reporting
TFAIL when the syscall returns ENOSYS.

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
