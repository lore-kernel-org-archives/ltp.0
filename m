Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5B6C001DF
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 12:20:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8F253CD0AB
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 14:20:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9EAA3C8B7A
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 14:20:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F288F601027
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 14:20:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4001C1F88B;
 Tue, 25 Jul 2023 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690287615;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OHN74kD8qUKl7u/kH87nn/lW2u70vpgu/sam19enTI=;
 b=AQvkIUpxd6XSsvM6iXB8/ILOrG6L3h8pxoW7PMXN5QuDOG7ga2+a6opWDhAZy69ofa3J98
 pk7AdyGZX5ZYQVmWHl1/g3kB52mw5eqTAc2voJFCVd6DwoEd8qTHZnenlekhFWxIXKIk34
 Tt/qzrf0Y1E1qatm9UNbEsW1XZiO7tI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690287615;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2OHN74kD8qUKl7u/kH87nn/lW2u70vpgu/sam19enTI=;
 b=AHP1/VoFCKCEObLZYEYaKKhprQx3TVYFDLnrRr3e0qS3EkgE8Mk1XV/G7kKvc2O7t6c5om
 2R7n+TVgosNJ/gDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14A2813342;
 Tue, 25 Jul 2023 12:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7tAWAv+9v2S/OwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jul 2023 12:20:15 +0000
Date: Tue, 25 Jul 2023 14:20:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230725122013.GA12613@pevik>
References: <20230721091515.1353371-1-pvorel@suse.cz>
 <20230721091515.1353371-3-pvorel@suse.cz>
 <f80349b8-a72e-454d-1ffd-b732bad7b640@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f80349b8-a72e-454d-1ffd-b732bad7b640@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
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

Thanks for all suggestions, fixed and merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
