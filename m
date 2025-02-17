Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0775C021A0
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 07:17:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9ABB13C9BB9
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 08:17:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A04D43C92EA
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 08:17:39 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C076310072CA
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 08:17:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8BAF01F397;
 Mon, 17 Feb 2025 07:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739776655;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eb58nOzXxUzRzJ6/H4SVfdpUhLjYfrV2HSGqV1T34fk=;
 b=XDvMsHWM+//XZERm2Qlnmgv2VnkmGQlapReGrhUfvzmOn/r9rLdswpmfgwULDOHTlx1RPN
 THkhtLBU/QxIwFUkNjeubMA3R5lLTmM33j92CQLL4lhiZDonp2O0oWE+ddq7f9toMYKROr
 rJtwxLETJ/kO/zoZjTm++i6QV0XMSCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739776655;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eb58nOzXxUzRzJ6/H4SVfdpUhLjYfrV2HSGqV1T34fk=;
 b=Fuy9d+LDCBz5WabWnYHLHXYqJEy80FfDIUw14N2dX1EdkX/hUqazUWkyoqgoFWfsy/JuDb
 7fL1b5fq1BpPxUCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XDvMsHWM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Fuy9d+LD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739776655;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eb58nOzXxUzRzJ6/H4SVfdpUhLjYfrV2HSGqV1T34fk=;
 b=XDvMsHWM+//XZERm2Qlnmgv2VnkmGQlapReGrhUfvzmOn/r9rLdswpmfgwULDOHTlx1RPN
 THkhtLBU/QxIwFUkNjeubMA3R5lLTmM33j92CQLL4lhiZDonp2O0oWE+ddq7f9toMYKROr
 rJtwxLETJ/kO/zoZjTm++i6QV0XMSCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739776655;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eb58nOzXxUzRzJ6/H4SVfdpUhLjYfrV2HSGqV1T34fk=;
 b=Fuy9d+LDCBz5WabWnYHLHXYqJEy80FfDIUw14N2dX1EdkX/hUqazUWkyoqgoFWfsy/JuDb
 7fL1b5fq1BpPxUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62B8A1379D;
 Mon, 17 Feb 2025 07:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KDOXFo/ismeEEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 07:17:35 +0000
Date: Mon, 17 Feb 2025 08:17:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250217071734.GA2298224@pevik>
References: <20250215091741.400782-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250215091741.400782-1-amir73il@gmail.com>
X-Rspamd-Queue-Id: 8BAF01F397
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: fix test failure when running with
 nfs TMPDIR
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 Rhythm Mahajan <rhythm.m.mahajan@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

> If TMPDIR does not support mount watches due to ENODEV, the failure
> to watch multiple fs would be EXDEV and not ENODEV.

> Reported-by: Rhythm Mahajan <rhythm.m.mahajan@oracle.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify01.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
> index c7e759166..38f5a0791 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify01.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
> @@ -375,8 +375,9 @@ static void setup(void)
>  	}

>  	if (fanotify_flags_supported_on_fs(FAN_REPORT_FID, FAN_MARK_MOUNT, FAN_OPEN, ".")) {
> -		inode_mark_fid_xdev = errno;
> -		tst_res(TINFO, "TMPDIR does not support reporting events with fid from multi fs");
> +		inode_mark_fid_xdev = (errno == ENODEV) ? EXDEV : errno;
> +		tst_res(TINFO, "TMPDIR does not support reporting events with fid from multi fs"
> +				" (errno = %d)", errno);

I merged with LTP specific flag TERRNO which prints both string and numeric
value for errno:

		tst_res(TINFO | TERRNO, "TMPDIR does not support reporting events with fid from multi fs");

Thanks for a fix!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
