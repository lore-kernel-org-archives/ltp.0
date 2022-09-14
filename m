Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C065ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 13:51:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16A0B3CAC33
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 15:50:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8549E3CAA07
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 15:50:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1603E14012D7
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 15:50:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD01C1FABF;
 Wed, 14 Sep 2022 13:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663163447;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ES6K+T0KC1Rk0V3cW6ABssF7CFpiTrv8NsG4/PTZ6o=;
 b=rFJuqhMXR8Lh2kTq/Nolecr7yYA8tLrOdxW+CcxWrY+m/jT/cter0FnOwlaxyhPXe+Zf/3
 9UewqO7N46z2kLo4ALTfCu1lgqc4Ev2dpqGKodC8bGEyaqOHFEysZjicmQO8XmBs5VJvi+
 N6zlYnP7p/zO0yc0DXXbC9Rt/Ko19TQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663163447;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ES6K+T0KC1Rk0V3cW6ABssF7CFpiTrv8NsG4/PTZ6o=;
 b=B5Z35K9NBpjgPMrstDxsHcbAQUbIpkc6ZPjbFfjzycZzlvoR9QxtA9eclpvgYgeRN/WMhB
 ZNrmjNn0bYwjbkAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A55B413494;
 Wed, 14 Sep 2022 13:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5iqGJjfcIWPjJQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 14 Sep 2022 13:50:47 +0000
Date: Wed, 14 Sep 2022 15:50:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, kernel-team@android.com,
 ltp@lists.linux.it, Edward Liaw <edliaw@google.com>
Message-ID: <YyHcNcTUNG+gU3rq@pevik>
References: <20220913202839.1807979-1-edliaw@google.com>
 <YyGisrbDIgVa/0QA@yuki> <YyHYvCr0PISg6ISY@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyHYvCr0PISg6ISY@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] minmax: fix type warnings
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward, Cyril,

Merged with requested fixes + update printf format (SAFE_FILE_SCANF) to %zi.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
