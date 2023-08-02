Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A48C001DE
	for <ltp@archiver.kernel.org>; Wed,  2 Aug 2023 09:25:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29C703CDB41
	for <ltp@archiver.kernel.org>; Wed,  2 Aug 2023 11:25:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3D183CC967
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 11:25:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 976F4237147
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 11:25:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D16D81F8B2;
 Wed,  2 Aug 2023 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690968341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xFMtxkS6hWbP1UeAam6GZo0DUxqM0NuJUd5T/zq+k8=;
 b=lKhLQ8DeFUN38VHGp4ihsZUxg8vKXrCn3elBj/AeVnPt7BJnK/yXVGkhGRicj4p2DMcscG
 6h7TGctHTs5jkoEJCQxUeb2/1IiYfTDNSyoSExV5FopXdmoQpHm2Tz0whO8XdcX3fbbi0l
 5xAP7aCc4SlNCftA4kRbqWHIPGNtBhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690968341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xFMtxkS6hWbP1UeAam6GZo0DUxqM0NuJUd5T/zq+k8=;
 b=WyD3lcS/P9NNbLc6IrVul7wUZbyT0sVBG2VNiO4tzqku+ZlLPuvqoqSede856izsl2OsOt
 Bsa7WQwCDx7grAAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E1CA13909;
 Wed,  2 Aug 2023 09:25:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id m6llOxQhymRaYwAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 02 Aug 2023 09:25:40 +0000
From: Avinesh Kumar <akumar@suse.de>
To: pvorel@suse.cz, Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 02 Aug 2023 14:55:39 +0530
Message-ID: <422745784.q2UjYaihZW@localhost>
Organization: SUSE
In-Reply-To: <ZL-mb1nXfwpAklYr@yuki>
References: <20230719113906.22317-1-akumar@suse.de> <ZL-mb1nXfwpAklYr@yuki>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pipe08: Remove the test
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

Hi Cyril, Petr,

On Tuesday, July 25, 2023 4:09:43 PM IST Cyril Hrubis wrote:
> Hi!
> 
> > This test scenario of verifying SIGPIPE signal is being covered in
> > syscalls/write05.c test.
> 
> Hmm, this one is actually hard to figure out. Indeed the write test
> implmenents the SIGPIPE case, however it would make more sense to have
> the SIGPIPE test in syscalls/pipe/ directory instead. I guess that any
> kernel developer that would like to use LTP for testing changes in
> pipe() implementation would rather want to have the test under pipe/
> directory.
> 
> Maybe we should keep the pipe08 test and remove the case from the
> write05 test instead? Or should we keep both?

Thank you for your feedback. Now I too think we can keep both, but you guys 
can decide. Please let me know, I can send the patch for pipe08 to convert to 
new API if we decide to keep it.

--
Regards,
Avinesh






-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
