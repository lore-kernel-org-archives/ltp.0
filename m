Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2571DC3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 10:21:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75F8F3CAB10
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 12:21:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F1723C1ABE
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 12:21:30 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 34F6C600BE6
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 12:21:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 136981F38D;
 Mon, 31 Mar 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9F0F139A1;
 Mon, 31 Mar 2025 10:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +jOdN6Zs6mf8YgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 31 Mar 2025 10:21:26 +0000
Date: Mon, 31 Mar 2025 12:21:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250331102121.GB234056@pevik>
References: <20250328075958.7616-1-wegao@suse.com>
 <20250331031945.5948-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250331031945.5948-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 136981F38D
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 0/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Changes v8-v9:
> * Remove .needs_cgroup_ver = TST_CG_V1, let case support both v1 and v2
> * Remove cpuset.sched_load_balance knob 
> * Update base Li Wang and Petr's improvement suggestions on v8

3rd point means:
* removed .runs_script = 1
* .needs_checkpoints = 1,
* SAFE_FILE_PRINTF() => FILE_PRINTF() and SAFE_FILE_SCANF() with TCONF check

Kind regards,
Petr

> link to v8:
> https://patchwork.ozlabs.org/project/ltp/cover/20250328075958.7616-1-wegao@suse.com/

> Wei Gao (2):
>   cpuset02: Convert the test6 from cpuset_memory_testset.sh to C code
>   cpuset_memory_testset.sh: Remove test6

>  runtest/mm                                    |   1 +
>  .../cpuset_memory_testset.sh                  |  37 +----
>  testcases/kernel/mem/.gitignore               |   1 +
>  testcases/kernel/mem/cpuset/Makefile          |   5 +
>  testcases/kernel/mem/cpuset/cpuset02.c        | 140 ++++++++++++++++++
>  5 files changed, 149 insertions(+), 35 deletions(-)
>  create mode 100644 testcases/kernel/mem/cpuset/cpuset02.c

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
