Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453E2C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 15:03:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2CFE3CA729
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 17:03:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83EEB3CA318
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 17:02:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B52EC14001EA
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 17:02:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 02ABF20388;
 Mon, 11 Jul 2022 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657551777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mcVxXPTvHuiyIJ7LzZg7yYibCd22okN9v+E19WIie9A=;
 b=tIjqvEqRgYXe9HWuLUYnDybZjJM8YPnTBgI2FLGnX2GiOO5FjepuaBF3P3D+/+D0mvTmMe
 9aFbKBv6nKM8ic4bBSuqpNKxHaj/ZiqqXcaCLng4WxSTQenrz4a7kWJxq3cIN3KHCpyrZ6
 qNi6npl5UVhZRqfaAANHSWmsaZ4Zvzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657551777;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mcVxXPTvHuiyIJ7LzZg7yYibCd22okN9v+E19WIie9A=;
 b=dBzgd98WmIpdgtCkUFYTJXyDUJXENwAproU23Umof+ZxcslRP5Bei3ylmO0FyyC1uYpsnh
 WcVoVSLTyEImPkBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9A5813322;
 Mon, 11 Jul 2022 15:02:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /j4HJ6A7zGJ8WAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 11 Jul 2022 15:02:56 +0000
Date: Mon, 11 Jul 2022 17:02:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Ysw7n+WQvw/rcoOy@pevik>
References: <20220609214223.4608-1-pvorel@suse.cz>
 <20220609214223.4608-5-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220609214223.4608-5-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/9] shell: Add test for TST_MOUNT_DEVICE=1
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
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

FYI merged up to this patch, the rest (the actual $TST_ALL_FILESYSTEMS)
will go in v3.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
