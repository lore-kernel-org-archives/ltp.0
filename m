Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AA1C4167B
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 10:12:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DC003CBAE0
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 11:12:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6651C3C89AA
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 11:12:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 360F310005C0
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 11:12:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 347746019D;
 Mon, 19 Dec 2022 10:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671444749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmQ5+nTqC1jA5jr3+VNviTYTaP0TrFqGKfUsEy1Dg3k=;
 b=CcxTYVM2PGXwRqUMNv6hgWvMsWvZn7iwGBXVzRxOppRwABi0tNGyPbn+KbbB7xDv8/NUYx
 9LP0q0d6NRUlfEelQy2i10JQ7OJrTbzUNZe4scxgWQnVIsr0wjViu3yPbKJgJZ7kMruocb
 2zYSc5MRvgk2AmtT+TVoBOWSWfLHTGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671444749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmQ5+nTqC1jA5jr3+VNviTYTaP0TrFqGKfUsEy1Dg3k=;
 b=jzPG+ySxYFHSozFOym6/eWZ9mlhTGxoJLlf9NYumBkgcVdpw8I8gy9AuRMv3ROGabL7n7f
 Qh1JNWjTp2jQ6TCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C54213910;
 Mon, 19 Dec 2022 10:12:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mEWmCg05oGPSLQAAMHmgww
 (envelope-from <pvorel@suse.de>); Mon, 19 Dec 2022 10:12:29 +0000
MIME-Version: 1.0
Date: Mon, 19 Dec 2022 11:12:28 +0100
From: pvorel <pvorel@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <98573ca81db1625d7b2f639aabeae1d9@suse.de>
References: <20221216170922.21752-1-mdoucha@suse.cz>
 <98573ca81db1625d7b2f639aabeae1d9@suse.de>
User-Agent: Roundcube Webmail
Message-ID: <53c35db794540b736389a7c18275cd79@suse.de>
X-Sender: pvorel@suse.de
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add test for CVE 2022-4378
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

On 2022-12-19 11:07, pvorel wrote:
> Hi Martin,
> 
>> diff --git a/testcases/cve/cve-2022-4378.c 
>> b/testcases/cve/cve-2022-4378.c
>> new file mode 100644
>> index 000000000..e1c5df325
>> --- /dev/null
>> +++ b/testcases/cve/cve-2022-4378.c
>> @@ -0,0 +1,108 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2022 SUSE LLC <mdoucha@suse.cz>
>> + */
>> +
>> +/*\
> nit: you used /*\ docparse start comment, but without any [...] mark,
> thus nothing shows in generated docs.
> There should have been either normal C comment /* or docparse [...] 
> mark.

I'm sorry, I was wrong, the text *appear* in generated docs, just 
without any header.
Just the text contains too much details (given we have link to git 
commit in the table below):

... fixed in:

commit bce9332220bd677d83b19d21502776ad555a0e73 Author: Linus Torvalds 
<torvalds@linux-foundation.org> Date: Mon Dec 5 12:09:06 2022 -0800

Kind regards,
Petr

> 
> Kind regards,
> Petr
> 
>> + * CVE 2022-4378
>> + *
>> + * Check that writing several pages worth of whitespace into 
>> /proc/sys files
>> + * does not cause kernel stack overflow. Kernel bug fixed in:
>> + *
>> + * commit bce9332220bd677d83b19d21502776ad555a0e73
>> + * Author: Linus Torvalds <torvalds@linux-foundation.org>
>> + * Date:   Mon Dec 5 12:09:06 2022 -0800
>> + *
>> + * proc: proc_skip_spaces() shouldn't think it is working on C 
>> strings
>> + */
> ...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
