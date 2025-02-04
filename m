Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCADC02197
	for <ltp@archiver.kernel.org>; Tue,  4 Feb 2025 11:18:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 184F93C8FC3
	for <ltp@archiver.kernel.org>; Tue,  4 Feb 2025 12:18:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 782CE3C4E26
 for <ltp@lists.linux.it>; Tue,  4 Feb 2025 12:17:57 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8599D6609E2
 for <ltp@lists.linux.it>; Tue,  4 Feb 2025 12:17:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C94581F365;
 Tue,  4 Feb 2025 11:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738667874;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCWvqfjG0BtUUcUKLRbPGcFU/qOT5u/PDe3V66sMGro=;
 b=V2AsqGoBdQoD9CyvNZGreA6cs0wF3MAKS5B0H3DurKDJQfY99SBz0pXHgXeeWVmaelEc7M
 bGyrybZ2cgBpcd8wvB7IjBE2siOQIey38tqzsCFkvCSk5O7oqBKUSD1iyI8AXXX3YZvaYr
 I5w6trcDz8YGvjg4XI4DnvnDKF8Bq4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738667874;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCWvqfjG0BtUUcUKLRbPGcFU/qOT5u/PDe3V66sMGro=;
 b=DKdUythLUCl3IQ/jEpNvzE6nGnF3PbujjLCaQld62utnEXov42OX3ZkSDbQCnPdejvi/kW
 d+/jBq4L/mijoFAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wZjieH7r;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Op07PxRq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738667873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCWvqfjG0BtUUcUKLRbPGcFU/qOT5u/PDe3V66sMGro=;
 b=wZjieH7rVYHZ399hValt6hVe7HXVoOdgtgAaHKGB537+oF3FGeoWIycNhyYrhlzPxIEkjQ
 WclnnCIiPcYF8mRTnk686t+iA1o/ZtIRo/82s8lSDEfdn0V6wyUsOHMMdE5ATuYNQJTGyW
 uawrkTz9on3SduJHlzcXIt67gy+9ZIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738667873;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCWvqfjG0BtUUcUKLRbPGcFU/qOT5u/PDe3V66sMGro=;
 b=Op07PxRqNBXO+m4sgc+MbLnNT7w62fmZ2MlsDEhQa2jfIvXZsFeXD7uCT71X/d7R7KJW97
 9hSqtEqQ6eRsHbBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9FDB13795;
 Tue,  4 Feb 2025 11:17:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EhUrKGH3oWcgJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 04 Feb 2025 11:17:53 +0000
Date: Tue, 4 Feb 2025 12:17:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250204111748.GA1454574@pevik>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-6-pvorel@suse.cz>
 <3c7dee2c281867aa279c9d556e4aa62a7e865d36.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c7dee2c281867aa279c9d556e4aa62a7e865d36.camel@linux.ibm.com>
X-Rspamd-Queue-Id: C94581F365
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 05/10] IMA: Read required policy from file
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

Hi MImi,

...
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> > @@ -1,6 +1,7 @@
> > =A0#!/bin/sh
> > =A0# SPDX-License-Identifier: GPL-2.0-or-later
> > =A0# Copyright (c) 2021 Microsoft Corporation
> > +# Copyright (c) Linux Test Project, 2021-2025
> > =A0# Author: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > =A0#
> > =A0# Verify measurement of SELinux policy hash and state.
> > @@ -14,15 +15,12 @@ TST_CNT=3D2
> > =A0TST_SETUP=3D"setup"
> > =A0TST_MIN_KVER=3D"5.12"
> > =A0
> > -FUNC_CRITICAL_DATA=3D'func=3DCRITICAL_DATA'
> > -REQUIRED_POLICY=3D"^measure.*$FUNC_CRITICAL_DATA"
> > +REQUIRED_POLICY_CONTENT=3D'selinux.policy'

> The selinux.policy contains a specific critical data measurement rule:
> measure func=3DCRITICAL_DATA label=3Dselinux.  However the test would wor=
k with the
> generic policy rule "measure func=3DCRITICAL_DATA", which can be specifie=
d on the . =

> boot command line via "ima_policy=3Dcritical_data".

> As long as being able to read the IMA policy is required, in addition to =
checking
> whether the specific critical data rule exists, check whether the generic=
 rule exists
> before loading the specific one.

> Perhaps all that is needed is defining REQUIRED_BUILTIN_POLICY like:
> REQUIRED_BUILTIN_POLICY=3D"critical_data"

Thanks for a hint, I'll retest ima_policy=3Dcritical_data and add it as an
alternative (as a separate patch). In a meanwhile I (hopefully) fixed all
mistakes in the commit messages and merged. Thanks a lot for your patient
review!

...

Kind regards,
Petr

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
