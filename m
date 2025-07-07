Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E1CC8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 08:16:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F3CD3C71A4
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 10:16:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2199B3C0433
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 10:16:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D1291400984
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 10:16:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E26D2116B;
 Mon,  7 Jul 2025 08:16:19 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C96613757;
 Mon,  7 Jul 2025 08:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DG/2BlOCa2jaLwAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 07 Jul 2025 08:16:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id B292EA0992; Mon,  7 Jul 2025 10:16:18 +0200 (CEST)
Date: Mon, 7 Jul 2025 10:16:18 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <mfx57o5lsxdkjpd3kq2y7ozkfu4rgr6zugdsnyqlhktwuh4dmw@7ldfhzgozaoo>
References: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
 <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
 <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
 <1c7ae5cb-61ad-404c-950a-ba1b5895e6c3@huaweicloud.com>
 <c2dvcablaximwjnwg67spegwkntxjgezu6prvyyto4vjnx6rvh@w3xgx4jjq4bb>
 <021aad1d-61ba-484f-88d1-9a482707ff94@huaweicloud.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <021aad1d-61ba-484f-88d1-9a482707ff94@huaweicloud.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 2E26D2116B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next-20250626: WARNING fs jbd2 transaction.c
 start_this_handle with ARM64_64K_PAGES
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
Cc: Theodore Ts'o <tytso@mit.edu>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4 <linux-ext4@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 07-07-25 12:54:56, Zhang Yi wrote:
> On 2025/7/4 19:17, Jan Kara wrote:
> > I wouldn't really disable it for 64K page size. I'd rather limit max folio
> > order to 1024 blocks. That actually makes sense as a general limitation of
> > our current implementation (linked lists of bhs in each folio don't really
> > scale). We can use mapping_set_folio_order_range() for that instead of
> > mapping_set_large_folios().
> > 
> 
> Indeed, after noticing that Btrfs also calls mapping_set_folio_order_range()
> to set the maximum size of a folio, I thought this solution should work. So
> I changed my mind and was going to try this solution. However, I guess limit
> max folio order to 1024 blocks is somewhat too small. I'd like to limit the
> order to 2048 blocks, because this this allows a file system with a 1KB
> block size to achieve a maximum folio size to PMD size in x86 with a 4KB
> page size, this is useful for increase the TLB efficiency and reduce page
> fault handling overhead.

OK. In my opinion whoever runs with 1k blocksize doesn't really care about
performance too much and thus is unlikely to care about getting 2M pages
:). But whatever, the limit of 2048 blocks is fine by me.

> I defined a new macro, something like this:
> 
> /*
>  * Limit the maximum folio order to 2048 blocks to prevent overestimation
>  * of reserve handle credits during the folio writeback in environments
>  * where the PAGE_SIZE exceeds 4KB.
>  */
> #define EXT4_MAX_PAGECACHE_ORDER(i)             \
>                 min(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SIZE))
								  ^^^ PAGE_SHIFT

Otherwise looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
