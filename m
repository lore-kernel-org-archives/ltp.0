Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E96EB8FA5
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 08:51:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31C863CB769
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 10:51:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D6793C89B6
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 10:51:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9669710004BB
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 10:51:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C44B20294;
 Wed,  6 Sep 2023 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693990275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
 b=UG2GEXxbWOZPp0cplKXcsawBCsOAyIPlMuyXJHqG6DUdLX6m8lRrpF7lqH9XtxvrjGPIMF
 WFuvhL9fXiWd7Rmb+GsgcAOlt6VxTonEZq1LQ7DomOCo4KwaMNzuuBuIA1Qqyz6G6oCMwR
 x1nDg0UJLvUx0ycUlqsHaoJnDuD8fVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693990275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
 b=I4O3Vx0GsBc1P41cVRzfBmQtqImn67LRqey0IaDOFLNJYGvlzLEKykvcvwrW5nNbMaKfvP
 +EPmgtFBSyCXrQDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40BCF1333E;
 Wed,  6 Sep 2023 08:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a6GyC4M9+GRNdgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 06 Sep 2023 08:51:15 +0000
Date: Wed, 6 Sep 2023 10:51:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Message-ID: <ZPg9qfsTeU0xoClt@yuki>
References: <014a7886-865f-109a-acc4-bc06ba92ce9b@linux.ibm.com>
 <20230829101327.3862937-1-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230829101327.3862937-1-vishalc@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ebizzy: prevent integer overflow in 64-bit
 systems
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
Cc: srikar@linux.vnet.ibm.com, sshegde@linux.vnet.ibm.com, raj.khem@gmail.com,
 chris@mips.com, gaowanlong@cn.fujitsu.com, tdavies@darkphysics.net,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
