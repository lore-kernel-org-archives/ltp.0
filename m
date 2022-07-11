Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD712C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 10:09:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B7393CA630
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 12:09:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 480833CA5E4
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 12:09:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8FE1D1A007FE
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 12:08:49 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C83001FF2C;
 Mon, 11 Jul 2022 10:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657534128;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sk1H3/QVE4UBiMLJ3sFsc0ERY2m06gg1veyeAwtqzFs=;
 b=VmyrxqRIIVC/FK9vUgvYvzh1KVdXCgD4JlLMrZME9IzzB9sQ5Uipkox0cBzs+CVimnJo8c
 NLpFiyj/nV1eCNgIU7O7U+OWr3SPnM3Ip1VBOnQar62OS5R9Mxd/9y2J2EoUabJuUjyOo2
 QfFFG5xGgCTM18OU2ofmSAYIW5u7UmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657534128;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sk1H3/QVE4UBiMLJ3sFsc0ERY2m06gg1veyeAwtqzFs=;
 b=3oJA0HHYCaMuNA78//5i4NxyshlwI5wE/LXZ49wl/uhlfmnZOugxW9NU4+jQULsuvGCvh8
 PMzqjdWx85GeIkAA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 866172C142;
 Mon, 11 Jul 2022 10:08:48 +0000 (UTC)
References: <1657190760-2272-1-git-send-email-xuyang2018.jy@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Mon, 11 Jul 2022 11:02:52 +0100
In-reply-to: <1657190760-2272-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <87o7xwneq7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/dirtyc0w: fix typo
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Yang Xu <xuyang2018.jy@fujitsu.com> writes:

> s/dirtyc0w/dirtycow/

I assume it's l33t speak, not a typo. Did the spelling cause a problem?

>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  runtest/cve                                                 | 2 +-
>  runtest/syscalls                                            | 2 +-
>  testcases/kernel/security/dirtyc0w/.gitignore               | 2 --
>  testcases/kernel/security/dirtycow/.gitignore               | 2 ++
>  testcases/kernel/security/{dirtyc0w => dirtycow}/Makefile   | 2 +-
>  .../security/{dirtyc0w/dirtyc0w.c => dirtycow/dirtycow.c}   | 6 +++---
>  .../dirtyc0w_child.c => dirtycow/dirtycow_child.c}          | 0
>  7 files changed, 8 insertions(+), 8 deletions(-)
>  delete mode 100644 testcases/kernel/security/dirtyc0w/.gitignore
>  create mode 100644 testcases/kernel/security/dirtycow/.gitignore
>  rename testcases/kernel/security/{dirtyc0w => dirtycow}/Makefile (86%)
>  rename testcases/kernel/security/{dirtyc0w/dirtyc0w.c => dirtycow/dirtycow.c} (94%)
>  rename testcases/kernel/security/{dirtyc0w/dirtyc0w_child.c => dirtycow/dirtycow_child.c} (100%)
>
> diff --git a/runtest/cve b/runtest/cve
> index 9ab6dc282..3727f58c3 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -9,7 +9,7 @@ cve-2015-7550 keyctl02
>  cve-2016-4470 keyctl01.sh
>  cve-2015-3290 cve-2015-3290
>  cve-2016-4997 setsockopt03
> -cve-2016-5195 dirtyc0w
> +cve-2016-5195 dirtycow
>  cve-2016-7042 cve-2016-7042
>  cve-2016-7117 cve-2016-7117
>  cve-2016-8655 setsockopt06
> diff --git a/runtest/syscalls b/runtest/syscalls
> index efef18136..111ef6f90 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1034,7 +1034,7 @@ process_vm_writev01 process_vm01 -w
>  process_vm_writev02 process_vm_writev02
>  
>  prot_hsymlinks prot_hsymlinks
> -dirtyc0w dirtyc0w
> +dirtycow dirtycow
>  dirtypipe dirtypipe
>  
>  pselect01 pselect01
> diff --git a/testcases/kernel/security/dirtyc0w/.gitignore b/testcases/kernel/security/dirtyc0w/.gitignore
> deleted file mode 100644
> index 7700d91a3..000000000
> --- a/testcases/kernel/security/dirtyc0w/.gitignore
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -dirtyc0w
> -dirtyc0w_child
> diff --git a/testcases/kernel/security/dirtycow/.gitignore b/testcases/kernel/security/dirtycow/.gitignore
> new file mode 100644
> index 000000000..ad36ce53c
> --- /dev/null
> +++ b/testcases/kernel/security/dirtycow/.gitignore
> @@ -0,0 +1,2 @@
> +dirtycow
> +dirtycow_child
> diff --git a/testcases/kernel/security/dirtyc0w/Makefile b/testcases/kernel/security/dirtycow/Makefile
> similarity index 86%
> rename from testcases/kernel/security/dirtyc0w/Makefile
> rename to testcases/kernel/security/dirtycow/Makefile
> index bf26d9eb6..07759a0e3 100644
> --- a/testcases/kernel/security/dirtyc0w/Makefile
> +++ b/testcases/kernel/security/dirtycow/Makefile
> @@ -4,5 +4,5 @@
>  top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
> -dirtyc0w_child: CFLAGS+=-pthread
> +dirtycow_child: CFLAGS+=-pthread
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtycow/dirtycow.c
> similarity index 94%
> rename from testcases/kernel/security/dirtyc0w/dirtyc0w.c
> rename to testcases/kernel/security/dirtycow/dirtycow.c
> index 7924285a7..881e376c5 100644
> --- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
> +++ b/testcases/kernel/security/dirtycow/dirtycow.c
> @@ -55,7 +55,7 @@ static void setup(void)
>  	nobody_gid = pw->pw_gid;
>  }
>  
> -void dirtyc0w_test(void)
> +void dirtycow_test(void)
>  {
>  	int i, fd, pid, fail = 0;
>  	char c;
> @@ -70,7 +70,7 @@ void dirtyc0w_test(void)
>  	if (!pid) {
>  		SAFE_SETGID(nobody_gid);
>  		SAFE_SETUID(nobody_uid);
> -		SAFE_EXECLP("dirtyc0w_child", "dirtyc0w_child", NULL);
> +		SAFE_EXECLP("dirtycow_child", "dirtycow_child", NULL);
>  	}
>  
>  	TST_CHECKPOINT_WAIT(0);
> @@ -100,7 +100,7 @@ static struct tst_test test = {
>  	.forks_child = 1,
>  	.needs_root = 1,
>  	.setup = setup,
> -	.test_all = dirtyc0w_test,
> +	.test_all = dirtycow_test,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "4ceb5db9757a"},
>  		{"linux-git", "19be0eaffa3a"},
> diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c b/testcases/kernel/security/dirtycow/dirtycow_child.c
> similarity index 100%
> rename from testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
> rename to testcases/kernel/security/dirtycow/dirtycow_child.c
> -- 
> 2.27.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
