Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1471CAC59A
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 17:46:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 123FF3CDC7B
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 19:46:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4257F3CD3F8
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 19:46:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8375010005F7
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 19:46:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3DB265BEC9;
 Wed, 17 Sep 2025 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758131163;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PUqcJjIhJDhpseOAcAsRSztwy1b5WBTrhJPI336NrnI=;
 b=lMiOyXWAfj4pbHUoIQ7I/ChbIB4drMnJL2UT9REkwV6QkcTL2CtyKAG79hnHrxQf+M7+DH
 lOP3iKyhQ6X5XBx6mmzslDNjcNS0NtUFLcT2E3qQu95okRbEuVajtSSI290gVFZDIhHWt5
 7uap4ulSziIGZYGdHrpfnB5Eky1U+m4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758131163;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PUqcJjIhJDhpseOAcAsRSztwy1b5WBTrhJPI336NrnI=;
 b=I+B7Ng+EdQVy55+CX1/DsTG0hAX+NxNutlyByl+cHH5M1dD3NCDbt5ypB5RBsrsarJrwcc
 RJYK4+k9WXGfCdBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758131163;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PUqcJjIhJDhpseOAcAsRSztwy1b5WBTrhJPI336NrnI=;
 b=lMiOyXWAfj4pbHUoIQ7I/ChbIB4drMnJL2UT9REkwV6QkcTL2CtyKAG79hnHrxQf+M7+DH
 lOP3iKyhQ6X5XBx6mmzslDNjcNS0NtUFLcT2E3qQu95okRbEuVajtSSI290gVFZDIhHWt5
 7uap4ulSziIGZYGdHrpfnB5Eky1U+m4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758131163;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PUqcJjIhJDhpseOAcAsRSztwy1b5WBTrhJPI336NrnI=;
 b=I+B7Ng+EdQVy55+CX1/DsTG0hAX+NxNutlyByl+cHH5M1dD3NCDbt5ypB5RBsrsarJrwcc
 RJYK4+k9WXGfCdBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EAF6137C3;
 Wed, 17 Sep 2025 17:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bO59O9rzymhCSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Sep 2025 17:46:02 +0000
Date: Wed, 17 Sep 2025 19:46:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20250917174600.GA354055@pevik>
References: <20250917165403.6038-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250917165403.6038-1-akumar@suse.de>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd05: Check if PIDFD_INFO_EXIT is
 available
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> This test also needs this check as it might fail with
> ioctl_pidfd05.c:45: TFAIL: ioctl(pidfd, PIDFD_GET_INFO, NULL) expected EINVAL: ENOTTY (25)
> ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
> when system does not have PIDFD_INFO_EXIT implementation.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for the fix!.  As a quick fix this would work, because
ioctl_pidfd_info_exit_supported() is using ioctl(fd, PIDFD_GET_INFO, ...).

But because PIDFD_GET_INFO was added in 6.12:
cdda1f26e74b ("pidfd: add ioctl to retrieve pid info") # v6.12-rc3
and PIDFD_INFO_EXIT in v6.14:
7477d7dce48a ("pidfs: allow to retrieve exit information") # v6.14-rc1
it'd make sense to create ioctl_pidfd_get_info_supported() which would
be also used by ioctl_pidfd_info_exit_supported().
Why? There is 6.12 LTSS kernel branch which will get TCONF instead of being
tested.

It could be done ioctl_pidfd_get_info_supported() could return int64_t mask
(__u64 mask struct pidfd_info member if supported or -1 if ioctl() returned -1.
ioctl_pidfd_info_exit_supported() would just evaluate that. Other option is just
code duplicity.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
