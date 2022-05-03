Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D1AC433EF
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 15:10:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E9B73CA8D9
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:10:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E91383CA8A1
 for <ltp@lists.linux.it>; Tue,  3 May 2022 17:10:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 163ED140097D
 for <ltp@lists.linux.it>; Tue,  3 May 2022 17:10:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D7A61F38D;
 Tue,  3 May 2022 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651590633;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzZp62RQarHaUU9DFRMz45N9YLauIMcUjqdnYFi1m+M=;
 b=kyg7+stnVOwYdWO/nCZf7eC0lCgD5Gh2YTRm3cujqIG15Zuy5ZXhxIZ6RKbUqkqr1yPyr5
 kwpyTpPxSJlSHTmCbf9W58s6lsu1ZgaYFHeS/4YOqXBF4qT5KIWOgGX+oMWtvr4ywX9Gm7
 T6bonMHo0xm1TI6Ktzx9e76jJWIjICk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651590633;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JzZp62RQarHaUU9DFRMz45N9YLauIMcUjqdnYFi1m+M=;
 b=G87cbb3bbyrQt282q08DcGWWdWQI0rfjSR1MekL9grgtfYRRSa9dO7D4ZGt5fNFouITB9W
 LEWW5thuKGF1eFBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA9BC13ABE;
 Tue,  3 May 2022 15:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Up/fN+hFcWLvegAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 May 2022 15:10:32 +0000
Date: Tue, 3 May 2022 17:10:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Message-ID: <YnFF54y/OJ/v2B14@pevik>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
 <81ac339d9c92668acabbdd396092bc4b67119872.1651176646.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81ac339d9c92668acabbdd396092bc4b67119872.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 08/19] API/cgroup: refuse to mount blkio when io
 controller is mounted
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

Hi Luke,

> Mounting the v1 blkio controller while v2 io controller is mounted
> unmounts the io controller, triggering a tst_brk that the number of
> controller has gone down.

> Because these controllers don't seem to be compatible, tst_brk with
> TCONF and report that we refused to mount the blkio controller while the
> io controller is mounted.

> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
>  lib/tst_cgroup.c | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 254f4aaca..6794046e2 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -717,6 +717,11 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const ctrl)
>  	char mnt_path[PATH_MAX];
>  	int made_dir = 0;

> +	if (ctrl->ctrl_indx == CTRL_BLKIO && controllers[CTRL_IO].ctrl_root) {
> +		tst_brk(TCONF,
> +			"IO controller found on V2 root, skipping blkio mount that would unmount IO controller");
Good catch! I'm just not sure if it wouldn't be better to use tst_res(TCONF,
..); return;
Because with tst_brk we're not skipping the test but quiting, right?
That's not true for tst_cgctl.c used in shell API (your changes),
but it'd be for tests which use C API.

Kind regards,
Petr

> +	}
> +
>  	sprintf(mnt_path, "%s%s", cgroup_mount_ltp_prefix, ctrl->ctrl_name);

>  	if (!mkdir(mnt_path, 0777)) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
