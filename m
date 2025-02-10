Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A79C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 15:25:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DA153C9881
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 16:25:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB5973C073D
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:25:01 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E847C1010C08
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:25:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 14B8D1F390;
 Mon, 10 Feb 2025 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739201100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLhn68yiQWiIATz7FxlrlBji0LlWBRIuMwBwxFugVa4=;
 b=Rfmq5lBO/NQZt9XMi2C6TdISmGEqSs6f+zMu7CcI63t2aCUjVXy8yu2KjTUfhRxHdb+C7h
 WKRbLxbcBfsw0FZGScwHVz8+pXM5Rhwhw9VmD7QdU36jSgNWzunCACycBxKQuLQ+O1SQXC
 tT54hqBAow3Z/QykDVnZsxc2H5s9zjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739201100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLhn68yiQWiIATz7FxlrlBji0LlWBRIuMwBwxFugVa4=;
 b=KRMRMlgF91VypZ0lNMVFcPuesvalEe8gNJdrehDX2CzmP9/9My6nu+aPFeZiUUxTcRx0ze
 7XLXY5jGhT7bOlDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739201100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLhn68yiQWiIATz7FxlrlBji0LlWBRIuMwBwxFugVa4=;
 b=Rfmq5lBO/NQZt9XMi2C6TdISmGEqSs6f+zMu7CcI63t2aCUjVXy8yu2KjTUfhRxHdb+C7h
 WKRbLxbcBfsw0FZGScwHVz8+pXM5Rhwhw9VmD7QdU36jSgNWzunCACycBxKQuLQ+O1SQXC
 tT54hqBAow3Z/QykDVnZsxc2H5s9zjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739201100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLhn68yiQWiIATz7FxlrlBji0LlWBRIuMwBwxFugVa4=;
 b=KRMRMlgF91VypZ0lNMVFcPuesvalEe8gNJdrehDX2CzmP9/9My6nu+aPFeZiUUxTcRx0ze
 7XLXY5jGhT7bOlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 080D713A62;
 Mon, 10 Feb 2025 15:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pTb3AUwaqmfpNQAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 10 Feb 2025 15:25:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 9A60EA095C; Mon, 10 Feb 2025 16:24:55 +0100 (CET)
Date: Mon, 10 Feb 2025 16:24:55 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <betolcydydpyyd45jncnozi6g7phk32anhn4kx3jvgrk4kvwzx@5covq3yufbp3>
References: <20250210151316.246079-1-amir73il@gmail.com>
 <20250210151316.246079-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250210151316.246079-3-amir73il@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-0.998]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_LAST(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] fanotify03: Add test cases for permission
 events on children
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 10-02-25 16:13:14, Amir Goldstein wrote:
> Verify that permission events are delivered iff parent is watching
> children.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Overall looks ok but:

> -	if (read(fd, buf, BUF_SIZE) != -1)
> +	exp_ret = exp_errno ? -1 : 1;
> +	errno = 0;
> +	if (read(fd, buf, BUF_SIZE) != exp_ret || errno != exp_errno) {
> +		tst_res(TFAIL, "read() got errno %d (expected %d)", errno, exp_errno);
>  		exit(3);
> +	} else if (errno == exp_errno) {
		^^ Why is this condition needed? It is always true AFAICT.

> +		tst_res(TINFO, "read() got errno %d as expected", errno);
> +	}
>  
>  	SAFE_CLOSE(fd);
>  
> -	if (execve(FILE_EXEC_PATH, argv, environ) != -1)
> +	exp_ret = exp_errno ? -1 : 0;
> +	errno = 0;
> +	if (execve(FILE_EXEC_PATH, argv, environ) != exp_ret || errno != exp_errno) {
> +		tst_res(TFAIL, "execve() got errno %d (expected %d)", errno, exp_errno);
>  		exit(5);
> +	} else if (errno == exp_errno) {
		^^^ and here as well...

> +		tst_res(TINFO, "execve() got errno %d as expected", errno);
> +	}
>  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
