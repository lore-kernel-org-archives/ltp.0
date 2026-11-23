Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597BC606A31E
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=D2j39hON;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=g2EUoBWO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Et3f2JhV;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VQt9h5/7
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D96743E9EE7
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 13:16:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EAFF3E9198
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 13:15:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 408DB1400980
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 13:15:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA26621CB9;
 Mon, 23 Nov 2026 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795436145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQWa2E2Pw81Hh5toNgwzNsGSKnrvyc8QsSXptOpce0g=;
 b=D2j39hONu2AH0Vamnt2WYHmKFrCUBKlti1NITurD1JEYubHOR2meTTYtvzqVs7mkmVo/Lb
 Ws59a1TJv47ih4wuJYXQDhfpmdsacns74NjASJ9i70nKGUXvTCxm38KViaoCAE4rS/lfdj
 VB/H4/jU2GgVj/39/emA6fBlcj+k1KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795436145;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQWa2E2Pw81Hh5toNgwzNsGSKnrvyc8QsSXptOpce0g=;
 b=g2EUoBWOWH4qcqU/rL/vWz+CBTAbuexra4Id6pNGfEVDdkyb4qtNLGzh8QLu/DThXkSSRa
 LEA/RwUrHmASQVAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Et3f2JhV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="VQt9h5/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795436144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQWa2E2Pw81Hh5toNgwzNsGSKnrvyc8QsSXptOpce0g=;
 b=Et3f2JhVbWnfnf5sWyp1gV9+YXfFTrwvICBty6jEFYfOMHIfL7lnmNgOI30/xZRYcKm0Wq
 Sy6B8ycw1yR+Rmw7uuhEx3nhXM3wgf+FVNa93fbDwT+KHY4DIk6bpzmlHvbL29LZy0stA+
 ZLR1fD68VB531LT2BV8V/oMGq2//E0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795436144;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQWa2E2Pw81Hh5toNgwzNsGSKnrvyc8QsSXptOpce0g=;
 b=VQt9h5/7cYqGNZlDixNEoFNY78cfeP1Q4nZ9EFFTZKGPtLHz5UTxBRdPwKRzM3mvk0lKT9
 cjpyfZ4p/dszSTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0DA413510;
 Mon, 23 Nov 2026 12:15:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YzzpJHAuBGsgUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 23 Nov 2026 12:15:44 +0000
Date: Mon, 23 Nov 2026 13:16:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Brian Mak <bmak@nvidia.com>
Message-ID: <awQuj0rKcuvA5ro9@yuki.lan>
References: <20261121003653.179935-1-bmak@nvidia.com>
 <20261121003653.179935-3-bmak@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261121003653.179935-3-bmak@nvidia.com>
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: EA26621CB9
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] tse_swap: Fill swapfile with zeroes on ntfs3
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> On ntfs3, fallocate() allocates clusters but does not change the valid
> data length.
> 
> ntfs3 has no ->swap_activate(), so swapon() maps the file with
> generic_swapfile_activate() and ->bmap(). Since ntfs3 was converted to
> iomap in v7.0, ntfs_bmap() calls iomap_bmap(), which only returns a
> block number for IOMAP_MAPPED extents, while ntfs3 reports the range
> beyond the valid data length as IOMAP_UNWRITTEN. swapon() therefore
> rejects the file, and swapon01-03 and swapoff01-02 fail on ntfs3 with:

We had similar bug introduced in exfat code and it was fixed in kernel:

commit 03a43677ca91e3997355a13b1da6e47329b025e1
Author: Jan Polensky <japo@linux.ibm.com>
Date:   Tue Jun 9 18:21:49 2026 +0900

    exfat: add swap_activate support

    Commit 07d67f3e9083 ("exfat: add iomap buffered I/O support")
    converted exfat buffered I/O to iomap, but did not add a
    .swap_activate handler to the address_space_operations.

Hence I assume this is a kernel bug.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
