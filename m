Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A082C433EF
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 12:37:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43CA861ACE
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 12:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43CA861ACE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 643763C8A0D
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 13:37:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 160C43C0D25
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 13:37:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 907A01001531
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 13:37:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C6ADC212C6;
 Fri, 19 Nov 2021 12:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637325420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=uaAF6CCkpstXW9MyY4+bhhYNE9XKGDg8R4re1H+8Ka4=;
 b=sEjs8Fnes63nr7hudUQNDaiGh3ctZiDrf1Od1kcDAwJzAgBti3ZW0D28/Y9MBAjdMKlYwh
 RB0VZ5FJ/O2McdeTYSjzXUsfILl3BOoWyfvxi2aIuPHVB3WN7C/3AFiDFVLchqmp6yMhaD
 qbe0k3nvwgQvrYUH9h3yKgv89y6jSUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637325420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=uaAF6CCkpstXW9MyY4+bhhYNE9XKGDg8R4re1H+8Ka4=;
 b=WFMRBfVDIm3siudv8dy0D3TXByX2smnmN5Tk3hEcQieyogwUUKUN3adHQQUHQb5HtpZ+PC
 2M26c+vVcIjZ9RAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B03D913B2A;
 Fri, 19 Nov 2021 12:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8aXLKWyal2GHTQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 19 Nov 2021 12:37:00 +0000
Date: Fri, 19 Nov 2021 13:38:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: linux-api@vger.kernel.org
Message-ID: <YZearmiVEw9/eor9@yuki>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] asm-generic/int-ll64.h wrongly used on x86_64?
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
Cc: libc-alpha@sourceware.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I was writing simple userspace code that prints the values from the
struct statx the line in question looks like:

	printf("%" PRIu64 "\n", st.stx_size);

This unexpectedly gives me warning on x86_64:

warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type '__u64' {aka 'long long unsigned int'}

Digging into the issue I've found that include/asm-generic/types.h looks like:

#ifndef _ASM_GENERIC_TYPES_H
#define _ASM_GENERIC_TYPES_H
/*
 * int-ll64 is used everywhere now.
 */
#include <asm-generic/int-ll64.h>

#endif /* _ASM_GENERIC_TYPES_H */

Which is the cause why you cannot print __u64 with PRIu64 and would
force every userspace code to explicitly cast any __u64 in order to get
rid warnings. I would say that it would be better to fix the headers so
that __u64 has the same type as uint64_t so that PRIu64 could be then
used to print __u64 as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
