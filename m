Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE417C54EE9
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 09:59:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCB803CAD12
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 11:59:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8271C3CAAE5
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 11:58:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 82C8D1A0043C
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 11:58:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E4F7E21B24;
 Tue, 20 Sep 2022 09:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663667932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fHaDJXD89HSRI2++WCcS1Q9llrLuufYvkK950Robv9I=;
 b=oKX4SFzivIWXaJMJFgFR9cp8HgA2KSQk/kfgXhunoV8sGgsUi8yxxKGUxHqbl0S4G9Ldas
 Eq98I86Yzkr4C6QL1AOmjb+xuxIB/SdYrgE5L633Kxsj/DqxEynBQLztKJ4sT+CcjG3XQh
 yzWlUVf0GM4HpsawaPOInssDJjvuqEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663667932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fHaDJXD89HSRI2++WCcS1Q9llrLuufYvkK950Robv9I=;
 b=l6xr11Fcwfi0KBNDFOCPD0dPQi2hmvRzYEE82e+UjT80iUZOqwGiNzzPaBO2n+6XM0q4DL
 iFDlhzM9WiN9poDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D26DE1346B;
 Tue, 20 Sep 2022 09:58:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7Ei0MtyOKWN/FQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 20 Sep 2022 09:58:52 +0000
Date: Tue, 20 Sep 2022 12:00:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ankita Anil Kulkarni <Ankita.AN@exaleapsemi.com>
Message-ID: <YymPUsYYQ6p4tHfN@yuki>
References: <PNZPR01MB810830AC76882E62E6D756A2FA4C9@PNZPR01MB8108.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PNZPR01MB810830AC76882E62E6D756A2FA4C9@PNZPR01MB8108.INDPRD01.PROD.OUTLOOK.COM>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Kernel Configurations
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
Cc: Indumathi Raju <Indumathi.r@exaleapsemi.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Which are the required kernel configurations to execute LTP tests?
> Probably we are missing some in our distro.  Could you please help
> with the list of kernel configs?

This should be exactly the other way. If your distro kernel works fine
for the distribution you shouldn't add config options just to make tests
pass. Rather than that these test should be fixed so that they are
skipped instead. So first of all you should try to identify which tests
fail because of missing kernel features and these should be fixed to
check for support of the particular feature.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
