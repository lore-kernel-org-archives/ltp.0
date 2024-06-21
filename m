Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D4CC27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:10:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E22A73D0F27
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:10:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 169333D0F88
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 11:06:12 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 59369601CCB
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 11:06:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AFE001FB56;
 Fri, 21 Jun 2024 09:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718960768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hyHK9/9CXgzg7/fyQ32203GajwLG1wxNBJLNn9Wtz2Q=;
 b=V+pUkoGk+/st3zpFTjnDuD6+bXowDHkcbK95eWCq9z5oFPoqzOvXXXCdHWwAeTU56tKkGY
 h5eygb1atpwk4tsQhbjQICBKp3PzCY0GKdek48N9cwtRtE6dx7zcSR557pJZgaXjIJqBMy
 bLXayx8GFwLyJb7QqV40sIW0Zsnwtyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718960768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hyHK9/9CXgzg7/fyQ32203GajwLG1wxNBJLNn9Wtz2Q=;
 b=esO97NMTtlUn+oAfEwyOTVYOhTeRU94sCm0ZPb1BSwmXNYQy85v1Tedjm4/B8n9qmKGcgt
 Uh1904PSOzptWVCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718960768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hyHK9/9CXgzg7/fyQ32203GajwLG1wxNBJLNn9Wtz2Q=;
 b=V+pUkoGk+/st3zpFTjnDuD6+bXowDHkcbK95eWCq9z5oFPoqzOvXXXCdHWwAeTU56tKkGY
 h5eygb1atpwk4tsQhbjQICBKp3PzCY0GKdek48N9cwtRtE6dx7zcSR557pJZgaXjIJqBMy
 bLXayx8GFwLyJb7QqV40sIW0Zsnwtyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718960768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hyHK9/9CXgzg7/fyQ32203GajwLG1wxNBJLNn9Wtz2Q=;
 b=esO97NMTtlUn+oAfEwyOTVYOhTeRU94sCm0ZPb1BSwmXNYQy85v1Tedjm4/B8n9qmKGcgt
 Uh1904PSOzptWVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9644413AAA;
 Fri, 21 Jun 2024 09:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xADGI4BCdWZwNwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 21 Jun 2024 09:06:08 +0000
Date: Fri, 21 Jun 2024 11:05:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Message-ID: <ZnVCcU6jOU98DYek@yuki>
References: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <ZnFeWJJldj_ggKnq@yuki>
 <OS3PR01MB639110A9BC48CA10A9D97FEC92CF2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OS3PR01MB639110A9BC48CA10A9D97FEC92CF2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
 memfd_secret
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
> I would suggest using tst_syscall() to check for syscall undefined instead
> of this modification. How about this modification? 
> 
> ```
> --- a/lib/tst_fd.c
> +++ b/lib/tst_fd.c
> @@ -255,7 +255,8 @@ static void open_memfd(struct tst_fd *fd)
> 
>  static void open_memfd_secret(struct tst_fd *fd)
>  {
> -       fd->fd = syscall(__NR_memfd_secret, 0);
> +       fd->fd = tst_syscall(__NR_memfd_secret, 0);
>         if (fd->fd < 0) {
>                 tst_res(TCONF | TERRNO,
>                         "Skipping %s", tst_fd_desc(fd));
> ```

We cannot use tst_syscall() in the tst_fd library because it calls
tst_brk() with TCONF which exits the test immediately, but in this case
we actually want to continue with the rest of the tests.

I guess that the best fix is to add fallback definitions for
memfd_secret into include/lapi/syscalls/*.in files. That way we should
get -1 and EINVAL properly even when kernel does not support the
syscall.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
