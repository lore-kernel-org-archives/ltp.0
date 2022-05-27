Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A301CC433EF
	for <ltp@archiver.kernel.org>; Fri, 27 May 2022 10:37:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBEF43C144A
	for <ltp@archiver.kernel.org>; Fri, 27 May 2022 12:37:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DD373C05C3
 for <ltp@lists.linux.it>; Fri, 27 May 2022 12:36:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3BBA51000656
 for <ltp@lists.linux.it>; Fri, 27 May 2022 12:36:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7EB6E1F92B;
 Fri, 27 May 2022 10:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653647809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OThoFRkZukXagraBU83iGkNCIgFu3sItzHGUy1gCnD0=;
 b=ZlPzHebLBkeg3g0gAqJ9Xz3cAATi4CYkz9VTZaX7HzNqVOsBioPn8SwwPk4GfIsNyFcEUe
 aSZmGp5UhM1S2HMkQGftK/WFxjN54+oAzzEhTLM+t2veGyd3NAVoOHXu5AM8WTAiOQodKp
 LiiOyrWCXwqKtkuyRF6k6uojg/GNXxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653647809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OThoFRkZukXagraBU83iGkNCIgFu3sItzHGUy1gCnD0=;
 b=Iu2NQX6htA9KHbH70QO6ZxgIfWGVdaZCkzix+MU2svAdBNcVDIWm/ivNgEpK3KX3TftwPA
 hsNzvDbPMGJBNTBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50AC413A84;
 Fri, 27 May 2022 10:36:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9YuIEcGpkGI3cQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 27 May 2022 10:36:49 +0000
Date: Fri, 27 May 2022 12:36:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <YpCpv3B5eDzjz/Q9@pevik>
References: <20220428104642.110-1-chenhx.fnst@fujitsu.com>
 <YoSzazXY+BRhAPmc@pevik> <62850DFF.8030607@fujitsu.com>
 <YoUT8GWHB0QCtbcV@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YoUT8GWHB0QCtbcV@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] syscalls/mount_setattr01: Add basic functional
 test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

merged.

I'm sorry Xu, I have forgotten to add your Reviewed-by.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
