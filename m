Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F556CD98D2
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 19:13:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD2D43E6B31
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 21:13:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2ACC3E5FC9
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 21:13:38 +0200 (CEST)
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7EDD71000D31
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 21:13:38 +0200 (CEST)
Received: by mail-oo1-xc41.google.com with SMTP id
 006d021491bc7-69e4af5a411so943785eaf.1
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781291617; x=1781896417; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAG5x564DW+nMFsT7zd6DRGDQwlKi5RXuVEjGvTtLLM=;
 b=UQwhIdo/b0t3vGXL05IAFfB5YvZcOAuPawacujOLOonP6DPwVyKrsnSpZkX+6RWUqU
 +SBaSmtZdv1Oniws6ko45C6ItDSXWSSLGeXURuByZwzU0EX10jOCcj1s6/cjGjkfmdl6
 dMRIvwkMOp9CCjEyagRYCc4+q9mfFbhyAu5NeAJQbTmLmq0ng9LbdjLnsvaevmNcXMm+
 xjz/Zzo8DoKy9OxU1gw+vM3O7RACz+i//yk0VIWSWKNuBwshsC2W5pXm+ZDt+GMiABAY
 XjuH6uJTMaPPAsOME21PH1z51oY06wbfc5nD9EZ/tuk3OK6MTE5G6G5j5H3k+OHCWp+m
 i8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781291617; x=1781896417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bAG5x564DW+nMFsT7zd6DRGDQwlKi5RXuVEjGvTtLLM=;
 b=U6QbZDxvrClGr13nS2eVnRxpPsuknyTcvnXU31PkTey31/rd+ramYhEckxSMw+0Euq
 K8nSoc/A9JI1i7FgHchPbpgXhNtsVXdmbDi0uKwWikr9RyTTEs2FX0J4W26YW/jcFB+v
 yca6Ht3HjBhCvDwF+z1yx2vJC2HOuDjNShX/c2Q/Esjg3s8MumcJ2cj8IMBAaB+jJN/2
 4Kw4dJQhlrQtvSat9tXfv99gNL+29osG7b3tYMI8j2Z0H2/1RHwNIiWbHzwO3+6L9dU0
 oArboARnrsWzgoe6ohBJ8CJKzyzSnxX3uszFjFKTzU2Tt7yYTQtlvea+xSKTlLUno/B1
 bdLw==
X-Gm-Message-State: AOJu0Yz8vyvQxi0tL5ihCuuAQdSeNDjCf3mwU0Q4uQsuUK4PMSR5NOUz
 RIjv+cyqiP/TQ4ojmc4IhXCdzmSZt1HcWqPFrcFDIrFkS2FbGaQls+Kj
X-Gm-Gg: Acq92OHdWyrdYmNQ2uNRoIimjx5+uR1J16TuUp6YcxSVNTvPSdxsaEHMVlJB0NElHDh
 z1Y9jzl0wW7lFATI+KoNnVz70D1WH5i4bfYAFAEID5BPpMSRJjl3anaRSUJf5KLsk7Gn4YTLH9s
 6bU8r4gWTLOrdsrbYxg63hH07MzXq5EyxRUTZ4HSmEzxQeDigVwK6irx1W0SKZr9zWvGuG9s/zm
 ael9GbEyJPIjWj2gEmRnGPk96RYp0g8YMPwSYK53Y7SXMQMrlqLBDj1+TRhR0OT+2MTLSMcG2du
 daYhzCmsa/Vu7bFWED4dP+u2rQyu4/Lx8BPYUnS/WRHv7y65re9Su+3JIQ+Z1jlONhbHjVUoSF1
 6g/T/S6qMwrxQiDfmswSkj6u01d6936+GLnF93p0kvKFtpA5JHyfOGbB+SaG6VMR8Lag8z8Os7O
 8uiaVxBjLApYYiHytlgYuAUMzgp+ANkZJ8dMG2wtQGJyHi6PkQzgIl0LMqSr1fW6PBznfLdoOQY
 IDuT1ShJWboUpuSGUM1q/WWNmq0zjwXGeV+F9I=
X-Received: by 2002:a05:6820:60c:b0:69e:30ea:133d with SMTP id
 006d021491bc7-69eec990ddfmr471534eaf.49.1781291617068; 
 Fri, 12 Jun 2026 12:13:37 -0700 (PDT)
Received: from
 runnervm1li68.vivxwfosngge1kbd0jgxbaewjb.gx.internal.cloudapp.net
 ([135.119.38.50]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69ed83694afsm2099902eaf.2.2026.06.12.12.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 12:13:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Fri, 12 Jun 2026 19:13:35 +0000
Message-ID: <20260612191335.4231-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612171930.11964-2-sachinp@linux.ibm.com>
References: <20260612171930.11964-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

On Fri, 12 Jun 2026, Sachin Sant wrote:
> fs/acl: Add ACL_USER_OBJ permission test

--- [PATCH 1/8] ---

> +static inline void reset_test_path_no_chown(void)
> +{
> +	SAFE_TRY_UNLINK(TESTSYMLINK);
> +	SAFE_TRY_UNLINK(TESTFILE);
> +	SAFE_TRY_RMDIR(TESTDIR);
> +
> +	SAFE_MKDIR(TESTDIR, 0755);
> +}
> +
> +static inline void reset_test_path(void)
> +{
> +	reset_test_path_no_chown();
> +}

reset_test_path() and reset_test_path_no_chown() are identical.
The "_no_chown" suffix implies that reset_test_path() performs a
chown, but it does not. Could this cause confusion for future
maintainers?

If both need to exist for readability, the naming should reflect
the actual difference (which is currently none). Otherwise, one
of them could be dropped.

> +/*\
> + * Test ACL_USER_OBJ permissions using direct xattr manipulation.
> + *
> + * Verify that owner permissions (ACL_USER_OBJ) correctly control access
> + * to files and directories. The test validates that:
> + * - ACL_USER_OBJ permissions are applied directly as the owner bits
> + * - Setting ACL_USER_OBJ=rwx via setxattr() overrides a previous
> + *   chmod restriction

setxattr() should use the RST manpage role for the test catalog,
e.g. :manpage:`setxattr(2)`.

--- [PATCH 5/8] ---

> +/*\
> + * Test chmod and chown interaction with ACLs using direct xattr manipulation.
> + *
> + * Verify that standard file operations (chmod, chown) interact correctly
> + * with ACLs:
> + * - chmod should update ACL_USER_OBJ, ACL_GROUP_OBJ, and ACL_OTHER entries
> + * - chown should change file owner/group without affecting ACL entries

Since the doc comment block is exported to the test catalog, chmod
and chown should use the RST manpage role, e.g.
:manpage:`chmod(2)` and :manpage:`chown(2)`.

> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = 2,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.forks_child = 1,

This test never calls SAFE_FORK() or any forking helper. Is
.forks_child = 1 needed here?

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
