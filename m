Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B5606A31C
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UKEVCfi3;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RTOTXNi6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xKk+bI8B;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1ODNwV09
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74FAB3C332C
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 20:38:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D73AC3C332C
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 20:38:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 405DF200769
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 20:38:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D78B7220B5;
 Mon,  9 Nov 2026 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794253096;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T90Q2mca0ybWC1e0FIJZ3MXCwgan37/bVPbSRg79hzM=;
 b=UKEVCfi33JJP2bnaENKkwMVP8lvVs4lbH88tmklbLtsugwZY1crdZBOBX6UFRo3Mf+DidI
 FOGCNaOVD6rR8gySWqlZ2N0EGNJjYD+q+xOZdcII8cLufIic17QUtvSEUF71PMvFeLCjwP
 ugk+//xPLpis9J3VumCAXDfYA5hZtys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794253096;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T90Q2mca0ybWC1e0FIJZ3MXCwgan37/bVPbSRg79hzM=;
 b=RTOTXNi6iYUzVAf3598k0sE5C4cfx3ivyxfB66+A9z+mn2GNsyusPCVpKpqbLlCz0xpuaf
 MT3yY3ge6FjJPKBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xKk+bI8B;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1ODNwV09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794253095;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T90Q2mca0ybWC1e0FIJZ3MXCwgan37/bVPbSRg79hzM=;
 b=xKk+bI8BkI8VXVClDpGXDwQRujN3H03RvmgdfHSIl9f/TMVBrRzIfotwHNbSDfs/ZByZcv
 8w2nLSvqFq1lJHzQS8idHQEXwMTpgs6peVJlrks9HboENt+ZS/vXXvWnEnY6DUT98PBPgH
 i+M4s4MyLMSfEFOgwC/nKscRPmrUCMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794253095;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T90Q2mca0ybWC1e0FIJZ3MXCwgan37/bVPbSRg79hzM=;
 b=1ODNwV09DEOzfgZi1SjAe3y4SGa2gWKNddfUMC0xu/x4Mo6Ru/yR+e8HvS/aiJhupKy05l
 Klfi7vsrG28feXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B20313319;
 Mon,  9 Nov 2026 19:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XD2LEych8mopKQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Nov 2026 19:38:15 +0000
Date: Mon, 9 Nov 2026 20:38:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20261109193809.GA669592@pevik>
References: <20261109193344.669217-1-pvorel@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261109193344.669217-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-12.71 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.71
X-Spam-Level: 
X-Rspamd-Queue-Id: D78B7220B5
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] zram01.sh: Fill the filesystem with a single
 dd call
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

More data how it's slow on the current implementation (without this patch):

We have these filesystems:
zram01 6 TINFO: mount /dev/zram0 (ext2)
zram01 6 TINFO: mount /dev/zram1 (ext3)
zram01 6 TINFO: mount /dev/zram2 (ext4)
zram01 6 TINFO: mount /dev/zram3 (xfs)
zram01 6 TINFO: mount /dev/zram4 (btrfs)
zram01 6 TINFO: mount /dev/zram5 (vfat)

For some reason only for XFS and Btrfs test use bigger disk size and therefore
bigger memory limit (I haven't investigated, but we use the same lzo alg. for
all of them):

zram01 3 TINFO: set disk size to zram device(s)
zram01 3 TINFO: /sys/block/zram0/disksize = '26214400'
zram01 3 TINFO: /sys/block/zram1/disksize = '26214400'
zram01 3 TINFO: /sys/block/zram2/disksize = '26214400'
zram01 3 TINFO: /sys/block/zram3/disksize = '314572800'
zram01 3 TINFO: /sys/block/zram4/disksize = '402653184'
zram01 3 TINFO: /sys/block/zram5/disksize = '26214400'
zram01 3 TPASS: test succeeded
zram01 4 TINFO: set memory limit to zram device(s)
zram01 4 TINFO: /sys/block/zram0/mem_limit = '25M'
zram01 4 TINFO: /sys/block/zram1/mem_limit = '25M'
zram01 4 TINFO: /sys/block/zram2/mem_limit = '25M'
zram01 4 TINFO: /sys/block/zram3/mem_limit = '300M'
zram01 4 TINFO: /sys/block/zram4/mem_limit = '384M'
zram01 4 TINFO: /sys/block/zram5/mem_limit = '25M'

And therefore filling it (test 7) fails on Btrfs:
zram01 7 TINFO: filling zram0 (it can take long time)
zram01 7 TPASS: zram0 was filled with '24724' KB
zram01 7 TINFO: /sys/block/zram0/mm_stat
24145920    24006    69632 26214400    69632     5877        0
zram01 7 TINFO: mem_used_total: 69632
zram01 7 TPASS: compression ratio: 363.58:1
zram01 7 TINFO: filling zram1 (it can take long time)
zram01 7 TPASS: zram1 was filled with '20628' KB
zram01 7 TINFO: /sys/block/zram1/mm_stat
26144768   184936   577536 26214400   577536     6079        0
zram01 7 TINFO: mem_used_total: 577536
zram01 7 TPASS: compression ratio: 36.57:1
zram01 7 TINFO: filling zram2 (it can take long time)
zram01 7 TPASS: zram2 was filled with '20132' KB
zram01 7 TINFO: /sys/block/zram2/mm_stat
24580096    31639   122880 26214400   122880     5774        0
zram01 7 TINFO: mem_used_total: 122880
zram01 7 TPASS: compression ratio: 167.76:1
zram01 7 TINFO: filling zram3 (it can take long time)
zram01 7 TPASS: zram3 was filled with '285128' KB
zram01 7 TINFO: /sys/block/zram3/mm_stat
298844160   100509   249856 314572800   253952    72411        0
zram01 7 TINFO: mem_used_total: 249856
zram01 7 TPASS: compression ratio: 1168.55:1
zram01 7 TINFO: filling zram4 (it can take long time)

Interesting enough, ~1/4 smaller XFS is ok, Btrfs is probably too big.
Of course nothing problematic in dmesg, IMHO it's just long (2h15m while still
filling zram4 btrfs).

And yes, looking into logs suggest testing each filesystem separately would help
to read the logs.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
