Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E78C4708D
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 18:23:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 782883CDEA9
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 19:23:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFF2D3C8201
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 19:23:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 52AAD1000540
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 19:23:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D0C833D07;
 Tue,  3 Jan 2023 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672770185;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggptdhBeOr8DqY2pyq1vxoLqO1QEr04ocgpAZ9moHvY=;
 b=Y3F8Jv1ATaUJTupkuT/sAHNLhrZQ25EOdkf9x97lehOOr3//X4FsLo4FiW91MmNxSp42dJ
 0JIhUIyYXhE40qMZLvko4RbH97HKeB136BZlx/G7FGti11rs2lHSc8vrGwzhjN+KgCUJnV
 hXeLPoXrCedkIbOl8/4HUKHebjKO0ZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672770185;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggptdhBeOr8DqY2pyq1vxoLqO1QEr04ocgpAZ9moHvY=;
 b=cKglH1b2Xn3rwrLvXPKSUJkKPRxm2Cf5bNQ3woc/KxXuTGEm+fWNcm1VuE4+13cUjoUk00
 /sroHoD6CtL3O6CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D54BB1390C;
 Tue,  3 Jan 2023 18:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EE7xMYhytGNmRQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 Jan 2023 18:23:04 +0000
Date: Tue, 3 Jan 2023 19:23:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y7Ryhx50EvHpbwI4@pevik>
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-13-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221225154213.84183-13-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 12/13] Hugetlb: Migrating libhugetlbfs shm-fork
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Migrating the libhugetlbfs/testcases/shm-fork.c test
NOTE: if you're talking about libhugetlbfs [1], the test path is
tests/shm-fork.c (not testcases).


> Test Description: Test shared memory behavior when multiple threads are
> Test shared memory behavior when multiple threads are attached
> to a segment.  A segment is created and then children are
> spawned which attach, write, read (verify), and detach from the
> shared memory segment.

> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugefork/hugefork02.c  | 104 ++++++++++++++++++
>  3 files changed, 106 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork02.c

> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 33fd384b4..348a7dc5f 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -2,6 +2,7 @@ hugefallocate01 hugefallocate01
>  hugefallocate02 hugefallocate02

>  hugefork01 hugefork01
> +hugefork02 hugefork02 -P 3 -s 5

You're not define tst_option [2] (you don't even have any code which would hold
these options), therefore passing any of these 2 options will quit the test:
hugefork02: invalid option -- 'P'

Please fix it in next version.

Kind regards,
Petr

[1] https://github.com/libhugetlbfs/libhugetlbfs
[2] https://github.com/linux-test-project/ltp/wiki/C-Test-API#15-test-specific-command-line-options

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
