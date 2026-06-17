Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05898CD98E2
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 09:36:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 702613E5934
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 11:36:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E3DF3D06C3
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 11:36:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B403660027D
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 11:36:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A27C75B43;
 Wed, 17 Jun 2026 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781688991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/b29KlSSJlF71c2D2OPKbfTWH14r8sXeAf8wbZZ5Cg=;
 b=f6W/97rwjisZofmXF+yfKZSHd4NyCiEGGQpxROYZSiswgMlFIqZsvcg87wDnuADehek0+2
 /R+dg5qDHHr/t74KhpCjNAnnqFsMJR9KAew4eiR8LvdKA0jQcUAer/wpCd3a9iBVVBGNqm
 7FYzu6UV6UU2TEcQSZYwKllsCDjYzWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781688991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/b29KlSSJlF71c2D2OPKbfTWH14r8sXeAf8wbZZ5Cg=;
 b=Sqk7aZm2SNpApg5MFBhd/6s2O1ncFRjggEM+LkaBTuF+g87WDRyIiBY0qK13IkYnWqhP/e
 Y8gAM4xiV5h2h7Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781688991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/b29KlSSJlF71c2D2OPKbfTWH14r8sXeAf8wbZZ5Cg=;
 b=f6W/97rwjisZofmXF+yfKZSHd4NyCiEGGQpxROYZSiswgMlFIqZsvcg87wDnuADehek0+2
 /R+dg5qDHHr/t74KhpCjNAnnqFsMJR9KAew4eiR8LvdKA0jQcUAer/wpCd3a9iBVVBGNqm
 7FYzu6UV6UU2TEcQSZYwKllsCDjYzWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781688991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/b29KlSSJlF71c2D2OPKbfTWH14r8sXeAf8wbZZ5Cg=;
 b=Sqk7aZm2SNpApg5MFBhd/6s2O1ncFRjggEM+LkaBTuF+g87WDRyIiBY0qK13IkYnWqhP/e
 Y8gAM4xiV5h2h7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53255779A8;
 Wed, 17 Jun 2026 09:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eBV3Ep9qMmoWcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jun 2026 09:36:31 +0000
Date: Wed, 17 Jun 2026 11:36:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ajJqmCnCwWAOJ4VW@yuki.lan>
References: <ajJjWSYh9Q31uWRb@yuki.lan>
 <6a3265bf.5dfca4bd.e0bdc.3ce6@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a3265bf.5dfca4bd.e0bdc.3ce6@mx.google.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] tst_cgroup: tolerate ESRCH in
 cgroup_drain()
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Maybe we can print tst_res(TINFO, "Pid %s died during drain", tok);
> > here as well, so that when this happens we will have the information in
> > the test log.
> 
> What about TDEBUG ?

I was thinking about TDEBUG but in the end I think TINFO is better
because:

- the message is not going to be printed very often
- it's visible by default, i.e. included in logs from CI

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
