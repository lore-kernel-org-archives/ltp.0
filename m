Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23287C433F5
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 09:55:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B34583C9549
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 10:55:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A4733C90AA
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 10:55:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 83BD160086C
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 10:55:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CAEC71F381;
 Tue, 25 Jan 2022 09:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643104506;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HM6ZF/qRnSTA4Qh2M61L2gX+c5zFoKMCFTcd6R/vkxM=;
 b=VBo44aAiqCCvZYzbOLyvEYSYT12lGLfxSkteGZAsjLz6nDM9XjV8O/LQLrGc+KuLcFTThA
 4LtSTayD21+4QK40DlPcXHMjknkh49uyRi2J6PSpqDLi17Cqq/2QrsZ1YW1pqjWthXMtdU
 p2Mg4ogLaCmir9krQOC/psdDXilOLsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643104506;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HM6ZF/qRnSTA4Qh2M61L2gX+c5zFoKMCFTcd6R/vkxM=;
 b=MPQN4QkEwt8Ejb2IX5GUWod98rhy9BjOPwNX5vyYFkvPlVDPtKCMJRZeHpzWKrl3lLiaaA
 nj+NrgIJ/TGT3bBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C04213D92;
 Tue, 25 Jan 2022 09:55:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cJZxJPrI72HmVQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jan 2022 09:55:06 +0000
Date: Tue, 25 Jan 2022 10:55:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Murphy Zhou <jencce.kernel@gmail.com>
Message-ID: <Ye/I+Kfg0wmeTeFs@pevik>
References: <20220125024746.gukme7rfwe6l3bix@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220125024746.gukme7rfwe6l3bix@xzhoux.usersys.redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] runtest/fs: add fsnotiy-stress
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

Hi Murphy,

> +++ b/runtest/fs
> @@ -87,3 +87,5 @@ binfmt_misc01 binfmt_misc01.sh
>  binfmt_misc02 binfmt_misc02.sh

>  squashfs01 squashfs01
> +
> +fsnotify-stresss.sh fsnotify-stress.sh
Please in next version put this into previous commit.  We put new entries into
runtest files as part of commit which introduces new tests.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
