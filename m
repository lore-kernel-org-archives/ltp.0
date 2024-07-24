Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2421C3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 11:53:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C89BD3D1C2F
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 13:53:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C0243D0895
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 13:52:55 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 88FD3600D04
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 13:52:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E257E1F79D;
 Wed, 24 Jul 2024 11:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721821973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DCMu0RGKmEFrVmECMBMEWgyn5Hw9vrLPVz7CjXRA23w=;
 b=FvbkcVm9UPZMRwZvBAbxcnXw6Yh3hafUeOv4vrs6Y31SjtaS60VrWKj7cwM79snonvMicR
 SufihPjm+DbvJaWKlpTryj3FAy5VLnvDTYlk6qOq1ryJp95WVzjuzD4F+KR4/RC1YWcq9e
 nDYo3zdb0ye1DrkD0bDlh5wPbFBBwWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721821973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DCMu0RGKmEFrVmECMBMEWgyn5Hw9vrLPVz7CjXRA23w=;
 b=/SqFocr+aykyBGDt8DzpEtskTIl4UzKcNQiiUcde0ZaYvvBSCm4q1igpRpfNUQYfsEb1VN
 ZsWCKvTZTCI1F4BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721821972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DCMu0RGKmEFrVmECMBMEWgyn5Hw9vrLPVz7CjXRA23w=;
 b=RI3aS/HmZodHj5G9kU7He49VYdZSHhIOoaXAnHVq+ODJ2nvQf9BFvwjy8EE6TG/GkxjBC5
 KaR4Agj1KD5v0FWlpealzq2onzfYx0IEt3DPdvwejKNCo57wtnJSI2W+mr7CE67X4F6wq4
 XsyRle0wFC1b5TmIlqi8oWOGZ9DkFmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721821972;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DCMu0RGKmEFrVmECMBMEWgyn5Hw9vrLPVz7CjXRA23w=;
 b=/mx67Bqf1fNOBSmXo/rZdkOfmfaciVocg+42rQXcZCk+fZNTd5MmLhdYnyOzkCUYFCJlIm
 yxEFFnSBpohyKFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC2F613411;
 Wed, 24 Jul 2024 11:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ql7BJxTroGb2egAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jul 2024 11:52:52 +0000
Date: Wed, 24 Jul 2024 13:52:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZqDq7ACxQbXgYzVF@yuki>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-1-33075bbc117f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240723-ioctl_ficlone-v2-1-33075bbc117f@suse.com>
X-Spamd-Result: default: False [-0.60 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] Add fallback definitions for lapi/fs.h
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
>  #include <limits.h>

I've added #include <stdint.h> here to make sure that the *int*_t are
defined and pushed, thanks.

>  #include "lapi/abisize.h"
>  
> +#ifndef HAVE_FILE_CLONE_RANGE
> +struct file_clone_range {
> +	int64_t src_fd;
> +	uint64_t src_offset;
> +	uint64_t src_length;
> +	uint64_t dest_offset;
> +};
> +#endif

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
