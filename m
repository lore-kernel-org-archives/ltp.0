Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957F2C433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 07:22:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2189C3CA687
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 09:22:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96EBE3C9C34
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 09:22:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E62DA140051D
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 09:22:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B54C215FF;
 Tue, 19 Apr 2022 07:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650352949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uK2lP/rCfh1cc5+r1Uhn5J+irFGiAof5JOYcqOF9lh8=;
 b=GI1bG7rxuFgNb10nG5hSyx37L8lRQmeBesqtOVViWdKSr0nl8GpNOwM89dew6SVBNad7qY
 Ki776dTauGO+QrRAC995yxRkYO5n0CRsbSaYnR9Gv3QFGvHsDiY+OH5PiAjTZjVK/K6oLT
 h3S7DNHXJ1D5QcnNQCcd4NwY6jRWLw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650352949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uK2lP/rCfh1cc5+r1Uhn5J+irFGiAof5JOYcqOF9lh8=;
 b=hkiJeC51n2bFXZiqvPFV8WToKBvM46x5r2q2kZaYwVuJo6ymVu0KvpqP0vANshLi8nisRL
 56hR9CsrUWJSCaDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E42F7132E7;
 Tue, 19 Apr 2022 07:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CevlMzRjXmL8SQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 19 Apr 2022 07:22:28 +0000
Date: Tue, 19 Apr 2022 09:22:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
Message-ID: <Yl5jM+a7yGtVpaIG@pevik>
References: <20220401050804.1286-1-andrea.cervesato@suse.de>
 <YkrJfb0vZq6WSZmX@pevik>
 <348d5c14-97e2-7c23-9666-92ba77354417@suse.com>
 <YkrqzV+W2qYKJuIw@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YkrqzV+W2qYKJuIw@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Rewrite userns06.c using new LTP API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

2 small things:

Actually adding one more #ifdef HAVE_LIBCAP
might be better than calling tst_brk() manually (this is better than my previous
suggestion):

#include "config.h"

#ifdef HAVE_LIBCAP
# define TST_NO_DEFAULT_MAIN
#endif

#include "tst_test.h"

#ifdef HAVE_LIBCAP

#include <string.h>
#include <sys/wait.h>
#include <sys/capability.h>

int main(int argc, char *argv[])
{
...
}

#else
TST_TEST_TCONF("System is missing libcap");
#endif

But if you prefer to original version (define main), then TCONF should be used.

Also #define _GNU_SOURCE is not needed, it should be dropped.

If you agree, I can merge it with proposed changes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
