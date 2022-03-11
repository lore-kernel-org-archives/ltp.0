Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2564C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 14:41:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E0F43C8CC2
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 15:41:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 685B23C8C50
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 15:41:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E26D2140012D
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 15:41:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 25C8A1F441;
 Fri, 11 Mar 2022 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647009676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zacr6YAO6Cg2Nz3YaHr7raROKrbcT2dICoPim2RQYBE=;
 b=TamUQ+g9aIJxHsqx+hiE4kxLdorjY5qJ/VUoEUSiyusXJ0dbH856ANhA43kUqhwHOCbbWA
 gl0f69NICiZ/S2tAAJlSycdhbr1HqPjCRzSoCayYm7Z2C3/wrmlU5CqbFNp47XvqRrSBRq
 3fF3RfJELBsUrp9bYh0BN31g1h6FllI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647009676;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zacr6YAO6Cg2Nz3YaHr7raROKrbcT2dICoPim2RQYBE=;
 b=cmzq2TusUVvAmALsAB6ubhMzKfEwr0mOocQ1hRYsXjLpTFvk17I6T+LW5EUzOlG5M5fqNF
 3PWWHCK/Y7ppXpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CBE213A89;
 Fri, 11 Mar 2022 14:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d4ffAYxfK2INeQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 11 Mar 2022 14:41:16 +0000
Date: Fri, 11 Mar 2022 15:43:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YitgFixpNYs/ydVi@yuki>
References: <20220210162739.30159-1-pvorel@suse.cz>
 <20220210162739.30159-7-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220210162739.30159-7-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/6] doc: Add missing shell variables
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
> diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
> index 5caa889c9e..7172917e05 100644
> --- a/doc/shell-test-api.txt
> +++ b/doc/shell-test-api.txt
> @@ -202,7 +202,13 @@ simply by setting right '$TST_FOO'.
>  |                          | https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem]
>  |                          | See also 'TST_DEV_EXTRA_OPTS', 'TST_DEV_FS_OPTS', 'TST_FS_TYPE'.
>  |                          | Implies 'TST_NEEDS_DEVICE=1' (no need to set it).
> +| 'TST_DEVICE'             | Block device name for 'tst_mount' and 'tst_mkfs', see
> +|                          | https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem]
>  | 'TST_FS_TYPE'            | Override the default filesystem to be used.
> +| 'TST_MNTPOINT'           | Holds path to mountpoint when use 'tst_mount', see
                                                         ^
							 used in 'tst_mount'
> +|                          | https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem]
> +| 'TST_MNT_PARAMS'         | Extra mount params for 'tst_mount', see
> +|                          | https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem]
>  | 'TST_NEEDS_ROOT'         | Exit the test with 'TCONF' unless executed under root.
>  |                          | Alternatively the 'tst_require_root' command can be used.
>  | 'TST_NEEDS_TMPDIR'       | Create test temporary directory and cd into it.

Other than the minor correction:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
