Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C2AC5478C
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 11:51:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F73D3D1932
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 12:51:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 875123CE07F
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 12:51:40 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 403086005F2
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 12:51:38 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D15BC202AF;
 Fri,  1 Mar 2024 11:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709293897;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZArhYf55rz68PKnNErtwaSoyy+acakhvG1VW5IiXD0=;
 b=k5V72ih3DiV5Ky+t+TSEf/tGMGE4l6OMdQYLM/QzsOq0ITKYaPOcXT2DBQw95J1hIoy0di
 EKeUJcmD0LzPWrJnvHglsXZpwO8rCvwA/qXb+3Qa7vwfc01wohWY2sc3eOM9SX4gd4/hGS
 gpQadip84exU/wdpmgSnaUlImqiRLj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709293897;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZArhYf55rz68PKnNErtwaSoyy+acakhvG1VW5IiXD0=;
 b=ejBNn9ns775TZSRGrFOWNB0l8w6/DAPqnu/g5R1vIKxV+EpDyvDa7iICNwfM2Vjjnmln5V
 N3csLwwmzi1xQcBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709293896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZArhYf55rz68PKnNErtwaSoyy+acakhvG1VW5IiXD0=;
 b=NcZpvu0CitBZEbnwlffjss44tX68Is3/Ny1qKY0vrAm9Vq7g8cR5uKy71fr/EKeeK4qyRV
 3U9oSgb6wYWK8M2IuaSXRYbUVpnvVsh1anq6x/PhI2Z5KLDYd9I+R0fIuLndYX71BqKDHB
 +bP0c/u6ZAVmyUP74LuW6f0zbtV06BE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709293896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZArhYf55rz68PKnNErtwaSoyy+acakhvG1VW5IiXD0=;
 b=PR6Kw8/2TbGzy5mD7/n5oOua+qyMT/qvxgNHSUxz1Mr7c140yJJam1Pem8CrVlL3M/c7GQ
 RO3qA5peSdeMbDDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A5BDC13581;
 Fri,  1 Mar 2024 11:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id cQjiJUjB4WWGOgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Mar 2024 11:51:36 +0000
Date: Fri, 1 Mar 2024 12:51:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240301115131.GC1661970@pevik>
References: <20240301102347.3035546-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240301102347.3035546-1-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.58 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.08)[95.51%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_dir_mk: set the umask to '0' before
 creating the subdir
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

Hi Li, Wei,

> This is to resolve the permission issue when creating
> a new subdir in the cgroup, in case of system's default
> umask is 0077, this will trigger issues for LTP case.

>  cgroup_core01.c will report following error msg:
>  cgroup_core01.c:50: TBROK: openat(21</sys/fs/cgroup/memory/ltp/test-3519/child_b>, 'tasks', 2, 0): EACCES (13)

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Setting this on single place which *should* fix problems, but still not affect
whole LTP API looks good to me. BTW there were more tests which needed it,
e.g. testcases/kernel/syscalls/statx/statx07.c
https://patchwork.ozlabs.org/project/ltp/patch/20240222031018.12281-3-wegao@suse.com/

Therefore this solves just some problems.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
