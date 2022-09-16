Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB95ECAAD8
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 09:37:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 242943CAC6F
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 11:37:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC5363CAC39
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 11:37:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C595B201732
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 11:37:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C9BF2129A;
 Fri, 16 Sep 2022 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663321042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KgfWEdozwKSFvrz0sMXrwsbApo+uThVhXbW3d4HEcuQ=;
 b=H2FF2RsFf/e2BQcW2tuS0iei4A3b1fJDEAx6TxDRk2hUdovqr3c3+YvoqZZcCUwEQIWJNS
 PF+G/hiXw0JK4yE8PFfD1xIwBh4WjxcPeOC7MZnJcxy1ChFh/bUW2eO3q4oC4UPJ2AQp3J
 fcRxD8+IwCe+JrIDPOjfPvV9AHoeDag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663321042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KgfWEdozwKSFvrz0sMXrwsbApo+uThVhXbW3d4HEcuQ=;
 b=2VVIMV9i8glGdQUNtzWRE3gSqFXAlcqwREbzE/fftber9rgqFHzgQJWLK82RlRiJZxjtOE
 8xB5I/3ZZkvfgrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4836A1332E;
 Fri, 16 Sep 2022 09:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kcsGENJDJGNCXgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 16 Sep 2022 09:37:22 +0000
Date: Fri, 16 Sep 2022 11:39:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YyRER2kntqxXG7tl@yuki>
References: <20220915031020.2633347-1-liwang@redhat.com>
 <YyMgBQu+phGCulxV@pevik> <YyM05nwf1+0eCd3w@yuki>
 <CAEemH2d_ckW9Zm77wRcoejiY0rCDB1Tpgs7c3LB=WNwYYLF7Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d_ckW9Zm77wRcoejiY0rCDB1Tpgs7c3LB=WNwYYLF7Hg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open04: add EMFILE check
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I faintly remmeber a similar patch where we decided not to work around
> > for a test harness leaking filedescriptors into testcases.
> >
> 
> This also should be a solution, I searched the mailing list and got a
> patch[1].
> Do you mean adding that close-on-exec flag when opening fd in harness?

Yes, that way you can be sure that no file descriptors are leaked to the
tests.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
