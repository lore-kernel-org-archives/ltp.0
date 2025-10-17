Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881B5CCD195
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 09:24:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD8153CEE3D
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 11:24:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 668F13C7B08
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 11:24:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B75891400C49
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 11:24:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8E6621ADB;
 Fri, 17 Oct 2025 09:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760693056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xF4Nmh+lcrsfJ2k6MuR3XQ4K/GCNpUVcvrk/IUSwmog=;
 b=oKFY8Vh8HdrgJWICXdGPQ225mw6C6q5EbPtYZWcw4WC6fsesTzs5bqNpJ9f0oK0egLicXe
 cf60H9QPy5RjoTytk/ocqnmkyJDZzeD37cf6VJR1z2TIQDCqllTyC7ette2eEz6vK+LR/U
 64KWDhUkQvy7IPtW98HtETSdlA56TKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760693056;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xF4Nmh+lcrsfJ2k6MuR3XQ4K/GCNpUVcvrk/IUSwmog=;
 b=3yWDbeVll4eUeffk/SPEjI9XXhw0hebSLvu6Vz1D4Q0wn9dT7izbSvZ0u+f8QzRgF0NOih
 ZWTu2oTLZeJcH5Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760693056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xF4Nmh+lcrsfJ2k6MuR3XQ4K/GCNpUVcvrk/IUSwmog=;
 b=oKFY8Vh8HdrgJWICXdGPQ225mw6C6q5EbPtYZWcw4WC6fsesTzs5bqNpJ9f0oK0egLicXe
 cf60H9QPy5RjoTytk/ocqnmkyJDZzeD37cf6VJR1z2TIQDCqllTyC7ette2eEz6vK+LR/U
 64KWDhUkQvy7IPtW98HtETSdlA56TKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760693056;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xF4Nmh+lcrsfJ2k6MuR3XQ4K/GCNpUVcvrk/IUSwmog=;
 b=3yWDbeVll4eUeffk/SPEjI9XXhw0hebSLvu6Vz1D4Q0wn9dT7izbSvZ0u+f8QzRgF0NOih
 ZWTu2oTLZeJcH5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 928D813A71;
 Fri, 17 Oct 2025 09:24:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GyMBI0AL8mjmKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 17 Oct 2025 09:24:16 +0000
Date: Fri, 17 Oct 2025 11:25:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <aPILdh2XzsYgEg66@yuki.lan>
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL:
 ioctl(pidfd, PIDFD_GET_INFO_SHORT,
 info_invalid) expected EINVAL: ENOTTY (25)
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Andrey Albershteyn <aalbersh@kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ben Copeland <benjamin.copeland@linaro.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > The LTP syscalls ioctl_pidfd05 test failed due to following error on
> > the Linux mainline
> > kernel v6.18-rc1-104-g7ea30958b305 on the arm64, arm and x86_64.
> >
> > The Test case is expecting to fail with EINVAL but found ENOTTY.
> 
> [Not a kernel regression]
> 
> From the recent LTP upgrade we have newly added test cases,
> ioctl_pidfd()
> 
> The test case is meant to test,
> 
> Add ioctl_pidfd05 test
> Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO
>  is used.
>  This happens when:
>    - info parameter is NULL
>    - info parameter is providing the wrong size
> 
> However, we need to investigate the reason for failure.
> 
> Test case: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c

Already fixed in:

commit 00c3e947cece63ce81cdaf12b5a2071984aa7815
Author: Avinesh Kumar <akumar@suse.de>
Date:   Thu Sep 25 10:19:11 2025 +0200

    Introduce ioctl_pidfd_get_info_supported() function

    Check if ioctl(PIDFD_GET_INFO) is implemented or not
    before proceeding in ioctl_pidfd05 test.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
