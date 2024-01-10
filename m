Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEAFC3DA6E
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 09:46:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 730A83CE4BB
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 10:46:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2742F3C4D98
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 10:45:54 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B5ED0605630
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 10:45:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 077EF1F844;
 Wed, 10 Jan 2024 09:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704879953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPG7T/pGkOmzRA0QE+tftSg7rZnWz8XGJkhstWt6sRU=;
 b=cRSM6XEYUOdBgDtPjDp2rX//Po85n6GAew7UCsQIZ0EMip+kiQbdO/9rP6Si7T2hKrSekS
 PefN4n0EMF2Dbe3vCX/0tNYz4hbtlRYE4YwdFa9mWYoxyLJcPlLnVSk7S8N+q5lvdVHH+g
 tA97L2WwCezFw47Xf5f4yf0UbSHQI1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704879953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPG7T/pGkOmzRA0QE+tftSg7rZnWz8XGJkhstWt6sRU=;
 b=vMgNGrkJQEmuT4VOZUtS03a2N4IOMOObOeFwFGwwUVQpsctgytdD5u9zCaCpfNOwktnuuz
 e2K0RbsAw7gJK0DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704879953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPG7T/pGkOmzRA0QE+tftSg7rZnWz8XGJkhstWt6sRU=;
 b=cRSM6XEYUOdBgDtPjDp2rX//Po85n6GAew7UCsQIZ0EMip+kiQbdO/9rP6Si7T2hKrSekS
 PefN4n0EMF2Dbe3vCX/0tNYz4hbtlRYE4YwdFa9mWYoxyLJcPlLnVSk7S8N+q5lvdVHH+g
 tA97L2WwCezFw47Xf5f4yf0UbSHQI1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704879953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPG7T/pGkOmzRA0QE+tftSg7rZnWz8XGJkhstWt6sRU=;
 b=vMgNGrkJQEmuT4VOZUtS03a2N4IOMOObOeFwFGwwUVQpsctgytdD5u9zCaCpfNOwktnuuz
 e2K0RbsAw7gJK0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA54A13CB3;
 Wed, 10 Jan 2024 09:45:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cQaXOFBnnmXELQAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 10 Jan 2024 09:45:52 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 10 Jan 2024 10:45:52 +0100
Message-ID: <2381416.cqcTQP2oNQ@localhost>
Organization: SUSE
In-Reply-To: <874jhobua2.fsf@suse.de>
References: <20230913100803.13756-1-akumar@suse.de>
 <e73de656-9075-42d5-8d0a-b6951c28d603@suse.com> <874jhobua2.fsf@suse.de>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 077EF1F844
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cRSM6XEY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vMgNGrkJ
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.82 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; HAS_ORG_HEADER(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 CTE_CASE(0.50)[]; BAYES_HAM(-0.31)[75.36%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[suse.com,gmail.com]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/munmap02: Refactor the test using
 new LTP API
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

On Tuesday, November 14, 2023 9:37:16 AM CET Richard Palethorpe wrote:
> Hello,
> 
> Andrea Cervesato via ltp <ltp@lists.linux.it> writes:
> > Hi!
> > 
> > munmap01 and munmap02 looks quite similar. The refactoring is good to
> > me, but maybe we can merge them into a single test using 2 different
> > test cases, where the first is mapping a certain portion of the file
> > and the second an another.
> 
> Yes, these should be merged. Otherwise the rewrite looks good.
> 

Hi,

sorry for not responding to this review earlier.
But may I request for merging these patches if the refactoring is fine. I agree 
that these both should be combined to single test, and I would like to do 
that, but maybe in the second step after upcoming release.

Thank you,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
