Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09E5C433EF
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 11:23:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C12A3C96AA
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 12:23:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 969723C9685
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 12:23:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0F3A51400B83
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 12:23:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 51B001F37E;
 Wed, 19 Jan 2022 11:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642591383;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xFbzcn/XpvMPdC3IP04O/FQ8YbZxhh4SILy+uiF+eus=;
 b=xMIjxX4O1V3yKYf4bs6Yopb3saS/e/cH5zlNgn7TQj5iJLlIhTTzXB9+uQOs5SqrgZLsPE
 c2vRHTmjiYSX8luJKfUJNAVNf7Oa+Icz+StSEI+jnuGPd+/wVwK+9uVnz1gzpcQcIvRdfC
 BTkkciMef7x5dBT+P+o4UZ3BSv7bvv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642591383;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xFbzcn/XpvMPdC3IP04O/FQ8YbZxhh4SILy+uiF+eus=;
 b=iIubQvEX9CzE/PEsubVvb+BXS+mRfvEPjB0cNxomafGlx6oVbZ0sX4SL109YhCIGApHqvv
 uN+RsA0VlJuSHtDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A4C413B31;
 Wed, 19 Jan 2022 11:23:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vli7A5f052FWZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jan 2022 11:23:03 +0000
Date: Wed, 19 Jan 2022 12:23:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yef0lBQ5aryeC5ew@pevik>
References: <20220119111533.8356-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220119111533.8356-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite statx04 test
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

Hi Martin,

> statx04 is supposed verify that inode attribute support in statx() matches
> what should actually be implemented. However, we already have functional tests
> for this in statx08 and lack a test of the stx_attribute_mask field which
> reports inode attribute support to userspace.

> Rewrite the test to drop the duplicate code and add the missing coverage.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> Changes since v1:
> - added known-fail tag for XFS in strict mode
> - changed copyright header to SUSE since this is a near-complete rewrite
Thanks a lot!

> This also fixes Btrfs failures on kernels v4.11 and v4.12 where the attributes
> are not supported at all. LTP is supposed to check for bugs, not force people
> to backport features from newer kernels.

> If anybody want to backport the Btrfs support, the test now has strict mode
> which disables kernel version exceptions.

> I've also disabled FUSE filesystems because they return wrong errno codes
> in the ioctl() check and NTFS3g now has some rudimentary support for inode
> attributes but no support for them in statx().

I'd put this into commit message (can be done during merge).

...
> +	if (TST_RET)
> +		tst_brk(TBROK | TTERRNO, "Unexpected ioctl() error");

> -static void test_unflagged(void)
> -{
> -	struct statx buf;
> +	for (i = 0, expected_mask = 0; i < ARRAY_SIZE(attr_list); i++)
Before merge we should cast to prevent "comparison of integer expressions of
different signedness" warning:
for (i = 0, expected_mask = 0; i < (int)ARRAY_SIZE(attr_list); i++)

> +		expected_mask |= attr_list[i].attr;

...
> -static void setup(void)
> -{
> -	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
> -	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
> +	for (i = 0; i < ARRAY_SIZE(attr_list); i++) {
And here:
for (i = 0; i < (int)ARRAY_SIZE(attr_list); i++) {
> +		if (!(expected_mask & attr_list[i].attr))
> +			continue;

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
