Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2C0C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 09:53:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B46CE3CC880
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:53:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE6D23C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 10:53:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7B8B2200C63
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 10:53:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7106F1FD6A;
 Fri, 25 Nov 2022 09:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669369999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQ8yrHazvPQkYznQtrGJDTVdynCPZdi6DKnifKaTZHI=;
 b=VTW+0N+ZyOnahAveaxj0Jn+hpBnHT+oUHUpJYw2aEYzFCrs84Ekjc0ibiyaxLZwIDjCiNp
 UD/kWkFfMoQeZFSbd9gL5Dfpd/igha42gGeCCCCNHL0kmthWEBhclQEMqP6aGvaOhogB4v
 8Uh0ju8ma4MUrm7gpwB/uVUJ6muUlEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669369999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQ8yrHazvPQkYznQtrGJDTVdynCPZdi6DKnifKaTZHI=;
 b=LtVJPWlSkSCRqVNfrOOWx7UhU/kVSsAIfhEVuuBbkfSICuD8+s4Noilw/54bk6CqYoKAcm
 1g0iwkAI+Nm5DyCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BD3B1361C;
 Fri, 25 Nov 2022 09:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cRetEY+QgGNLVwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 25 Nov 2022 09:53:19 +0000
Message-ID: <8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz>
Date: Fri, 25 Nov 2022 10:53:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: David Hildenbrand <david@redhat.com>, ltp@lists.linux.it
References: <20221123103547.54246-1-david@redhat.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20221123103547.54246-1-david@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] security/dirtyc0w_shmem: Add new test for
 CVE-2022-2590
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 23. 11. 22 11:35, David Hildenbrand wrote:
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		SAFE_SETGID(nobody_gid);
> +		SAFE_SETUID(nobody_uid);
> +		SAFE_EXECLP("dirtyc0w_shmem_child", "dirtyc0w_shmem_child", NULL);

Manpage says that the last argument of execlp() must be (char*)NULL, 
including the explicit typecast.

> +#else /* UFFD_FEATURE_MINOR_SHMEM */
> +#include "tst_test.h"
> +TST_TEST_TCONF("System does not have userfaultfd minor fault support for shmem");
> +#endif /* UFFD_FEATURE_MINOR_SHMEM */

When the child exits through this TST_TEST_TCONF(), the 
TST_CHECKPOINT_WAIT() in parent will fail. The parent process should not 
even fork() when UFFD_FEATURE_MINOR_SHMEM is not defined in config.h.

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
