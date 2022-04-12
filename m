Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C71C433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 11:55:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE2133CA554
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 13:55:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B29493C5785
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 13:55:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F227760076C
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 13:55:19 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3045121608;
 Tue, 12 Apr 2022 11:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649764519;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6+R7ZJK7VT0vRiiemucD27qF7f3Wnse5YrgHO6UMSxc=;
 b=fSfbPhp5f0MbTbZLCO+nf+coE4E5lgfT71Abj0+14kkk6WNV8ER/9jatuu0FBNZUlzVlda
 DWrJ00j0JtL43729GZFMlB1+x0O4IxzAsfpJ4hd0h4GwXJ5HpNJ9Bk1W5Je89m2L0r2eqs
 WS9hNq45K3dBusTVYLNtslNXV7orZJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649764519;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6+R7ZJK7VT0vRiiemucD27qF7f3Wnse5YrgHO6UMSxc=;
 b=ddMuAWOZfyYjm2vphllrDJvAk50B/OjOwl3HnfdnwZN9QA2siblLz1IW4SEDZgy85Jr6G3
 cplRFPd2MJZwc7Bg==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 01388A3CBD;
 Tue, 12 Apr 2022 11:55:18 +0000 (UTC)
References: <20220408091733.15323-1-zhaogongyi@huawei.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Tue, 12 Apr 2022 12:53:30 +0100
In-reply-to: <20220408091733.15323-1-zhaogongyi@huawei.com>
Message-ID: <87h76yzfbt.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] futex_waitv01: Add test verifies EINVAL for
 invalid nr_futexes
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

Hello Zhao,

Zhao Gongyi via ltp <ltp@lists.linux.it> writes:

> Add test verifies EINVAL for invalid nr_futexes according to
> https://www.kernel.org/doc/html/latest/userspace-api/futex2.html.
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
> v1->v2: Check also lower bound that suggested by Andrea Cervesato
>
>  testcases/kernel/syscalls/futex/futex_waitv01.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
> index 601fee8df..721852750 100644
> --- a/testcases/kernel/syscalls/futex/futex_waitv01.c
> +++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
> @@ -98,6 +98,19 @@ static void test_invalid_clockid(void)
>  		     "futex_waitv invalid clockid");
>  }
>
> +static void test_invalid_nr_futex(void)
> +{
> +	struct timespec to;

Space required here (run `make check-<test_name>`).

Pushed with correction, thanks!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
