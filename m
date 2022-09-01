Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E0FECAAD2
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 06:10:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D7753CA834
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 08:10:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36AEE3CA754
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 08:10:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A4C43200B76
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 08:10:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 895E31FA66;
 Thu,  1 Sep 2022 06:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662012628;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TbgQAWYnA/rbBlnL7cRGQ1aguCeoO6oRrwi5OO9icjM=;
 b=FyzCSc7qWe4t8eqat4H0ROTFXcsPsnDvY1NkE8tOKNcfImLSlcLP4lQdFyvoNYqdVu3sdc
 iadeq1iCn693gO6x/GVShjtJ/loKYB4w3TmoVUcXXrE4jW7ac5aKJtlf6DxeQ/YFW/II10
 51iu7qbj2uN0vGn5LPyA9QJDXxiHvn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662012628;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TbgQAWYnA/rbBlnL7cRGQ1aguCeoO6oRrwi5OO9icjM=;
 b=Z9HR+Qhv9JN+ww53A0nx4To3nekaSxXJ+2l6p3W/AosR3m2g9RLeo7+ZlN/jTU8xLIqLat
 D/eEazaNmVeGFADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C8F013316;
 Thu,  1 Sep 2022 06:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vaCGENRMEGN1FgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 01 Sep 2022 06:10:28 +0000
Date: Thu, 1 Sep 2022 08:09:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YxBMry8v0Bgie3UO@pevik>
References: <20220831112620.54251-1-luoxiaoyu9@huawei.com>
 <Yw9VzAE1YhkwaR1f@pevik> <5857767.lOV4Wx5bFT@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5857767.lOV4Wx5bFT@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/open04.c: Rewrite open04.c using new LTP
 API --------------------
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

> Hi Luo, Petr,

> FYI, There is already a patch for this on the list which I had sent last month, it might have been missed.
> http://patchwork.ozlabs.org/project/ltp/patch/20220714060722.18894-1-akumar@suse.de/
I'm having a look at it.

Kind regards,
Petr


> Regards,
> Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
