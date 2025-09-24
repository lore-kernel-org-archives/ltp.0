Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAE1CAC5AE
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 20:30:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01F083CDAB5
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 22:30:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A7063CB2AF
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 22:30:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0051D60005F
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 22:30:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CBF2538CC1;
 Wed, 24 Sep 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B154B13647;
 Wed, 24 Sep 2025 20:30:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XIbEKtJU1GgMdQAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 24 Sep 2025 20:30:10 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Sep 2025 22:30:10 +0200
Message-ID: <2397643.ElGaqSPkdT@thinkpad>
In-Reply-To: <aNOtI3crFfbKofHt@yuki.lan>
References: <aNKJP8fKNn6JcT5I@yuki.lan> <20250923150337.19821-1-akumar@suse.de>
 <aNOtI3crFfbKofHt@yuki.lan>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CBF2538CC1
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Introduce ioctl_pidfd_get_info_supported()
 function
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

Hi Cyril,

On Wednesday, September 24, 2025 10:34:43 AM CEST Cyril Hrubis wrote:
> Hi!
> > +static inline bool ioctl_pidfd_get_info_supported(void)
> > +{
> > +	pid_t pid;
> > +	int pidfd, ret;
> > +	int supported = 0;
> > +	struct pidfd_info info;
> > +
> > +	if (tst_kvercmp(6, 12, 0) >= 0)
> > +		return 1;
> > +
> > +	memset(&info, 0, sizeof(struct pidfd_info));
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid)
> > +		exit(100);
> > +
> > +	pidfd = SAFE_PIDFD_OPEN(pid, 0);
> > +	SAFE_WAITPID(pid, NULL, 0);
> 
> Again, please do not waitpid before the PIDFD_GET_INFO ioctl(). If you
> do that it has no chance of succeeding.
> 
> From fs/pidfd.c:
> 
> ...
>         task = get_pid_task(pid, PIDTYPE_PID);
>         if (!task) {
>                 /*
>                  * If the task has already been reaped, only exit
>                  * information is available
>                  */
>                 if (!(mask & PIDFD_INFO_EXIT))
>                         return -ESRCH;
> 
>                 goto copy_out;
>         }
> ...
> 
> We have to do the ioctl() first and the waitpid() second for this case.
> 
> And if we do so we don't have to check the errno at all, the call will
> just succeed in case that it's supported.
> 
Thank you for your patience explaining this one repeatedly. I read through
the iterations of these new tests in ML to get better understanding of
checking the feature detection. I have sent another revision.
I have also changed the kernel version check from 6.12 to 6.13 as that's
where I see pidfd_info() implementation.


Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
