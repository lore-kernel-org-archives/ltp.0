Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B83C3ABD9
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 08:23:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2FB63CC38A
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 10:23:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E83B3C1D15
 for <ltp@lists.linux.it>; Wed, 14 May 2025 10:23:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7EE36140051B
 for <ltp@lists.linux.it>; Wed, 14 May 2025 10:23:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE6081F391;
 Wed, 14 May 2025 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747210979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pMbAhkmvRFg3+jbJfqLUfcOXmg2d6wWelMoYTXr5IiU=;
 b=uPV8ln5bMxlvPgSYZFoHBLRuT8Ox1j7gxcsMHWWO9YOiM9GfyVo2wwtCsvcy0ILcpiEvMX
 pQzIOvc+of8wMNGYX0DdH8LLJejIBfbRQeCaNd2N9x7woSxLJyUO3jPiRaaiPkRdFwvJw7
 dFhD1gIS9vlRO5B7QJN+9+uidONWrzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747210979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pMbAhkmvRFg3+jbJfqLUfcOXmg2d6wWelMoYTXr5IiU=;
 b=AX63Fxc197QEt5WD+s9ORfMyakjNIUvDGc7YVw3nEpJ2+xPfmB8qhmS9MlspsY0zFgGJxO
 GE8VLLwcFImtgnAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747210978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pMbAhkmvRFg3+jbJfqLUfcOXmg2d6wWelMoYTXr5IiU=;
 b=XuNxACfDWmbAbMbaOLwwwKlKnid5tL8XOuKXW+m+emCQn2bJJJXZwMz4BewJbnNUn3IupP
 EfMPq3Xn+3ak+BRMftSXr8cXuinwgHdps7nSODc5wMpdhyFhABZ2cJUtZmk1T6bDUdVmFS
 oD4b6oRgRJU7KLjca2y5jCFRA1E7dF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747210978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pMbAhkmvRFg3+jbJfqLUfcOXmg2d6wWelMoYTXr5IiU=;
 b=GgtQ2iKHP7Kg6y4DRr+PmGGBF+qBZou4FLR6Y8ZL/sUzAfGJZoEOBfmbAVa3yM46TBc8go
 zp8c5Pi/Xc+mmtDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2D5713306;
 Wed, 14 May 2025 08:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MQ6cLuJSJGhDEwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 14 May 2025 08:22:58 +0000
Date: Wed, 14 May 2025 10:23:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aCRTBfIRoj0rhhX3@yuki.lan>
References: <20250513050530.47541-1-liwang@redhat.com>
 <aCM2PrCrCdPqNIGc@yuki.lan>
 <CAEemH2cP78yxJEWi-Z_v=EuXWP+6XDQBNnGMVHKq3pYLiGQRdw@mail.gmail.com>
 <aCRNqIAGRnZQJzua@yuki.lan>
 <CAEemH2f8TVDozK+UJDrtekwNqk7AM2MZZu8Mq8VDrkvyyu50LA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f8TVDozK+UJDrtekwNqk7AM2MZZu8Mq8VDrkvyyu50LA@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: initialize lib|main_pid to zero in the
 setup_ipc
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
> I see, and you're right we have to set lib_pid before any real setup.
> 
> Does this change below make sense (based on the v2 I just sent)?
> 
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -144,6 +144,8 @@ static void setup_ipc(void)
>         }
> 
>         memset(results, 0 , size);
> +
> +       results->lib_pid = getpid();
>  }
> 
>  static void cleanup_ipc(void)
> @@ -1933,7 +1935,6 @@ void tst_run_tcases(int argc, char *argv[],
> struct tst_test *self)
> 
>         do_setup(argc, argv);
> 
> -       results->lib_pid = getpid();
>         tst_enable_oom_protection(results->lib_pid);
> 
>         SAFE_SIGNAL(SIGALRM, alarm_handler);

Yes, this should fix it.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
