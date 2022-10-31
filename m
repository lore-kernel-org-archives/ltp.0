Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CD3FA3742
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 13:17:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56F963CAB0C
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:17:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78C603C0135
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:17:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E4C161000348
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:17:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 297FE1F383
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 13:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667222261;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2cVCC9BuDWm0D4cWRqVt6jmQF7l0mviGtdpVwVxstA8=;
 b=u5DQuhGree28XY/p+bla8sZQNrQNY9r6Iv8lYjyqj2K+QEz4fQHbtZs95L47ZE2PmJBk20
 EEhri/cJ43rj4BG42xZFCHZt6nl9iFs7IxTZG3dsMuZIHFhvb6iOj8abddOU+DeEL/OzNI
 qMRlie/p0hZhM6touLrXLdpsBzsLfXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667222261;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2cVCC9BuDWm0D4cWRqVt6jmQF7l0mviGtdpVwVxstA8=;
 b=Ql9VrjdFN5u1bMPqba4wRmegi/KSPi3piPp8tij7sqyp5qtt6bPanOFPNKJe9VCfmjm59K
 vNc0eMkYBcEDtxCg==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7EEE02C141;
 Mon, 31 Oct 2022 13:17:40 +0000 (UTC)
References: <20221027140954.4094-1-akumar@suse.de>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 31 Oct 2022 13:01:49 +0000
Organization: Linux Private Site
In-reply-to: <20221027140954.4094-1-akumar@suse.de>
Message-ID: <87tu3kb098.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: using -1 as invalid fsuid for
 setfsuid()
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

Avinesh Kumar <akumar@suse.de> writes:

> a uid which does not have an entry in the /etc/passwd
> file is not really an invalid fsuid for setfsuid(), so changing
> the test to use -1 as an invalid fsuid.
> And second setfsuid(-1) call is to verify that preceding call has
> actually failed and there is no change in the fsuid.

I think the original test is flawed and testing what using -1 does is
not very interesting as the kernel uses standard boilerplate to deal
with this.

AFAICT we don't test what happens if a non-root user tries to set the
fsuid to a uid that is not the euid, ruid or saved uid or 0/-1.

Possibly that is something for a new test though.

>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/setfsuid/setfsuid02.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> index 850f17834..f5aa1c004 100644
> --- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> +++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> @@ -21,9 +21,7 @@ static void run(void)
>  	uid_t invalid_uid, current_uid;
>  
>  	current_uid = geteuid();
> -	invalid_uid = 1;
> -	while (getpwuid(invalid_uid))
> -		invalid_uid++;
> +	invalid_uid = -1;
>  
>  	UID16_CHECK(invalid_uid, setfsuid);
>  
> -- 
> 2.38.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
