Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B805C8303D
	for <ltp@archiver.kernel.org>; Tue,  1 Jul 2025 11:40:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAA483C755D
	for <ltp@archiver.kernel.org>; Tue,  1 Jul 2025 13:40:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B8EA3C72A2
 for <ltp@lists.linux.it>; Tue,  1 Jul 2025 13:40:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 653737EEB55
 for <ltp@lists.linux.it>; Tue,  1 Jul 2025 13:40:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 39F611F457;
 Tue,  1 Jul 2025 11:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751370013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5Xo7aOoL2wkq86nsuN5XQ2MhefaOtwhtnh5KJ822ik=;
 b=BCsDm53xGiyLUTyNO3xgQ1sGDXrfCTdeDMyR81g3pQqxcuOAn+Bqc9Ey+6rRFtYRvZ7T1h
 AL+f2W0TOI2YOA67fii0aXvQLPCRtDnlo30MP1o/AlHhBkNUaX1Q2+VwG4DXH1nV0V7i4Y
 mRpH1D1w8u1OxWk/alo2QlKYfEsPb+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751370013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5Xo7aOoL2wkq86nsuN5XQ2MhefaOtwhtnh5KJ822ik=;
 b=JmWXi/ET9Qemz19AHEcoHJWFHWaWc83BGjhT75nYsU/FzAbSG+DA+A4rWlLa3glBG+k58B
 bD9bh2dteImiIUCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WZ1UrEuV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5gibFoU5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751370012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5Xo7aOoL2wkq86nsuN5XQ2MhefaOtwhtnh5KJ822ik=;
 b=WZ1UrEuV6qwQExnWqUfcIEwROxLPYw/GF1CAxHYfIXYQbX5JjLMmdbgB5zKSNdURsVJKkr
 xyNHzumzro0EwNw9DP8GrnRmtGbuos3E9P2s+JQL0q0oozxaAlV0YcteG3jAJxGcu0VLt5
 rHlxji3YBL9V56cUNnPbbbZ3gajN1CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751370012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5Xo7aOoL2wkq86nsuN5XQ2MhefaOtwhtnh5KJ822ik=;
 b=5gibFoU5khwQV4LxTXvvTu4PG1+ha3RRaCgAG0Q8gawa2HlEB4uWIsBCid+ImB4plpmlwI
 DSHA0KulEWuZxgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26C2C13890;
 Tue,  1 Jul 2025 11:40:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LbpfCBzJY2g0WAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 01 Jul 2025 11:40:12 +0000
Date: Tue, 1 Jul 2025 13:40:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aGPJQi0L5iD_w1tF@yuki.lan>
References: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
 <aF5u9ZBRzv-a18Mt@yuki.lan>
 <4df2c4de-46ee-48d0-b451-fc7f4f74eac8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4df2c4de-46ee-48d0-b451-fc7f4f74eac8@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 39F611F457
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/6] ioctl_pidfd testing suite
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
> > I guess that we miss a test for the case where the processes are in the
> > same pid namespace, e.g. process created by a plain old fork(). In that
> > case calling the ioctl() before the the process was waited for would
> > return the information I've mistakenly pointed out for the second test.
> 
> Sorry but I don't get this one. When we fork() a process and we check 
> its exit code via ioctl(PIDFD_GET_INFO) __before__ the child has been 
> reaped, we only need to check if mask is still having PIDFD_INFO_EXIT, 
> because that's not available.The same for exit_code.
> 
> Am I missing something?

That paragraph was still written under the assumption that you are not
supposed to get anything else than exit vaule from a process that is in
a different namespace.

The main point should have been that all the tests you have sumbitted
are written so that the child process is cloned into a new pid
namespace. We need at least one test where both the child and the parent
are in the same namespace. Either cloned without pid namespace or
created by plain old fork().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
