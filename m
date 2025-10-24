Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E5DCCF9E0
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 15:40:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BF3F3CF2EB
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 17:40:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13CE03C5705
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 17:39:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7C79F2000B2
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 17:39:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2505221205;
 Fri, 24 Oct 2025 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761320383;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O0frLo6AAYuIHoErSNJWjvArRA0LONXYgy0IVn5afxI=;
 b=RjxXkegjZ2eBbe1dfJwh761EMriEw3uQOBqqiK0ev4+bVn1ZjFGJTYDOQOwD3hia1tn0VC
 GE6/OGOxalSDjTrgysvItzvtDWwGMe6E3DEflbu00/NXObnFv+GD+YWShKzhCBioFkucN7
 ZzENC5LUV2jM0x9tXDbGLtxkgH1tCpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761320383;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O0frLo6AAYuIHoErSNJWjvArRA0LONXYgy0IVn5afxI=;
 b=m7Rz+Z4Cf/9A7+OXUdVsiJ21t5UcaOrKxUv8ynXBlkrbG4uC3hxLQcdwDx+Ip9sYbAhtWo
 B819ID/Nmu1hVzBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761320383;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O0frLo6AAYuIHoErSNJWjvArRA0LONXYgy0IVn5afxI=;
 b=RjxXkegjZ2eBbe1dfJwh761EMriEw3uQOBqqiK0ev4+bVn1ZjFGJTYDOQOwD3hia1tn0VC
 GE6/OGOxalSDjTrgysvItzvtDWwGMe6E3DEflbu00/NXObnFv+GD+YWShKzhCBioFkucN7
 ZzENC5LUV2jM0x9tXDbGLtxkgH1tCpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761320383;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O0frLo6AAYuIHoErSNJWjvArRA0LONXYgy0IVn5afxI=;
 b=m7Rz+Z4Cf/9A7+OXUdVsiJ21t5UcaOrKxUv8ynXBlkrbG4uC3hxLQcdwDx+Ip9sYbAhtWo
 B819ID/Nmu1hVzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA3F0132C2;
 Fri, 24 Oct 2025 15:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NoMCJ76d+2hmCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Oct 2025 15:39:42 +0000
Date: Fri, 24 Oct 2025 17:39:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20251024153941.GA609911@pevik>
References: <20251024125649.2343520-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251024125649.2343520-1-anders.roxell@linaro.org>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] isofs: Add ISO9660 kernel config requirement
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
Cc: benjamin.copeland@linaro.org, dan.carpenter@linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Anders,

> The isofs test requires ISO9660 filesystem support to test mounting and
> accessing ISO images. Without CONFIG_ISO9660_FS enabled, the test fails
> with "unknown filesystem type 'iso9660'" errors during mount attempts,
> resulting in 140 failed test cases.

> Add the CONFIG_ISO9660_FS kernel configuration requirement to ensure the
> test properly skips with TCONF on systems without ISO9660 support,
> either built-in or as a module.

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  testcases/kernel/fs/iso9660/isofs.sh | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
> index 088e062d67c6..c66a284cebf1 100755
> --- a/testcases/kernel/fs/iso9660/isofs.sh
> +++ b/testcases/kernel/fs/iso9660/isofs.sh
> @@ -11,6 +11,7 @@

>  TST_NEEDS_CMDS="mount umount"
>  TST_NEEDS_TMPDIR=1
> +TST_NEEDS_KCONFIGS="CONFIG_ISO9660_FS=y | CONFIG_ISO9660_FS=m"

LGTM
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>  TST_TESTFUNC=do_test
>  TST_CNT=3
>  TST_SETUP="setup"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
