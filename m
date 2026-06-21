Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8585CD98F2
	for <ltp@archiver.kernel.org>; Sun, 21 Jun 2026 10:08:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAB3B3E2F57
	for <ltp@archiver.kernel.org>; Sun, 21 Jun 2026 12:08:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 589E53C5DEF
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 12:08:04 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F1977600209
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 12:08:03 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-519f9f13b06so17582991cf.0
 for <ltp@lists.linux.it>; Sun, 21 Jun 2026 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782036483; x=1782641283; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GcCCqKS809LTyRPogxTeQeaYDOi3xRJ9bVlWIEfLMKk=;
 b=JZaLs2qezu1OSvE89+BpmIVTZIpGoCH4M+au1KLmT4S8uN/3j8hN9FDrJV5RGWOSsB
 jxkY41AsTMXRwwqV5H8WdxZ8NB79FZK67AVa+IonTnlXz1L2RlpQl7k2svS+qm0x8zH+
 CROBpSeQ7KdcY6F2JDuwPsUxoaYSuA021stSX/Leb27llwXgJvPYex5oIxvyNbCZ8WAi
 vRbfW5UA3trQqOiKvZQA6yXcHqhlyGAbicS1p+BLIo3xRHzS7io/UAhWXu+OUjw2ggDL
 GqkEC8jvq3yZ/HhtZHY7hDBqToDOlzgQvlUZZvU09x9GWcZeyZAtON8XMnGa7EKZMLJO
 YtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782036483; x=1782641283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GcCCqKS809LTyRPogxTeQeaYDOi3xRJ9bVlWIEfLMKk=;
 b=G24GfmI+D3X5o26AobbRI4X57mvvCSzw/P52xdjm84clXvIDsyNxxXd6xeGCW+EOS7
 FzPm1J0GKfeIOvw300XRNPet+xCEg8cV6detqx4x9kLltqwR0NYvW8o40AKfjrR0nh0X
 sWp8GRar9WzwnDSR3mxo6cRZxYriRn1CweTfBeAZ54yFFoMrKUKLyhcawyCIv6C0rCeA
 Xj16YmXetk/jF2dqvoOVvnQQPmhiFlobVR0+RLDvHrIFq6kUqZL0Nw/d5tE6a8g5l60w
 UfpaGegYcgwe2BYGcJoh5g+zO27+0bwcRNZvyc8lpIR/fYsb2QVcH8QfOUkcS60+/ZnC
 4neA==
X-Gm-Message-State: AOJu0Yz//hTW7z44sVgYtBDVaJW9mUYYW64cEjbadWm0avRc3TDEBnf5
 i9yOh0SzR3nAWJGjFk7f/kRlUBgbrCndRqmjNT4vzHi9GksTjiS9TMYD
X-Gm-Gg: AfdE7clMD08a2b4darL3Wh2kep8tcGkLynv/mYSCuqWMuyPxbrdeIPK8ZQE1mpEZxmC
 I+HUxeG+gWY1+orUrIMeCmBI8IiY5b7jQGE+Wmcy3ffG2cLD2oGACN560ASn3kIib/47NZZeGs3
 CV2xJ0poPEEoRLfd+qBhtduZazDQ5vZ+hXbGLg1+izqQXUgmRBWw0bfFbcftZqz8hU2NzebQMwC
 WN4iBwelqbYnvbxdAtrfJz7A3A2XnovXxCsZk0A9GJTNAZe4W6PUUKTylZufXNGTAFynkWXSYd2
 Ru7+XZzo6SUQjbBsAbU/+FQ4H4+PbTnsMne8qOuO7CZTsfHzEjDTiWRVjFdEMSHlslPtX9bwmzw
 By7afm8qFusfi0VhyKOnseod4tWEpX2YPMYHpWvP6vtVZIQ8G0QTYKah5bagE/iQ2Ga66HAa0Rq
 nJvu3ByJqGVH7VBSk8bxvYak41aVmrzuC+996yUhkubNoESHFRQ3dwJdcLLvRAz60ED7ABsN4L9
 p6ZWrIImOx9D7IGj15I4/maE7qatw==
X-Received: by 2002:a05:622a:130b:b0:517:8529:6f29 with SMTP id
 d75a77b69052e-519f0491279mr133164991cf.27.1782036482626; 
 Sun, 21 Jun 2026 03:08:02 -0700 (PDT)
Received: from
 runnervm7b5n9.vuofcnqkcubu3oy5yogz5ckase.bx.internal.cloudapp.net
 ([172.178.118.85]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a091c2601sm39386331cf.2.2026.06.21.03.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 03:08:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Sun, 21 Jun 2026 10:08:01 +0000
Message-ID: <20260621100801.4003-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621090403.2236-1-always.starving0@gmail.com>
References: <20260621090403.2236-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] open: remove O_DIRECTORY case (move to fstat test)
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

Hi Jinseok,

On Sun, 21 Jun 2026 18:03:59 +0900, Jinseok Kim wrote:
> open: remove O_DIRECTORY case (move to fstat test)

--- [PATCH 2/2] ---

> +/*\
> + * Verify that :manpage:`fstat(2)` correctly identifies various
> + * file types.
> + */

The test uses .needs_root = 1 for mknod() to create device nodes, but
the doc comment does not mention why root is required.

> +	switch (tc->exp_type) {
> +	case S_IFREG:
> +		TST_EXP_EXPR(S_ISREG(buf.st_mode));
> +		break;
> +	case S_IFDIR:
> +		TST_EXP_EXPR(S_ISDIR(buf.st_mode));
> +		break;
> +	case S_IFIFO:
> +		TST_EXP_EXPR(S_ISFIFO(buf.st_mode));
> +		break;
> +	case S_IFCHR:
> +		TST_EXP_EXPR(S_ISCHR(buf.st_mode));
> +		break;
> +	case S_IFBLK:
> +		TST_EXP_EXPR(S_ISBLK(buf.st_mode));
> +		break;
> +	}

Each S_IS*() macro is equivalent to (st_mode & S_IFMT) == S_IF*, and
tc->exp_type already holds the expected S_IF* value. Could the whole
switch be replaced with a single check?

  TST_EXP_EXPR((buf.st_mode & S_IFMT) == tc->exp_type,
      "fstat on %s", tc->path);

This would also give more informative output on failure by
identifying the file being tested.

Verdict - Needs revision

Pre-existing issues in open01.c (not introduced by this series):

- static int fd; should be static int fd = -1;
- cleanup() uses if (fd > 0) which should be if (fd != -1)

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
