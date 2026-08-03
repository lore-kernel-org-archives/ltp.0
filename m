Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB800C55175
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 08:11:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 857D53E2969
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 10:11:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7799D3D064D
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 10:11:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5E63E1400745
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 10:11:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DD9947EC;
 Mon,  3 Aug 2026 08:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785744680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p2347QIVHvSwCl4nClQWY1nACVkvA6JuDR3De3RCc6E=;
 b=aBOMwXTJHYhFxEscGzNczO+kfWcb38b6sPxrs81EahbjGSOJGqwrNQVK2JvEhA92C6l4F4
 wQBEIMHzmaKYMFMp3LTydLAuTj0bcQxXslB8HPKOo41+ihi7Q8Td0WebCv1VlVMP7fvEYe
 omQ4vTE0m7sx2W/v7KoB65emLTPc6eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785744680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p2347QIVHvSwCl4nClQWY1nACVkvA6JuDR3De3RCc6E=;
 b=7Uo4u6/kEKUJtG1MDazyueXWsvbXrtePCc18VkujyyDxqgU+9SiKMVHRG315QZyA7xIiPO
 JLKHjXMSY+cj+qDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785744675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p2347QIVHvSwCl4nClQWY1nACVkvA6JuDR3De3RCc6E=;
 b=OU7bHWtgV1hy9YzqcxAqGj7KxO6qbItdbjLc/Oa9OcVHeBQzVD6lncq52/jZjkDsJ/8d1v
 cUKVWNd/vKnR7AtkCN2inFew/XuDoiqXP72Bbsdl7mnoqMHea05EQggnSTObRkrDrVW0/W
 jPBO7Bo/YRL2W4xjCFCdZ0v+2SjFDIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785744675;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p2347QIVHvSwCl4nClQWY1nACVkvA6JuDR3De3RCc6E=;
 b=4cPV0NFiQ4ZwcUyNbvAkfbVP+9aOP2B1Yh+Z8kz2M9FK3hixZ0i0gl6fvPNFRZG+aGYGpG
 +eGsfw8kQLHK5FAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DBB2779A1;
 Mon,  3 Aug 2026 08:11:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j2Y6AiNNcGpHTgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 03 Aug 2026 08:11:15 +0000
Date: Mon, 3 Aug 2026 10:11:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <anBNIz29I4YdG2Ii@yuki.lan>
References: <20260801-cve-ghostlock-v1-0-178f698f9702@suse.com>
 <20260801-cve-ghostlock-v1-1-178f698f9702@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260801-cve-ghostlock-v1-1-178f698f9702@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,yuki.lan:mid,suse.cz:email,configure.ac:url];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 configure.ac:url, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lapi/prctl: add more fallback definitions
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  configure.ac         |  2 ++
>  include/lapi/prctl.h | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 19fc5e1b8f5f5f94bd797ff2ba4275c29c20cb6c..e698c2b890547ccd32872526daeba13477a7edba 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -286,6 +286,8 @@ AC_CHECK_TYPES([struct fsxattr],,,[#include <linux/fs.h>])
>  
>  AC_CHECK_TYPES([struct logical_block_metadata_cap],,,[#include <linux/fs.h>])
>  
> +AC_CHECK_TYPES([struct prctl_mm_map],,,[#include <linux/prctl.h>])
                                                      ^
						      This must be
						      sys/prctl.h


You are checking linux/prctl.h but include sys/prctl.h in lapi/prctl.h
which breaks compilation on all targets in CI.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
