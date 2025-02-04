Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8126DC02194
	for <ltp@archiver.kernel.org>; Tue,  4 Feb 2025 11:25:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1714B3C8FC6
	for <ltp@archiver.kernel.org>; Tue,  4 Feb 2025 12:25:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C45053C016A
 for <ltp@lists.linux.it>; Tue,  4 Feb 2025 12:25:37 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 466B3200CFF
 for <ltp@lists.linux.it>; Tue,  4 Feb 2025 12:25:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7DFE91F365;
 Tue,  4 Feb 2025 11:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738668335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcMcrP/ngv/m0VRSPnvgFaauvdF2sE2MShSutqWfX4U=;
 b=rAaVP6gjDA+4a9AdDvFtupY1gFL7KK6BnlbC+WkUh5mHB7puialg/XR1XM++hc9tC6z2o4
 tE0vAZ7W7gOczHny8/36eR/3ysH//NRJTZZV3mN02PUVilhD/i1QiErNawcMsQg+f2rr5i
 o2PUd2xdAEfra7XBjRI9X5K+UvtCLkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738668335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcMcrP/ngv/m0VRSPnvgFaauvdF2sE2MShSutqWfX4U=;
 b=BOBU5idlvlQ6FOimDC7rP74gXkTg4XPPInrnh794IXhovl/uviApYib/sQGoRBkIQ8jOnt
 M28Nj+qnISmkAWCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rAaVP6gj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BOBU5idl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738668335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcMcrP/ngv/m0VRSPnvgFaauvdF2sE2MShSutqWfX4U=;
 b=rAaVP6gjDA+4a9AdDvFtupY1gFL7KK6BnlbC+WkUh5mHB7puialg/XR1XM++hc9tC6z2o4
 tE0vAZ7W7gOczHny8/36eR/3ysH//NRJTZZV3mN02PUVilhD/i1QiErNawcMsQg+f2rr5i
 o2PUd2xdAEfra7XBjRI9X5K+UvtCLkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738668335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcMcrP/ngv/m0VRSPnvgFaauvdF2sE2MShSutqWfX4U=;
 b=BOBU5idlvlQ6FOimDC7rP74gXkTg4XPPInrnh794IXhovl/uviApYib/sQGoRBkIQ8jOnt
 M28Nj+qnISmkAWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62A6E1393E;
 Tue,  4 Feb 2025 11:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X4UUFy/5oWexKQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 04 Feb 2025 11:25:35 +0000
Date: Tue, 4 Feb 2025 12:25:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250204112530.GB1454850@pevik>
References: <20250203210233.1407530-1-pvorel@suse.cz>
 <4e4fb197b7127f8d82705ec441e8a273cd237b7f.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4e4fb197b7127f8d82705ec441e8a273cd237b7f.camel@linux.ibm.com>
X-Rspamd-Queue-Id: 7DFE91F365
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] IMA: measure.policy: limit dont_measure tmpfs
 policy to func=FILE_CHECK
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi,

> On Mon, 2025-02-03 at 22:02 +0100, Petr Vorel wrote:
> > add func=3DFILE_CHECK to dont_measure tmpfs

> > Similarly to tcb.policy limit dont_measure tmpfs policy to func=3DFILE_=
CHECK.
> > This allows to do extra measurements, e.g. kexec boot command line, see
> > kernel commit

> > 7eef7c8bac9a ("ima: limit the builtin 'tcb' dont_measure tmpfs policy r=
ule")

> > Also remove leading 0 from tmpfs magic (to match IMA docs and tcb.polic=
y).

> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks, also this one merged.

Kind regards,
Petr

> > ---
> > =A0.../security/integrity/ima/datafiles/ima_policy/measure.policy=A0 | =
2 +-
> > =A01 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git
> > a/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.=
policy
> > b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.=
policy
> > index 9976ddf2de..8abd05fb1a 100644
> > --- a/testcases/kernel/security/integrity/ima/datafiles/ima_policy/meas=
ure.policy
> > +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/meas=
ure.policy
> > @@ -8,7 +8,7 @@ dont_measure fsmagic=3D0x62656572
> > =A0# DEBUGFS_MAGIC
> > =A0dont_measure fsmagic=3D0x64626720
> > =A0# TMPFS_MAGIC
> > -dont_measure fsmagic=3D0x01021994
> > +dont_measure fsmagic=3D0x1021994 func=3DFILE_CHECK
> > =A0# SECURITYFS_MAGIC
> > =A0dont_measure fsmagic=3D0x73636673
> > =A0measure func=3DFILE_MMAP mask=3DMAY_EXEC


-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
