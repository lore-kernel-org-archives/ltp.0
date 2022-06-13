Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB02C43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 15:13:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98B823C9428
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 17:13:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B56C3C110E
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 17:13:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 11B2C60009A
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 17:13:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5662721B94;
 Mon, 13 Jun 2022 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655133209;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EdgzsnKMcx/wec63D9wT1ARkDgTEVdwPFlFf2BC4NsA=;
 b=Z9fBPlR8wYVpzxis1fr0C+V+PHuANXYJafW81Jcns52axqfu5AI08MrkqtBCuXTzCm7wmM
 E58ZbuCOwap+fBycih43l/ItCXpDpYfMbt0h6AmUABmZnGECEFRN3kg4+W3aIs2qV9ry51
 3RddVfUfKlFdoPtvKJTIyc4u5OAEmq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655133209;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EdgzsnKMcx/wec63D9wT1ARkDgTEVdwPFlFf2BC4NsA=;
 b=xCsOKJl7g/87mqAYllOxbe66VNO2emvCRP3AQtAp3BWPIKMN7ee92iY6I+nGjeyoJingRD
 8/a5Ry5hj0mo3VAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E602013443;
 Mon, 13 Jun 2022 15:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id e8PcNRhUp2LpVQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Jun 2022 15:13:28 +0000
Date: Mon, 13 Jun 2022 17:13:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <YqdUF8Z4zLZ+5cEf@pevik>
References: <1653636077-13606-1-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1653636077-13606-1-git-send-email-zhanghongchen@loongson.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Hongchen,

The script is really messy that I understand why people are rewriting cgroup
tests into C which has also cgroup v2 support among other improvements. Although
FYI there is ongoing effort to add this cgroup v2 support also to shell tests,
my guess is that sooner or later anything relevant will be rewritten to LTP C API.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=297465&state=*

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
