Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677E3C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 12:54:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BA3E3C9430
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 14:54:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 217ED3C80B0
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 14:54:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9FAFD100055F
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 14:54:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B6B661F38A;
 Mon, 13 Jun 2022 12:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655124852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lk8UUjJeUaGZ/CtvrNXdPLxENKXAmcSEzJgmNvJzc0Q=;
 b=ouxh6DV8DRobicgrYsHe64bEkgNedGORxA7SIX7k+nVhUDayFcj/M17cGLAdmr1QM5qpbd
 jm8uAKQTrQ6+oh6/2BR1a0IwuQP0s3y9raxJocblq6DWHvxLz8lXZ3LHE6hQdQD8RcvZKd
 5q1M3QXvyG5FyYupZ6PBdMP0fJmjr4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655124852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lk8UUjJeUaGZ/CtvrNXdPLxENKXAmcSEzJgmNvJzc0Q=;
 b=qp8hlhuOav3a4cOmyBm51zzRgvXQUyqNz1aOiRua3r0FwHefpfpg/29p4Mm5bgqEPKrji5
 WhfqugdsOMwhcYBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E23C13443;
 Mon, 13 Jun 2022 12:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id btaMJXQzp2LLHAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 13 Jun 2022 12:54:12 +0000
Message-ID: <f527c92a-97f0-9d07-87e9-58ab3e521aaf@suse.cz>
Date: Mon, 13 Jun 2022 14:54:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20220610131442.5032-1-mdoucha@suse.cz> <YqNIIb/NFVBjsZdb@rei>
 <156915a0-cd2b-e6b8-1b7c-273c67911d4b@suse.cz> <YqbyFKN999MTr6Xf@yuki>
 <Yqcmuv8dwtU+tntL@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Yqcmuv8dwtU+tntL@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure: Check for KVM linker script support
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

On 13. 06. 22 13:59, Petr Vorel wrote:
>>> Also, the KVM Makefile already builds nothing on non-x86 archs so the
>>> problem was there from the beginning.
> 
> I thought we're using TST_TEST_TCONF() for non-x86 archs.

We will use TST_TEST_TCONF() for KVM on unsupported archs once they have
their own guest bootstrap code (which is currently available only for
32bit and 64bit x86). But it is not possible to link test binaries
without bootstrap code so non-x86 archs are currently skipped during build.

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
