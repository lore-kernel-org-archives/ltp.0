Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3801C77B7E
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 14:12:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 855A03CD923
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 16:12:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 640BF3CB8C4
 for <ltp@lists.linux.it>; Tue,  2 May 2023 16:12:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BCAE720032E
 for <ltp@lists.linux.it>; Tue,  2 May 2023 16:12:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD00E21E09;
 Tue,  2 May 2023 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683036745;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iPPhEryjS+2KFmFoFOeU2yODQALj3M6oDxhL206TOj8=;
 b=JT8oFb7d93Sy4HePnjk7QbvdbbeK61OcsBN5l6RLkT28T02cnCx2bF7EF3JzwdQbFFg6TD
 TNlauWJxN+BrsirVnr8ig9x1eVuvUNHYLjn7YW61885QItm7vE31S29U1rfgzWXrWdifrH
 OQgFcRvVi/m/nxJ7O5wfC4P5iNKTvhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683036745;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iPPhEryjS+2KFmFoFOeU2yODQALj3M6oDxhL206TOj8=;
 b=E7TKQbY8fNFGTQ+6yGyMaHCIDajy1b/h4Zctk2XAw7DTldXkvvyEtSAOtdcJJY5/tEGTuD
 2GuXqfA1k3zSv+Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5FC6139C3;
 Tue,  2 May 2023 14:12:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8k3DKkkaUWTwdQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 02 May 2023 14:12:25 +0000
Date: Tue, 2 May 2023 16:12:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230502141238.GA3664328@pevik>
References: <20230424103056.6017-1-wegao@suse.com>
 <20230430060419.12045-1-wegao@suse.com>
 <20230502103248.GB3631203@pevik> <ZFD5n4x6fdNkMuyj@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZFD5n4x6fdNkMuyj@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] recvmsg01: Refactor using new LTP API
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

Hi Wei,

thanks a lot, merged with fixes I proposed!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
