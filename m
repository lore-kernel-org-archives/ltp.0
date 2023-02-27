Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B2DC64ED8
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 15:26:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 674EE3CDE5D
	for <ltp@archiver.kernel.org>; Mon, 27 Feb 2023 16:26:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C63303CB726
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 16:26:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E948623D356
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 16:26:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 34AE01FD63;
 Mon, 27 Feb 2023 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677511603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2rcw7tU8624pfigUNWmQAe8d+B9k2swsxAgftZ4HFbo=;
 b=BgaXIvFfYXAdZxzJ7eHYVlTpXQ7wZPrENvdrqHl4xgwWp+7zsmgd8LpnAYRFOfsiNZDrg5
 8Rtxxy4kYqGXj39cqTBB5JGimYyl8690/Wa1UBDl3LqcigrBxQZ9w5rKjgU9XfNB7BZU/O
 fCEfPc7dQ9zPdv4ba0mzaTYLcAXt/g8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677511603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2rcw7tU8624pfigUNWmQAe8d+B9k2swsxAgftZ4HFbo=;
 b=GIsv/e7pTZbE3OvyrXqWwVIcuPjLjaoZtYMMW35k2i/TBFPhlY33Q27r2dopn7tB3JQG3J
 uCYRO0l7IhDaRpBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BBD013A43;
 Mon, 27 Feb 2023 15:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lNf/BLPL/GNlJwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 27 Feb 2023 15:26:43 +0000
Date: Mon, 27 Feb 2023 16:28:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y/zMBSx4p3gqRC3J@yuki>
References: <20230227144402.GA23697@localhost> <Y/zFIdiWccmVzddV@yuki>
 <20230227151709.GA12774@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230227151709.GA12774@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Question on .needs_cgroup_ctrls for cgroupv2
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
Cc: rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> So .needs_cgroup_ctrls can not used anymore for ONLY V2 case?
> Since i encounter "tst_cgroup.c:848: TCONF: V2 'memory' controller required, but it's mounted on V1" when i add ".needs_cgroup_ctrls = (const char *const []){ "memory", NULL }". 

Each controller can be mounted as V1 or as V2 but not both at the same
time. It depends on how the system is booted, the default on most
distributions is mixed V1 and V2 at the moment. If you want V2 system
you have to reboot with systemd.unified_cgroup_hierarchy=1.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
