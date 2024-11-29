Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D1BD6EBFC
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 10:27:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E0923DC009
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 11:27:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2E5B3DBFEB
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 11:27:30 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F07527A7C91
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 11:27:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 88DA021187;
 Fri, 29 Nov 2024 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732876048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vT+YEN7lAe1lu8HQ11yAJLbXlTjEL9RoTyHP977Rchc=;
 b=h70cE5i3KQPyu95w8mkjG7tzHBOVH9G2Y3oeAa+r7cCkKrEtfU0azdwJ+QnFrjIHKdgacl
 6P7vW0HHWCljnjMlVoI0Km3HO7dDUp/xSUmaiedoviBs2hRHdinskbDpDsuxeMXbBveaZo
 nNsOXIpDtiSFF+vQroPXLh/sIPP4TK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732876048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vT+YEN7lAe1lu8HQ11yAJLbXlTjEL9RoTyHP977Rchc=;
 b=RfnZEXkhhgIQis2BMUeaH86IMl1GgZL1htlkePRCxRRinpKojRYdmLSeuYNqK0Ll6a0V10
 yhtsDQkfmDQNJLCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732876048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vT+YEN7lAe1lu8HQ11yAJLbXlTjEL9RoTyHP977Rchc=;
 b=h70cE5i3KQPyu95w8mkjG7tzHBOVH9G2Y3oeAa+r7cCkKrEtfU0azdwJ+QnFrjIHKdgacl
 6P7vW0HHWCljnjMlVoI0Km3HO7dDUp/xSUmaiedoviBs2hRHdinskbDpDsuxeMXbBveaZo
 nNsOXIpDtiSFF+vQroPXLh/sIPP4TK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732876048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vT+YEN7lAe1lu8HQ11yAJLbXlTjEL9RoTyHP977Rchc=;
 b=RfnZEXkhhgIQis2BMUeaH86IMl1GgZL1htlkePRCxRRinpKojRYdmLSeuYNqK0Ll6a0V10
 yhtsDQkfmDQNJLCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73E70133F3;
 Fri, 29 Nov 2024 10:27:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QNE6GxCXSWcmZAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 29 Nov 2024 10:27:28 +0000
Date: Fri, 29 Nov 2024 11:27:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: xiubli@redhat.com
Message-ID: <Z0mXHSnqmstCIMrF@yuki.lan>
References: <20241119101357.951813-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241119101357.951813-1-xiubli@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: correct the build steps for
 open_posix_testsuite
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> './configure' is needed just before generating the Makefiles.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  doc/users/quick_start.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
> index 1581b1f0c..e80c1c244 100644
> --- a/doc/users/quick_start.rst
> +++ b/doc/users/quick_start.rst
> @@ -54,6 +54,7 @@ generated first:
>  .. code-block:: console
>  
>     $ cd testcases/open_posix_testsuite/
> +   $ ./configure

That should be before the 'cd testcase/...' otherwise good catch, this
is clearly missing there.

>     $ make generate-makefiles
>     $ cd conformance/interfaces/foo
>     $ make
> -- 
> 2.46.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
