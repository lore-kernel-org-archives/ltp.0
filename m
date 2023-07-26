Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615F2C001DC
	for <ltp@archiver.kernel.org>; Wed, 26 Jul 2023 13:16:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC6D03CDBF5
	for <ltp@archiver.kernel.org>; Wed, 26 Jul 2023 15:16:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3CAB3C4BC7
 for <ltp@lists.linux.it>; Wed, 26 Jul 2023 15:16:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 24F701000A14
 for <ltp@lists.linux.it>; Wed, 26 Jul 2023 15:16:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D5DF1F889;
 Wed, 26 Jul 2023 13:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690377383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7mq/QmVLWwjWbun8k3GsyxFouD1jKiXmW4a+CBytRVw=;
 b=nmCM1CxvuSeJXBjCzZWg+82Fd12NOO1tWwtqlRiyuARyARjN3X4vQU7aHvMCUeQNct4Vhy
 lDPlRonYCbdaU6ExIEJx+arG1UvSeDA/Vsfhf2mtJZ41ZGv5iQhiof28QcvBo+War4fZCA
 OHznr49mW5BVDtM+nLCSGnZrPvWPHPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690377383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7mq/QmVLWwjWbun8k3GsyxFouD1jKiXmW4a+CBytRVw=;
 b=H4m/MQb2U865XHU8AtmeNSgFyc+j8AzzQpS/Xv3UfqyDdHRwb09tHpgE3Sc9lTxjvr6jOa
 6K3Jj8XwEK6mHkAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F08C5139BD;
 Wed, 26 Jul 2023 13:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bJLTOaYcwWTFYAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Jul 2023 13:16:22 +0000
Date: Wed, 26 Jul 2023 15:17:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZMEc5R9KNcDoKe7h@yuki>
References: <1689760756-865-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1689760756-865-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZMEWwCwC0DPrtdAi@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZMEWwCwC0DPrtdAi@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/setgroups02: Convert to new API
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
Also can we please allocate the buffers passed to setgroups/getgroups as guarded buffers[1] of size 1?

[1] https://github.com/linux-test-project/ltp/wiki/C-Test-API#131-guarded-buffers

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
