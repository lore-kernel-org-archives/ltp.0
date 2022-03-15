Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522DCC433F5
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 09:15:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB33B3C91EE
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 10:14:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CA8A3C20CC
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 10:14:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E8BF21400E60
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 10:14:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B70171F391;
 Tue, 15 Mar 2022 09:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647335684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oxajtx4usvX49iR0WBVX9Y/1otRMlBrnRdnzha//nAI=;
 b=MRDk/zXCfhARBu8G5hKCFrJMNOBJtFweybxCiZpmxc17AbzH7GDqHR+jh5tVV8xZR0QEBX
 V17sOMWo34GbOWQFqe9XGZ/NDRIWHUmSbN5TgaUR3OCPaumfi+yr9Q9RmIMh57453bLeKj
 T6NhdimHfrUiddw84V4TxbOrw2Yjbis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647335684;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oxajtx4usvX49iR0WBVX9Y/1otRMlBrnRdnzha//nAI=;
 b=5HX04eYXxmTA8KpRltFWXvjeacBX12cd3eOJtEyH2w4jL4nfjotQTVN/dSwSiBCHdTa+XY
 BSVfGzmjQGQAaHDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9202713B4E;
 Tue, 15 Mar 2022 09:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IdJlIQRZMGKqeQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 15 Mar 2022 09:14:44 +0000
Date: Tue, 15 Mar 2022 10:14:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YjBZAUelR7ExR83A@pevik>
References: <20220314130630.9378-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220314130630.9378-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tools/sparse-ltp: Check all struct arrays in
 tst_test for ending {}
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

Hi Richie,

> Check for null termination on tst_test.save_restore and all the other
> struct arrays in tst_test. They are all null terminated.

> Also prevents a segfault when scalar NULL is used as the final entry
> and print a helpful error message instead.

thanks for this! LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
