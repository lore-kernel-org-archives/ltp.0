Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD5DC5AD4C
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 08:51:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4AEC3CDEC1
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 09:51:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EC7B3CBB47
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 09:51:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E06B42009C9
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 09:51:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 916AA1F388;
 Thu, 23 Nov 2023 08:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700729489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZjObg+4ao07/W9SP6kbKDiwPUbQJuXksV+kAsnqM0s=;
 b=LkSscGJFHM9yz+PewDUshxVaiCvRDZcomKC36kl9YxZdg7L7Ql3A3e4FHsU/kRFNOergx5
 20ull6X8ezBu5a2f41sRQjIJAw5sanskt5WrYUpLzizFqShU0s0Nxbs8ol0is7xyOxD65R
 bG9mXX8eLboEUvtWv6/ttPG8U8O4Fro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700729489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZjObg+4ao07/W9SP6kbKDiwPUbQJuXksV+kAsnqM0s=;
 b=6wBXUzjxMgm17uufYMxEb78PNRpEW/LWYPsk0Li3YH1CYpYAQjOe+bT9QGp19ncsK4zEFi
 djFjU/azP+SIu1Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88C70133B6;
 Thu, 23 Nov 2023 08:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vVdfIZESX2X/CgAAMHmgww
 (envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 08:51:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 0A17BA07D9; Thu, 23 Nov 2023 09:51:29 +0100 (CET)
Date: Thu, 23 Nov 2023 09:51:29 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20231123085129.tvumwmmmuk2zgtfo@quack3>
References: <20231122211318.31358-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231122211318.31358-1-pvorel@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_SPAM_SHORT(3.00)[0.999]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_SPAM_LONG(3.50)[1.000]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[99.99%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] diotest4: Skip test 3 and 14 for tmpfs
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
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Christoph Hellwig <hch@lst.de>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 22-11-23 22:13:18, Petr Vorel wrote:
> tmpfs in kernel v6.6 got support for O_DIRECT in e88e0d366f9c ("tmpfs:
> trivial support for direct IO"). There is no reason for tmpfs to reject
> direct IO of any size therefore follow the approach already used for
> Btrfs, NFS and FUSE: skipping test 3 (odd count of read and write)
> and 14 (read, write with non-aligned buffer).
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Looks good, thanks for writing this! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  testcases/kernel/io/direct_io/diotest4.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
> index 45c677b5b..ad00fa3e0 100644
> --- a/testcases/kernel/io/direct_io/diotest4.c
> +++ b/testcases/kernel/io/direct_io/diotest4.c
> @@ -270,6 +270,7 @@ int main(int argc, char *argv[])
>  	case TST_NFS_MAGIC:
>  	case TST_BTRFS_MAGIC:
>  	case TST_FUSE_MAGIC:
> +	case TST_TMPFS_MAGIC:
>  		tst_resm(TCONF, "%s supports odd count IO",
>  			 tst_fs_type_name(fs_type));
>  	break;
> @@ -443,6 +444,7 @@ int main(int argc, char *argv[])
>  	case TST_NFS_MAGIC:
>  	case TST_BTRFS_MAGIC:
>  	case TST_FUSE_MAGIC:
> +	case TST_TMPFS_MAGIC:
>  		tst_resm(TCONF, "%s supports non-aligned buffer",
>  			 tst_fs_type_name(fs_type));
>  	break;
> -- 
> 2.42.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
