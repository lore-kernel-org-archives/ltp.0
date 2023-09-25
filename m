Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AB0CE7A81
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 13:45:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BE0B3CE22C
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:45:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B2AA3C65F4
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:45:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8668C60063D
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:45:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C26B721850;
 Mon, 25 Sep 2023 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695649523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xY1lMx/4Nxe6wAtIWuLVm3aRCXFmTJvVV9ToE+HZrWE=;
 b=mkWYUKEmSEGmmUnUU3f3x7dnaohQfgAKcU7ns4m5SwRv9fV9pcGZV0yrcvsibZSiT9ipc1
 EOjeU/tKXMa01dy6kOpwIxdwyj7xzLkLOIej5pUxp3UF0kD5V3Jy9TqSxFnBcAASbf+pp9
 1JvmsURY/I9sWFSJ3H2IlGSG8Ib5dVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695649523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xY1lMx/4Nxe6wAtIWuLVm3aRCXFmTJvVV9ToE+HZrWE=;
 b=tW1hMeosRCPr1wlvb0aK0PngbDT+S3MSrHlNuh6FeqKCJyorm6ij3eSntULjvN08+6Dede
 k5F60L4faBw9cDBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABEBD1358F;
 Mon, 25 Sep 2023 13:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bMwpKfOOEWW8GgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 25 Sep 2023 13:45:23 +0000
Message-ID: <681b8c4b-1965-40ae-4489-ace37f45dad1@suse.cz>
Date: Mon, 25 Sep 2023 15:45:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20230919114701.15327-1-mdoucha@suse.cz>
 <20230919114701.15327-4-mdoucha@suse.cz> <ZQ2Dth3NZO2rhzXP@yuki>
 <20230925132449.GD60471@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230925132449.GD60471@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] nfs_lib.sh: Fail the test if NFS unmount fails
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

On 25. 09. 23 15:24, Petr Vorel wrote:
>> Hi!
>>> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
>>> index a996f7cc8..099c78759 100644
>>> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
>>> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
>>> @@ -214,7 +214,7 @@ nfs_cleanup()
>>>   		local_dir="$(get_local_dir $i $n)"
>>>   		if grep -q "$local_dir" /proc/mounts; then
>>>   			tst_res TINFO "Unmounting $local_dir"
>>> -			umount $local_dir
>>> +			umount $local_dir || tst_res TFAIL "Unmount failed"
> 
>> I suppose that this should be TBROK instead. And that this, apart from
> 
> Right, TBROK looks to be the best.
> Martin, if you're ok with the change, I'll update it before merge (after the
> release).
I don't see the point. This is a cleanup function. The TBROK will be 
changed to TWARN and the test will continue anyway.

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
