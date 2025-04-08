Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC69C369A2
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 13:10:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 612613CB39D
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 15:10:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 224223C0496
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 15:09:44 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 39144200BB9
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 15:09:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B4A721162;
 Tue,  8 Apr 2025 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744117782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lG2oxEBFCQ8iqckvextKXJhlILEiRFRZCimhnPRecsg=;
 b=mZta4xIfY+eP16z5zf0DJCc/Awqa7DB5z6cm9AH11LdXn43YyvtVDEQRXzSxxlFR4DV42u
 gzKP5zjWtK3vXeTe2OFcdp7yVkd5Pjudt+yhyBKpklZ4lQigVl2CZxHobJDs0+JcKOn7U9
 9FsW4uB/TLKErDeDiXRpmUL8y2uaZCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744117782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lG2oxEBFCQ8iqckvextKXJhlILEiRFRZCimhnPRecsg=;
 b=Bu7vOdcdlohJRLWQ4ArFklznaStV3XNatu34GgAdofrwSdB4idXyz4uwEaVzQUX6C5OxR8
 I6Xw5IcyS4To2LDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744117782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lG2oxEBFCQ8iqckvextKXJhlILEiRFRZCimhnPRecsg=;
 b=mZta4xIfY+eP16z5zf0DJCc/Awqa7DB5z6cm9AH11LdXn43YyvtVDEQRXzSxxlFR4DV42u
 gzKP5zjWtK3vXeTe2OFcdp7yVkd5Pjudt+yhyBKpklZ4lQigVl2CZxHobJDs0+JcKOn7U9
 9FsW4uB/TLKErDeDiXRpmUL8y2uaZCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744117782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lG2oxEBFCQ8iqckvextKXJhlILEiRFRZCimhnPRecsg=;
 b=Bu7vOdcdlohJRLWQ4ArFklznaStV3XNatu34GgAdofrwSdB4idXyz4uwEaVzQUX6C5OxR8
 I6Xw5IcyS4To2LDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 746CF13691;
 Tue,  8 Apr 2025 13:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o6CJGxYg9WcLLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 08 Apr 2025 13:09:42 +0000
Date: Tue, 8 Apr 2025 15:09:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250408130941.GD225750@pevik>
References: <20250404143423.16268-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250404143423.16268-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib/tst_test.c: Fix tst_brk() handling
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

> This makes the tst_brk() handling cleaner and saner as instead of
> propagating the tst_brk() result in a return value an abort flag is
> introduced into the shared memory.

LGTM. Thanks for updating the old API.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
...
>  /**
> - * tst_brk() - Reports a breakage and exits the test.
> + * tst_brk() - Reports a breakage and exits the test or test process.
>   *
>   * @ttype: An enum tst_res_type.
>   * @arg_fmt: A printf-like format.
>   * @...: A printf-like parameters.
>   *
> - * Reports either TBROK or TCONF and exits the test immediately. When called
> - * all children in the same process group as the main test library process are
> - * killed. This function, unless in a test cleanup, calls _exit() and does not
> - * return.
> + * Reports a single result and exits immediately. The call behaves differently
> + * based on the ttype parameter. For all ttype results but TBROK the call exits
> + * the current test process, i.e. increments test result counters and calls
> + * exit(0).
> + *
> + * The TBROK ttype is special that apart from exiting the current test process
> + * it also tells to the test library to exit immediately. When TBROK is
> + * triggered by any of the test processes the whole process group is killed so
> + * that there are no processes left after the library process exits. This also
> + * means that any subsequent test iterations are not executed, e.g. if a test
> + * runs for all filesystems and tst_brk() with TBROK is called, the test exits
> + * and does not attempt to continue a test iteration for the next filesystem.
>   *
>   * When test is in cleanup() function TBROK is converted into TWARN by the test
>   * library and we attempt to carry on with a cleanup even when tst_brk() was
>   * called. This makes it possible to use SAFE_FOO() macros in the test cleanup
>   * without interrupting the cleanup process on a failure.
>   */
> -#define tst_brk(ttype, arg_fmt, ...)						\
> -	({									\
> -		TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(!((ttype) &			\
> -			(TBROK | TCONF | TFAIL)));				\
> -		tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
> -	})

Could you please also before merge delete TST_BRK_SUPPORTS_ONLY_TCONF_TBROK()
definition in include/tst_common.h?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
