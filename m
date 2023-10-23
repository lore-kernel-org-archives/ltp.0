Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78AECDB474
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 12:32:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10B6D3CECCE
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 14:32:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D05B3CCDD2
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 14:32:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8B27D600BF9
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 14:32:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D4461FE11;
 Mon, 23 Oct 2023 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698064327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kNkgZeCRZTZlLichU4GtpDZ+HaSVfXfRG1L8eGtc0pI=;
 b=lWhDsgUmm+IvwzlLtq9FdoozwNd7dOiYRl2ao3FauCCggNTRT1Z/8g4ZcBhtAZRdrVZ/nP
 jgh/w9lYdg8yJ7b40von/ncQ0xpT/MDlgpbpWqUyYZkW5if3JCw0GdHfVFBuf3xqb+0ivv
 YxEptl17BwvMQWVpbPWKSlRDNo7zHPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698064327;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kNkgZeCRZTZlLichU4GtpDZ+HaSVfXfRG1L8eGtc0pI=;
 b=YOUAPOoRIX9sC6hiUrT+VteQIA7ZrE3BaaqQIk0JLsRE6pve73K24/F8G+w7zXSYgSERVC
 me0uwUJgAbcEz7Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED353139C2;
 Mon, 23 Oct 2023 12:32:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3QRMOcZnNmWHLQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 23 Oct 2023 12:32:06 +0000
Date: Mon, 23 Oct 2023 14:32:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZTZn5vw-PFjKhYW9@yuki>
References: <20231021122958.13458-1-wegao@suse.com>
 <20231021122958.13458-2-wegao@suse.com> <ZTZnHLi1tSN_WGPc@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZTZnHLi1tSN_WGPc@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.84 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.24)[89.57%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] lib: Add .ulimit
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
> > +void tst_ulimit_conf(const struct tst_ulimit_val *conf)
> > +{
> > +	struct rlimit rlim;
> > +
> > +	rlim.rlim_cur = conf->rlim.rlim_cur;
> > +	rlim.rlim_max = conf->rlim.rlim_max;
> 
> I wonder if we should adjust the max only if it's smallre than the
> requested value.

Looking again we store both values in the structure. I wonder if we need
to set both, maybe we just need the rlim_cur value in the tst_ulimit_val
structure and we would attempt to adjust rlim_max only if its smaller
than rlim_cur. That would allow us to use the API even for tests that
does not require root to raise limits within the permitted maxium.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
