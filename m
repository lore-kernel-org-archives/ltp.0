Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDC0C44536
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 12:06:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 258ED3CAFA6
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 13:06:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDDEA3C05FA
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:06:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4B466600BC7
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:06:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B47A8336A3;
 Thu, 22 Jan 2026 12:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769083566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W7mdNQTI3ZIGwYZKcBjno79otgOm3KZTmsdMALicMVw=;
 b=E86prplC/3cxnZwB5VgUPWkvyhYlWN9FewCrvk5+6UVCGjA6stAwtOgefJ7sZmaJmR+YTf
 i/5ITGPnKy3Y7aqMWhI7gcch1q0r+fhkEZF9ELG/oaPpseTBzYfUAygm84eCe8bZisFz90
 5QU5IcRjmdtfxiPqeiaTqmrgkVFxCyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769083566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W7mdNQTI3ZIGwYZKcBjno79otgOm3KZTmsdMALicMVw=;
 b=s/UDqJ2Y/MiWf1G7E7pEbYUqcq5C3q/r0SkRN41LAF6A5OmWQ1ebXCXSLqUwsM/Ts7+3Yt
 DZ3F+rZAtKhVSPDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769083565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W7mdNQTI3ZIGwYZKcBjno79otgOm3KZTmsdMALicMVw=;
 b=eN49PScte+2Wc5yaHoKx8JJBY+bOUfHmuI/PaZqeoX9HNDmRFXpa+1eJpS2ltmf4+Ip1s0
 /RMdNZLfJBkKjmyBCCJwFlibmYH7GrilrhQd28VNh6ZNris+CE58ziCods7H8BaD6/5IhO
 mnaa3A6O6Z1H0oFBIkdMgxda5Jq8D0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769083565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W7mdNQTI3ZIGwYZKcBjno79otgOm3KZTmsdMALicMVw=;
 b=inVF55okF8fY2Q4Yth9LbKPD5cmzKQYR5C95k9aurHzFEiBvv3cfUA9CEXyOyktulfsFpx
 igDhf2ewaCDQSZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EEC013533;
 Thu, 22 Jan 2026 12:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZBn+Ia0ScmkYcAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 Jan 2026 12:06:05 +0000
Date: Thu, 22 Jan 2026 13:06:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260122120604.GA64562@pevik>
References: <20260122111810.91411-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260122111810.91411-1-liwang@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vma05: fix the needs_cmds format
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

Hi Li,

> Fixes: 39a28444272 ("lib: Add support option for .needs_cmds")
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/mem/vma/vma05.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
> index 34a82162c..b9654e80c 100755
> --- a/testcases/kernel/mem/vma/vma05.sh
> +++ b/testcases/kernel/mem/vma/vma05.sh
> @@ -26,7 +26,14 @@
>  # {
>  #  "needs_root": true,
>  #  "needs_tmpdir": true,
> -#  "needs_cmds": ["gdb", "uname"],
> +#  "needs_cmds": [
> +#     {
> +#       "cmd": "gdb"
> +#     },
> +#     {
> +#       "cmd": "uname"
> +#     }
> +#   ],

Good catch, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>  #  "save_restore": [
>  #   ["/proc/sys/kernel/core_pattern", "core", "TBROK"],
>  #   ["/proc/sys/kernel/core_uses_pid", "0", "TBROK"]

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
