Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F34C54E58
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 12:33:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EACA13CFD5A
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 13:33:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BC213CE06D
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 13:32:47 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CE57020B271
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 13:32:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B1CF1F7D1;
 Wed, 13 Mar 2024 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710333165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugZ1SfT+miCdVKZ0jsRJZ43J9d9eUbxMtoMxYT1Xias=;
 b=p0PgnlDz6Q1f4d61qBzm2w+kYRgJyrbiuFu1f60WLkbK1cuhKhXDZBe9GhO7lUOrtwolS2
 2PgJ2eaXxyadG33WMwbKW+LxNhgrEbpSw1+3WgGExF2ZVpYr0WC+kNnSz1Z75GhZNRMNQ2
 Ln2aDZGYyQSDHqcNyWadEU52P+wDLWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710333165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugZ1SfT+miCdVKZ0jsRJZ43J9d9eUbxMtoMxYT1Xias=;
 b=mVC5Qc1z3JQRO2zLCx5e+prgaN2duA3tdoQkkV5SFHikqip3H9RMITsTAUZ7iQRtfV+e8I
 JJXttG2/AzjufHCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710333165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugZ1SfT+miCdVKZ0jsRJZ43J9d9eUbxMtoMxYT1Xias=;
 b=p0PgnlDz6Q1f4d61qBzm2w+kYRgJyrbiuFu1f60WLkbK1cuhKhXDZBe9GhO7lUOrtwolS2
 2PgJ2eaXxyadG33WMwbKW+LxNhgrEbpSw1+3WgGExF2ZVpYr0WC+kNnSz1Z75GhZNRMNQ2
 Ln2aDZGYyQSDHqcNyWadEU52P+wDLWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710333165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugZ1SfT+miCdVKZ0jsRJZ43J9d9eUbxMtoMxYT1Xias=;
 b=mVC5Qc1z3JQRO2zLCx5e+prgaN2duA3tdoQkkV5SFHikqip3H9RMITsTAUZ7iQRtfV+e8I
 JJXttG2/AzjufHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 301CF13977;
 Wed, 13 Mar 2024 12:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AXnGCu2c8WXWNQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 Mar 2024 12:32:45 +0000
Date: Wed, 13 Mar 2024 13:31:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZfGcrzw7Vdv0BsIn@yuki>
References: <20240312151324.13236-1-andrea.cervesato@suse.de>
 <ZfGSsIEG_k2htig8@yuki>
 <387c48d3-69bc-4ae0-a56c-255554b7b6b3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <387c48d3-69bc-4ae0-a56c-255554b7b6b3@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.03 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.23)[89.49%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor fork05 using new LTP API
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
> > Huh, why have you dropped the only TPASS/TFAIL in the test?
> >
> We have TST_EXP_EQ_LI()

I'm blind today...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
