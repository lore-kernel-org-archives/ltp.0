Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DBBC48BC3
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 07:33:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 185E43CFB14
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 08:33:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C60FF3CD90E
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 08:33:03 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5BBC01000C1D
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 08:33:01 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAFA32208B;
 Wed, 21 Feb 2024 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708500779;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TtPvIBdfAYvO2mYgkdzsyowg5HQRuFW0ZjKyevJ+HhA=;
 b=iqAWlAHhnfnHagnHcaJ0x4poqdcYn4HMOoLLmZm39xSp19P5JqGOuf3m7XMnxBrCLtzPZj
 iUtjpkqQijxyXcanIGvPMcGkUWuDcnPso2yyriauKHfR46Ge3vQrfcsvYCh8ukKoBA7PnK
 6LnwQYTRCxJS4PcFRRUSORL5mKbQjOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708500779;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TtPvIBdfAYvO2mYgkdzsyowg5HQRuFW0ZjKyevJ+HhA=;
 b=NPUec180h81FyFhmkCYpM4SRyXPCaHBsOGPgKV3hzOvuE9/Pur0nszuYxVEKxW80UdFuXd
 9ltgLK66RV8idrDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708500778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TtPvIBdfAYvO2mYgkdzsyowg5HQRuFW0ZjKyevJ+HhA=;
 b=ryJ0foYaLCUHwpYT1kWQDDatEyO2CtWjraIL/XQVvUrEI4DYL/kwEPWno+TAXFoKFqn52Z
 a217t1+3ldL0OY3lng5pnE8t94KPB6WyeGbeEuQ76tZ0SZ41CV9VmyL8nyzx0vEyEnI8Nu
 qtN3zAn7DnVhmpdOwDX95q31yIw/ZxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708500778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TtPvIBdfAYvO2mYgkdzsyowg5HQRuFW0ZjKyevJ+HhA=;
 b=bU6T6ERRVC0NWaYcoH3GoSXrx8lT9mjkd5WLOPiJSnOyzmYRqYSGN5m8vM8BEG+GIVdUxL
 v4qRzuAcQkvJfnBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id ADB4C13A25;
 Wed, 21 Feb 2024 07:32:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id hJQTKSqn1WX3bgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 21 Feb 2024 07:32:58 +0000
Date: Wed, 21 Feb 2024 08:32:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240221073249.GA1213466@pevik>
References: <20240219134845.22171-1-wegao@suse.com>
 <20240221071635.17239-1-wegao@suse.com>
 <20240221071635.17239-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240221071635.17239-3-wegao@suse.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ryJ0foYa;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bU6T6ERR
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.73 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 ARC_NA(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.02)[52.10%]
X-Rspamd-Queue-Id: CAFA32208B
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] statx07.c: set umask to 0022
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

Hi Wei,

> When system's default umask is 0077, this will trigger issues.

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/statx/statx07.c | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
> index 4dbf83e18..1ad02fb3e 100644
> --- a/testcases/kernel/syscalls/statx/statx07.c
> +++ b/testcases/kernel/syscalls/statx/statx07.c
> @@ -116,6 +116,8 @@ static void setup(void)
>  	int ret;
>  	char server_path[BUFF_SIZE];

> +	umask(0022);
Even this works, why not completely reset umask with umask(0), as I asked
previously? That's the safest option.

Kind regards,
Petr

> +
>  	cwd = tst_get_tmpdir();

>  	SAFE_MKDIR(SERV_PATH, DEFAULT_MODE);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
