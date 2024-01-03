Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A742C3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 15:40:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EFDF3CE7A6
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 16:40:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 613F73CE767
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 16:40:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 78FC9600D87
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 16:40:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A4C0621E55;
 Wed,  3 Jan 2024 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704296428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAt0T9ah7z6lWHLS6Fv/9ENoQRLJpQb+a06SNBUny3Y=;
 b=1uyCd7JfAeRm5lJMV7vxP6Lj4LUgl6klcBryJTpExAKswDE3tj3cshN5Ng2KrGO9NH8kME
 9VuRQ2rDFRcZpoqLD2ASFYvgPD1dGp1ITfg17/6oJN3z1dyC0wrIE+YPhIxypLPkJxq3Cs
 7Yl0s08WbEcpAWNagSASAeqEXAD9bBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704296428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAt0T9ah7z6lWHLS6Fv/9ENoQRLJpQb+a06SNBUny3Y=;
 b=RXaDCaJpr8J8+pjHTOFyS5QgjOxhylJoqiIx58DG/TqQMc+6alydui+71X19//U+AjFR98
 8HzBj5l+cpa9ELDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704296428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAt0T9ah7z6lWHLS6Fv/9ENoQRLJpQb+a06SNBUny3Y=;
 b=1uyCd7JfAeRm5lJMV7vxP6Lj4LUgl6klcBryJTpExAKswDE3tj3cshN5Ng2KrGO9NH8kME
 9VuRQ2rDFRcZpoqLD2ASFYvgPD1dGp1ITfg17/6oJN3z1dyC0wrIE+YPhIxypLPkJxq3Cs
 7Yl0s08WbEcpAWNagSASAeqEXAD9bBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704296428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAt0T9ah7z6lWHLS6Fv/9ENoQRLJpQb+a06SNBUny3Y=;
 b=RXaDCaJpr8J8+pjHTOFyS5QgjOxhylJoqiIx58DG/TqQMc+6alydui+71X19//U+AjFR98
 8HzBj5l+cpa9ELDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9259F1398A;
 Wed,  3 Jan 2024 15:40:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j/uvIux/lWU6XgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jan 2024 15:40:28 +0000
Date: Wed, 3 Jan 2024 16:40:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZZWABSaod5UAIAPl@yuki>
References: <20231205061639.68656-3-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-1-xuyang2018.jy@fujitsu.com>
 <20231222050006.148845-5-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231222050006.148845-5-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_SPAM_LONG(3.50)[1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.51)[91.81%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/7] swapon/Makefile: Remove useless section
 for MAX_SWAPFILES
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
Good catch, looks like the code that used this has been removed back in
2009 in 96db7a4982e.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
