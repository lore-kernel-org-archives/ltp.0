Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37F8C5DF81
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 07:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787556189; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=/qUS4KCl8pV9QNOCWfxh5TfSaG/Ljzq4fgENrRXajeE=;
 b=KDwnYUzcN2ShHDMycjh5LfREEcBPOvpMNecEgOvBWslryJqP/pQ1AXePLVVcpqz4oyxRk
 OOggamhxQg3pUkeOnl/mAGPdRwmStnPsTQNRiNDLuKW4kxOhlL/E6V46Q+yvsargWhvJcsV
 4iX5Aw9/a9yuhO//1gjOku5DGUYC8QY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7905A3D03E6
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 09:23:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA7693C7B15
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 09:22:50 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 019EF20032C
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 09:22:49 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a3fda88184so4803131a12.3
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 00:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787556169; x=1788160969; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/wFnQeXkeOjzS4ziVVmqqDK5Ob/I+8rnN4etfHgc+GQ=;
 b=fKenW9VdayFMXwWiWFYK1PsjBXckkLUWSZUJ3xEPxmrYxO0XghhY+t5CZt5vbTUhwG
 +AT87PYOTnJHs/xegNM0Q+mNptEqCLn9TNK3TcvlyOJFD7rlLNKf/xYR5ma3pAVYKd3N
 iVvrUVRfIj/iyHMyHHrIMWNvmEQojQyEZKHe+uafCL0H7zrAEzs6dZ2m4UcHXn1Fg4MR
 VI0GsfLU9BYeSye7HPIqsOuisW21aIssAQL+GENQfoHbKlp9DFW11Oou+nJaLjTWtQqX
 ikPgd0Fr9fGjdTbIq9jqZv3HyQf3UYUxk4CzFK9mUxbImD+r1ReyHm22b/neF/JbIhOs
 71SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787556169; x=1788160969;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/wFnQeXkeOjzS4ziVVmqqDK5Ob/I+8rnN4etfHgc+GQ=;
 b=bA4KtIbOmSkF1NCsiDfbIN6HOxcWaG4YSgVIuTNcAGSrwxE+V2A8jPHdTsORgpNVJd
 lN0XcjPt7usS4ZpZC/+lqC/SDgyoShQceuxKnegbyBZzDgPS92YWKWfqlckwM/tbR1G3
 j6sgx8J4ep6Nj3Cgx36j0KFaYh0VB1z1u2xQHLgbb/GPz5AyZbqvTCcVZm1H4tpzFKlh
 8OPASNrayfYAVvglsbpBvDPKq/43pCxCe8a2j4u1aI3pyEgyc8dqf2TMXd5+/qP/Pw49
 cKd6AbRUPcEnM9/byuuo3ScWKG2X3ZqqzUmbJU71xQ1lgj4jGsqIxfM/uJ0CugL9NVRU
 yPQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RriKsp5spqUjxjSRPGeXlw2DXjqOLKd8C2gYwTCwRxNozKYCzUSuk/yrST88EZP8g+MOME=@lists.linux.it
X-Gm-Message-State: AFuF++ny7pfh5nNIB1yPZSLqHEBOlfQbtim28S7Y8NJiSDv3lt03483B
 IZ/BySmHuA4TfHNjHVm6sFlEzbFK/9hoeQoPtdv4IlbgxOKOYd2tOde0xBQxIW4RUYw=
X-Gm-Gg: AR+sD11vKhMlC0XG+rIa4yaGRnkN2AlFtMgYyVAzdImknqlfCo1CKEiuLsMKf5AC+a+
 DjtJTsGhIm7BlKLD6LjpMYHI7fZX76YAmLwQmsJvALNdOXvEfozwvLgVWo/fz5g0p4J6c1a+UOc
 fnd0VwSWqHNnwN1rTVbcOM7ZIkrkj3t84TX7VdO57QwgMC+fnB/rGhLUUUI0hTEhaA3kqlN/wQ1
 m8gEyxdYzN9Ql0V+XuiLBphcv2a19R8EIBh6Zv8nez738E3CtvhPG4zn83BhAzNtr/MPDOengud
 +JXTfhBzyGdQgzyYXvvzAASYHQoWEjWHtTtv6gU5ke8krvb17zFdbUV7cH/HxmnFO6LWuepet4W
 ouXj1TcXRn+jv5bWcnl9JkGbPrhct4EG8dd7y/6fry6j7biY3wbO2opnlABl+5MOIkvdZGKMwy7
 SC5YsKBXCo22a7hBqhSdhcVtJjUCZcVrJALNQZDWAkWdDQ6Y0yG7Oz+jIsl8sBjJgb4WRQdGBfw
 v8l9BmxtiyKWDiIJa+8JIzCF9AxyjaUCJpEEoLiqNA4BkPlt0D4uFFthqeAc+LFAYjjh0E=
X-Received: by 2002:a05:6402:3805:b0:6a1:1bea:8ea0 with SMTP id
 4fb4d7f45d1cf-6a42f0f7634mr29922021a12.3.1787556169252; 
 Mon, 24 Aug 2026 00:22:49 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59dd550bcsm7868038a12.0.2026.08.24.00.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 00:22:48 -0700 (PDT)
Message-ID: <6a8bf148.5551098a.2071c9.be8d@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260820193514.9107-1-linuxtestproject.agent@gmail.com>
Date: Mon, 24 Aug 2026 07:22:48 +0000
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > 	ssize_t rval, i;
> > 	int fd, elf;
> >
> > 	if (bytes >= 4 && !memcmp(magic, "\177ELF", 4))
> > 		elf = 1;
> >
> > 	dprintf(fd, "exe=%s pid=%s sig=%s bytes=%lld elf=%d\n",
> > 		argv[1], argv[2], argv[3], bytes, elf);
> 
> Could `elf` be initialized to zero? For short or non-ELF input the
> condition does not assign it, so `dprintf()` reads an indeterminate value.
> A nonzero value can make the test accept a malformed core stream as ELF.

This can be fixed.

> 
> > 	SAFE_PRCTL(PR_GET_DUMPABLE, 1, 0, 0, 0);
> 
> Should this use `PR_SET_DUMPABLE`? `PR_GET_DUMPABLE` only returns the
> current state and ignores arg2, so this call does not ensure that
> `abort()` can produce a core dump.
> 
> > 	/* the kernel spawns the helper asynchronously */
> > 	if (TST_RETRY_FN_EXP_BACKOFF(access(res, F_OK), TST_RETVAL_EQ0, HELPER_TIMEOUT)) {
> > 		tst_res(TFAIL, "%s did not report any core dump", HELPER);
> 
> Could kernels with `CONFIG_STATIC_USERMODEHELPER` be rejected with TCONF
> before this check? In particular, an empty
> `CONFIG_STATIC_USERMODEHELPER_PATH` intentionally disables the helper, so
> this timeout reports TFAIL without testing specifier expansion.

This can be added in needs_kconfig.

> 
> > 	set_pattern("|%s/%s %%e %%p %%s %s/res.%%p", helper_dir, HELPER, cwd);
> >
> > 	len = SAFE_READLINK("/proc/self/exe", helper_dir, sizeof(helper_dir) - 1);
> 
> Could the pipe case require the initial mount namespace, or otherwise use
> paths visible there? The kernel resolves and runs a `core_pattern` pipe
> handler in the initial mount namespace. If LTP runs in another mount
> namespace, these helper and result paths may not exist there, producing a
> spurious TFAIL.
> 
> > /*
> >  * Core dump collector for the piped core_pattern tested by coredump01.
> >  *
> >  * Avoiding the LTP API here is correct, since the kernel spawns the helper
> >  * through ``call_usermodehelper()`` without the LTP IPC environment.
> >  */
> >
> > int main(int argc, char *argv[])
> 
> Could this helper follow the LTP helper-binary convention by defining
> `TST_NO_DEFAULT_MAIN` and including `tst_test.h`? The missing IPC
> environment means it should avoid IPC-backed result calls, but does not
> require avoiding the helper API form itself.

It doesn't make any sense. We can skip this one.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
