Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFE9C3DA49
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 15:18:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99FD63D1C9D
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 17:18:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A36A73D0F94
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 17:17:52 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2CE371A011C1
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 17:17:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DCF781F7FA;
 Thu, 25 Jul 2024 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721920670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/3A6S+67pkd+wduv+fD4Zk8Xke3xAe8fGicKZA0Bao=;
 b=H+nPmQSbIn0bsaS6j5DHPLqr6fwG6lRyRosbMNJXJxUgFymN7J8uXWQ0O2zpZXL6d+JFvi
 7GtwLf+Lea5JSFF55MpS74zNd0XhCPnq3vsNZxKFHyCSvvGBs0qgyEwGTTu0g2BoYWRzYr
 +Nhn7Pz74/f/vORZnWBreqAGk8uT2kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721920670;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/3A6S+67pkd+wduv+fD4Zk8Xke3xAe8fGicKZA0Bao=;
 b=4Q247MXHqry1olNedKAxA1XltG60X7/f34q7r6QMtvdzuk831q1gWEAFXB4iJL6BwisVZf
 8JLiUY2hYy779xCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721920669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/3A6S+67pkd+wduv+fD4Zk8Xke3xAe8fGicKZA0Bao=;
 b=BF3kPHPVNyQbg//3aSRAojuGK/qUK8e4ZbRHzGQ/gE53oEyyqr8D9cW3cZZcXxOiN9IMUQ
 +bOB+BJ49iqH9OlGawHeTdVYF6sKkCJMnd60V9c80gJWLKmWfIBfMFJJDZq++zSyYHa94z
 GZ8W+PC8MWGcXkWFuXCEmf5Df9faHII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721920669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L/3A6S+67pkd+wduv+fD4Zk8Xke3xAe8fGicKZA0Bao=;
 b=NXbCwJQyTfjdJ7rOw7PV+ZHdc582J5NCYrpER4je8sSQUNIg4G+TD9jMLFGEpx5LG1mN6q
 1L45F9YwgGQcxWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C395C13874;
 Thu, 25 Jul 2024 15:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qU6uLp1sombcJQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 25 Jul 2024 15:17:49 +0000
Date: Thu, 25 Jul 2024 17:17:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZqJshM8YUQKwLR5s@yuki>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-1-33075bbc117f@suse.com>
 <ZqErzC4PMRrrk929@yuki>
 <CAEemH2eaTSuyD3GT5QGwq7wDUe0eX79+-XpfnzhQqN8ztJ2Vog@mail.gmail.com>
 <20240725125516.GA987417@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240725125516.GA987417@pevik>
X-Spamd-Result: default: False [-3.60 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] Add fallback definitions for lapi/fs.h
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
> > However, if we want LTP could be built with all the middle glibc versions
> > (2.22 < glibc < 2.36)
> > this might be thinking over. Because we announce support the minimal
> > glibc-version is 2.22.
> 
> Hm, it makes sense to keep it. But nobody will remember once we raise the
> support.

Maybe we should at least add a comment glibc-2.22 workaround or
something that could be found with grep.

> Also, removing HAVE_LINUX_FS_H [1] works in the CI [2], including distros with
> glibc 2.36 (minimal build [3] or all cross-compile builds, e.g. [4]).
> 
> I wonder how realistic is that somebody is still affected by this issue.

That's a good question but I'm afraid the only way to find out is to
remove the workaround and wait for people complain that the next LTP
release is broken...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
