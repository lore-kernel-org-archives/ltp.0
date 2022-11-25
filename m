Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D3BC4321E
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:06:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CEEF3CC894
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:06:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE1093C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:06:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 345771000CD5
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:06:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE9DC1FD69;
 Fri, 25 Nov 2022 10:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669370800;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t1UgQWr0fA0hODkBV2z8uStRgltIoHzgXiAvYKydVNw=;
 b=zCgLI8FcSvMyvBR+vFcB2d5cV0B/rAGaGvcbvSmKPzIH8yHjWiJWLbfaOluO/+iDIv/Z1J
 4dJAlUDRTwAT9j4CDBXqISLyMBm6rFaJUsFavomFfYDGVLbwrsD7iZ1kMufploF1ciREAw
 a2rxP40KVE4hifMOpBDQ7uuJhVeAigc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669370800;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t1UgQWr0fA0hODkBV2z8uStRgltIoHzgXiAvYKydVNw=;
 b=UQa57zfM8WmEu65qR3S1BFPvMFb9/K6zjAijr6bmobazQLsbpWHs8o/LbK1bTCRpVjipPK
 RLcbBQVBtORsIcAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86FCA13A08;
 Fri, 25 Nov 2022 10:06:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PikRG7CTgGPkXgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Nov 2022 10:06:40 +0000
Date: Fri, 25 Nov 2022 11:06:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y4CTrrCb4jtQay9y@pevik>
References: <20221123103547.54246-1-david@redhat.com>
 <8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi,

> On 23. 11. 22 11:35, David Hildenbrand wrote:
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		SAFE_SETGID(nobody_gid);
> > +		SAFE_SETUID(nobody_uid);
> > +		SAFE_EXECLP("dirtyc0w_shmem_child", "dirtyc0w_shmem_child", NULL);

> Manpage says that the last argument of execlp() must be (char*)NULL,
> including the explicit typecast.
I was too fast here (already merged).

You're right, although we use execlp() or SAFE_EXECLP with just NULL on many
places, including testing execlp() itself in execlp01.c. I guess we should fix
that.

> > +#else /* UFFD_FEATURE_MINOR_SHMEM */
> > +#include "tst_test.h"
> > +TST_TEST_TCONF("System does not have userfaultfd minor fault support for shmem");
> > +#endif /* UFFD_FEATURE_MINOR_SHMEM */

> When the child exits through this TST_TEST_TCONF(), the
> TST_CHECKPOINT_WAIT() in parent will fail. The parent process should not
> even fork() when UFFD_FEATURE_MINOR_SHMEM is not defined in config.h.
+1, this should be fixed. Please let us know if you don't have time to send fix
yourself.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
