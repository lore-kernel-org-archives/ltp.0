Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798ABC433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 12:52:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6CCD3C9EE0
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 13:52:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA56D3C9E0D
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 13:52:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 61DAD140123A
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 13:52:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 595B5210E4;
 Thu, 10 Feb 2022 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644497536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ib3rhuDtjquhc+r0k91uM5lAueL2qA6FtJvy7GVRg0=;
 b=NlRFH3766A3SOkiAeBk6cO9nBQC3Kto0KXVmHICXT8pmKPmKzXZl2xGqEKVeNhTX8ETiQw
 uJC6l2ltmZtrl19WbOSZKBZIkl/K2Am2n+Evq5pJzh14FtQjTgBK/F+nxHwmUULMmbqlo8
 TgP/ogSbKeB4znFboQ8a32jkom2nJ9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644497536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ib3rhuDtjquhc+r0k91uM5lAueL2qA6FtJvy7GVRg0=;
 b=KYnpnVBmc+Q6aVPKYSw+XkLhtEgbcomDA3LnDsrX50DPfvhzgt2QFI0k5z7yPRfn3Gb4Az
 Ok77tDEBa87aPAAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 392DA13B84;
 Thu, 10 Feb 2022 12:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3CJODIAKBWLzPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Feb 2022 12:52:16 +0000
Date: Thu, 10 Feb 2022 13:54:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Kautuk Consul <kautuk.consul.80@gmail.com>
Message-ID: <YgUK/1qWA0qQ304h@yuki>
References: <CAKWYkK03vnioG=XBmGOzAruwVo_XtZgn9k+dw8HPXyvTwfaVQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKWYkK03vnioG=XBmGOzAruwVo_XtZgn9k+dw8HPXyvTwfaVQQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open Question about KVM test-cases.
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Currently there are no tests for KVM in LTP, however Martin Doucha is
working on some CVE reproducers and send a RFC while ago (added to CC).

There seems to be some KVM tests in linux selftest, but I haven't try
any of these so I have no idea how/if they work.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
