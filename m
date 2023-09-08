Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2500DEE57EB
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 09:22:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9668E3CC9B7
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 11:22:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 011CB3CB504
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 11:21:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 393D914013A3
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 11:21:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 13A481F461;
 Fri,  8 Sep 2023 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694164908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xp2Pae6n+q9ITfJ1v5AgyzdH1C3zSnKzgKEIsjjGSHI=;
 b=b8RPwVCGfiMMXaCfGsbfimnDNgkEWhDyFjjHVjFql1DwyMzJdXIemwwdy64TXxPlo1oDzd
 3l+XO51IpPqf3dJub/h63AcXDMoK1VXnyCecPkc8p9kOGnoa7iD+4MMWou/fsLkTAQJYel
 O0Eky9uJsOAVpbHZ/hiso9yizm+3zvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694164908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xp2Pae6n+q9ITfJ1v5AgyzdH1C3zSnKzgKEIsjjGSHI=;
 b=cKfBMhkGg/fd9GrtbDL5Sv4S3hUAD8PU6pd9wPxrIJrYdwDskLiG3EfyjeYCs99catOOWL
 JywBX4OEFvxCPVAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2276132F2;
 Fri,  8 Sep 2023 09:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Om9nOqvn+mThUAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 08 Sep 2023 09:21:47 +0000
Message-ID: <845ca8fe-1ae2-13ba-c9e0-a53cf953c0ff@suse.cz>
Date: Fri, 8 Sep 2023 11:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Ian Wienand <iwienand@redhat.com>
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com> <87il8xhr05.fsf@suse.de>
 <ZPlxtKUwOta4GYh2@fedora19.localdomain>
 <65af05ae-bfd1-8153-4662-1bf61be855f3@suse.cz>
 <ZPpOuK9lyWr2wZWI@fedora19.localdomain>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <ZPpOuK9lyWr2wZWI@fedora19.localdomain>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kernel/device-drivers/zram/zram01.sh : don't
 fill from /dev/zero
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

On 08. 09. 23 0:29, Ian Wienand wrote:
> I don't think this is the correct way to deal with it.  I think that
> you're probably referring to earlier mail where there was a suggestion
> that this was a ppc64/vfat specific issue [1].  I was seeing this in a
> different context, and I believe the zeros are explained by no data
> actually being in the compressed buffers, as explained at [2].  Hence
> I think we need to come to some conclusion on actually writing data
> during testing.

Well then, did you see the failure on any other filesystem than vfat? 
I've read this whole e-mail thread again but there is no mention of 
which filesystems trigger this issue.

Alternatively, if kernel developers say that the caching behavior in 
zram is correct, then your v1 patch (adding sync) is the right solution.

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
