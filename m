Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50EFECAAD5
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 09:51:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 970683CAADD
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 11:51:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 737823C278D
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 11:50:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 652781A006EA
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 11:50:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42E2322A55;
 Mon, 12 Sep 2022 09:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662976252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reb32PrQDoisS4h6Io6DRQG3erikJU2XbHGoEUJsMlA=;
 b=dPGh3UNoopaRAv9tOF+IjBAbAksTpL+1+LgSNERBXgoO3vbKgwI0daqh+TwEf+8+r+bogW
 bG+ly5gqFwcwPk577OOEAncwTByPHHGVdFSsEw2MrD1DHsd9dEci5G/6m8G0Sa4x79rUlK
 Us577o+YduErQRGiS03uSW4i9kEi7/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662976252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reb32PrQDoisS4h6Io6DRQG3erikJU2XbHGoEUJsMlA=;
 b=0O1TT6LBL963gISKs6h3b5+7hlVBUXTmTT2fHA3cQ2DxZKisCASRFYSyZMTqPGnKhY1zyP
 +hZeWZ0BeHvOwOCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 288EB139C8;
 Mon, 12 Sep 2022 09:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3UufCPwAH2O+TwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 12 Sep 2022 09:50:52 +0000
Date: Mon, 12 Sep 2022 11:52:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Randolph Lin <randolph@andestech.com>
Message-ID: <Yx8Bbu2Zaosb6y7f@yuki>
References: <20220907053841.7923-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220907053841.7923-1-randolph@andestech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: Fix tst_res() format string for 64-bit
 offset
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
Cc: Mina Hui-Min Chou <minachou@andestech.com>, alankao@andestech.com,
 kester.tw@gmail.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> When compiling as 32-bit with _FILE_OFFSET_BITS=64, the format string
> needs to be specified as 64-bit long (%lld).
> Fix format string for type block_size.

This change introduces warnings on 64bit platform instead.
Unfortunatelly unlike the size_t and ssize_t which can be printed with
%zu and %zi there is no such thing for off_t. So the only way how to
actually print off_t correctly is to cast it to (long long int) in
addintion to changing the format string to %lli or %lld.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
