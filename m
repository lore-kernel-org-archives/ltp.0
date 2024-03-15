Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508E1C54E67
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 14:50:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0E913D0A1B
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 15:50:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6BC23D0860
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 15:50:01 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 100F510085F6
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 15:50:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C9EA1FB6F;
 Fri, 15 Mar 2024 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710514200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qLns1K/O2DnblFDDOvNNQmCKnW+xm16WB3FqmaAZOVw=;
 b=Ahxv7uPn0yHUyjnSVGswZtpTD96N/M1Eq5D5oxrO5ZNIc5mCRwUV+uESmU/nnpRJCfJ4QM
 D/efYwLiIy+ILug7JgYGYHAap4jkfBrvbQu7BDat0RZC3Ewd7P3GLPFbgWyrfWkKtusRXj
 e6AkBS3oa4Wepby39OGTr/BFbC7Sxjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710514200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qLns1K/O2DnblFDDOvNNQmCKnW+xm16WB3FqmaAZOVw=;
 b=5q/3pwV4Nxs9UtGYE/cVhuZn7fFOdVV5nFHgAsTWRJrxUEnC5aqZaLP20X9Av2BuDSfSAp
 QF9M5g13ybobxfCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710514200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qLns1K/O2DnblFDDOvNNQmCKnW+xm16WB3FqmaAZOVw=;
 b=Ahxv7uPn0yHUyjnSVGswZtpTD96N/M1Eq5D5oxrO5ZNIc5mCRwUV+uESmU/nnpRJCfJ4QM
 D/efYwLiIy+ILug7JgYGYHAap4jkfBrvbQu7BDat0RZC3Ewd7P3GLPFbgWyrfWkKtusRXj
 e6AkBS3oa4Wepby39OGTr/BFbC7Sxjo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710514200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qLns1K/O2DnblFDDOvNNQmCKnW+xm16WB3FqmaAZOVw=;
 b=5q/3pwV4Nxs9UtGYE/cVhuZn7fFOdVV5nFHgAsTWRJrxUEnC5aqZaLP20X9Av2BuDSfSAp
 QF9M5g13ybobxfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0930913931;
 Fri, 15 Mar 2024 14:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GsQAARhg9GVGRgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 15 Mar 2024 14:50:00 +0000
Date: Fri, 15 Mar 2024 15:49:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <ZfRf36u7CH7bIEZ7@yuki>
References: <202403151507.5540b773-oliver.sang@intel.com>
 <20240315-neufahrzeuge-kennt-317f2a903605@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240315-neufahrzeuge-kennt-317f2a903605@brauner>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ahxv7uPn;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="5q/3pwV4"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.76 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.75)[84.05%]
X-Rspamd-Queue-Id: 2C9EA1FB6F
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linus:master] [pidfd]  cb12fd8e0d: ltp.readahead01.fail
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
Cc: lkp@intel.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> So I'd just remove that test. It's meaningless for pseudo fses.

Wouldn't it make more sense to actually return EINVAL instead of
ignoring the request if readahead() is not implemented?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
