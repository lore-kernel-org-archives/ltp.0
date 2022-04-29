Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D9EC433EF
	for <ltp@archiver.kernel.org>; Fri, 29 Apr 2022 18:09:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F185B3CA7F4
	for <ltp@archiver.kernel.org>; Fri, 29 Apr 2022 20:09:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 260E13C986F
 for <ltp@lists.linux.it>; Fri, 29 Apr 2022 20:09:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8294C60046A
 for <ltp@lists.linux.it>; Fri, 29 Apr 2022 20:09:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ADD9D1F893;
 Fri, 29 Apr 2022 18:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651255777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8WbViof3qiNbIOqRqZtO0hEOPiD3fzlKeO1dfx6C2xU=;
 b=S+dA5Q8EOSeoFUm6KKb9Sbw8hai0AlTGwyxQsN9yO2gAWO5zcShlFIMGxtGRneb6nN1xNP
 QBEMBlJIorw0YTtpGt+ihA4oXquYcdiC1RYcuaIdpYDjE19bphUz872kkmw4ksCSwVvQv5
 +dxCFRQUByVTOFgBvr/eV4E1XZqmogg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651255777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8WbViof3qiNbIOqRqZtO0hEOPiD3fzlKeO1dfx6C2xU=;
 b=hlE6P+c5BdzDZhzgcNW7+98qvdgZa23jDmIGJ1N6hcetHajJF0wtJ7SFV2fub2Hhp8ShSJ
 +7ip5BK2PcjX7+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 807B213446;
 Fri, 29 Apr 2022 18:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hcRpF+ApbGKVaQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Apr 2022 18:09:36 +0000
Date: Fri, 29 Apr 2022 20:09:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Ymwp2cilZtjn+g3y@pevik>
References: <20220428065657.32046-1-pvorel@suse.cz>
 <539e2eb7-05d5-470c-3287-b1e9b7220532@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <539e2eb7-05d5-470c-3287-b1e9b7220532@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/5] busy_poll: Move TST_{SETUP,
 CLEANUP} to the tests
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
> TST_TESTFUNC should be moved to individual test scripts as well, for the
> same reason. Other than that, the whole patchset looks good:

I was thinking about it as well. Makes sense, but then it hides the fact that
busy_poll_lib.sh contain other API variables (missing TST_TESTFUNC suggest that
there are some variables in busy_poll_lib.sh). Anyway, I'm ok to move it there
as well, just document that sharing variables between library and test will be
always a bit problematic.

> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
