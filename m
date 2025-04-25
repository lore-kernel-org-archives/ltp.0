Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78986C369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 18:34:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23C6F3CBABF
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 20:34:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E1AE3CBA62
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 20:33:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A87AF1000A61
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 20:33:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5C0621167;
 Fri, 25 Apr 2025 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745606032;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B6g2kJO5hWtmtYH9P3BbNAnwI63ooUfbqzDzAoE2+6E=;
 b=WrhGFOAT2ivcrraLEA02rvvbQEaivph0+P4eBB3n+WAn4zNV+v/D1EQqnWp0bkR5JrTWzZ
 2gef/Fx1gSA0vuF0NRPCq8Tei2pLDw5QNs1XyXG687PG2reBCAR+IGPaJPGgDmYAIJ65Nn
 RRNHzaj+tpSUdkAYj4AFFxe+WinAwho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745606032;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B6g2kJO5hWtmtYH9P3BbNAnwI63ooUfbqzDzAoE2+6E=;
 b=jwp9i8Q3GCOBlIAzWoevjMzdz1wuurTHb4BkH6VwAW+8IMrLl8XKizkOZskNrtFvuULkR3
 A3XvRzk1YKxQzRBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745606031;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B6g2kJO5hWtmtYH9P3BbNAnwI63ooUfbqzDzAoE2+6E=;
 b=Nxj/X6Nu5K+JI8oUz0wna6epThpFym6iFvamPeIJKfBVaUxHmCDJ9rJYfT/z9/S0vvJXyq
 5rgqC6sfr8rbzugnhZep5Uc07cF0YSZPQDINQBdaoxyxw+nSwE8VRnM1b9I7S4M+6NCHks
 d3Y9RUlbLIPLHXMNf2j8XIETaPKmX/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745606031;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B6g2kJO5hWtmtYH9P3BbNAnwI63ooUfbqzDzAoE2+6E=;
 b=Se6zbaIyemapb3UnlCBrxVcxt2//T1jZ3Tr3TTHyPWT6lcDRw+sohUyZldKa6+niiz7r5J
 ZKxEE5W4DCVa7+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7956F1398F;
 Fri, 25 Apr 2025 18:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1jh9HI/VC2g5IgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Apr 2025 18:33:51 +0000
Date: Fri, 25 Apr 2025 20:33:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250425183345.GA79209@pevik>
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-5-pvorel@suse.cz>
 <Z8shfrkfVkwsCOTw@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z8shfrkfVkwsCOTw@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,shell_loader_setup_cleanup.sh:url,imap1.dmz-prg2.suse.org:helo,tst_exec.sh:url,tst_loader.sh:url,tst_env.sh:url];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 4/5] shell lib: Add basic support for test
 cleanup
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> > +++ b/testcases/lib/tst_loader.sh
> > @@ -3,11 +3,8 @@
> >  # Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>

> >  # This is a loader for shell tests that use the C test library.
> > -#

> >  if [ -z "$LTP_IPC_PATH" ]; then
> > -	tst_run_shell $(basename "$0") "$@"
> > +	tst_run_shell tst_exec.sh $(basename "$0") "$@"
> >  	exit $?
> > -else
> > -	. tst_env.sh
> >  fi

> Do we really need the tst_exec.sh?

> Doesn't it work if we add what is in the tst_exec here?

I guess you mean to keep the original:
-	tst_run_shell $(basename "$0") "$@"

instead of what I proposed:
+	tst_run_shell tst_exec.sh $(basename "$0") "$@"

I added it to get rid of previous error:

tst_res: not found

$ PATH="testcases/lib:testcases/lib/tests:$PATH" shell_loader_setup_cleanup.sh
tst_test.c:1903: TINFO: LTP version: 20250130-239-gc016fb0c0a
tst_test.c:1907: TINFO: Tested kernel: 6.12.20-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.20-1 (2025-03-23) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/boot/config-6.12.20-amd64'
tst_test.c:1720: TINFO: Overall timeout per run is 0h 00m 30s
testcases/lib/tests/shell_loader_setup_cleanup.sh: 16: testcases/lib/tst_loader.sh: tst_res: not found
testcases/lib/tests/shell_loader_setup_cleanup.sh: 21: tst_res: not found
tst_test.c:452: TBROK: Invalid child (82160) exit value 127

tst_exec.sh added in this v1 contains:

. tst_env.sh

. "$1"

if [ -n "$TST_CLEANUP" ]; then
	trap $TST_CLEANUP EXIT
fi

if [ -n "$TST_SETUP" ]; then
    $TST_SETUP
fi

tst_test
---

The most important part is:

. "$1"

which is to source the script. This cannot be added into tst_loader.sh
(it would create indefinite loop), this must be somehow added to tst_run_shell.c

And the only way I come up with was to add it via the above mentioned change of
tst_run_shell.c running actually tst_exec.sh instead of the test directly.

I guess I'm missing something.

Feel free to look into my v2, likely it's obvious to you what am I missing:
https://github.com/pevik/ltp/blob/refs/heads/shell-loader-setup-cleanup.v2/testcases/lib/tst_loader.sh

Kind regards,
Petr

> The whole point of [ -z "$LTP_IPC_PATH" ]; is to detect when we are
> being re-executed by the tst_run_shell, so the else branch (which
> isn't really needed, because we do exit in the if) was when the test did
> run.

> If you change the tests to be in functions and source the tst_loader.sh
> at the end it should just work.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
