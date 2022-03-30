Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CD3C433F5
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 12:47:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 939F73C9F34
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 14:47:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC6103C97E5
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 14:46:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D23AD1A000B0
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 14:46:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C5891F38C;
 Wed, 30 Mar 2022 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648644410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9iFgw5/kZCfaUUQ2KD/bPXgdHpEg0O5nmt5aJqxpkc=;
 b=FDN++w7D7wNMXFGZzOZAPyCu098W3cxltkNKR9AZu2Jxs9EqC6bncebfecmbKsUBD4ukTI
 OgE2kqKDZzfUFyVGb/Hw/0fa35Pd9nRHAN7gIXdi4vzBb0s2jcOT47ytOc5nr1JuiOLVgl
 aRL8TxNehf1q5K/k688C91seNLwbUV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648644410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9iFgw5/kZCfaUUQ2KD/bPXgdHpEg0O5nmt5aJqxpkc=;
 b=gSU6yKa2JmkuKbvcSXkQ8bYBONlLXTGjwYiAB/YdFgXdr+Io0/YEauJO+JFIJkxXagSpDZ
 ppqlGCvE4MJaB8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12C9513AF3;
 Wed, 30 Mar 2022 12:46:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bYxiBDpRRGLSQAAAMHmgww
 (envelope-from <pvorel@suse.de>); Wed, 30 Mar 2022 12:46:50 +0000
MIME-Version: 1.0
Date: Wed, 30 Mar 2022 14:46:49 +0200
From: pvorel <pvorel@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
In-Reply-To: <YkRNGt435X50u8Z9@yuki>
References: <20220328204643.2601-1-pvorel@suse.cz> <YkRNGt435X50u8Z9@yuki>
User-Agent: Roundcube Webmail
Message-ID: <92fea33b63410dfa96d0c654950eb11f@suse.de>
X-Sender: pvorel@suse.de
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] lib: Retry safe_clone() on ENOSPC|EUSERS
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, all,
>> 
>> NOTE: 0.1s seems to be safe, although using TST_RETRY_FUNC() with 1s
>> (the default) would be of course OK.
> 
> I would just put in the default 1s to make things extra safe even on
> slow hardware.
> 
+1
...
>> +/* too fast creating namespaces => retrying */
>> +#define TST_CHECK_ENOSPC(x) ((x) >= 0 || !(errno == ENOSPC || errno 
>> == EUSERS))
> 
> Reading the manual page I do not think that we have to retry on EUSERS,
> that used to be the return value where we reached limit of nested
> namespaces and that is not going go away if we retry.
> 
> Otherwise the rest looks good.
> 
Fixed both and merged.

Kind regards,
Petrb

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
