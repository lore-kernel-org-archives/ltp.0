Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E1FC54F4C
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 12:58:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79B3E3D0E80
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 14:58:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51CB03D0E80
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 14:58:19 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A99001A00430
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 14:58:18 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92e51e6879fso246780785a.1
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 05:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785243497; x=1785848297; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f5bmNimw9tkIx6j6bvA+R6/osqxFoXnOSJsChStJBLI=;
 b=BVFFcLF1Z9cgy9Woct+KA5ztSvn2Tdj6CFipZQfkLx26ev3QXSKUu0cjm6zfauUrhk
 wKBKi0dFyV4fT5otHKz5yG+AZ+GbnWRa8fNcTcmo/oWvIRHJP4AJn8GfwMiO+i0JL/W9
 8jCdN3+CnChQi71BdLt0I010H2SNF3dtfs99BZiau8YXujBue1c8MqBTdZvkMBSwLRe5
 wqhjj8rVz2P/czW3eEZU99Clgj3COxKJFXQtTzWnd8+pMBW+/7UJRIpxxf3E0jrGSvX5
 PosGsTEp2lps6KECcfE35A7ZPlxLRwq9zHzQUjuleG6rIAuBGiS6e3EEaFs+KUEvoX3C
 k7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785243497; x=1785848297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f5bmNimw9tkIx6j6bvA+R6/osqxFoXnOSJsChStJBLI=;
 b=W9gwUf1D0jKmH246m2zxLC8L3sJFnAE/g3eoRB+2WzPJZpRoOpN5k1LHI4Z6G4Se4x
 2A2P5uk6nXGwDmZHIe8IVeM5v2c/0rxQBIYCkkXpLwOAX+qkfAsxCN5IBLwPDZbmOB9K
 jICT8fL2IPB30UXl4Xc9XwqkucWKFS77XkO5aPg6As6YpU8/wmsLFnywHa5+4KPPiIsw
 C3GBsxHoNMROpToO+Pbktr+g3eFsOqdp6Tc83Hb5XPoYBCAFiY1zD2wHgGH1oOITbNNH
 6tyxorycZhpmYwIIRunh3JYap0FnxIJ8xEFc9dYS84TeTBMOyqugLceWjbMNUPDtp6A6
 98ag==
X-Gm-Message-State: AOJu0Yw9/IdpqzVrQzXqPteM+0vWstL1jHCOzRDbeef2ZpEt5GkTDk5Q
 HYNfkDVqAxMpDutXGtOXBpYyfJccTWsOByfwPMrVGRDBah/xgPyjMnhu
X-Gm-Gg: AR+sD12uz8x4/GFBX/rE+auTz6HgEW2oMlE9FKJHaU5dG6COWFCxm1lONJOguEyaPcl
 CCmGt9tihg4JkjzCPjpK7mUB3bNDi/1fN+MMRT5PaCG/5whom5BroNurt672ZLkdIg2Ymc6NGJG
 +EAE++F3n9jRURH0iKH15AP52X6G3YZxKLV9jSREr+AuUwgZKjiktShfKd72KPPBD02CHfvkblJ
 yAajPDbkQ8qK6oGS4oqtSyQvG/5l+By1NM5MDg6ApnsnGK8BcYA5p4S0cMZh0HgozVAuIQlJadk
 nfDij+5cAqBuAice1dHX6FEL/0szG32PEd1Gf4HqvPoChUgfoPsHhEYWkWm1ess1vADugvyfAAw
 dZuE15rpEFT90JqmOMY/dSpag5tDQti+jc+CTxAmkDSs7UpXedbvWOU0tj14O0+YZamwWzRC5S4
 pB1RRNfoQbGw0mZord2FBZ7BL494QpE7CtlEqIaBXc3xY8xnlNwP68EFC0GuXXRgMfKYtnsoD5E
 0MdOtYhbBdfltgPOA==
X-Received: by 2002:a05:620a:3726:b0:92e:e252:bb43 with SMTP id
 af79cd13be357-93302716fc2mr180930385a.77.1785243496897; 
 Tue, 28 Jul 2026 05:58:16 -0700 (PDT)
Received: from
 runnervmvrwv9.rbvbdlov45kutln3wjst01zbxa.bx.internal.cloudapp.net
 ([20.62.254.162]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de655676sm853386085a.37.2026.07.28.05.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:58:16 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Jul 2026 12:58:15 +0000
Message-ID: <20260728125815.4069-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728114224.1055009-1-pvorel@suse.cz>
References: <20260728114224.1055009-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_setup.sh: Fix check_policy_writable() for kernel < 4.5
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

Hi Petr,

On Tue, Jul 28, 2026 at 01:42:24PM +0200, Petr Vorel wrote:
> ima_setup.sh: Fix check_policy_writable() for kernel < 4.5

> -	# workaround for kernels < v4.18 without fix
> +
> +	# Workaround for kernels < v4.18 without fix
>  	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
> -	echo "" 2> log > $IMA_POLICY
> -	grep -q "Device or resource busy" log && return 1
> +	# Require >= 4.5 to write multiple times via CONFIG_IMA_WRITE_POLICY
> +	# 38d859f991f3 ("IMA: policy can now be updated multiple times")

Is CONFIG_IMA_WRITE_POLICY really the reason for the 4.5 boundary here?

On >= 4.5 ima_release_policy() runs ima_check_policy(), which returns
-EINVAL when ima_temp_rules is empty. The empty write therefore sets
valid_policy = 0, ima_delete_rules() is called and IMA_FS_BUSY is
cleared, so the probe stays non-destructive even when
CONFIG_IMA_WRITE_POLICY=n.

What makes < 4.5 different is the absence of ima_check_policy(): there
the empty write is committed and securityfs_remove() drops the policy
file. Would it be clearer to state that, and to keep the v4.18
permission workaround in a separate paragraph, since the two comments
describe unrelated things?

> +	if tst_kvcmp -ge 4.5; then
> +		echo "" 2> log > $IMA_POLICY
> +		grep -q "Device or resource busy" log && return 1
> +	fi
>  	return 0

With this, require_policy_writable() no longer TCONFs on < 4.5, so
ima_policy.sh test2 ("verify that policy file is not opened concurrently
and able to loaded multiple times") now runs there.

On those kernels one loader gets -EBUSY at open, the other succeeds and
the policy file is then removed on release. That hits

	elif [ $rc1 -eq 0 ] || [ $rc2 -eq 0 ]; then
		tst_res TPASS "policy was loaded just by one process and able to loaded multiple times"

so the test reports that the policy can be loaded multiple times while
only the concurrency half of the assertion was exercised, and loading
twice is not possible before 4.5.

Should test2 report TCONF (or split the two assertions) when
CONFIG_IMA_WRITE_POLICY is not available?

Verdict - Needs revision

Pre-existing issues, not introduced by this patch:

- "log" is created in the test working directory by
  check_policy_writable() and load_ima_policy() and is never removed.

- $IMA_POLICY is expanded unquoted throughout ima_setup.sh.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
