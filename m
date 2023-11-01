Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FAAC4332F
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 15:44:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C03703CE9C5
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 16:44:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC25F3CE060
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 16:44:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0FE5D600903
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 16:44:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA4531F74A;
 Wed,  1 Nov 2023 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698853461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IImUTHLgDyhPgsU+8JygtwLUK6+2XtkwHDev6Xvy+C0=;
 b=E8jk7mw7xok8cy40yZ+JxgN75Vc2qOQf75nN1n3s6RmPcYkbQbwujtsBCmLxRaEOfcsilW
 paH4UdCN7T5HZjjdtS5XJ+ZotYQqXVwT4JnpeOMJygombBrjhE6lVwqC9jvTxjm4H795pg
 bfQABx97e7/JkPwdoe5VsZRrfMPNtVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698853461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IImUTHLgDyhPgsU+8JygtwLUK6+2XtkwHDev6Xvy+C0=;
 b=BPhqbsWfQDZ1tN/vmtCfaBpa0YDZDTiXKCi5G/Ga1feV/G/XoaGdi85WpCfblelZ3YzguP
 UVP2/BuEN5BX6LBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 993E413460;
 Wed,  1 Nov 2023 15:44:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZxVnJFVyQmU8LgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 01 Nov 2023 15:44:21 +0000
Date: Wed, 1 Nov 2023 16:44:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZUJydZgdGTcPQAxt@yuki>
References: <20230907150538.16772-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230907150538.16772-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor fork09 using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Honestly I'm struggling to understand the point of this test, the
description says:

"Check that child has access to a full set of files"

What is that supposed to mean? I guess that if we wanted to check that
the child has inherited the file descriptors ee should open a few files,
do some changes in the child/parent and check that they are not propagated to
the other one. I.e. reading from a file in child/parent does not change
file offset in parent. Closing a file descriptor from a child/parent
does not close the file in the other one, etc.

Also why do we use fopen() instead of just open()?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
