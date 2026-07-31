Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644EAC5516D
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 12:18:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D1673E71D9
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 14:18:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE4CF3E4AD2
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 14:18:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 38BC614004FD
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 14:18:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 35C4E3F3D;
 Fri, 31 Jul 2026 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785500284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5f9teHL9+i6WmQArTEmGpQrMjSwAAUf+nw18m0PiRI=;
 b=HMUZm8JuszU/v1EcYf0lllo9XVvVP/yTgkuaE01Qcfr0GbmxTL5d+FqVPO7pKsnm+Nbuzs
 O4niuR+vKebAPxHc1cNojKF9MizQ6cWO57J2KZmhQBXx17vmPgDYYjmPgqh8qvLJzht+tl
 jyZBSs6z5ilVUKT5sm3iQ8i5HcB9vfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785500284;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5f9teHL9+i6WmQArTEmGpQrMjSwAAUf+nw18m0PiRI=;
 b=3bZ5Ewav8b9T8PWJNSid2518NiNFYm+Z29cuI8SuGRE5dqcEJRPqsuixJSbgIkowG/4kH3
 +wq6O8V209EEsQDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785500280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5f9teHL9+i6WmQArTEmGpQrMjSwAAUf+nw18m0PiRI=;
 b=eRJEtxUJD9jesv5Urlrq6sHE0KWk4cuJsS8JktfUGtBRQcj6g4AeNv6s5/InznAmxbCRU8
 nJdsRGOlvY7hbK8C2TR2F3XRn3YLD6osYsxsHCvD/YkUPRilYuyLk9N0IMnd1GZtA0DAUs
 ELdKxp+F+WTtjcVpp1P9qNwVWeKMRL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785500280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5f9teHL9+i6WmQArTEmGpQrMjSwAAUf+nw18m0PiRI=;
 b=TW4OX77B6s8zJtEe1Ozn9ZtkbUntFpURBt9gZ2IuwekDYdbOqCIpet1AW9Kq4m8VA6W5fz
 ICj+R7U+5JZEy9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B145779B0;
 Fri, 31 Jul 2026 12:18:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r1sWBXiSbGp1fAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 31 Jul 2026 12:18:00 +0000
Date: Fri, 31 Jul 2026 14:17:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <amySdwkUDnYyQSNK@yuki.lan>
References: <20260715123612.1684984-3-chrubis@suse.cz>
 <6a6b3120.16149c93.268d1c.58c5@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a6b3120.16149c93.268d1c.58c5@mx.google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] syscalls: Add epoll_wait13
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
> >		if (fds[i][0] > 0) {
> >			  SAFE_CLOSE(fds[i][0]);
> >			  SAFE_CLOSE(fds[i][1]);
> >		}
> 
> It's worth to change the statement to check for fd != -1.
> Otherwise:

Fixed with:

diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait13.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait13.c
index 8a8446baa..53a75ef1a 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait13.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait13.c
@@ -56,15 +56,28 @@ static void close_fds(int fds[][2], int n)
        int i;
 
        for (i = 0; i < n; i++) {
-               if (fds[i][0] > 0) {
+               if (fds[i][0] != -1) {
                        SAFE_CLOSE(fds[i][0]);
                        SAFE_CLOSE(fds[i][1]);
                }
        }
 }
 
+static void init_fds(int fds[][2], int n)
+{
+       int i;
+
+       for (i = 0; i < n; i++) {
+               fds[i][0] = -1;
+               fds[i][1] = -1;
+       }
+}
+
 static void setup(void)
 {
+       init_fds(ready_fds, NREADY);
+       init_fds(quiet_fds, NQUIET);
+
        epfd = SAFE_EPOLL_CREATE1(0);
 
        register_fds(ready_fds, NREADY, 0);

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
