Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AECC433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 11:13:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C10B3C8C70
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 12:12:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 676E33C2AE3
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 12:12:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D605C600640
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 12:12:48 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1686821122;
 Mon, 24 Jan 2022 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643022768;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MWSMnAo5cK/gOUnbd+JOur/e9HgMpt/aTIRgRdSL1s0=;
 b=oNHec/wSMhuULQeGtpaseJypALXP8dgX2tfcHeBfpYddtY820U4fhXvPe9ld14m8AMCNFQ
 p/9FLWV9DAQFOXDu1+OK2z2JJW1Tw9DOQLRi4OtHuZNx11MOisFaE1RBrr9Y9VsJl1HeNO
 qr9KrpJwn1FxV4VPombAlQT/0rWCYE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643022768;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MWSMnAo5cK/gOUnbd+JOur/e9HgMpt/aTIRgRdSL1s0=;
 b=fJ3n4kMZvrB9Q5YVD/eErIy633terIGVaEvH72pS+qJoDpRKzMkjEtoDi71i9K58m/s/8Y
 ept9UQvPdgCl2wAw==
Received: from g78 (unknown [10.163.24.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C8770A3B84;
 Mon, 24 Jan 2022 11:12:47 +0000 (UTC)
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <2a49929d166ac88d4c7900c5961be77cbd601fa4.1642601554.git.luke.nowakowskikrijger@canonical.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Mon, 24 Jan 2022 10:44:17 +0000
In-reply-to: <2a49929d166ac88d4c7900c5961be77cbd601fa4.1642601554.git.luke.nowakowskikrijger@canonical.com>
Message-ID: <87o841z8sx.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 06/16] API/cgroup: Change to TWARN when v2
 controllers change
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Luke,

Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> writes:

> When the v1 blkio controller is mounted it unmounts the v2 io controller
> effectively bringing the amount of cgroupv2 controllers down and
> triggering the tst_brk. Because this is exected behaivor it should be
> changed to TWARN in case there is something funny still going on and
> should be logged.

Ah, we are in new territory here, the library assumes this won't happen.

What happens if a test author requires the V2 io controller then
requires the blkio controller?

At best I think we will get TBROK saying some file doesn't exist. Not
too bad, but nothing helpful either.

Also what happens if the io controller was in use, disappears then
returns? (that is, if it returns, because unmounting V1 controllers
doesn't guarantee the V1 root is destroyed and it can block V2 from
being used afterwards).

The basic assumption we originally made was that we can't mess with the
current CGroup setup beyond adding to it. LTP doesn't guarantee it won't
mess up your system, but it at least tries not to. Pulling controllers
out from underneath the system manager seems likely to cause wierd
errors for people.

Why not treat the blkio controller and io controller as the same thing?
Or if they are not remotely compatible, then do tst_brk(TCONF... when we
need blkio, but io is on V2.

BTW, this is a moot point, but TWARN is really only used when we think
an error was just caused by previous errors. Otherwise, if something is
expected, then it should be TINFO.

>
> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
>  lib/tst_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 3d56a3364..c53b88ed2 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -677,7 +677,7 @@ static void cgroup_root_scan(const char *const mnt_type,
>  		goto discard;
>  
>  	if (root->ctrl_field)
> -		tst_brk(TBROK, "Available V2 controllers are changing between scans?");
> +		tst_res(TWARN, "Available V2 controllers are changing between scans?");
>  
>  	root->ver = TST_CGROUP_V2;


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
