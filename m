Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAF5C3DA49
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 09:47:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A01C3D1F53
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 11:47:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A82563D1C3E
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 11:47:33 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B73096006DD
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 11:47:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9EA181F38C;
 Fri,  2 Aug 2024 09:47:31 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C09B1388E;
 Fri,  2 Aug 2024 09:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uh5eHDOrrGZyLgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 02 Aug 2024 09:47:31 +0000
Date: Fri, 2 Aug 2024 11:47:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240802094732.GA1613449@pevik>
References: <20240802-fchmodat2-v5-0-bff2ec1a4f06@suse.com>
 <20240802-fchmodat2-v5-1-bff2ec1a4f06@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240802-fchmodat2-v5-1-bff2ec1a4f06@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9EA181F38C
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/5] Add SAFE_SYMLINKAT macro
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

Hi Andrea,

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/safe_macros_fn.h  |  4 ++++
>  include/tst_safe_macros.h |  3 +++
>  lib/safe_macros.c         | 20 ++++++++++++++++++++
>  3 files changed, 27 insertions(+)

> diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
> index d256091b7..6d9e72e4f 100644
> --- a/include/safe_macros_fn.h
> +++ b/include/safe_macros_fn.h
> @@ -122,6 +122,10 @@ int safe_symlink(const char *file, const int lineno,
>                   void (cleanup_fn)(void), const char *oldpath,
>                   const char *newpath);

> +int safe_symlinkat(const char *file, const int lineno,
> +                 void (cleanup_fn)(void), const char *oldpath,
> +                 const int newdirfd, const char *newpath);
> +

IMHO we agreed that we don't touch legacy API unless really needed.
If I remember correctly (I'm sorry I don't have a link), Cyril was not against
modifying lib/safe_macros.c (I would be against there is no need to touch old
API at all), but he was against exposing safe_symlinkat() in old API headers.

@Cyril correct me please if I'm wrong.
@Andrea if not, would you mind to move things to include/tst_safe_macros.h
and lib/tst_safe_macros.c?

The code itself is correct.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
