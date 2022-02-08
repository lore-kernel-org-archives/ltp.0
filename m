Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F5BC433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 13:14:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2F673C9B82
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 14:14:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF3D83C26B4
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 14:14:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1A9AC1A00CD6
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 14:14:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48B4F210F6;
 Tue,  8 Feb 2022 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644326057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MUxOkj5Frsxt1j5rxDyHeaNgDQM5WcT8OM/3HA/N6Zo=;
 b=oNQ3ROI9WoPF+QWjptutP8IVjEOKUoQJ4nF1PPCjmB01mewdFIoHHmzYpccEKy1My69xSN
 aFn5nfyqtoHFjnczA9w6qXn3Cy2oZCAjU9ZRMcmLYFkSUK+Z2QFc9pxlbAAdR99VRMPDHF
 g1SvIs2dLtrKwIfjzxFDZmzxb0q8zko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644326057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MUxOkj5Frsxt1j5rxDyHeaNgDQM5WcT8OM/3HA/N6Zo=;
 b=hlq2nkFOV7Pdd3X9WFEFnW1xyx0cXBNPrJudnushxo9BsFFjqdCGOotlUzuuefd7NJUYJb
 T8aJSv2R6uibg8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3196E13C99;
 Tue,  8 Feb 2022 13:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /ObQCqlsAmJEWQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 08 Feb 2022 13:14:17 +0000
Date: Tue, 8 Feb 2022 14:16:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YgJtJeKJz9Ne+BBu@yuki>
References: <20220126141152.6428-1-pvorel@suse.cz>
 <YfFeXoHL5iTx4QNh@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YfFeXoHL5iTx4QNh@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Rename array used for .all_filesystems
 flag
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
> > Although fs_type_whitelist[] is also used for whitelisting with
> > .skip_filesystems, the main purpose is to be used for .all_filesystems.
> 
> > Thus rename it to all_filesystems[].
> 
> NOTE: the main purpose of this change is to increase code readability.
> https://lore.kernel.org/ltp/CAEemH2fNfFes-eUtiQKX9JJxqEQUQ+O5nWQM8G-yNyTo8sxviw@mail.gmail.com/
> 
> That's why I added doc.

I guess that fs_type_whitelist[] may be confusing but all_filesystems[]
is IMHO not that much better since we use that a as base for the
all_filesystem before we filter out these that are not supported. Maybe
we should call it try_filesystems[] instead?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
