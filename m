Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71967C0015E
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 11:06:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C61A3CE762
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 13:06:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD5313C01A5
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 13:05:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 712121A00F21
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 13:05:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA7541F895;
 Tue, 25 Jul 2023 11:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690283153;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DOHiCKBItvAe5iC4xobPx4oUdn+/ZJhguQyjduIwV/Y=;
 b=TsLdMoJ6k0efa1QqMS3DjTpnyvOnUJbz2d3Z51TeRFlVBeLk9XrPERd6vmVHQblImSzF6T
 ph4aP0TCZAUJVZDkM8R64zP8FVnuIkyS/9Atp29Rdw+s9m966LvrPuduEPuJaAdr3KBRho
 Ij2/CuvErCKgNvS6VN84YpHOrRosMzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690283153;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DOHiCKBItvAe5iC4xobPx4oUdn+/ZJhguQyjduIwV/Y=;
 b=a5eN9j7vgggqSNQMtRl81pDb9MtkMqDqtOuo/IDcYPUPZ2MkwLul2U4Vf5+C5ZVpd8LZA/
 vouGKxI6cl8l2qAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 898A813487;
 Tue, 25 Jul 2023 11:05:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CHFvH5Gsv2ReEQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jul 2023 11:05:53 +0000
Date: Tue, 25 Jul 2023 13:05:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230725110552.GA1639899@pevik>
References: <20230721091515.1353371-1-pvorel@suse.cz>
 <20230721091515.1353371-3-pvorel@suse.cz>
 <f80349b8-a72e-454d-1ffd-b732bad7b640@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f80349b8-a72e-454d-1ffd-b732bad7b640@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] tst_lockdown_enabled: Print lockdown state
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

> Hi,
> Printing "Kernel lockdown: %s" instead would make more sense to the user.
> But that can be fixed during merge.

+1, I'll fix that during merge.

Kind regards,
Petr

...
> > +	tst_res(TINFO, "Lockdown: %s", ret ? "on" : "off");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
