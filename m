Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF63C00144
	for <ltp@archiver.kernel.org>; Fri, 29 Jul 2022 14:43:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D539E3C8D38
	for <ltp@archiver.kernel.org>; Fri, 29 Jul 2022 16:43:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 047D13C8625
 for <ltp@lists.linux.it>; Fri, 29 Jul 2022 16:43:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 22A2B200FEC
 for <ltp@lists.linux.it>; Fri, 29 Jul 2022 16:43:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E54E834BB9;
 Fri, 29 Jul 2022 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659105801;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7IQE/W1PJiFqIHeHJfg0JTmRXauT99nRtTLntMiAbNM=;
 b=KRw9rGvOLbqo7fQ5JwxYbuO9ln5838FuNerlgY3J1e5kXL6s4v+2kBzoscrkhXHVtPxXjn
 9U82AveHsFhAPc2hE1+UHqpu0JcjNbmxKkgpr9/llJc0KxRrjVTlZBXKf+DQ/scrdX2Qwv
 vfljra0te3Oghu34E1F+lRFMbF+KcMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659105801;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7IQE/W1PJiFqIHeHJfg0JTmRXauT99nRtTLntMiAbNM=;
 b=L0jQ/kfiFPRHgLuEElJjq5aQnNhff4lVarM2xJOK3kG5p/+A4X+e5riz8jd9DSu6RniaL/
 0U6n2canebZxvhDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF0A913A1B;
 Fri, 29 Jul 2022 14:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Z5pKKAny42IRbAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Jul 2022 14:43:21 +0000
Date: Fri, 29 Jul 2022 16:43:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
Message-ID: <YuPyB1Vr3Yps37yX@pevik>
References: <20220722083529.209-1-chenhx.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220722083529.209-1-chenhx.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] resource_files: inline resource file for readable
 doc
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Chen, Cyril,

> Currently from resource_files section of metadata doc, we usually get:

> .resource_files  TEST_APP

> or

> .resource_files  resource_files

> which do not help much.

> This patch will inline reource file with its real name.

> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Suggested-by: Petr Vorel <pvorel@suse.cz>

:).

> ---
>  testcases/kernel/containers/userns/userns06.c     |  2 +-
>  testcases/kernel/syscalls/creat/creat07.c         | 10 ++++------
>  testcases/kernel/syscalls/execve/execve02.c       | 10 ++++------
>  testcases/kernel/syscalls/execve/execve04.c       | 10 ++++------
>  testcases/kernel/syscalls/execve/execve05.c       | 10 ++++------
>  testcases/kernel/syscalls/execveat/execveat01.c   | 10 ++++------
>  testcases/kernel/syscalls/execveat/execveat02.c   | 10 ++++------
>  testcases/kernel/syscalls/execveat/execveat03.c   | 10 ++++------
>  testcases/kernel/syscalls/fanotify/fanotify03.c   | 10 ++++------
>  testcases/kernel/syscalls/fanotify/fanotify10.c   | 10 ++++------
>  testcases/kernel/syscalls/fanotify/fanotify12.c   | 10 ++++------
>  testcases/kernel/syscalls/getrusage/getrusage03.c | 10 ++++------
>  testcases/kernel/syscalls/pipe2/pipe2_02.c        | 10 ++++------
>  testcases/kernel/syscalls/prctl/prctl06.c         | 10 ++++------
>  14 files changed, 53 insertions(+), 79 deletions(-)

> diff --git a/testcases/kernel/containers/userns/userns06.c b/testcases/kernel/containers/userns/userns06.c
> index 002c72907..9e900d94b 100644
> --- a/testcases/kernel/containers/userns/userns06.c
> +++ b/testcases/kernel/containers/userns/userns06.c
> @@ -122,7 +122,7 @@ static struct tst_test test = {
>  	.needs_root = 1,
>  	.needs_checkpoints = 1,
>  	.resource_files = (const char *[]) {
> -		TEST_APP,
> +		"userns06_capcheck",
>  		NULL,
Hardcode binary name when there is TESTBIN is no-go => I'd be for rejecting
this.

@metan: what bothers me is that even adding a test directory as include does not
help (yes, path relative to src root is correct):

$ ./metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ -Itestcases/kernel/containers/userns/ ../testcases/kernel/containers/userns/userns06.c

I'd expect 36d6d745c ("docparse: Implement #define and #include") would fix
this. What am I missing?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
