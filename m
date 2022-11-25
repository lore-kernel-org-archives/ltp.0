Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB07C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 16:43:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36FE03CE110
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 17:43:28 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52F473CC8EC
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 17:43:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A8177600E53
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 17:43:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 77EBB1FD82;
 Fri, 25 Nov 2022 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669394596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u/eJ4UxVoSlLRrPva7khlNvqulZ0eRuWavJ8zBUBYUs=;
 b=WjBhONECsigVuvlPD4msKFEYxczzZSDEDhOPHHXmbtdmxK8DclDTxtbqaY1EDkcgP90CoI
 InuTitZn0BWmsG+aedEt+IX6YzilrJ+EBfql8nKJBEqifQCsiA5EPL0HMHuwhtg2BI9hzw
 m5T4nlxRz58LbIVBHNeU54ID88DkD2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669394596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u/eJ4UxVoSlLRrPva7khlNvqulZ0eRuWavJ8zBUBYUs=;
 b=40bGK5Qdt5MV9oly3SQoY6PNe9BTkasVxA+1xdjTrNN6ZSU0t55teh8sbe4bSa8NmKtqg/
 reJGu+HGVBjCtQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A8381361C;
 Fri, 25 Nov 2022 16:43:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wSn8DaTwgGMpLwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Nov 2022 16:43:16 +0000
Date: Fri, 25 Nov 2022 17:43:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y4DwocwY/SQnVPY0@pevik>
References: <20221125153453.19323-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221125153453.19323-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Implement tst_setup_netns() helper function
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

Hi Martin,
> Namespace setup boilerplate for network tests is getting more complicated
> with the need to check or modify some sysfiles. Move it into LTP library.
+1

Reviewed-by: Petr Vorel <pvorel@suse.cz>

>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>  #include "tst_net.h"
>  #include "tst_private.h"
> +#include "lapi/namespaces_constants.h"
WDYT about adding <sched.h> to lapi/namespaces_constants.h?
(not related to this patchset at all).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
