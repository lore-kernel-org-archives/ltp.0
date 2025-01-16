Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A964C02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 10:13:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 805CE3C217E
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 11:13:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D2F53C1117
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:12:44 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6ECEE62EB28
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:12:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B9FF7211C4;
 Thu, 16 Jan 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 702F313A57;
 Thu, 16 Jan 2025 10:12:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iv1CGZvbiGcuGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jan 2025 10:12:43 +0000
Date: Thu, 16 Jan 2025 11:12:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Michal Hocko <mhocko@suse.com>
Message-ID: <20250116101242.GA679477@pevik>
References: <e66fcf77-cf9d-4d14-9e42-1fc4564483bc@oracle.com>
 <PH7PR10MB650583A6483E7A87B43630BDAC302@PH7PR10MB6505.namprd10.prod.outlook.com>
 <20250115125241.GD648257@pevik> <20250115225920.GA669149@pevik>
 <Z4i6-WZ73FgOjvtq@tiehlicka>
 <6ee7b877-19cc-4eda-9ea7-abf3af0a1b57@oracle.com>
 <Z4jL_GzJ98S_VYa3@tiehlicka>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z4jL_GzJ98S_VYa3@tiehlicka>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B9FF7211C4
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Issue faced in memcg_stat_rss while running mainline
 kernels between 6.7 and 6.8
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
Cc: cgroups@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michal, all,

> On Thu 16-01-25 13:37:14, Harshvardhan Jha wrote:
> > Hello Michal
> > On 16/01/25 1:23 PM, Michal Hocko wrote:
> > > Hi,

> > > On Wed 15-01-25 23:59:20, Petr Vorel wrote:
> > >> Hi Harshvardhan,

> > >> [ Cc cgroups@vger.kernel.org: FYI problem in recent kernel using cgroup v1 ]
> > > It is hard to decypher the output and nail down actual failure. Could
> > > somebody do a TL;DR summary of the failure, since when it happens, is it
> > > really v1 specific?

> > The test ltp_memcg_stat_rss is indeed cgroup v1 specific.

> What does this test case aims to test?

I'm not an expert on cgroup tests, maybe Li or Cyril will comment better.

memcg_stat_rss.sh [1] claims "Test the management and counting of memory",
test_mem_stat() [2] checks memory.stat doing some memory allocation.
Each test runs memcg_process.c [3], which does various mmap(),
followed by checks.

These tests are quite old, not sure how relevant they are. We have newer tests
written completely in C, which are more reliable.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh#L17C3-L17C45
[2] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/controllers/memcg/functional/memcg_lib.sh#L249
[3] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/controllers/memcg/functional/memcg_process.c


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
