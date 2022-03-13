Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5E3C433F5
	for <ltp@archiver.kernel.org>; Sun, 13 Mar 2022 21:09:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B90063C913F
	for <ltp@archiver.kernel.org>; Sun, 13 Mar 2022 22:09:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C25063C0CEA
 for <ltp@lists.linux.it>; Sun, 13 Mar 2022 22:09:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C52FB20016D
 for <ltp@lists.linux.it>; Sun, 13 Mar 2022 22:09:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0FD821100;
 Sun, 13 Mar 2022 21:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647205778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nRr6YUxq6gDTBshGySyabogQib7U9e75XoVlYAfCRLk=;
 b=XlYo4XPuoAWiHypLINVTPilKhuGQEW9BPLVGl+iFNTxGFLOSjn+XeRT8sfgq1oYH5gdOhP
 np03886B9v9Cf+SzrxmlgGBR7j/2v+U4UWWmmerQs7utrp9e6TKiPwbzcSev0NjMsBoAWf
 dhVFnKc6gCx7ZQV5bxcuZFddeocYyVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647205778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nRr6YUxq6gDTBshGySyabogQib7U9e75XoVlYAfCRLk=;
 b=eAjrw096rtV2q+TNJbmsm0KLKzNhM3yRb4Egqp9iEXQbUEa2cQ+JK4aUjgka5ZASI8Nn1g
 eg9WwVv3Xin472CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9734313AFE;
 Sun, 13 Mar 2022 21:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id It1IIpJdLmLdKgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sun, 13 Mar 2022 21:09:38 +0000
Date: Sun, 13 Mar 2022 22:09:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yi5dkdAkkU1yVRUz@pevik>
References: <20220311124923.6504-1-pvorel@suse.cz>
 <ea39e6ce-7b6f-66e1-40e9-f616506ece35@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea39e6ce-7b6f-66e1-40e9-f616506ece35@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfs_lib: Fix fsid randomisation
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
Cc: Neil Brown <neilb@suse.de>, Martin Doucha <martin.doucha@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi,
> I can confirm that this patch fixes the test failures.

> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

Thanks for your review, merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
