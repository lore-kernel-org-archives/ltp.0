Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218F7ECAAA1
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 06:07:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8D613CA709
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 08:07:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 197F23C05D5
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 08:07:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 32D2A600D18
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 08:07:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 269593401E;
 Tue,  6 Sep 2022 06:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662444420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xcR1n/x9EjcDRKpiSKPCgoxgesXQh1NOMqB3Bu+t9EE=;
 b=K5SAWHtvUgmDMYtbwneigjtFkTg1PrCEmlg8tb7KC2jEbbV4o00ZmEQlfB8BJDOOc0Jx0S
 1Y1SyPI+P7NNACwFLGM+v5KRPms4ZXfvqDzLPFUEnzLHtJhMkTmHflc2uHn4u3EtobDQvZ
 FLyBgKJ35hTbFlIP62Mt180TVWxlXTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662444420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xcR1n/x9EjcDRKpiSKPCgoxgesXQh1NOMqB3Bu+t9EE=;
 b=xpgZmrtO748drasVwggsBiJOsK0Sx3sqeChK/GqwMZkbh4ef68qnflRRmWIF6ecmYJi5xQ
 SlC4n+lZXe+iaJDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E709B13A7A;
 Tue,  6 Sep 2022 06:06:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nKi3NoPjFmO2GQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 06 Sep 2022 06:06:59 +0000
Date: Tue, 6 Sep 2022 08:06:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YxbjfSRVZTD6JNu2@pevik>
References: <20220905154239.2652169-1-amir73il@gmail.com>
 <20220905154239.2652169-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220905154239.2652169-3-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/9] syscalls/fanotify14: Require FAN_REPORT_FID
 support for entire test
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir, all,

> To avoid complex requirements for the new test case, we now require
> FAN_REPORT_FID support for the entire test, which opts-out from testing
> on FUSE filesystem.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> It is not clear that there is anything to gain from running this test
> on all_filsystems in the first place.

Interesting.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
