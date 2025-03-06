Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57338C282D1
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 17:26:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93CF83CA0F2
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 18:26:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56A843CA037
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 18:26:30 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 00FC960066B
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 18:26:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 27DA32118D;
 Thu,  6 Mar 2025 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741281988;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QmGmfy2uHW8AaKSzaBV9xdsoBubhk5MJ3iEAl3p4Sho=;
 b=L7pm3+Tm7TXF9jFFNt2o3CsZauQIQIniQUQELNqhQ1WmLX6j+CJEocpnQSX5FD49O4L5z/
 QdDBrgfGUaYhK2IPcDZJ9yPY+1dBgeywAw8cJiUGze8gKhG35YVOre0j5M+MEHNFYrPtN1
 bbUAlV8sIysYwbVNZeW8AVwKs5VLBt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741281988;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QmGmfy2uHW8AaKSzaBV9xdsoBubhk5MJ3iEAl3p4Sho=;
 b=8htN2tAieookVO5Y1M+uBFwrwXXNHL2fuxZtzYRcIsaIeEskXA/fH/Tjl3jJgHlyZLX0zk
 ryGYbaZj3iJeDmDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L7pm3+Tm;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8htN2tAi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741281988;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QmGmfy2uHW8AaKSzaBV9xdsoBubhk5MJ3iEAl3p4Sho=;
 b=L7pm3+Tm7TXF9jFFNt2o3CsZauQIQIniQUQELNqhQ1WmLX6j+CJEocpnQSX5FD49O4L5z/
 QdDBrgfGUaYhK2IPcDZJ9yPY+1dBgeywAw8cJiUGze8gKhG35YVOre0j5M+MEHNFYrPtN1
 bbUAlV8sIysYwbVNZeW8AVwKs5VLBt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741281988;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QmGmfy2uHW8AaKSzaBV9xdsoBubhk5MJ3iEAl3p4Sho=;
 b=8htN2tAieookVO5Y1M+uBFwrwXXNHL2fuxZtzYRcIsaIeEskXA/fH/Tjl3jJgHlyZLX0zk
 ryGYbaZj3iJeDmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E22813A61;
 Thu,  6 Mar 2025 17:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id F1twHcPayWfMOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Mar 2025 17:26:27 +0000
Date: Thu, 6 Mar 2025 18:26:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250306172622.GB186319@pevik>
References: <20250305145421.638857-1-zohar@linux.ibm.com>
 <20250305145421.638857-5-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250305145421.638857-5-zohar@linux.ibm.com>
X-Rspamd-Queue-Id: 27DA32118D
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/5] ima_violations.sh: require kernel v6.14
 for minimizing violations tests
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi,

> Depending on the IMA policy and the number of violations, the kernel
> patches for minimizing the number of open-writers and ToMToU (Time of
> Measure Time of Use) violations may be a major performance improvement.

I would prefer this to be squashed into "ima_violations.sh: additional
open-writer violation tests" commit, which adds this incompatibility.

But it's a minor detail, therefore I merged whole patchset as is.

Thanks!

Kind regards,
Petr

> Most likely the kernel patches will be back ported, but for now limit
> the new tests to new kernels with the applied patches.  Bail after the
> first new test.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .../kernel/security/integrity/ima/tests/ima_violations.sh     | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 0395f8d0a..8e988fca6 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -177,6 +177,10 @@ test4()
>  {
>  	tst_res TINFO "verify limiting single open writer violation"

> +	if tst_kvcmp -lt 6.14; then
> +		tst_brk TCONF "Minimizing violations requires kernel 6.14 or newer"
> +	fi
> +
>  	local search="open_writers"
>  	local count num_violations

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
