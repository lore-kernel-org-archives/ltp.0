Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B88C7EE31
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 09:47:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E58C3C76B8
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 11:47:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 453E13C05D1
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 11:46:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 510D614000EE
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 11:46:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC7752116B;
 Fri, 27 Jun 2025 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751017604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0ZyfSgJ6QqLLabFIVhLxezCuzjVEPAPED9KCqswkjU=;
 b=FNwaCX5ncWIX2DYcA0ZqXYOHbqRRA56T8qaXZeRJ9Sw6BWiHhT04mOk2XzrHrLwN5UGiXb
 h76q6vRBH5VtTysNm7emWtNHxmqYfClqXiyTIRQU/d/8TQu47TiVF2nj3xNlv2liUJKCcR
 RvCdtOnFun/rqpNoAXwQCjUZh92lBSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751017604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0ZyfSgJ6QqLLabFIVhLxezCuzjVEPAPED9KCqswkjU=;
 b=EvdTU0DbWMtmVpdSIeYijSYJkKnXK8fq2B5qkkUy+uZq557d8un7tAVYrq2WbCRjWRPfjh
 F2SolIE34SAlrfDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751017604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0ZyfSgJ6QqLLabFIVhLxezCuzjVEPAPED9KCqswkjU=;
 b=FNwaCX5ncWIX2DYcA0ZqXYOHbqRRA56T8qaXZeRJ9Sw6BWiHhT04mOk2XzrHrLwN5UGiXb
 h76q6vRBH5VtTysNm7emWtNHxmqYfClqXiyTIRQU/d/8TQu47TiVF2nj3xNlv2liUJKCcR
 RvCdtOnFun/rqpNoAXwQCjUZh92lBSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751017604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0ZyfSgJ6QqLLabFIVhLxezCuzjVEPAPED9KCqswkjU=;
 b=EvdTU0DbWMtmVpdSIeYijSYJkKnXK8fq2B5qkkUy+uZq557d8un7tAVYrq2WbCRjWRPfjh
 F2SolIE34SAlrfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD2B913786;
 Fri, 27 Jun 2025 09:46:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NMlmKYRoXmj2cgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Jun 2025 09:46:44 +0000
Date: Fri, 27 Jun 2025 11:47:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aF5orcIPzGviYyj6@yuki.lan>
References: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
 <20250626-ioctl_pidfd_suite-v1-4-165b9abf0296@suse.com>
 <aF5gXnHipDoPXla6@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aF5gXnHipDoPXla6@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/6] Add ioctl_pidfd02 test
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
> > +	TST_EXP_EQ_LI(info->mask & PIDFD_INFO_EXIT, PIDFD_INFO_EXIT);
> > +	TST_EXP_EQ_LI(WIFEXITED(info->exit_code), WIFEXITED(status));
> > +	TST_EXP_EQ_LI(WEXITSTATUS(info->exit_code), WEXITSTATUS(status));
> 
> And here we should check that we got the same fields set as in the
> previous case when the process was still running plus the exit_code.
> 
> I suppose that we will need two info structures so that we can do the
> comparsion. Also it wouldn't harm to clear the structures with memset
> before use.

Ah no, if task has been reaped only exit value is available. So in the
latter case only the PIDFD_INFO_EXIT should be set in flags.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
