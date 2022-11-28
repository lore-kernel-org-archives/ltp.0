Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDCAC43217
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 12:00:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8AF23CC668
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 13:00:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F00233C714A
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 13:00:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 21034200056
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 13:00:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 79B8F1F891;
 Mon, 28 Nov 2022 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669636828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2KpuYX8z+Sgk10fE5xhACkiXLrBj2LXMIcbsvLNhYqI=;
 b=mqbmLhJcKvr2rrFbnyl/QZkCgL+AEEdCI52cNO0lmF+PMDzf9HJg11tupDqB557JAYRcj9
 UYV581xAXeSOAcKdesKvOjlajHIVA36pz4gi33OTJ7IgJKu0QO0rpUzuJgQKaHWRDSnwp4
 sk4noEq4nsh5l/R0EQVfNRLWq4PbKEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669636828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2KpuYX8z+Sgk10fE5xhACkiXLrBj2LXMIcbsvLNhYqI=;
 b=tQxTzyNOknQP7BMwPt52i9YQW1k9uoXfsTyxZbW0sZkbk57urHImjaOBekzRHoCF8qHX1b
 A53eB0681GByKaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C66B1326E;
 Mon, 28 Nov 2022 12:00:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M33eFdyihGPvUgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 28 Nov 2022 12:00:28 +0000
Message-ID: <c43283e1-e969-46e0-f933-a18c2a6428f5@suse.cz>
Date: Mon, 28 Nov 2022 13:00:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: Petr Vorel <pvorel@suse.cz>, Michael Kerrisk <mtk.manpages@gmail.com>
References: <20221125122546.99144-1-david@redhat.com> <Y4DL5928NpuPI2Q6@pevik>
 <58d046ff-c89c-611c-0607-c2ec8f556526@redhat.com>
 <Y4SXTPBViJiqulow@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y4SXTPBViJiqulow@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] execl(),
 execlp() and execle() require proper termination of argument list
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
Cc: ltp@lists.linux.it, David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 28. 11. 22 12:11, Petr Vorel wrote:
> Hi Michael,
> 
> sorry to bother you, could you please comment our discussion about execl{,e,p}()
> termination of argument list being NULL vs. (char *)NULL vs. (void*)0?
> 
> Martin reported [2] that man page suggests (char*)NULL, his view of reason [3]:
> NULL may be defined as simple integer 0. When int is 32bit and pointers
> 64bit, this will cause trouble in variadic functions such as execlp().
> 
> Cyril pointed out [4]: NULL is required to be 0 cast to void* in POSIX. [5]
> 
> Therefore what should be really used?
> 
> Kind regards,
> Petr
> 
> [2] https://lore.kernel.org/ltp/8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz/
> [3] https://lore.kernel.org/ltp/af63ed9a-7108-fd19-fe2c-4b56be85d068@suse.cz/
> [4] https://lore.kernel.org/ltp/Y4DSmk7uY9zUUQsV@yuki/
> [5] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/stddef.h.html

Cyril is correct that we don't need this fix as long as we use C99 or 
later with POSIX-compliant build system. The explicit type cast is 
required only in C++ where there's no explicit conversion from void* to 
other pointer types and therefore NULL must be defined as integer 
instead of void* pointer constant.

Then again, pedantically following the docs won't break anything either.

Acked-by: Martin Doucha <mdoucha@suse.cz>

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
