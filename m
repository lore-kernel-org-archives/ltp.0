Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B90ACA9ED0
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 11:14:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A87BD3E9C61
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 13:14:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67C813E2D2D
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 13:14:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AEF751000741
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 13:14:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09B6C1F7A1;
 Mon, 12 Oct 2026 11:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791803659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ngRFiZ167N8uYJLRcBwkx2hwvij0bMSny41ewpHO/E4=;
 b=HevBgCEwHNyTSwaEzfHNQJf+qKhtl8PVoi/zXn65jMRoXurT42n+Y/At1RSMXn/1yWs69b
 yt6ek4aSfW+jUb4pNVE7FKt+zlrnWuu/R7Li8ODeRtCXrhGByOQG1yktNFmToOu7c0UxWM
 E8EDTkYfm+aHGfYZiBz2tVoGiTHHlRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791803659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ngRFiZ167N8uYJLRcBwkx2hwvij0bMSny41ewpHO/E4=;
 b=GfAGGR1gUh4LZapIP5iNtykMfxnpVMFo1nFdf1+PGZsgnm4pMQLFYCp8xWZZRJevWpR4Rg
 9qIo01Jd/dfXg6Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791803659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ngRFiZ167N8uYJLRcBwkx2hwvij0bMSny41ewpHO/E4=;
 b=HevBgCEwHNyTSwaEzfHNQJf+qKhtl8PVoi/zXn65jMRoXurT42n+Y/At1RSMXn/1yWs69b
 yt6ek4aSfW+jUb4pNVE7FKt+zlrnWuu/R7Li8ODeRtCXrhGByOQG1yktNFmToOu7c0UxWM
 E8EDTkYfm+aHGfYZiBz2tVoGiTHHlRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791803659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ngRFiZ167N8uYJLRcBwkx2hwvij0bMSny41ewpHO/E4=;
 b=GfAGGR1gUh4LZapIP5iNtykMfxnpVMFo1nFdf1+PGZsgnm4pMQLFYCp8xWZZRJevWpR4Rg
 9qIo01Jd/dfXg6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC8D613408;
 Mon, 12 Oct 2026 11:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2ld3KQrBzGrTWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 12 Oct 2026 11:14:18 +0000
Date: Mon, 12 Oct 2026 13:14:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aszBHHq0VvINVwrT@yuki.lan>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
 <20260831-fchroot-v4-8-57cceb68f927@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831-fchroot-v4-8-57cceb68f927@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v4 08/16] fchroot05: test failfs root can
 not be referenced
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
> +	len = readlinkat(procfd, "self/root", buf, sizeof(buf) - 1);
> +	if (len < 0) {
> +		tst_res(TFAIL | TTERRNO, "readlinkat() of /proc/self/root");
> +	} else {
> +		buf[len] = '\0';
> +		TST_EXP_EQ_STR(buf, "failfs:/");
> +	}
> +
> +	exit(0);

Here as well.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
