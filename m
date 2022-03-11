Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50956C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 14:26:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E19FC3C8C8E
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 15:26:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5338F3C1ADE
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 15:26:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 51AAB60102E
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 15:26:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 52CDD1F44F;
 Fri, 11 Mar 2022 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647008767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q720kTBsRpHDhBr/oLP3PqoYrcvQdgPBpMstE1XFHBw=;
 b=1U3bEWDbweJxIoo5goVszqnQn13+LhSFGGmBIU40VzcYs4U8rEw8l1ZEGRwcLGaBuEvi6W
 bU+fIGV7VQqbPC082wY6b0+3wTLrLhi7+eeG2my/aF3+6gTkoHJFAnFPnJcKL/p8AI6HrN
 1/o4Qlc2eBZjnh9SkRzWy93NNhjXq7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647008767;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q720kTBsRpHDhBr/oLP3PqoYrcvQdgPBpMstE1XFHBw=;
 b=uDsHYzYqcL6AnfQj7UqPdNcAdCdF4McDKnl6vctkMHoHIPzcsEkZWuX/ApGMz0Spwcz6Jd
 FL1s+DSauTe/etDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B18B13A89;
 Fri, 11 Mar 2022 14:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Uv3wDP9bK2KFcQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 11 Mar 2022 14:26:07 +0000
Date: Fri, 11 Mar 2022 15:28:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yitcifh+HxHMce/T@yuki>
References: <20220210162739.30159-1-pvorel@suse.cz>
 <20220210162739.30159-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220210162739.30159-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/6] tst_test.sh: Add $TST_FORMAT_DEVICE and
 related vars
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> ---
>  doc/shell-test-api.txt    | 31 +++++++++++++++++++++++++++++--
>  testcases/lib/tst_test.sh |  6 ++++++
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
> index a5974b4fad..5caa889c9e 100644
> --- a/doc/shell-test-api.txt
> +++ b/doc/shell-test-api.txt
> @@ -189,11 +189,20 @@ space as default value is used. Of course, it's possible to use separate functio
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  Similarily to the C library various checks and preparations can be requested
> -simply by setting right '$TST_NEEDS_FOO'.
> +simply by setting right '$TST_FOO'.
>  
>  [options="header"]
>  |=============================================================================
>  | Variable name            | Action done
> +| 'TST_DEV_EXTRA_OPTS'     | Pass extra 'mkfs' options _after_ device name,
> +|                          | to 'tst_mkfs', use with 'TST_FORMAT_DEVICE=1'.
> +| 'TST_DEV_FS_OPTS'        | Pass 'mkfs' options _before_ the device name,
> +|                          | to 'tst_mkfs', use with 'TST_FORMAT_DEVICE=1'.
> +| 'TST_FORMAT_DEVICE'      | Format a block device with a filesystem, see
> +|                          | https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem]

Hm, I guess that we already have a few absolute links in the docs to a
github.com wiki, but I do not like it that much. I guess that realtive
links does not work, right?

> +|                          | See also 'TST_DEV_EXTRA_OPTS', 'TST_DEV_FS_OPTS', 'TST_FS_TYPE'.
> +|                          | Implies 'TST_NEEDS_DEVICE=1' (no need to set it).
> +| 'TST_FS_TYPE'            | Override the default filesystem to be used.
>  | 'TST_NEEDS_ROOT'         | Exit the test with 'TCONF' unless executed under root.
>  |                          | Alternatively the 'tst_require_root' command can be used.
>  | 'TST_NEEDS_TMPDIR'       | Create test temporary directory and cd into it.
> @@ -495,7 +504,25 @@ tst_random 0 1000
>  Formatting device with a filesystem
>  +++++++++++++++++++++++++++++++++++
>  
> -The 'tst_mkfs' helper will format device with the filesystem.
> +'TST_FORMAT_DEVICE=1' can be used to format device before running the test.
> +Uses '$TST_FS_TYPE' (used filesystem, by default ext2), '$TST_DEVICE' (used
                              ^
			      I would removed this part and keep only
			      the (by default ext2)
> +block device, usually prepared by 'TST_NEEDS_DEVICE=1'), '$TST_DEV_FS_OPTS'

and rewrote this part no to be in the parentheses as:

'$TST_DEVICE' a block device to be formatted, usually prepared by the
library (TST_NEEDS_DEVICE=1 must be set).

> +('mkfs' options _before_ the device name) and '$TST_DEV_EXTRA_OPTS'
> +(extra 'mkfs' options _after_ the device name).

And remove the parentheses here as:

'$TST_DEV_FS_OPTS' a 'mkfs' options _before_ the device path and
'$TST_DEV_EXTRA_OPTS' extra 'mkfs'' options _after_ the device path.


Other than that and the test1() pointed out by Yang Xu:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
