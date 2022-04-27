Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C05EC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 15:28:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 945BA3CA6D9
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 17:27:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E02053C9E2C
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 17:27:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 19DD220034F
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 17:27:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 381301F37B;
 Wed, 27 Apr 2022 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651073267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F26aOKLH7jpOkoRVJbvRjIl9iEY9S80p/V16q0HK4Wc=;
 b=dN1TOedUxEU7OD05YqvTtNW1hf9SWEFcmgwQHLExIhNbKpSaunNX0bKd0XtThVY2nxttoH
 uz+RcKATsjUXI7KmGhhcLuEnKbkH+OIT3bs3yTcJHlV35p76u/qCCFl+pnuWdEGpgqCO67
 35b6c/jyjI1ZsMu3fNU0Btq1Gw0Z5LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651073267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F26aOKLH7jpOkoRVJbvRjIl9iEY9S80p/V16q0HK4Wc=;
 b=92MdjGFXZ8kZH7Wbu46FrcuouFyyMMBzzmor8R3mkhNKwhWM+zxHVoptHB+J+3VAnwAB8I
 R4bN3Ht0p3jxNuAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 258221323E;
 Wed, 27 Apr 2022 15:27:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9d2mB/NgaWJcFAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 27 Apr 2022 15:27:47 +0000
Date: Wed, 27 Apr 2022 17:30:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
Message-ID: <Ymlhe/b6mm++dMJG@yuki>
References: <20220425060806.1038-1-chenhx.fnst@fujitsu.com>
 <Ymfo4yKddW7OWfRO@yuki>
 <OS3PR01MB6449E26528843CFF8CDCF30CE6FA9@OS3PR01MB6449.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OS3PR01MB6449E26528843CFF8CDCF30CE6FA9@OS3PR01MB6449.jpnprd01.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ????: [PATCH v3] syscalls/mount_setattr01: Add basic
 functional test
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> For move_mount, we should close(fd) before umount.

Really?

And even if that was the case we can simply close the file descript
right after the move_mount() call, which would simplify things a lot.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
