Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD95C46CD2
	for <ltp@archiver.kernel.org>; Sat, 27 Jan 2024 05:54:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CF953CE19B
	for <ltp@archiver.kernel.org>; Sat, 27 Jan 2024 06:54:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EF4E3C8883
 for <ltp@lists.linux.it>; Sat, 27 Jan 2024 06:54:23 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 003BB1A00F28
 for <ltp@lists.linux.it>; Sat, 27 Jan 2024 06:54:22 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDE591FB77;
 Sat, 27 Jan 2024 05:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706334860;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLSCQAax2fqgfU1vpIOznWZbK0p+SR4OGgZoLs91oio=;
 b=bOZ90fBeiBTVF2QBiXDroi06qfgJ+h40ykYRMqja15TTpDM77ncCRy5HGRL+uodX3WAC4C
 JVtg/pRqTI101sYpj1FKGgpaTNGXu+ZwVjCwisuhygpWnXg91ZdlefnBkpgVrMHYQdkfc0
 GRgizxmQdxl0w7WPCzM6IfSlfJDXvFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706334860;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLSCQAax2fqgfU1vpIOznWZbK0p+SR4OGgZoLs91oio=;
 b=x7u9MKpMXz5Y3+nHVQG+l0w5/CzWwu5b7mYDAZhnD58ZAjjLhwby0YlQZM/OZ10+LyYgBL
 ffN72NuVSRDUoOBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706334860;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLSCQAax2fqgfU1vpIOznWZbK0p+SR4OGgZoLs91oio=;
 b=bOZ90fBeiBTVF2QBiXDroi06qfgJ+h40ykYRMqja15TTpDM77ncCRy5HGRL+uodX3WAC4C
 JVtg/pRqTI101sYpj1FKGgpaTNGXu+ZwVjCwisuhygpWnXg91ZdlefnBkpgVrMHYQdkfc0
 GRgizxmQdxl0w7WPCzM6IfSlfJDXvFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706334860;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLSCQAax2fqgfU1vpIOznWZbK0p+SR4OGgZoLs91oio=;
 b=x7u9MKpMXz5Y3+nHVQG+l0w5/CzWwu5b7mYDAZhnD58ZAjjLhwby0YlQZM/OZ10+LyYgBL
 ffN72NuVSRDUoOBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AF75132DC;
 Sat, 27 Jan 2024 05:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id LfsMJIyatGW9OwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Sat, 27 Jan 2024 05:54:20 +0000
Date: Sat, 27 Jan 2024 06:54:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240127055414.GA530936@pevik>
References: <20240126111506.491324-1-pvorel@suse.cz>
 <ZbPP8pdtXnOsgA5Q@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZbPP8pdtXnOsgA5Q@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.53 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.23)[72.42%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] lapi/io_uring: <sys/types.h> =>
 <linux/types.h>
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

Hi Cyril,

...
> I did look twice and we do not seem to use anything from the
> <sys/types.h> in the header, so this should be safe.

Thank you for this check (I did just compile check), merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
