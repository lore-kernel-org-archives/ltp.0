Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88601CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 09:08:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CFD03C72D7
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 11:08:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B46993C0528
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:08:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2BB191A00113
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:08:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6FF6B6B4BC;
 Fri, 12 Jun 2026 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781255278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=58cFVSJ0tile+Xhye+4UybuDtJrRp+2dWL6FWFX2VtQ=;
 b=bbGsjYrVGageSZ3AzpE0YC57QKZY8bYbXBToxtuSNoaeNr5di8r5M0/b4UCP6i2YIMr5HL
 u5IGGn2i6diTTNULoBEijRMcqb3is3TLk1AzZY9e60Z/ReUlRk/XGqTQ+7PcNZ4zzO/hja
 ACbdjypTqp+ATwIw9hP5sH6O+AxoiBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781255278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=58cFVSJ0tile+Xhye+4UybuDtJrRp+2dWL6FWFX2VtQ=;
 b=d0NjVq3sXFwBwq1ahZUSOUlPaxb+EUifkKWDi41mNwAcV1J58r6faOA2FHZGpYOf+OGawf
 7eFim1i6hBAas8DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781255278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=58cFVSJ0tile+Xhye+4UybuDtJrRp+2dWL6FWFX2VtQ=;
 b=bbGsjYrVGageSZ3AzpE0YC57QKZY8bYbXBToxtuSNoaeNr5di8r5M0/b4UCP6i2YIMr5HL
 u5IGGn2i6diTTNULoBEijRMcqb3is3TLk1AzZY9e60Z/ReUlRk/XGqTQ+7PcNZ4zzO/hja
 ACbdjypTqp+ATwIw9hP5sH6O+AxoiBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781255278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=58cFVSJ0tile+Xhye+4UybuDtJrRp+2dWL6FWFX2VtQ=;
 b=d0NjVq3sXFwBwq1ahZUSOUlPaxb+EUifkKWDi41mNwAcV1J58r6faOA2FHZGpYOf+OGawf
 7eFim1i6hBAas8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58289779A7;
 Fri, 12 Jun 2026 09:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CNSSFG7MK2oSbAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 12 Jun 2026 09:07:58 +0000
Date: Fri, 12 Jun 2026 11:07:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aivMbUk008_2cMSU@yuki.lan>
References: <aiggi35F7Iz0dMPN@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <6a2bcc0a.bb4da8e5.d8214.30fe@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a2bcc0a.bb4da8e5.d8214.30fe@mx.google.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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
> maybe I reproduced it, but it would be nice to have the test output
> as well. Also Kernel 7.1 is still in RC stage, so this patch must
> wait kernel release before being considered valid.

If it's reproducible only in 7.1 isn't it a kernel regression?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
