Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1848CC54EE9
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 08:46:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2C1E3CAC80
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 10:46:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 349AC3CAC3A
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 10:46:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C4B96602F59
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 10:46:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 837FE20029;
 Fri, 16 Sep 2022 08:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663317964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zg/64UBeCyCIP0CkJlTrov8Pd48mYDIa0wndmhTd95w=;
 b=kiU4CvdLaX+5K0OyrKNTI11Oy4uVJH1gyew3fQoosg4sgLGQXHEAffTbRiOvuieUCS/qph
 9s+ar277OTTJlRbJ61K+N2JIgmEXjC99NqKBDW1atySYpMongZ6IrRk5RM1G6ucDuGooR5
 0FBxs7xgqORViFE4+ABdsVTB7kEIAuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663317964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zg/64UBeCyCIP0CkJlTrov8Pd48mYDIa0wndmhTd95w=;
 b=dvlpOYOEElRLphBnG0Axl00wJxV5lEqp5cViEGUO+NFMJBKnFWhVOckaljmBL+vaUD4Mgs
 pVWRB6oN9vAzNjAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67AEC1346B;
 Fri, 16 Sep 2022 08:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cvhbDsw3JGOCSQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 16 Sep 2022 08:46:04 +0000
Message-ID: <98b89722-1cbe-5617-381b-df78d04f9d31@suse.cz>
Date: Fri, 16 Sep 2022 10:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220915160343.21773-1-mdoucha@suse.cz> <YyQ2i0t6JEL0ksib@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YyQ2i0t6JEL0ksib@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ksm: Add max_runtime to tests
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

On 16. 09. 22 10:40, Cyril Hrubis wrote:
> Hi!
>> ksm02, ksm04 and ksm05 take 10+ seconds to finish. Set max_runtime to avoid
>> random timeout issues.
> 
> The patch looks good. I guess that the ksm05 in the description is a
> leftover and should be removed before applying, right?

Yes, that's a leftover, ksm05 gets executed for a fixed period of time 
via the -I parameter in runfile so it doesn't need static max_runtime. 
Otherwise the test finishes almost instantly. I forgot to remove the 
mention in commit message, sorry about that.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
