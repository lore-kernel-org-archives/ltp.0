Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DF7C5DF86
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 19:35:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 584E23CE52A
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 21:35:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B53673C062E
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 21:35:18 +0200 (CEST)
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com
 [IPv6:2607:f8b0:4864:39::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4865A1400043
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 21:35:18 +0200 (CEST)
Received: by mail-pj2-x08.google.com with SMTP id
 98e67ed59e1d1-392c6555df6so92800a91.0
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787254516; x=1787859316; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qb4ouOpC5ohCUBIu2jeNUxdUjEdZb1vgZVsqrZKQ9mw=;
 b=h5FI10pTqPWm6WsMDlZ/VV1+PgySamO9wlqiizuy/7PrGirIThdnHdE6TtKnmlwIwL
 VZrmFuS7vOVVhOfoHuv8Eh6ZMNl54ZnihTOJdXyl0QfIGFJG9Tliomw3NchGH1me+84/
 ToRmlj5Hg0mqgGW9f73tB2wFwQ7+A2u62r5vR1QKMSSWBGO4TVuQl5VykWtkaaHOf+w5
 Sc5ktaoViavUJtxdBvgNHohQa/DTXSB8sTx0TpnCsWxA21ddgf4AT5EDuNDMXmQREVXd
 lwcJYkZDNXV9cYtd7m+ov7hJtP8IjvjoMxc6K3D8JgRCsJF7mZDqeqO43D+5BEgLuR5+
 vqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787254516; x=1787859316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qb4ouOpC5ohCUBIu2jeNUxdUjEdZb1vgZVsqrZKQ9mw=;
 b=aLTtYT2JC0S6NmlZBEWsMk7ws85XneaCmEVHm0Je6CkXYvFSwaSjviSt5GQyi6wbJu
 KqNCQRAJJ7JUdpz2D4R3Na3DyZkDvRFAETowa3mtayk1DQsTabU5AmEZi0TPedRk4MX1
 dS5Xvy8eH6+7GVX6C71kg3/1uW5f9A+bcU9Jj+UaJcSyiL7HoFVFAfslWDLDuM8R5bQW
 eQZ3czFZtBGhUq2VSloxh0b5fPOWY/fki653ccn998fUWGRdvT4+7nx5b2nlopfoxorT
 GHgRD0cwNLBCYPs/fdX8d5kChDcLO4W3qn7FPdUw1W1yCamXsXm4Eqzg2JBMOVRGAa2P
 LWMQ==
X-Gm-Message-State: AFuF++l2W1GSUovc/FAipiPgFGqlZdmHfJTxtYfOINL760haew2reqjA
 leOpgcJGzbH7JTEv+JTvZpiffxZX2mvvdoFRF5YKYvcMrOa1P9mvT5MV
X-Gm-Gg: AR+sD12Q3NjYgfskUhzZVLP0vFcF/IwT2t+4zuPMJVzjeRnpFSKBMgTfZLUq3+ifYWl
 oVfbTOfk2QbvSrXg8WwetM2oexkxUnsyIxkjDaO32TJOQVihMjHdpozydrMqzW5r/n8fGb2ykcH
 RiDFHBS4a9HRuSnIy6ndKlTAq+cIN0t15bL0y4o6hyEOcOXkCmmLb/zfw9KhXOwCWwE9xk0Mlc5
 XvOTvCH0vMyXjv75nuckhOcR+5ttRYgxJbGBUwiKmFmmB13bR4T+pyCkY0DPv8IeugI2QqdAMJE
 5EsigkXAUFgYir2PblDGPbijOdw6VX7esfBtCSeRm9jBIg0w+PoDYppbldAQrwM0VwToh4Fj/hi
 VrU4Zo4OuBV4Ut8vW7heZAZwlN/Qcx5e7/FLFjnJFgJtZBY4nn1Jb2HyPM3tWtgcfFpZCDuvF1X
 O0achqY87GToFmko9DA987TeGFFXBP+9KBAQulcufk9kdEi/4pHJdIYV4q8pXitFi6xvjBrx+Bs
 blw3+cIlhJIDpBXNH5xamuARqG+sbQAE4osgel1iRNZi/0D+S+rH4ChZ18oU4LNp7as1udoK2c=
X-Received: by 2002:a17:90b:288a:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-395c3719f99mr1377695a91.13.1787254516485; 
 Thu, 20 Aug 2026 12:35:16 -0700 (PDT)
Received: from
 runnervm76f27.hqvb1w5sullexdfu0h25jepama.yx.internal.cloudapp.net
 ([52.161.50.37]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae143edsm36103824c88.10.2026.08.20.12.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 12:35:16 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 19:35:14 +0000
Message-ID: <20260820193514.9107-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820-coredump-v1-1-7ce51603cefb@suse.com>
References: <20260820-coredump-v1-1-7ce51603cefb@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

On Aug 20, 2026, Andrea Cervesato wrote:
> coredump01: New core_pattern specifiers test

> 	ssize_t rval, i;
> 	int fd, elf;
>
> 	if (bytes >= 4 && !memcmp(magic, "\177ELF", 4))
> 		elf = 1;
>
> 	dprintf(fd, "exe=%s pid=%s sig=%s bytes=%lld elf=%d\n",
> 		argv[1], argv[2], argv[3], bytes, elf);

Could `elf` be initialized to zero? For short or non-ELF input the
condition does not assign it, so `dprintf()` reads an indeterminate value.
A nonzero value can make the test accept a malformed core stream as ELF.

> 	SAFE_PRCTL(PR_GET_DUMPABLE, 1, 0, 0, 0);

Should this use `PR_SET_DUMPABLE`? `PR_GET_DUMPABLE` only returns the
current state and ignores arg2, so this call does not ensure that
`abort()` can produce a core dump.

> 	/* the kernel spawns the helper asynchronously */
> 	if (TST_RETRY_FN_EXP_BACKOFF(access(res, F_OK), TST_RETVAL_EQ0, HELPER_TIMEOUT)) {
> 		tst_res(TFAIL, "%s did not report any core dump", HELPER);

Could kernels with `CONFIG_STATIC_USERMODEHELPER` be rejected with TCONF
before this check? In particular, an empty
`CONFIG_STATIC_USERMODEHELPER_PATH` intentionally disables the helper, so
this timeout reports TFAIL without testing specifier expansion.

> 	set_pattern("|%s/%s %%e %%p %%s %s/res.%%p", helper_dir, HELPER, cwd);
>
> 	len = SAFE_READLINK("/proc/self/exe", helper_dir, sizeof(helper_dir) - 1);

Could the pipe case require the initial mount namespace, or otherwise use
paths visible there? The kernel resolves and runs a `core_pattern` pipe
handler in the initial mount namespace. If LTP runs in another mount
namespace, these helper and result paths may not exist there, producing a
spurious TFAIL.

> /*
>  * Core dump collector for the piped core_pattern tested by coredump01.
>  *
>  * Avoiding the LTP API here is correct, since the kernel spawns the helper
>  * through ``call_usermodehelper()`` without the LTP IPC environment.
>  */
>
> int main(int argc, char *argv[])

Could this helper follow the LTP helper-binary convention by defining
`TST_NO_DEFAULT_MAIN` and including `tst_test.h`? The missing IPC
environment means it should avoid IPC-backed result calls, but does not
require avoiding the helper API form itself.

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
