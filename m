Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5223C7618E
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 12:15:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53C173C26E5
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 14:15:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D31E73C26E5
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 14:14:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 071BD1400332
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 14:14:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA7A521A2F;
 Fri, 21 Apr 2023 12:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682079293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RqcokwC8IFEnXrRB348T1bJ/wHKYVDihrluPewmHKLs=;
 b=irvpz5ntc8XryVT//AM8z2pIgBwIcfl8aScnxVSg1ujo19xz4YoH2cB7TZZ/iCZTA1Khc1
 oTB2MEQqwToiLPNojxhvrI71Kb7DH4FJ5fKvrAF64QNtYPGMwbjy3Vmx67q0BwS7+cqLbm
 VzkY/uq+zFUBJE2VuWOfmaDgePWycxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682079293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RqcokwC8IFEnXrRB348T1bJ/wHKYVDihrluPewmHKLs=;
 b=afjFDiy2uvgJ2/MEseNlj7q10wxM+WTs1FbloCynmOOiUhzSwQUEpbIochss/6dWATAKgt
 7/ypEHTgEGE4rUBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D534A13456;
 Fri, 21 Apr 2023 12:14:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9/Q8Mz1+QmRvLwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Apr 2023 12:14:53 +0000
Date: Fri, 21 Apr 2023 14:15:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sowmya Indranna <Sowmya.Indranna@ibm.com>
Message-ID: <ZEJ+fsJBLshJ3mMa@yuki>
References: <MN2PR15MB36641E17F2BC189A06014B63F2609@MN2PR15MB3664.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR15MB36641E17F2BC189A06014B63F2609@MN2PR15MB3664.namprd15.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
> Sharing the patch for issue#1033 - cpuset_regression_test.sh

The patch has been corrupted by your email client (does not apply) and
is missing a Signed-off-by line.

See: https://www.kernel.org/doc/html/v4.10/process/email-clients.html
     https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
