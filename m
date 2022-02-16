Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99284C433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 09:26:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA2FB3CA084
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 10:26:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08BA63C9564
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:26:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9087E1A002E6
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:26:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEEE31F383;
 Wed, 16 Feb 2022 09:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645003583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OfgyT6lR/1kmFlxwJ2RSNomReVLn46gItG7GlNetNtg=;
 b=qA1TYPDvpERqmMkCuggUuInlMRrWJwJdeeXH6WZblXN0HTghpjDRwsRKpbUiOKM+stiJ/j
 XEIlcXd5ulGnUps5+ojS1SnpPih1WJ6JTOE66WypBCLcziaoRh6tn3gRSIIsi+32v4N90s
 Yuj8v1xotBSr7lnR9vKbQXlQcCk6NWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645003583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OfgyT6lR/1kmFlxwJ2RSNomReVLn46gItG7GlNetNtg=;
 b=xzrq2ay13bZSDRJuSd9rbMSG4HEQvyC0aCVHPomrXo+ifIqOnXH/B1fOjoIuR75zpAEQ5o
 9/Pxtgvsn0wNv0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4FF313A5E;
 Wed, 16 Feb 2022 09:26:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wKaQJj/DDGJHbQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 16 Feb 2022 09:26:23 +0000
Date: Wed, 16 Feb 2022 10:26:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Bogdan Lezhepekov <blezhepekov@suse.de>
Message-ID: <YgzDPl1u6Nr9YqYI@pevik>
References: <20220216090708.29588-1-blezhepekov@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220216090708.29588-1-blezhepekov@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ltpfs/main.c: Initialize return variable
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

Hi Bogdan,

> LTP_fs_open_block_device returned initialized local
                                    ^ uninitialized ?

> variable, when device handler is occupied.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
