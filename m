Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FA4C77B75
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 13:02:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C8DF3CBF00
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 15:02:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 501A43CBE81
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 15:02:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 71E51600984
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 15:02:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D52D61FDDC;
 Fri, 21 Apr 2023 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682082137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vm4vRLyRFNWFnxU538gMiPVLNjde9nrkdafA/r96qZU=;
 b=1Usb44LiyStUJWTsJ5O6oK4pb3Tb2MXvVrinUG7mKIemdC5F4g6MuyXft2Xlb+cQWXXEMI
 ZIxkb19kdvoXkg7lVFt2vIWPNKLk9Y6IyCCUJld9VVYovtdadNy5+M3FhormfmXwvPc8fB
 G8Z0hPoesDC7RfC69IqC1VtNk+MpEdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682082137;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vm4vRLyRFNWFnxU538gMiPVLNjde9nrkdafA/r96qZU=;
 b=sDuPtz32t9+/nFT6FsSqOed/Gp/GJEHvazU8VJ75jnInvqwnfgeyxEKTNCmXL4mAvSugOE
 vIwvPzChfsdhsSBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B18D71390E;
 Fri, 21 Apr 2023 13:02:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id khEXKFmJQmStSgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Apr 2023 13:02:17 +0000
Date: Fri, 21 Apr 2023 15:03:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sowmya Indranna <Sowmya.Indranna@ibm.com>
Message-ID: <ZEKJmYUJiIADlmCR@yuki>
References: <MN2PR15MB36641E17F2BC189A06014B63F2609@MN2PR15MB3664.namprd15.prod.outlook.com>
 <ZEJ+fsJBLshJ3mMa@yuki>
 <MN2PR15MB36643ECDF70003A3486FFE90F2609@MN2PR15MB3664.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR15MB36643ECDF70003A3486FFE90F2609@MN2PR15MB3664.namprd15.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Patch] controllers/cpuset_regression_test.sh - Issue
 #1033
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
Cc: Mahesh Kumar G <Mahesh.Kumar.G@ibm.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, Chethan Jain <chetjain@in.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
This has the same issues as the previous patch you have send.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
