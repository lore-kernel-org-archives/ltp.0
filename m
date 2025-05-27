Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F34AC54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:19:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12E913C5837
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 13:19:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 149C13C01E9
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:18:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 71AE41A000BE
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:18:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 912AC1F455;
 Tue, 27 May 2025 11:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748344726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRWVwQtnPw75nx6vEGfO7gavZyem770XnfFValrhTbE=;
 b=G+v8PruEmr1kD+/XcttjxBakzTa+3+2WUJ41stqIhhDzlDy7tccNnXVntU/XomVIZ70iTj
 V8cxJB8ch15BOumHwGjZkI9kNnWyXCaRwuwNyqiMwtpGsVcx4fnT9VSR1JgB8H/Nu1aiiP
 5aOuwVCSFRtosMWuynrxYAqmT5QbUiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748344726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRWVwQtnPw75nx6vEGfO7gavZyem770XnfFValrhTbE=;
 b=tFNsOsEYIR7iQP6rPOnR9flpC9I6IWYTWLx5M+O+GT3Sjjtw5j7uyuxxk8HR6kqJAuWsGs
 NTOCUrlnvMoWWICA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748344726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRWVwQtnPw75nx6vEGfO7gavZyem770XnfFValrhTbE=;
 b=G+v8PruEmr1kD+/XcttjxBakzTa+3+2WUJ41stqIhhDzlDy7tccNnXVntU/XomVIZ70iTj
 V8cxJB8ch15BOumHwGjZkI9kNnWyXCaRwuwNyqiMwtpGsVcx4fnT9VSR1JgB8H/Nu1aiiP
 5aOuwVCSFRtosMWuynrxYAqmT5QbUiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748344726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRWVwQtnPw75nx6vEGfO7gavZyem770XnfFValrhTbE=;
 b=tFNsOsEYIR7iQP6rPOnR9flpC9I6IWYTWLx5M+O+GT3Sjjtw5j7uyuxxk8HR6kqJAuWsGs
 NTOCUrlnvMoWWICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80B621388B;
 Tue, 27 May 2025 11:18:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wyUeHpafNWgXfgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 27 May 2025 11:18:46 +0000
Date: Tue, 27 May 2025 13:19:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aDWfrkuuohllNO27@yuki.lan>
References: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; REPLY(-4.00)[];
 SUBJECT_ENDS_QUESTION(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Reduce .runtime for Long-Running Tests ?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> After reviewing some LTP HTML test reports, I noticed that the ten tests
> alone take nearly 20 minutes to complete. For example:
> 
> --------------------
> bind06           300.15s
> msgstress01      180.44s
> fsx22            170.47s
> pty07            150.04s
> pty06            150.02s
> gf18             121.09s
> gf17             120.82s
> gf16             120.13s
> dirtyc0w_shmem   120.11s
> setsockopt07      76.47s
> 
> In total, running the full ltp-lite suite currently takes ~1h20m, which is a bit
> long for CI or pre-merge validation pipelines.
> 
> I'm wondering whether all these .runtime values are truly necessary to reproduce
> the intended issues (e.g., race conditions, fuzzing, sync timing issues).
> Or if we could:
>  - Set a lower threshold for .runtime on general-purpose stress/fuzz tests
>  - Introduce a runtime _policy_ for different environments (e.g., fast
> CI vs. full weekly runs)
> 
> It might be beneficial to revisit the .runtime values of long-running tests and
> set a minimal yet effective duration that balances reproducibility with resource
> efficiency. This could help save time and free up test resources earlier.
> 
> Any thoughts/comments would be appreciated.

This is exactly the reason why I want to have queries on metadata
available in kirk, e.g. "filter out all tests that have runtime >
$some_constant".

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
