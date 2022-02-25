Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B6FC433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Feb 2022 12:38:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 088763CA1BD
	for <ltp@archiver.kernel.org>; Fri, 25 Feb 2022 13:38:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75BE43CA105
 for <ltp@lists.linux.it>; Fri, 25 Feb 2022 13:38:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6A28E20E74C
 for <ltp@lists.linux.it>; Fri, 25 Feb 2022 13:37:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7942F1F383;
 Fri, 25 Feb 2022 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645792678;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ZZWY4v+9hwGMX1PoRcsAIN4FphSnYK3CsxgZB31fV8=;
 b=0q9vhJfT7plc7c0RY71uKAUFAPcfDHPB4UP9iq2OE6TA6zn/zBVD/776qPhytcT95rmtei
 o6H2/3m0YNaE/LQMEbzEClw1NQdf+PORPMIqZH1ASbQPcj96DBZYWcwsjwkdGZNTD2yfru
 KZSPvGIipYsOqGaNOQNwrQL6xVCT6Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645792678;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ZZWY4v+9hwGMX1PoRcsAIN4FphSnYK3CsxgZB31fV8=;
 b=hPLbmbk92IQpAShnj7L11BBVCy0oTC/77P9i5qd51LxIMx3n/6KwZ6XMfqo2/0Z91IeBGq
 NTdEMRpRCq0dyQBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 416DC13BBE;
 Fri, 25 Feb 2022 12:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VpyBDabNGGLPMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Feb 2022 12:37:58 +0000
Date: Fri, 25 Feb 2022 13:37:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Martin Doucha <martin.doucha@suse.com>
Message-ID: <YhjNpL9C3PP6Yd4U@pevik>
References: <20210303023235.431238-1-yangx.jy@cn.fujitsu.com>
 <YEigO2gryF1Kp6Gq@pevik>
 <b11680c3-7878-b06b-e87a-8991bd3cb305@163.com>
 <YEkAH6xJlSK99bp+@pevik> <YEnx4V3Il/VrThv/@pevik>
 <YEn0BK8xHVU1e52X@yuki.lan> <YEtK/A2mGoEZjF8Q@pevik>
 <YEtox4nFn3DO1KHv@yuki.lan> <YEtrkUmj9j0ej/r6@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YEtrkUmj9j0ej/r6@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: Use anonymous .resource_files for
 docparse
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Changes in  ltp.json after Cyrils enhancements to parser:

  "execveat02": {
-   "resource_files": "resource_files",
+   "resource_files": [
+     "TEST_APP"
+    ],

=> improvement => I'd merge this patch.


NOTE: It'd be nice if even TEST_APP was changed to execveat_child,
not sure what needs to be one for it. NOTE the definitions are mostly in C
source:

#define TEST_APP "execveat_child"

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
