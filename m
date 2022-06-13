Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28498C43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 15:09:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD88B3C9430
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 17:09:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FE833C110E
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 17:08:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B7C001000901
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 17:08:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0418E21B8B;
 Mon, 13 Jun 2022 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655132927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nhgNJ8RwIcY7wMowmtHFvOq8ZeK4CsJpNuwGyvHt818=;
 b=fzXU+qKa6n3x3YOKoAVXWI3vwsX3hIh3qwwEwAesQ1S2AjvR9wnFJqzkHeGCYiWiRd/V13
 /gzf/WYdec4xqy994RBznnJkoxboO/O6EbnhKMGbQvi+ZbqRtj2sjL1kLhU9J0FHQ7SmYY
 gsDIxSujQJiDUWXtP7xEipz93iUWWtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655132927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nhgNJ8RwIcY7wMowmtHFvOq8ZeK4CsJpNuwGyvHt818=;
 b=z2aMzdGK1HLXcMN8D9fRegPChZo35+zAzYoC+3EUIxN+Efp0+FNA5uBBSZPc+OfGEmujKK
 L5HtfQBq3ELjuEDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D10913443;
 Mon, 13 Jun 2022 15:08:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0XD2Hv5Sp2IGVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Jun 2022 15:08:46 +0000
Date: Mon, 13 Jun 2022 17:08:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <YqdS/GnQg4kcNbHH@pevik>
References: <1653636077-13606-1-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1653636077-13606-1-git-send-email-zhanghongchen@loongson.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/cpuset: default
 cpuset.sched_load_balance to 1
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Hongchen,

> when we exited between the cpuset test,we may leave /dev/cpuset
> not cleared. And we did the cpuset test again, we would set the
> cpuset.sched_load_balance to 0 as following:
> 	setup()
>         if [ -e "$CPUSET" ]
>         cleanup
> 	echo $SCHED_LB_VALUE > $SCHED_LB
> as the default value of cpuset.sched_load_balance is 1 at the time
> cpuset mounted, so it is reasonably to be set to 1.

It makes sense to use the default value (1), but how about setting values only
when really get? That'd be IMHO the safest way. WDYT?

-CHILDREN_VALUE="0"
+CHILDREN_VALUE=
 HOTPLUG_CPU="1"
 SCHED_LB="/dev/cpuset/cpuset.sched_load_balance"
-SCHED_LB_VALUE="0"
+SCHED_LB_VALUE=

...
-	echo $CHILDREN_VALUE > $CLONE_CHILDREN
-	echo $SCHED_LB_VALUE > $SCHED_LB
+	[ "$CHILDREN_VALUE" ] && echo $CHILDREN_VALUE > $CLONE_CHILDREN
+	[ "$SCHED_LB_VALUE" ] && echo $SCHED_LB_VALUE > $SCHED_LB

Kind regards,
Petr

> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>  testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> index 9939f13..3991475 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> @@ -61,7 +61,7 @@ CLONE_CHILDREN="/dev/cpuset/cgroup.clone_children"
>  CHILDREN_VALUE="0"
>  HOTPLUG_CPU="1"
>  SCHED_LB="/dev/cpuset/cpuset.sched_load_balance"
> -SCHED_LB_VALUE="0"
> +SCHED_LB_VALUE="1"

>  cpuset_log()
>  {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
