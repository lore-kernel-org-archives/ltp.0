Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8957C433F5
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 15:14:17 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F01C60F02
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 15:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F01C60F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC1DD3C1D1A
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 16:14:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A9723C1D1A
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 16:14:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3AC5C1000464
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 16:14:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 954CF1FD29
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635779643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QiTghD8DNmWxD1iDrJShw06aKQ0A8qtLzekZNkAcv0=;
 b=mI60WR/KCK/MY1I/VXJBr66YEOOg8ieRpOebPrd53oip4n02p6ahi/pknlkeRJ2/YOCOWb
 sVjsREvvxtAqK2upsymOKscsEtCvAKSL25meylsKV8nBeRUXk8vAu85DZIPzF9DnpwQu4v
 n3soieKrfWoVRAYxnIoOH+TZrKSvu8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635779643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QiTghD8DNmWxD1iDrJShw06aKQ0A8qtLzekZNkAcv0=;
 b=+vjJsY2m3KjgidPRwi6DkNr4web2D36rQcIRyfvz3v3/+Pi53qMReHOoA5dAQ4BLAsqsOo
 y16hbWrRrh2DLaAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8339913A4A
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 15:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UlkbHzsEgGEONQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 01 Nov 2021 15:14:03 +0000
Date: Mon, 1 Nov 2021 16:14:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YYAEcnED+AUnRzHp@yuki>
References: <20211101145342.7166-1-chrubis@suse.cz>
 <20211101145342.7166-8-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211101145342.7166-8-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 7/7] docparse: Split into metadata and docparse
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> That way the metadata are build and installed unconditionally as they
> are going to be integral part of the test execution framework.
> 
> The metadata file is also renamed to ltp.json and installed into
> $DESTDIR/metadata/ltp.json.
> 
> The docparse build is triggered from the metadata Makefile since it has
> to be done once the ltp.json is fully generated.

I have forgotten to update the parse.sh script, this patch is broken
without:

diff --git a/metadata/parse.sh b/metadata/parse.sh
index 52d9a5cbf..b43d024c6 100755
--- a/metadata/parse.sh
+++ b/metadata/parse.sh
@@ -30,7 +30,7 @@ echo ' "tests": {'
 first=1

 for test in `find testcases/ -name '*.c'`; do
-       a=$($top_builddir/docparse/docparse -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")
+       a=$($top_builddir/metadata/metaparse -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")
        if [ -n "$a" ]; then
                if [ -z "$first" ]; then

Sorry for that.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
