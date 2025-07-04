Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E745C83030
	for <ltp@archiver.kernel.org>; Sat,  5 Jul 2025 20:01:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BE523C9DE4
	for <ltp@archiver.kernel.org>; Sat,  5 Jul 2025 22:01:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FB343C992A
 for <ltp@lists.linux.it>; Sat,  5 Jul 2025 22:00:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 599C91400985
 for <ltp@lists.linux.it>; Sat,  5 Jul 2025 22:00:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E901D21162;
 Sat,  5 Jul 2025 20:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751745653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Ej3hCCfrQWrt1GFOzYcVms9XxZbLYdzP8GSAojwfQs=;
 b=TYF/Ne+gm84Jjzu+l1y7Ng3WdT1Zbg2a/G2+meZE/naYB6PpZTtP1lTX7VcI4+YBOSetSg
 hSbijUk41V5baToNXQUshPu0ii4yHrxxW8Orm4ZqzbRF673AkyVUhgJPFqik2l9EiM0M2c
 dYOuyw0GudKqq/w87vQg8JelcKV8JDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751745653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Ej3hCCfrQWrt1GFOzYcVms9XxZbLYdzP8GSAojwfQs=;
 b=J3G1lxAGXomf/SBDfTgumU9R0JnWekvLClbpJ5Ggu/aWU9UFKT6P+0TEuWvOSjS8YVaADg
 /X+dv0uaU+v7dLCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mMrF3HJZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nyW5d7U2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751745651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Ej3hCCfrQWrt1GFOzYcVms9XxZbLYdzP8GSAojwfQs=;
 b=mMrF3HJZ2uVVpv/4ZDdDcLlzTEKfvndTgpnQTk0mjxoshaKYrj1I7dfCGp7Fd5rlKycztA
 BpOlwo8U8PO8TOG/r2Ns/KJV4vR3hjLj2gjo24X9K85BuwibfRuMVZMzyhiswwGbBSAIXU
 HoMlNozXcH3C93LEyoLl4EhVZ7MdL10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751745651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Ej3hCCfrQWrt1GFOzYcVms9XxZbLYdzP8GSAojwfQs=;
 b=nyW5d7U2IaF6rMG78ShWPMAsBIDGGXHKQ+wPcwKkhyqCNZXPb2wQx1ZpzaQRTu20lIZY69
 6qnlGcO9gjW4IuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7A7213757;
 Sat,  5 Jul 2025 20:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0hikNHOEaWiaMgAAD6G6ig
 (envelope-from <jack@suse.cz>); Sat, 05 Jul 2025 20:00:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id AD57CA0A31; Fri,  4 Jul 2025 13:17:02 +0200 (CEST)
Date: Fri, 4 Jul 2025 13:17:02 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <c2dvcablaximwjnwg67spegwkntxjgezu6prvyyto4vjnx6rvh@w3xgx4jjq4bb>
References: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
 <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
 <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
 <1c7ae5cb-61ad-404c-950a-ba1b5895e6c3@huaweicloud.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c7ae5cb-61ad-404c-950a-ba1b5895e6c3@huaweicloud.com>
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DATE_IN_PAST(1.00)[32]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_LAST(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, huaweicloud.com:email, linaro.org:email]
X-Rspamd-Queue-Id: E901D21162
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
Cc: Jan Kara <jack@suse.cz>, Linux Regressions <regressions@lists.linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Dan Carpenter <dan.carpenter@linaro.org>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu 03-07-25 19:33:32, Zhang Yi wrote:
> On 2025/7/3 15:26, Naresh Kamboju wrote:
> > On Thu, 26 Jun 2025 at 19:23, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
> >> On 2025/6/26 20:31, Naresh Kamboju wrote:
> >>> Regressions noticed on arm64 devices while running LTP syscalls mmap16
> >>> test case on the Linux next-20250616..next-20250626 with the extra build
> >>> config fragment CONFIG_ARM64_64K_PAGES=y the kernel warning noticed.
> >>>
> >>> Not reproducible with 4K page size.
> >>>
> >>> Test environments:
> >>> - Dragonboard-410c
> >>> - Juno-r2
> >>> - rk3399-rock-pi-4b
> >>> - qemu-arm64
> >>>
> >>> Regression Analysis:
> >>> - New regression? Yes
> >>> - Reproducibility? Yes
> >>>
> >>> Test regression: next-20250626 LTP mmap16 WARNING fs jbd2
> >>> transaction.c start_this_handle
> >>>
> >>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >>
> >> Thank you for the report. The block size for this test is 1 KB, so I
> >> suspect this is the issue with insufficient journal credits that we
> >> are going to resolve.
> > 
> > I have applied your patch set [1] and tested and the reported
> > regressions did not fix.
> > Am I missing anything ?
> > 
> > [1] https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/
> > 
> 
> Hmm. It seems that my fix for the insufficient journal credit series
> cannot handle cases with a page size of 64k. The problem is the folio
> size can up to 128M, and the 'rsv_blocks' in ext4_do_writepages() can
> up to 1577 on 1K block size filesystems, this is too large.

Firstly, I think that 128M folios are too big for our current approaches
(in ext4 at least) to sensibly work. Maybe we could limit max folio order
in ext4 mappings to max 1024 blocks per folio or something like that? For
realistic setups with 4k blocksize this means 4M folios which is not really
limiting for x86. Arm64 or ppc64 could do bigger but the gain for even
larger folios is diminishingly small anyway.

Secondly, I'm wondering that even with 1577 reserved blocks we shouldn't
really overflow the journal unless you make it really small. But maybe
that's what the test does...

> Therefore, at this time, I think we should disable the large folio
> support for 64K page size. Then, we may need to reserve rsv_blocks
> for one extent and implement the same journal extension logic for
> reserved credits.
> 
> Ted and Jan, what do you think?

I wouldn't really disable it for 64K page size. I'd rather limit max folio
order to 1024 blocks. That actually makes sense as a general limitation of
our current implementation (linked lists of bhs in each folio don't really
scale). We can use mapping_set_folio_order_range() for that instead of
mapping_set_large_folios().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
