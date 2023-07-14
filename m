Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39363EB64DA
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 12:32:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 877203CDE6A
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 14:32:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3C203CB5DF
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 14:32:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA623200B73
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 14:32:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B33A51FD66;
 Fri, 14 Jul 2023 12:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689337934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gTzYMwib7VJ1h2x82ZIkcBh/j5N5JoJAvxiI4guC43U=;
 b=iNjsCLb3p1GjdZZC+SlB2M5gXWh2z8UVJDxL8TqvNwemDPtOLcAKGHOfSjaxJpxok+fuyl
 KKwZKOWoB2tZPeo/WPzIoMXbgiP/uHiiHv85C23YwF1nZwcOdAuyKm4YCKd1L9HjOCTAPj
 WVnJ35XgWHefYcnbLIegRkPRw4IqQuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689337934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gTzYMwib7VJ1h2x82ZIkcBh/j5N5JoJAvxiI4guC43U=;
 b=eDuVO+dU+w7lQpGLKty4Tu/y2kz+tQTeKEreMRiEB1Uz0xnJDGp1wz+qkZk42dymxY3w3l
 TG2hsadYiQLotdCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 986CF13A15;
 Fri, 14 Jul 2023 12:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6oMGJE5AsWTsVAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 14 Jul 2023 12:32:14 +0000
Message-ID: <ebfe2958-c981-2ef6-3255-01b546fa4bea@suse.cz>
Date: Fri, 14 Jul 2023 14:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Eric Biggers <ebiggers@kernel.org>
References: <20230713132901.28660-1-mdoucha@suse.cz>
 <20230714034048.GA913@sol.localdomain> <20230714114719.GB958548@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230714114719.GB958548@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx09: Reduce fs-verity blocksize to 1024
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 14. 07. 23 13:47, Petr Vorel wrote:
>> There are a few different approaches you could take.  One would be the one you
>> mentioned: just add "-b 4096".  Though, note that systems with non-4K pages and
>> kernel older than v6.3 can't mount an "-O verity -b 4096" filesystem.
> 
> I suppose the problem would be with e.g. ppc64le. Because otherwise
> it works with this setup (untested on ppc64le, I believe it'd fail):
> .dev_fs_opts = (const char *const []){"-O verity", "-b 4096", NULL},
> and kept enable.block_size = 4096
> the test passes on older kernels 6.2.12-1-default (openSUSE), 5.10.0-8-amd64
> (Debian) as well as on 6.3 kernel.
> 
>> Or you could query the filesystem block size (that resulted from mkfs.ext4 with
>> unspecified block size) and use that as the Merkle tree block size.
> 
> Unless it's not too complicated, it looks to me the best, as it'd support both
>   >= 6.3 and older kernels.

Querying the filesystem size doesn't help on older kernels because 
mkfs.ext4 still creates the filesystem with small blocksize and setup() 
exits with TCONF because it can't mount the loop device, as you've seen 
in your own experiments. But it'll work on kernels v6.3+ so I've 
submitted that as v2.

For the older kernels, we'll have to run mkfs.ext4 in setup() with 
dynamically constructed command line arguments and set blocksize 
explicitly to pagesize.

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
