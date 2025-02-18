Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE36C02198
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 12:18:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F2953C9C5F
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 13:18:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 769983C91B5
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:17:53 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B166A651797
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:17:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 11B492116B;
 Tue, 18 Feb 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE9A6132C7;
 Tue, 18 Feb 2025 12:17:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ODb0NG56tGdkMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Feb 2025 12:17:50 +0000
Date: Tue, 18 Feb 2025 13:17:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <20250218121745.GA2469726@pevik>
References: <20250218094302.956853-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250218094302.956853-1-maxj.fnst@fujitsu.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 11B492116B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fork13: Fix the doc
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

Hi Ma Xinjian,

> Previously, the use of "-" would cause "Race Description" to be misinterpreted as a subsection.

This is meant to be a subsection, see patchset I yesterday forgot to sent,
therefore send it now:

https://patchwork.ozlabs.org/project/ltp/patch/20250218121553.2470592-1-pvorel@suse.cz/

> Add a blank line to avoid it and use :: to keep the description as origin text.

> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>  testcases/kernel/syscalls/fork/fork13.c | 27 +++++++++++++------------
>  1 file changed, 14 insertions(+), 13 deletions(-)

> diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/syscalls/fork/fork13.c
> index 3da698e33..9e07c9d4f 100644
> --- a/testcases/kernel/syscalls/fork/fork13.c
> +++ b/testcases/kernel/syscalls/fork/fork13.c
> @@ -15,21 +15,22 @@
>   * implementation.  Furthermore, many shell scripts assume that pid
>   * numbers will not be used for some length of time.
>   *
> - * [Race Description]

That's why "[Race Description]" should stay. The rest of code formatting looks
good, could you please resent?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
