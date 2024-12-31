Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB27E77188
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 10:41:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 159713E9F22
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 11:41:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 558F03E9F13
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 11:40:52 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5A4EF20A6CA
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 11:40:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4497721108;
 Tue, 31 Dec 2024 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735641651;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6+MAFqoMV229k/3h+WdL4IBeCWh7p4xDF7lhmaw2cLE=;
 b=OtC3EiCRH5irYLgusSfwnoa1k0K6iKMqkFYYFbPwurvWARwnW7LfOGHcrn1BGl3zEFR7G0
 AoCoXcq8S5CerpKYg6VXWe6+9D2DjV7aoWzaxoTpJwyZjxkRVMNe+0BgLoFtMlLn1HNNe3
 wbr4tc5rR5EsPzHBpklU8MrjR4OAXMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735641651;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6+MAFqoMV229k/3h+WdL4IBeCWh7p4xDF7lhmaw2cLE=;
 b=ZczI/I6x683/70uNdI1yU9l/sy9uSN/crZAVxKuHNxVtytXWVMp0npJHCJDDaxuqiMwS7r
 0Sn90/uA5nZqlYDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OtC3EiCR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ZczI/I6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735641651;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6+MAFqoMV229k/3h+WdL4IBeCWh7p4xDF7lhmaw2cLE=;
 b=OtC3EiCRH5irYLgusSfwnoa1k0K6iKMqkFYYFbPwurvWARwnW7LfOGHcrn1BGl3zEFR7G0
 AoCoXcq8S5CerpKYg6VXWe6+9D2DjV7aoWzaxoTpJwyZjxkRVMNe+0BgLoFtMlLn1HNNe3
 wbr4tc5rR5EsPzHBpklU8MrjR4OAXMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735641651;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6+MAFqoMV229k/3h+WdL4IBeCWh7p4xDF7lhmaw2cLE=;
 b=ZczI/I6x683/70uNdI1yU9l/sy9uSN/crZAVxKuHNxVtytXWVMp0npJHCJDDaxuqiMwS7r
 0Sn90/uA5nZqlYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BEFA13A67;
 Tue, 31 Dec 2024 10:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QtsoBTPKc2d2GQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 31 Dec 2024 10:40:51 +0000
Date: Tue, 31 Dec 2024 11:40:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20241231104039.GC36475@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-7-pvorel@suse.cz>
 <35af7de88f6961817a9df23c55104d20c32d2680.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <35af7de88f6961817a9df23c55104d20c32d2680.camel@linux.ibm.com>
X-Rspamd-Queue-Id: 4497721108
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/8] IMA: Add example policy for
 ima_violations.sh
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  .../integrity/ima/datafiles/ima_violations/violations.policy     | 1 +
> >  1 file changed, 1 insertion(+)
> >  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy

> > diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
> > new file mode 100644
> > index 0000000000..5734c7617f
> > --- /dev/null
> > +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
> > @@ -0,0 +1 @@
> > +func=FILE_CHECK

> "[PATCH v2 1/8] IMA: Add TCB policy as an example for ima_measurements.sh"
> contains two rules to measure files opened by root on file open.

> measure func=FILE_CHECK mask=^MAY_READ euid=0
> measure func=FILE_CHECK mask=^MAY_READ uid=0

My bad of course "func=FILE_CHECK" is not enough. Thanks for providing a correct
example policy (required part of 'tcb' policy).

> If the 'tcb' or equivalent policy is loaded, there is no need to load another
> policy rule. 

Yes, I'll fix the next commit to avoid loading example policy when
ima_policy=tcb.

Kind regards,
Petr

> Thanks,

> Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
