Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DCBC5475B
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 12:46:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A75653CEB73
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 13:46:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E74CB3CD783
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 13:46:41 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D1D92140024E
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 13:46:40 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B97E76CF9;
 Wed,  6 Mar 2024 12:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709729200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6YvlUh7PDNETj2ZLNxM5HxZX5Um1DaDdDMMBXKbScdo=;
 b=xUsSiNL9PnLjctR90tPAsV07rxDWCMT+9MP+ZdMMGXIjEJZP1hDyUQG/p7kcbdHMCMuXOv
 HIlDLXLDqmoVWndtl4NQF4Qbin9BEm909uSOWBs+YCW92bhzZW+pZRbQNDBW8q2ta00tk2
 ERFzvr4bhdzUK6N8PNoPc7ro5nqm9j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709729200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6YvlUh7PDNETj2ZLNxM5HxZX5Um1DaDdDMMBXKbScdo=;
 b=I5lblUXLXkuZjjjwM5Lp3q7bhnV2hSM35+ZV4UQsvHjij4Ow4VFq96QqxBkaT+7sN3Py9Q
 oYUPrv8i+AFE9kCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709729200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6YvlUh7PDNETj2ZLNxM5HxZX5Um1DaDdDMMBXKbScdo=;
 b=xUsSiNL9PnLjctR90tPAsV07rxDWCMT+9MP+ZdMMGXIjEJZP1hDyUQG/p7kcbdHMCMuXOv
 HIlDLXLDqmoVWndtl4NQF4Qbin9BEm909uSOWBs+YCW92bhzZW+pZRbQNDBW8q2ta00tk2
 ERFzvr4bhdzUK6N8PNoPc7ro5nqm9j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709729200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6YvlUh7PDNETj2ZLNxM5HxZX5Um1DaDdDMMBXKbScdo=;
 b=I5lblUXLXkuZjjjwM5Lp3q7bhnV2hSM35+ZV4UQsvHjij4Ow4VFq96QqxBkaT+7sN3Py9Q
 oYUPrv8i+AFE9kCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 02A611377D;
 Wed,  6 Mar 2024 12:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id +ZTIOq9l6GX0UgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 06 Mar 2024 12:46:39 +0000
Date: Wed, 6 Mar 2024 13:46:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wenjie Xu <xuwenjie04@baidu.com>
Message-ID: <20240306124638.GB746976@pevik>
References: <20240301124129.GE1661970@pevik>
 <20240305072014.55145-1-xuwenjie04@baidu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240305072014.55145-1-xuwenjie04@baidu.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.61 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.09)[64.52%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pipe/pipe15.c: Adjust fd check for pipe creation
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

> > HI Wenjie, Marius,

> > > A pipe occupies 2 fds, and considering 3 standard fds,
> > > we should compare rlim_max with such *2+3 calculated value
> > > to verify whether the maximum file descriptor configuration
> > > of the current machine is sufficient.

> > Indeed, 1024*2+3 is the lowest number which passes with non-default ulimit:

> > ulimit -n $((1024*2+3)) && ./pipe15

> > Therefore I merged, thank you!

> > BTW I wonder how did you encounter this?

> In my test case, the system ulimit is set to 10240,
> and the calculated pipe_count is also 10240, causing
> the EMFILE failure when creating the pipe below.

+1, thanks for info.
Is it some embedded distro or a regular widely used distro?
I'm just curious what kernels are tested by LTP and whether where the
non-default setup comes from.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
