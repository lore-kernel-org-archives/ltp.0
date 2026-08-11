Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8761DC5AC67
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 04:45:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FB233CE2C2
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 06:45:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 657AB3CBD18
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 06:45:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6F6306002F8
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 06:45:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 773B93E28;
 Tue, 11 Aug 2026 04:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786423517;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RA1xYZ6ZKafDHaSGf9sqmODzIccL1dgGkdo188H3PuY=;
 b=xDknh3xqTeg74WWyjcNejiRsTuLlnGTDd1lGUFp1ZS2kVKKhxwIyZZ5N7Ot+eoMRQEck+E
 7dtRL8TEW+f+5U+e+ZQSx4OnskahpjFgHdWVPV+LHpelVpkDzqVSl0kypjfz/SH+1+1UdB
 PRh8UBW6W0oeHcS6mtPRySpQlplVrLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786423517;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RA1xYZ6ZKafDHaSGf9sqmODzIccL1dgGkdo188H3PuY=;
 b=+NfV8VPymAPYu+nTOuh5jRt3E+m2CjWd+K2yr8U4g+Hqt2q6HWMlSxBkBoB3CLo9Nzrxz3
 TaI78vdpsN84xMCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786423513;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RA1xYZ6ZKafDHaSGf9sqmODzIccL1dgGkdo188H3PuY=;
 b=X8fM3l1jKqddBexYAqNo1hBh1KIG33C3I2DVhd/GDlfb+suwP9+1cb4LY4H3OzvQIKnEam
 FVf0k7sj08meQFs/Rc/Z3ycnfHgb8tDiMoBBcQVZjVPvDEtwgPB57l5B1EGsDUeK5ZdwbK
 VmwpPFYYAAXGuGuJU2TAv/NUYCNvg+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786423513;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RA1xYZ6ZKafDHaSGf9sqmODzIccL1dgGkdo188H3PuY=;
 b=beFCom2DneBsNoIvzXbYDwHMN0sAB3RKQOjP/k79KaHGXkE0RvaEaceZcKoIiTxaW3P3QK
 zEhEHRGARVn2PcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 464EF779B6;
 Tue, 11 Aug 2026 04:45:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fWMSD9moemo1bAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Aug 2026 04:45:13 +0000
Date: Tue, 11 Aug 2026 06:45:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>,
 Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260811044507.GA230862@pevik>
References: <20260810-shell_oom_protection-v4-1-4dac0dbb0414@suse.com>
 <anqQXb08RqRK-74w@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anqQXb08RqRK-74w@linux.dev>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,tst_test.sh:url];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] shell: enable OOM protection by default
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Andrea,

> Hi Andrea, Petr,

> After looking into it more, now I slightly think doing OOM protection
> in the shell harness isn't worth it: the benefit doesn't justify the
> complexity. Forking the whole test body means dealing with cleanup and
> timer ownership across the fork, plus passing results back from the
> child, and all of that would need revalidating for every shell test
> that goes through tst_test.sh.

+1

> Given that only a few tests actually produce memory pressure, I'd
> rather keep it simple and handle it locally in those tests instead of
> touching the common harness. Something like a small helper the test
> can wrap the memory hungry workload with:

>     tst_oom_run()
>     {
>         ( echo 0 > /proc/self/oom_score_adj; exec "$@" )
>     }

+1

Maybe test should declare through TST_* variable that it needs OOM killer
(approach on Andrea's v2 [1]). I'm sorry Andrea, it takes time to find a right
solution.

[1] https://lore.kernel.org/ltp/20260730-shell_oom_protection-v2-0-be1de2baa83d@suse.com/

And again, IMHO the real solution would be to rewrite tests into C API or shell
loader API.

> The harness (or the setup) protects itself with oom_score_adj -1000,
> and only the workload started via tst_oom_run stays killable.
> This keeps the harness alive to report results without forking the
> whole test body, and matches the C harness model where the worker is
> the unprotected part.

Yes, forking (the subshell) part looked to me fragile.

> Does this direction make sense to you, or do you see a case that
> really needs the protection to be harness-wide?

> > Suggested-by: Li Wang <liwang@redhat.com>

> This email address is no longer in use :).

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
