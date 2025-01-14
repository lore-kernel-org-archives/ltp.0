Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F51C02183
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 02:43:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 877F43C79EF
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 03:43:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 209F53C1858
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 03:43:22 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 064911425B56
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 03:43:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C02F1F441;
 Tue, 14 Jan 2025 02:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736822600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKU0WRheJE12VZCAcK9d3wP296Ebo26Ubr6QTD6/7W4=;
 b=J5b9mmivU9NFa1qGNCAcWX7rwl8R6jMkFpSMeJnO8exmA1DUq6Sv7lw6295Uvgvjs9nNrx
 ilIcpEK9bYSVZhp7Vrva9h9wt279vcyRQ3tqOPnU8OauQOUFIyjg5jXbICpUh3wb+4XFJb
 DhXpU6uLyKu2Zn6xf7NZjh4iURk+x3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736822600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKU0WRheJE12VZCAcK9d3wP296Ebo26Ubr6QTD6/7W4=;
 b=SBgszus9YjwTjN3zJWTogVlVzTGYiaLCJ3xEJG1QInXQdRFhv/IwcpOnKLHRMQieI1sDU2
 +yCXK+dAGJXjiKCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736822600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKU0WRheJE12VZCAcK9d3wP296Ebo26Ubr6QTD6/7W4=;
 b=J5b9mmivU9NFa1qGNCAcWX7rwl8R6jMkFpSMeJnO8exmA1DUq6Sv7lw6295Uvgvjs9nNrx
 ilIcpEK9bYSVZhp7Vrva9h9wt279vcyRQ3tqOPnU8OauQOUFIyjg5jXbICpUh3wb+4XFJb
 DhXpU6uLyKu2Zn6xf7NZjh4iURk+x3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736822600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKU0WRheJE12VZCAcK9d3wP296Ebo26Ubr6QTD6/7W4=;
 b=SBgszus9YjwTjN3zJWTogVlVzTGYiaLCJ3xEJG1QInXQdRFhv/IwcpOnKLHRMQieI1sDU2
 +yCXK+dAGJXjiKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A6F81384C;
 Tue, 14 Jan 2025 02:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id McyXHEjPhWfKCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 02:43:20 +0000
Date: Tue, 14 Jan 2025 03:43:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Ricardo B. Marliere" <rbm@suse.com>
Message-ID: <20250114024315.GA562038@pevik>
References: <20250113-add_b4-config-v1-1-d0c14d9dfac6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250113-add_b4-config-v1-1-d0c14d9dfac6@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add .b4-config file
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

[ Cc Andrea, who uses b4 ]

> This file configures the `b4` tool which some contributors might use.

LGTM.

Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> ---
>  .b4-config | 6 ++++++
>  1 file changed, 6 insertions(+)

> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 0000000000000000000000000000000000000000..2efdf2273240dcf57bd5cab174ff6c7a1952dd5b
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,6 @@
> +# Configuration for the `b4` tool
> +# See https://b4.docs.kernel.org/en/latest/config.html
> +[b4]
> +    send-series-to = Linux Test Project <ltp@lists.linux.it>
> +    pw-url = https://patchwork.ozlabs.org/
> +    pw-project = ltp

> ---
> base-commit: 7aea2cea9ad5d9e1586112a57948c7f85dc12970
> change-id: 20250113-add_b4-config-4fb22fbded22

> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
