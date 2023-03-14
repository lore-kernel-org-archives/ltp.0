Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B9DC6FD1D
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 10:38:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EF9E3CD50B
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 11:38:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 317CD3CA013
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 11:38:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8E5C22003B0
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 11:38:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA2F11F893;
 Tue, 14 Mar 2023 10:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678790308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mczvu5lcjxgxmv3jCxPJVQU1flfJythgr1Ej+u36wu0=;
 b=s7BINyHShL1VnQqTJRV0aQsaKZuTjIyp9tZUN+GzZpvr6agt85++W2xyDBL6SqRC9j+P/7
 BwaK5RML0lO5h7BDPHB2wjHUvB66Snrjom2gxuVOrckG/zye2+b5cQtka9XKH+8rsV6m8J
 Ppp4AVRAAUY3hrJlrGHiJYk1dSq/L7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678790308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mczvu5lcjxgxmv3jCxPJVQU1flfJythgr1Ej+u36wu0=;
 b=p46P1DkiJPxLMNH/IL5TS+FUurEFnspiEDlS5FmMfm4zb4BaZMX+vPDhjhYPYajTcxJc1B
 X8qymuRYS6o4+DDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BB7613A26;
 Tue, 14 Mar 2023 10:38:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XxiwF6ROEGRlFQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Mar 2023 10:38:28 +0000
Date: Tue, 14 Mar 2023 11:38:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ping Fang <pifang@redhat.com>
Message-ID: <20230314103826.GB40740@pevik>
References: <20230309085454.735531-1-pifang@redhat.com>
 <20230313222437.GA27892@pevik>
 <CANKfEn6YtZRnFJYAePRg3e7W2yESMuVd=Lh4r4b9TpgUtGdYBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANKfEn6YtZRnFJYAePRg3e7W2yESMuVd=Lh4r4b9TpgUtGdYBQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] setfsuid02_16: Fix uid -1 too large for
 testing 16-bit version
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ping,

> > > __kernel_old_uid_t is not defined as 16bit on s390, ppc64le

> > I suppose limitation on s390 is because __kernel_old_uid_t is guarded only
> > for
> > kernel, right?


> Yes, userspace header will use definition in
> /usr/include/asm-generic/posix_types.h
> unsigned int break the size check.

Thanks for additional info.


> > arch/s390/include/uapi/asm/posix_types.h
> > #ifdef __KERNEL__
> > typedef unsigned short __kernel_old_uid_t;
> > typedef unsigned short __kernel_old_gid_t;
> > #define __kernel_old_uid_t __kernel_old_uid_t
> > #endif

> > > Then -1 will be translated into UINT_MAX fails the size check.
> > > s390, ppc64le use definition in /usr/include/asm-generic/posix_types.h
> > BTW do you test LTP syscalls on s930 and ppc (32bit)?


> I don't have these machines at hand.
Ah, I see it's broken on 64bit (not many people have 32bit for s390 or ppc).

Merged, thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
