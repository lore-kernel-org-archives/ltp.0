Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477A1C4332F
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 10:36:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 013353CC409
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 11:36:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1AD83CC3BE
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 11:36:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BDBBD1BCA6D6
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 11:36:13 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 99F571FE04;
 Fri,  2 Dec 2022 10:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669977372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Okg1SKfObLDpEaKnoZe2VflkYMfHByETi1eLa1pJ8mQ=;
 b=kN95AXeaOxZ7cPlV5KBTCkqYN6xaGkNrfiBjawy5VrzTdXn2Ax44N1Bu14c5skzQZL56lr
 GJ5s06a5JRujmOt1xmKmuv1nyav8d6ZJabBbdYQNDXf8R6PMe/OhCt8k6dZVgNAKByrh5f
 aKwZNoA4wPHmWY3L/0HLzOIxN0W5jA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669977372;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Okg1SKfObLDpEaKnoZe2VflkYMfHByETi1eLa1pJ8mQ=;
 b=slAsNIBIIIXQ1equodkt6ElTdPmRR48xj+DzQNmyrTs3K5Iw0Wxypwv45J2NGxrlnW4+43
 sMvGSNrLaP6Zo8Ag==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7D5F9133DE;
 Fri,  2 Dec 2022 10:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id N0AKHBzViWPbbwAAGKfGzw
 (envelope-from <chrubis@suse.cz>); Fri, 02 Dec 2022 10:36:12 +0000
Date: Fri, 2 Dec 2022 11:37:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <Y4nVbLMCS2Bg1Z4K@yuki>
References: <fb6425cf863e4c178db2cb78cee119eb@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fb6425cf863e4c178db2cb78cee119eb@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib/safe_macros: Add SAFE_STRTOF
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> According to man 3 strtof, it seems there are some cases like:
> 
> 1. strtof return the converted value as normal
> 2. strtof return 0 when no conversion is performed, and endptr == nptr:  'rval == 0'

We can ignore this case since we check that the string was consumed
later on. That's the:

+       if (endptr == str || (*endptr != '\0' && *endptr != '\n')) {
+               tst_brkm_(file, lineno, TBROK, cleanup_fn,
+                       "Invalid value: '%s'", str);
+               return 0;
+       }


> 3. strtof return HUGE_VAL or -HUGE_VAL when overflow:      '(rval == HUGE_VAL) || (rval == -HUGE_VAL)'
> 4. strtof retrun 0 and set errno to ERANGE when underflow:   'errno == ERANGE'

My manual says that the value is no larger than DBL_MIN, FLT_MIN, or
LDBL_MIN in this case. Either way I would avoid checking the returned
value in the case errno was set.

> For 2, it seems need to add checking of endptr when 'rval == 0' like:  (rval == 0 && !strcmp(endptr, nptr)

Again, no need to check the actual return value, we can just check that
the string was consumed, which we already do.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
