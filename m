Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF00CCD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 09:31:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 556B73C330F
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 11:31:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7646E3C3299
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 11:31:35 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AF7BE200CF8
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 11:31:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C407C1FBA4;
 Mon,  2 Sep 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF62813A7C;
 Mon,  2 Sep 2024 09:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r0GBKvWF1Wb2VAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 02 Sep 2024 09:31:33 +0000
Date: Mon, 2 Sep 2024 11:30:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Geetika M <geetika@linux.ibm.com>
Message-ID: <ZtWFr6OWSah0k4j0@yuki.lan>
References: <bf5ed5dc-805c-4825-898f-1e4d3d280f2c@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf5ed5dc-805c-4825-898f-1e4d3d280f2c@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C407C1FBA4
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Acceptance Status of libhugetlbfs Patches
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
Cc: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>, pavrampu@linux.ibm.com,
 sachinp@linux.ibm.com, ltp@lists.linux.it, pavithra.visweswara@ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I am writing on behalf of my team regarding the patches we recently 
> submitted to the LTP mailing list. We wanted to follow up and inquire 
> about the status of these patches and their potential integration into 
> the upstream project.
> 
> For your reference, here are the few links to the patches we have sent:
> 
> *[LTP] [PATCH v2] [PATCH] Hugetlb: Migrating libhugetlbfs shm-perms 
> <https://lore.kernel.org/ltp/20240510141020.189065-1-spoorthy@linux.ibm.com/>*
> 
> *[LTP] [PATCH v4] Migrating the libhugetlbfs/testcases/shm-gettest.c 
> test 
> <https://lore.kernel.org/ltp/20240515092456.3180-1-sachinpb@linux.ibm.com/>*
> 
> *[LTP] [PATCH v3] Hugetlb: Migrating libhugetlbfs test 
> truncate_reserve_wraparound.c 
> <https://lore.kernel.org/ltp/20240802061342.8540-1-geetika@linux.ibm.com/>*
> 
> *[LTP] [PATCH v4] Migrating the 
> libhugetlbfs/testcases/stack_grow_into_huge.c test 
> <https://lore.kernel.org/ltp/20240816103317.127972-1-samir@linux.vnet.ibm.com/> 
> **[LTP] [PATCH v3] Migrating the 
> libhugetlbfs/testcases/truncate_sigbus_versus_oom.c test 
> <https://lore.kernel.org/ltp/20240407095243.65152-1-samir@linux.vnet.ibm.com/> 
> **Re: [LTP] [PATCH v2] Migrating the 
> libhugetlbfs/testcases/truncate_above_4GB.c test 
> <https://lore.kernel.org/ltp/7c9bf212-bbd8-4889-ade9-9798cce3a29c@linux.ibm.com/>*
> 
> We would greatly appreciate any updates you could provide on when these 
> might be reviewed and merged. Please let us know if there are any 
> additional steps we need to take or if further modifications are required.

I will go over these as a part of the September release preparations.
Sorry I haven't had time to for a review earlier.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
