Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DFFC88E4D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 12:21:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 139A03E921B
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 14:21:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8A3F3E2F38
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 14:21:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 793201000A50
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 14:21:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA78821BE2;
 Fri, 11 Sep 2026 12:21:20 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9406413715;
 Fri, 11 Sep 2026 12:21:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S4LqIkDyo2rPdgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 12:21:20 +0000
Date: Fri, 11 Sep 2026 14:21:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260911122115.GF1454430@pevik>
References: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
 <20260911-fix_documentation-v2-9-716b2613c477@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260911-fix_documentation-v2-9-716b2613c477@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DA78821BE2
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 9/9] include: Fix API comment spelling and style
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

>  /**
> - * tse_nodemap_count_pages() - Check which numa node resides each page.
> + * tse_nodemap_count_pages() - Check on which NUMA node each page resides.
>   *
>   * Check on which numa node resides each page of the mapping starting at ptr
>   * and continuing pages long and increases nodemap counters accordingly.
> @@ -114,7 +114,7 @@ enum tse_numa_types {
>   *             requested amount of free+buffers memory it's not included in
>   *             the resulting list of nodes.
>   *
> - * return: On success returns allocated and initialized struct tse_nodemap which contains
> + * Return: On success returns allocated and initialized struct tse_nodemap which contains
>   *         array of numa node ids that contains desired resources.

Although lowercase 'r' on return also works as expected (but it's indeed better
to unify), again: whitespace on the second line breaks formatting (first line is
bold, second line is shifted.

Unfortunately Return: does not work like struct members, which allow shifting
without any formatting (OTOH other formating e.g. lists does not work on them).

The rest hopefully LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Thanks for whole patchset.

Kind regards,
Petr

diff --git include/tse_numa.h include/tse_numa.h
index add048eb4c..ac6aab41b8 100644
--- include/tse_numa.h
+++ include/tse_numa.h
@@ -114,8 +114,8 @@ enum tse_numa_types {
  *             requested amount of free+buffers memory it's not included in
  *             the resulting list of nodes.
  *
- * Return: On success returns allocated and initialized struct tse_nodemap which contains
- *         array of numa node ids that contains desired resources.
+ * Return: On success returns allocated and initialized struct tse_nodemap which
+ * contains array of numa node ids that contains desired resources.
  */
 struct tse_nodemap *tse_get_nodemap(int type, size_t min_mem_kb);
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
