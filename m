Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA25C433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 12:38:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1CF43C9319
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:38:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB8703C54E8
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:38:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E64D21400E71
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:38:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 330E6210F0;
 Tue, 15 Mar 2022 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647347918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGGZTFHPmduNyc8ZObPwRt8Hv7DuJbkCX14+0PUnhB0=;
 b=M5LaUCm3RSgDYSKXsSzWmRs6fZww5VYxpGIVR5R3ONc/k04s0NGRNu/N3OcP8cpEpX5FZr
 eQBkRcuwMWf6NiTTEG6yskb1XC/kIndcdViqDlboTDWr88HLUfcFe6iT5ogj3jBrnIloOD
 LjzIVK0OpZ7Q1mZZcw6fUpJ5OEwN/1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647347918;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGGZTFHPmduNyc8ZObPwRt8Hv7DuJbkCX14+0PUnhB0=;
 b=BYGXM+RNXZWx56caN0kA+7M31Mmz+UfBXx+nZh+0E9Ym0R8B2K32uVosfolNC0gBy+MmeG
 eJJW0XL9h92HjqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27E8613B59;
 Tue, 15 Mar 2022 12:38:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I/m3Cc6IMGLSVgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 15 Mar 2022 12:38:38 +0000
Date: Tue, 15 Mar 2022 13:38:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YjCIxuTqxE2KEJdl@rei>
References: <20220310105916.7960-1-andrea.cervesato@suse.de>
 <20220310105916.7960-2-andrea.cervesato@suse.de>
 <YioISjHts5dstfLM@yuki>
 <048dca25-9519-5575-aadf-313250f8b011@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <048dca25-9519-5575-aadf-313250f8b011@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 01/10] Rewrite mesgq_nstest.c using new LTP API
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
> > And technically it would be best to call the msgget() with IPC_PRIVATE
> > and then get the key by msgctl() IPC_STAT.
> According with documentation and examples, msgget() is mostly used with 
> IPC_CREAT . What's the advantage of using IPC_PRIVATE in this case?

If you pass IPC_PRIVATE instead of the hardcoded key kernel will pick an
unused key for you, that's all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
