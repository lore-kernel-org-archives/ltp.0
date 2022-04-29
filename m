Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6E1C433EF
	for <ltp@archiver.kernel.org>; Fri, 29 Apr 2022 16:06:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B71B3CA77D
	for <ltp@archiver.kernel.org>; Fri, 29 Apr 2022 18:06:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6086D3C8972
 for <ltp@lists.linux.it>; Fri, 29 Apr 2022 18:05:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 77A1D1000A50
 for <ltp@lists.linux.it>; Fri, 29 Apr 2022 18:05:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33288210DF;
 Fri, 29 Apr 2022 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651248348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYlQ00pa3l1UwhXTbpGnCKAN1Gy0QXDNrOlHxAIiitI=;
 b=Mjz8nOlDr1eRTc/D0DeDdoQn0VIEBrU//FtsDkW01B4ls+AunOirG2HkuwooIm9KlLf2jm
 9pVfuI2uitOOBwY7S35zDrr49vqwSfgm2mX8MgcNTDYuLX6aaexg/euplQXi9EH1HXQXVN
 +U41KxDGOtfyrBN4zA6CKLkU1ZRjR/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651248348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYlQ00pa3l1UwhXTbpGnCKAN1Gy0QXDNrOlHxAIiitI=;
 b=zZyzUQGnHQOOwvK0Of5VWwylc+WJHUTJOlLwzbSSvJDzzQDVvNuAo70UjTh6KRhA9L/lYE
 lquQnHyKUqL+1iBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D08A13446;
 Fri, 29 Apr 2022 16:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jUBQAdwMbGJ+PgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 29 Apr 2022 16:05:48 +0000
Message-ID: <539e2eb7-05d5-470c-3287-b1e9b7220532@suse.cz>
Date: Fri, 29 Apr 2022 18:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220428065657.32046-1-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220428065657.32046-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/5] busy_poll: Move TST_{SETUP,
 CLEANUP} to the tests
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
TST_TESTFUNC should be moved to individual test scripts as well, for the
same reason. Other than that, the whole patchset looks good:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 28. 04. 22 8:56, Petr Vorel wrote:
> Although having variables in both busy_poll_lib.sh and the tests which
> are using it isn't optimal, hooking up callbacks on the reverse end of
> include is even worse code.
> 
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Follow-up of "v3 shell: Cleanup getopts usage" patchset [1],
> replacing first commit.
> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/project/ltp/list/?series=297175
> 
>  testcases/network/busy_poll/busy_poll01.sh   | 3 +++
>  testcases/network/busy_poll/busy_poll02.sh   | 3 +++
>  testcases/network/busy_poll/busy_poll03.sh   | 2 ++
>  testcases/network/busy_poll/busy_poll_lib.sh | 3 +--
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
> index 65f4db3fe..1f7097771 100755
> --- a/testcases/network/busy_poll/busy_poll01.sh
> +++ b/testcases/network/busy_poll/busy_poll01.sh
> @@ -4,6 +4,9 @@
>  #
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  
> +TST_SETUP="setup"
> +TST_CLEANUP="cleanup"
> +
>  cleanup()
>  {
>  	[ -n "$busy_read_old" ] && \
> diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
> index ebae4d2f5..634bbd6bd 100755
> --- a/testcases/network/busy_poll/busy_poll02.sh
> +++ b/testcases/network/busy_poll/busy_poll02.sh
> @@ -4,6 +4,9 @@
>  #
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  
> +TST_SETUP="setup"
> +TST_CLEANUP="cleanup"
> +
>  cleanup()
>  {
>  	[ -n "$busy_poll_old" ] && \
> diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
> index 04d5978f7..b2e1c0a7a 100755
> --- a/testcases/network/busy_poll/busy_poll03.sh
> +++ b/testcases/network/busy_poll/busy_poll03.sh
> @@ -4,6 +4,8 @@
>  #
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  
> +TST_SETUP="setup"
> +TST_CLEANUP="cleanup"
>  TST_TEST_DATA="udp udp_lite"
>  
>  cleanup()
> diff --git a/testcases/network/busy_poll/busy_poll_lib.sh b/testcases/network/busy_poll/busy_poll_lib.sh
> index de61d3fcd..446ae3d65 100755
> --- a/testcases/network/busy_poll/busy_poll_lib.sh
> +++ b/testcases/network/busy_poll/busy_poll_lib.sh
> @@ -1,10 +1,9 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) Linux Test Project, 2016-2022
>  # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
>  
> -TST_SETUP="setup"
>  TST_TESTFUNC="test"

^^ here

> -TST_CLEANUP="cleanup"
>  TST_MIN_KVER="3.11"
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_ROOT=1


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
