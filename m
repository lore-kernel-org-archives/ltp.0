Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F865EB64DC
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 15:09:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C91BB3CDC76
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 17:09:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13EF33C0222
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 17:09:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E0B406013F1
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 17:09:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3753D1F894;
 Fri, 21 Jul 2023 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689952143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+gosm3SWprTUozKzJhIfyA2l6Xh/K2isMlEfOCVtVk=;
 b=t6Zh5B1yyzRycb6CodL2QtL0rVCaomnLd7ji8A7BhRy5dqe0gUH8QtYatgG70mmxzvIoR7
 M29uiziST+Znj9qxl0IG4USiprTXHv6Blr0iEEqNKQxBSFk0gI/ASCW1OIaCphKEysdORd
 gOpmnZvSwos9iaLQVQQJXBnAdMIz0tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689952143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+gosm3SWprTUozKzJhIfyA2l6Xh/K2isMlEfOCVtVk=;
 b=s44SOA18NQb0Rednnj+IsWa5sRH2SIdS9nHqMEexV6vPnKyH3t4UaaN4p8tNb4AXKn7Pqe
 vGXuXD5nJfLrsqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0E63134BA;
 Fri, 21 Jul 2023 15:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9/F/OI6fumSuIgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 15:09:02 +0000
Date: Fri, 21 Jul 2023 17:09:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230721150901.GA1435454@pevik>
References: <20230315092552.18127-1-andrea.cervesato@suse.de>
 <20230329055459.GA833475@pevik> <20230721125012.GA1421542@pevik>
 <ZLqbjAUAjk49BXQY@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZLqbjAUAjk49BXQY@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite eventfd01 using new LTP API
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

> Hi!
> > Or, Cyril, if you post your RBT, I can change this before merge. Because the
> > proposed include/tst_test_macros.h change was merged in 303eb96a3
> > ("tst_test_macros.h: Support return value in TST_* macros") we should finish
> > this nice work.

> The changes looks good, so feel free to merge with the minor fix.

Great, thanks, merged with required changes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
