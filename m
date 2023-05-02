Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9823C77B73
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 06:56:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EE103CB8F3
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 08:56:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55A2D3CB8B0
 for <ltp@lists.linux.it>; Tue,  2 May 2023 08:56:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 66CD11A006EF
 for <ltp@lists.linux.it>; Tue,  2 May 2023 08:56:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB2CE1F8AE;
 Tue,  2 May 2023 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683010563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OqbTu56fUKslG4lp/QzHK85RUqFi6rLZcVdyBgy4Vy4=;
 b=LJRXdqQFWjfQuSqFrui4oPSFnVmFaGQzv+OfIUuUj5GPwLZKC2N5Tflk+Lj2e4hXx2O9az
 QK014hswiLmSPUiHWQpvplXLcyL+PNr3mwG+r41j4gKxsIUQEz3oeYMDGL6dG5I7rQHaV+
 vJrJdGcVogoJSsaXHdh1uKaJY4O5EAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683010563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OqbTu56fUKslG4lp/QzHK85RUqFi6rLZcVdyBgy4Vy4=;
 b=j28ZrbChT8OsLjA7MrHcwSbo4iBYyUNDU9vrGv3MH8v0p6QGybAovd8TWMz5zYmX9OnTy1
 ANF4Y9g91Hw95HDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 564C7139C3;
 Tue,  2 May 2023 06:56:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IUQIEgO0UGREfwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 02 May 2023 06:56:03 +0000
Date: Tue, 2 May 2023 08:56:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230502065616.GA3604091@pevik>
References: <20230428101038.7253-1-wegao@suse.com>
 <20230430074811.29555-1-wegao@suse.com>
 <20230430074811.29555-2-wegao@suse.com>
 <CAEemH2cK60iL2cxeJQVfAwcqmhtmdA5=L25M5QEreMmp74-gCA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cK60iL2cxeJQVfAwcqmhtmdA5=L25M5QEreMmp74-gCA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 1/2] tst_cgroup.c: Add a cgroup base controller
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

Hi Wei, Li,

> Hi Wei,

> Seems we have to skip the cgroup.subtree_control cleanup
> process inside tst_cg_cleanup(), otherwise, test complains that
> there is error operation in line#1020 if the unified cgroup-V2
> was mounted by LTP.

> (no need to resend another patch, someone who merge this can help fix.)

> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -1012,7 +1012,8 @@ void tst_cg_cleanup(void)
>         }

>         for_each_ctrl(ctrl) {
> -               if (!cgroup_ctrl_on_v2(ctrl) ||
> !ctrl->ctrl_root->we_mounted_it)
> +               if (!cgroup_ctrl_on_v2(ctrl) ||
> !ctrl->ctrl_root->we_mounted_it
> +                               || !strcmp(ctrl->ctrl_name, "base"))
>                         continue;

Agree.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>                 SAFE_FILE_PRINTFAT(ctrl->ctrl_root->mnt_dir.dir_fd,

> With above fix:

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
