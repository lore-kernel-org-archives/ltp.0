Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A32EB64DC
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 11:14:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B58B13CBE67
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 13:14:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69F723C99FC
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 13:14:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0417410006CE
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 13:14:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C86E1FF04;
 Tue, 11 Jul 2023 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689074066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kwtfFxSgrEdN9EXc4wNgOPDLzjYBrRDcDo3HgBVka7Y=;
 b=m8pH161DMgKiZxdUhJzk0QgGi0Wo7USzgvt3BVqu3he8tTsD/ErrOQdVk0kjTRsD4KdlCE
 eun6CQdSi0jo+f1XbSLnecUc96qmM/fmeDQirP3E86B/18oJF1vAjMauRXcIh0xSI3d387
 LExgmLQ9+52U4m/Ni/H2JVHeimz4UFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689074066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kwtfFxSgrEdN9EXc4wNgOPDLzjYBrRDcDo3HgBVka7Y=;
 b=tQaWl8Nhgi3ENbXL+sv+OnxjDSfynfg3KDeKMc7c94Mqr838WKJ33wjFuPNhhj2pH6+vWT
 HEXWsPJ/S3NeAkBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 167F11390F;
 Tue, 11 Jul 2023 11:14:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zKaZAZI5rWQQFQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 11 Jul 2023 11:14:26 +0000
Date: Tue, 11 Jul 2023 13:14:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20230711111419.GB722759@pevik>
References: <20230705141223.31468-1-andrea.cervesato@suse.de>
 <20230705141223.31468-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230705141223.31468-3-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/4] Refactor mqns_04 using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> +++ b/testcases/kernel/containers/mqns/mqns_04.c
> @@ -1,187 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> -* Copyright (c) International Business Machines Corp., 2009
> -* This program is free software; you can redistribute it and/or modify
> -* it under the terms of the GNU General Public License as published by
> -* the Free Software Foundation; either version 2 of the License, or
> -* (at your option) any later version.

or (at your option) any later version => SPDX-License-Identifier: GPL-2.0-or-later

This can be fixed by person who merges the patchset.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
