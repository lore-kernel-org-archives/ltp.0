Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48BBC79F80
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 07:53:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D8A43E935F
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:53:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6D0B3E1CFD
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:52:44 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 62C5A200DDC
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:52:44 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 af79cd13be357-930f7b1eb68so51243685a.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 00:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788508363; x=1789113163; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hfyUTv6VvEZm32P65EVGsKkJKsKciIFJtGGDfk2YGWU=;
 b=Uq4aR/KzJJff4+j0DKi9qquII2dkU50o265O6qVVxhvV8Ii4coOBoPLeJZWh9UFaVd
 W6sJ+wF8WonhmegZ9EyqCwv4pprr4u8d6U27FKEeQyrFCy9qd7oqSIWQmUW2sjLx7Q+C
 SeHAhiqY+WXDkfFjr63LSP4RzgUvQnxF8WedpCIb0YbTOFHAOOfqnJAUrxca4yqcmQfw
 KZA8edXzZ9Re7UkM6Yw/mSD9qe/v4MFYcqmWvitLXsY4iWun3K2oNUoBpajfpkzMw6ep
 NoM4o94ns1/Ho+PaRNA1LO5q2JQJ+AyMZ9iIngxTavoIphX+PzYWAGr/ibY6gT78hEpX
 Ypew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788508363; x=1789113163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hfyUTv6VvEZm32P65EVGsKkJKsKciIFJtGGDfk2YGWU=;
 b=ozKqmWnreky8sFsADWwPbMc9j4nrkE6zhmXUplYDx++V1qe+c45rW5PEoyUE09RQl0
 3JYEcq9N3KhCoH6L1TWCLPD06WXVfv9yaPawR4uwFm2YBwPGHAC9yQ24jSwcMHA9A529
 mu0fsQ+nkfVMkR91OT02qkeQ8USgDa6W8GrvfsFNKVdfPtegE4KW3vbfwMX+u7ftMe01
 n4FoVJ15GUUYDJ51FH4Cdxz5PKV5lsPCGrKnHN5ZJCUvdWSbTmY85G27B6BjXoDdBGtp
 x+4Xq1nIfWj6TqrDZMKsw71HR/dD6/c5uAeUMEwzdEzBqlcxb859oBJaMGsTsKZFH4ic
 s6yQ==
X-Gm-Message-State: AFuF++lKanIfNYizGz+oDoSi6DYoWWv+PgTi6+khQeIqud1m5hr30eJg
 HJWlFXY1L+6aCZBnnDPWgm4V+jENhlwceAYtXuXxz+MmbD2BxdfWhjgX
X-Gm-Gg: AYBFou3p9pImkfUmgU6ZI2BO3I9JQDY7bp91xGwsEyQDAT7AbJf0QOyTFjB0nfU7kCw
 LFOtpzET4mw3inzdMI2ro81gZ9ypKtGcPkFb1eUyW7YaVbaF3ZhG3yxIk7BEZ4IkG6yAs8hxI4q
 9vRBPlc1CPb8qRk8wuu/avSv4ImjJdAEVSK3bQMPYW/qYLeI4xqK1zoU0X9XpMpK0Pdf1hyB4V+
 jAozZmQZ3IWMp9CMFpsV13DvCWin0epzSfF+6KiJ6Wrha1I2fMIGdFcotFt28R9C2ja+T4ZfVwY
 u/Yii0YKX2i3Xj84Aow3r6i48Q8/HrDSthR8DTtxSXdKF9QaEqu3CBNEXysIotoBGA6fChR6MuM
 bOUZMBh6wa+Xo+UA+B4A932I9drT49QL/G+AIhbkPkzcMNoORdC45daAJNVK58a3PJ3aI2M2VfT
 H5CJW+kLhU1/iR55UKcuV9ybudstOMwpDsTDBC9MAs9z+hyYOiWmDNRIDlUm5EzAKgMedrLNQej
 92v8uO/FSGwKgF3IvcdES0zUnydy/6pRJEPmffbq1/KdSPKn8ARVfs4ChEAcyK2HB9HxpHDhYbX
 qPy25HjlYio=
X-Received: by 2002:a05:620a:3943:b0:937:1097:feb8 with SMTP id
 af79cd13be357-93980426539mr412177385a.24.1788508363127; 
 Fri, 04 Sep 2026 00:52:43 -0700 (PDT)
Received: from
 runnervmejwal.5im3poowmk4e3it2xdho1gde0e.cx.internal.cloudapp.net
 ([20.109.86.227]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93985cffb3dsm68419385a.18.2026.09.04.00.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:52:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri,  4 Sep 2026 07:52:42 +0000
Message-ID: <20260904075242.9160-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-coredump-v6-1-b8e3947cc646@suse.com>
References: <20260904-coredump-v6-1-b8e3947cc646@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] coredump01: New core_pattern specifiers test
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

On Fri, Sep 4, 2026 at 09:15, Andrea Cervesato wrote:
> coredump01: New core_pattern specifiers test

--- [PATCH 2/2] ---

> Verify that a kernel-generated core dump contains a valid ELF header,
> expected program headers (PT_NOTE and PT_LOAD), and valid process
> metadata notes (NT_PRPSINFO and NT_PRSTATUS).

The commit message only restates what the test verifies. Please explain why
this coverage is needed or what problem it addresses.

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
