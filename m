Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A48CE7AAB
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 10:19:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C39EE3CF81F
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 11:19:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 876983C2932
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 11:19:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2852D60049E
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 11:19:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7CD9E2119B;
 Fri, 14 Nov 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21C333EA61;
 Fri, 14 Nov 2025 10:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZI2IOSICF2kpBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 14 Nov 2025 10:19:14 +0000
Date: Fri, 14 Nov 2025 11:19:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Message-ID: <20251114101908.GB52218@pevik>
References: <20251113184216.7768-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251113184216.7768-1-sebastian.chlad@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7CD9E2119B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] controllers: Remove obsolete testplan.txt
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sebastian,

> The testplan.txt file contains outdated information and is unlikely to be
> maintained going forward. The tests are already self-contained and clearly
> organized by controller type.

> Removing this file avoids confusion and reduces maintenance overhead.

> -testplan.txt
> -------------
> -A brief description of the plan for resource management testing.
> -
>  test_controllers.sh
>  -------------------
>  This is the main script file that starts the test. It first checks if the
> diff --git a/testcases/kernel/controllers/testplan.txt b/testcases/kernel/controllers/testplan.txt
> deleted file mode 100644
> index 7fbca2a05..000000000
> --- a/testcases/kernel/controllers/testplan.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -THE RESOURCE MANAGEMENT (CONTROLLERS) TEST PLAN
> -
> -This directory "controllers" is created to include all test cases related to
> -the resource controllers in linux. The testplan at present includes testing
> -of cpu controller, memory controller and cpuset controller.
> -There are test cases to test cpu, memory and cpuset controller. In future new
> -testcases will be included to test these controllers further.
> -Each new controller will have it's own directory to contain all its test
> -cases.
> -A brief description of all the testcases is given in the corresponding
> -controllers directory.
> -
> -For more information on resource controllers please refer to
> -cgroups/cgroups.txt, cgroups/memory.txt and cgroups/cpusets.txt in kernel
> -source code documentation.

+1. This file is indeed useless.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Proof how it is outdated is that it does not reflect the doc move in kernel:

0d942766453f ("cgroup: rename Documentation/cgroups/ to Documentation/cgroup-legacy/") # v4.5-rc1
da82c92f1150 ("docs: cgroup-v1: add it to the admin-guide book") # v5.3-rc1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
