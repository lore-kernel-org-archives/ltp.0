Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CD9C5478C
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 08:43:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF5253CED68
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 09:43:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFE6F3CED2D
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 09:43:19 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A59CD600055
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 09:43:18 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7BE022B39;
 Fri,  1 Mar 2024 08:43:16 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8095C13A39;
 Fri,  1 Mar 2024 08:43:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id b+JeHiSV4WVkCQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Mar 2024 08:43:16 +0000
Date: Fri, 1 Mar 2024 09:43:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240301084311.GA1660278@pevik>
References: <20240221084256.32661-1-wegao@suse.com>
 <20240222031018.12281-1-wegao@suse.com>
 <20240222031018.12281-2-wegao@suse.com>
 <CAEemH2cXOi0DpE1p36H-hUxuH2o8WwhD8DUPndBDMoKBbJJnCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cXOi0DpE1p36H-hUxuH2o8WwhD8DUPndBDMoKBbJJnCQ@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A7BE022B39
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] cgroup_core01.c: Set system default umaks
 to 0
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

Hi Li,

> Hi Wei, Petr,

> Seems the problem Wei met is the default umask of 0077,
> any new files or directories that are created will have their
> permission bits modified by this umask.

> After looking though what you both discussed, I think maybe
> another better choice is to set the umask to '0000' temporarily
> before creating the directory, and then restoring the previous
> umask right after.

> All these operations are just put into cgroup_dir_mk function.

LGTM this approach, please send a patch.

> Something like this:

> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -368,8 +368,11 @@ static void cgroup_dir_mk(const struct cgroup_dir
> *const parent,
>         new->ctrl_field = parent->ctrl_field;
>         new->we_created_it = 0;

> +       mode_t old_umask = umask(0000);
nit: umask(0) is the same right?

Kind regards,
Petr

> +
>         if (!mkdirat(parent->dir_fd, dir_name, 0777)) {
>                 new->we_created_it = 1;
> +               umask(old_umask);
>                 goto opendir;
>         }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
