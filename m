Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F45CA1005
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 14:26:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0186E3CD1D1
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 16:26:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C0913CCB6F
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 16:26:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5011A1400B70
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 16:26:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A7D92118D;
 Tue,  2 Sep 2025 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756823187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uzAzJpM7M7NOpl+QiPT6zcG1fCeczR+TdIXmv4J2Y6A=;
 b=zcxLXrfxhG7AP27j6OemSiMQ/s6ZLzJGsP1WkPp0Qko6xY33Gp1NR1ciAGrbOLTrOgpyF9
 cF8ILWKENhYUTg6ckr/7rv25Wj+Fh1NAbtg7RfIMxSH7wk8DdCRs9Dx2Bd3qrmBOwsAvve
 QiXt/CZjFCy3Ct9oFroowJlaD2/xfSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756823187;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uzAzJpM7M7NOpl+QiPT6zcG1fCeczR+TdIXmv4J2Y6A=;
 b=r73O0j9Z/zCmctwDvtXVBOrOaxnWhDe60x7V++yp4Y5fsSg56LWJhUQA0c9BsGm/SvPCy5
 cN+Ww9+oP+LieRAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756823187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uzAzJpM7M7NOpl+QiPT6zcG1fCeczR+TdIXmv4J2Y6A=;
 b=zcxLXrfxhG7AP27j6OemSiMQ/s6ZLzJGsP1WkPp0Qko6xY33Gp1NR1ciAGrbOLTrOgpyF9
 cF8ILWKENhYUTg6ckr/7rv25Wj+Fh1NAbtg7RfIMxSH7wk8DdCRs9Dx2Bd3qrmBOwsAvve
 QiXt/CZjFCy3Ct9oFroowJlaD2/xfSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756823187;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uzAzJpM7M7NOpl+QiPT6zcG1fCeczR+TdIXmv4J2Y6A=;
 b=r73O0j9Z/zCmctwDvtXVBOrOaxnWhDe60x7V++yp4Y5fsSg56LWJhUQA0c9BsGm/SvPCy5
 cN+Ww9+oP+LieRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8160113A54;
 Tue,  2 Sep 2025 14:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1DWPHpP+tmjXcAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 02 Sep 2025 14:26:27 +0000
Date: Tue, 2 Sep 2025 16:27:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <aLb-uPKS6ZCmpUTc@yuki.lan>
References: <20250829-conversions-lchown-v5-0-7c3f25cd1de4@suse.com>
 <20250829-conversions-lchown-v5-4-7c3f25cd1de4@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250829-conversions-lchown-v5-4-7c3f25cd1de4@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/4] syscalls: lchown03: Merge into lchown02
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
>  static void run(unsigned int i)
> @@ -70,8 +77,14 @@ static void setup(void)
>  {
>  	bad_addr = tst_get_bad_addr(NULL);
>  
> -	memset(longpath, 'a', LONGPATHSIZE - 1);
> -	longpath[LONGPATHSIZE-1] = 0;
> +	memset(maxpath, 'a', MAXPATH - 1);
> +	maxpath[MAXPATH-1] = 0;
> +
> +	snprintf(longpath, sizeof(longpath), ".");
> +	SAFE_MKDIR("longpath", 0755);
> +	SAFE_SYMLINK("../longpath", "longpath/longpath");
> +	for (int i = 0; i < 43; i++)
> +		strcat(longpath, "/longpath");

There is much more easier way how to get ELOOP, just create two symlinks
pointing to each other.

	SAFE_SYMLINK("infinte_loop_a", "infinite_loop_b");
	SAFE_SYMLINK("infinte_loop_b", "infinite_loop_a");

Trying to resolve either of these ends up in ELOOP.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
