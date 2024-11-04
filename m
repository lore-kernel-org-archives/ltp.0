Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCA8D132C0
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 13:13:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 131BE3D0AEE
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 14:13:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1ECD73CFDA3
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 14:13:05 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E1D141BC9172
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 14:13:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46D8421DAA;
 Mon,  4 Nov 2024 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730725982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQo8VNQD6mk1l7II8ENufquR35S3GtWUY6mfVhBOJb4=;
 b=no8MNh4hoomH7Ef2r5Ojp2bguRhy7FlgTM9cSpNmc5Etg/quSTM6ZqGFv+MeTFheEfns/W
 8j3ufF1rQxMy70txEfv2ysD8R2MXIxIzyPy073zTW8HHRCO+ccaIPO2crDzLfdILUcTu35
 TzDggkLLBmpiNOOWoFy2jTaU99uGYf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730725982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQo8VNQD6mk1l7II8ENufquR35S3GtWUY6mfVhBOJb4=;
 b=QZZNfzI4gKSrB3vbl/I4FXPCkiEVuXF7/HJnNFMv3Y3mQwef/a6Xtncj99zFtwJo99PUyU
 jtRy294k4aJPMyDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730725982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQo8VNQD6mk1l7II8ENufquR35S3GtWUY6mfVhBOJb4=;
 b=no8MNh4hoomH7Ef2r5Ojp2bguRhy7FlgTM9cSpNmc5Etg/quSTM6ZqGFv+MeTFheEfns/W
 8j3ufF1rQxMy70txEfv2ysD8R2MXIxIzyPy073zTW8HHRCO+ccaIPO2crDzLfdILUcTu35
 TzDggkLLBmpiNOOWoFy2jTaU99uGYf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730725982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQo8VNQD6mk1l7II8ENufquR35S3GtWUY6mfVhBOJb4=;
 b=QZZNfzI4gKSrB3vbl/I4FXPCkiEVuXF7/HJnNFMv3Y3mQwef/a6Xtncj99zFtwJo99PUyU
 jtRy294k4aJPMyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 385A31373E;
 Mon,  4 Nov 2024 13:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1fK/DF7IKGc9ZgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 04 Nov 2024 13:13:02 +0000
Date: Mon, 4 Nov 2024 14:13:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <ZyjIYpYv_o6osllR@yuki.lan>
References: <a0c8683d576671c055a4fe5edde45b5232a27660.1730714163.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a0c8683d576671c055a4fe5edde45b5232a27660.1730714163.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/sched.h: don't include itself
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

Added by:

commit 45f6916bae4cf417fd5a757ea8ca516d17865075
Author: Wei Gao via ltp <ltp@lists.linux.it>
Date:   Thu Aug 31 02:47:27 2023 -0400

    clone3: Add clone3's clone_args cgroup
    
    Signed-off-by: Wei Gao <wegao@suse.com>
    Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
    [rpalethorpe: rm max_runtime]

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 1065665d1..ac766efc5 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -13,6 +13,7 @@
 #include <inttypes.h>
 #include "config.h"
 #include "lapi/syscalls.h"
+#include "lapi/sched.h"


Along with a few additions. Looks like a mistake to me as well. And it's
no-op due to the header guards either way.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
