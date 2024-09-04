Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ACACA0ED3
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 09:50:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B810D3C1CB9
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 11:50:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFD963C1A97
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 11:50:22 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C77E56181A3
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 11:50:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F032C1F7B3;
 Wed,  4 Sep 2024 09:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725443421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmHBqDsWNTJNPfwKGznHW+LgotinAfaomJxmN5iMTMw=;
 b=XUhdEWe2VTAodXDJfOfA5tggHN3L+YTaUX5ZRI8JMHsqIRp7wdfocsl1HdhILLxfPkjJee
 7nqnWwPJUAmv9CtqZzredgZbNXMCDN3RLUflE0SFqPc1hQ3txkKHsK4J902yQT3lQEaBUM
 0KDsWwCbZ7YT+caUV49nqmFQNeZdQhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725443421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmHBqDsWNTJNPfwKGznHW+LgotinAfaomJxmN5iMTMw=;
 b=jqChRfoSPY8D7NUMwJ38gQfZw0N4VVw1xoz2VgAVodP3JCf6V05nKOQu7uzrAGuh8xqiSW
 jJ2XcQYi7ATmPCDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725443420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmHBqDsWNTJNPfwKGznHW+LgotinAfaomJxmN5iMTMw=;
 b=dctPo1O4hx7sbkNye90bPwJQezX76Y8aiJTgf2XUrzeJk//uHWDUdzDta3SbY2IEqXBKeV
 8mIzQ7LWvidLbb3FiREoqvkUX9af5dWkImKNWex6olUQhLpVRTGh0BA7V2jOl6rsyvHv24
 oEiWfFg8e1Yw8tmqxO0hCordzfZAXe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725443420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmHBqDsWNTJNPfwKGznHW+LgotinAfaomJxmN5iMTMw=;
 b=HkzzyuJPssIWkYlZWU9I9BF+gCgrN25efuQI6oQHDHkvzZVdUMCAXX6YKEdTA/ebv3IY0p
 tKpeCD2cP2AEf7AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE64013A5F;
 Wed,  4 Sep 2024 09:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rLD0NFwt2GbgHAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Sep 2024 09:50:20 +0000
Date: Wed, 4 Sep 2024 11:49:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Samir Mulani <samir@linux.vnet.ibm.com>
Message-ID: <ZtgtFz04EXwhtIGb@yuki.lan>
References: <20240816103317.127972-1-samir@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240816103317.127972-1-samir@linux.vnet.ibm.com>
X-Spamd-Result: default: False [-3.64 / 50.00]; BAYES_HAM(-2.34)[96.92%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Migrating the
 libhugetlbfs/testcases/stack_grow_into_huge.c test
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
> + /*\
> +  * [Description]
> +  *
> + * Test Name: stack_grow_into_huge

Drop the test name please, it has no value in the description.

> + * On PowerPC, the address space is divided into segments.  These segments can
> + * contain either huge pages or normal pages, but not both.  All segments are
> + * initially set up to map normal pages.  When a huge page mapping is created
> + * within a set of empty segments, they are "enabled" for huge pages at that
> + * time.  Once enabled for huge pages, they can not be used again for normal
> + * pages for the remaining lifetime of the process.
> + *
> + * If the segment immediately preceeding the segment containing the stack is
> + * converted to huge pages and the stack is made to grow into the this
> + * preceeding segment, some kernels may attempt to map normal pages into the
> + * huge page-only segment -- resulting in bugs.
> + */
> +
> +#include "hugetlb.h"
> +#include <errno.h>
> +
> +#ifdef __LP64__
> +#define STACK_ALLOCATION_SIZE	(256*1024*1024)
> +#else
> +#define STACK_ALLOCATION_SIZE	(16*1024*1024)
> +#endif
> +#define PALIGN(p, a) ((void *)LTP_ALIGN((unsigned long)(p), (a)))
> +#define MNTPOINT "hugetlbfs/"
> +static int  fd = -1;
> +static unsigned long long hpage_size;
> +static int page_size;
> +
> +
> +void do_child(void *stop_address)
> +{
> +	struct rlimit r;
> +	volatile int *x;
> +
> +	/* corefile from this process is not interesting and limiting
> +	 * its size can save a lot of time. '1' is a special value,
> +	 * that will also abort dumping via pipe, which by default
> +	 * sets limit to RLIM_INFINITY.
> +	 */
> +	r.rlim_cur = 1;
> +	r.rlim_max = 1;
> +	SAFE_SETRLIMIT(RLIMIT_CORE, &r);

We have a library function tst_no_corefile() exactly for this purpose,
please use that one instead.


The rest looks good. You can add my Reviewed-by: Cyril Hrubis
<chrubis@suse.cz> with these minor changes added.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
