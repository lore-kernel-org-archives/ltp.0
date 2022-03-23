Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90157C433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 09:37:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 675EA3C95EA
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 10:37:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB4403C07B5
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 10:37:03 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D2989200BB0
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 10:37:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 85A651F38C;
 Wed, 23 Mar 2022 09:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648028221;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hoKpGuT9Q9PsYY9fi+6aZ1bGONejYvLKblCD3m5I93A=;
 b=a1csdFDMSJVmk5SM4t/Vrwwk8b+n7zArS7h2Baa5FazkFYmmh+R/PUzLANVICeB2hF7sVl
 NcuX6QDVYAkp1wnnJqIih7wWyD/z+/D5aLHFoSUo8pDzs/qCgzWKcqfYw5gPi0Gz/xXtx1
 ma3CkO8JrOoYJLUx/rL8abR5cugTbhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648028221;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hoKpGuT9Q9PsYY9fi+6aZ1bGONejYvLKblCD3m5I93A=;
 b=vNTT6RzAIIzHBphrYH3gLgZafk+/DbfEhNTFug3lpB7Dh3w/UQ/LE93iemZXvx+1QdkXYA
 iK48nqHo38G2nMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62366132BA;
 Wed, 23 Mar 2022 09:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ICGLFj3qOmIIKwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 23 Mar 2022 09:37:01 +0000
Date: Wed, 23 Mar 2022 10:36:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YjrqO8Er3NqOG8uc@pevik>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
 <20220315122351.8556-9-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220315122351.8556-9-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 8/8] Rewrite userns08.c using new LTP API
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

Hi Andrea,

./userns08 -i50
tst_kconfig.c:82: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1456: TINFO: Timeout per run is 0h 05m 00s

userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:36: TBROK: clone3 failed: ENOSPC (28)

Something needs to be closed after each run.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
