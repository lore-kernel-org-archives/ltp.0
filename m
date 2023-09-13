Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDC7EDEC5E
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 14:29:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C68363CE766
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 16:29:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D27C93CE762
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 16:29:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CC23A14010F0
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 16:29:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0683A1F385;
 Wed, 13 Sep 2023 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694615382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qttmkgsqu7jGdGb7CINy7wEnaGsnGFcg5fygI9KNaRU=;
 b=OCwU6exDaNy7VN/Ja78qh20E5TDvmLwsmILZwrgCdPfqcxkiPKFAZRole/AsX708/NuC3n
 M91m6KKH+p0KvpMIojgeW4kJy6d9mFM0LcANWYv95xxxPQHspmD79MvCyZ+o/wGRwDAvmA
 sl+Rtx+gSuuZFPTHqwPUqezWaMBnilw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694615382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qttmkgsqu7jGdGb7CINy7wEnaGsnGFcg5fygI9KNaRU=;
 b=qnRbN+heoUlqjX3jz7CKb8Br39S2/rvgCaZ5tI3FurUsHl0nuWHp3fCtZ1EeRU8f+T5a8i
 nNlru0TAMRh08EDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E603413582;
 Wed, 13 Sep 2023 14:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /4xzN1XHAWUWZAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 13 Sep 2023 14:29:41 +0000
Date: Wed, 13 Sep 2023 16:30:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZQHHhDfbfXwT9a-I@yuki>
References: <20230912161230.31983-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230912161230.31983-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tcindex01: Simplify test
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
> +	NETDEV_ADD_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle, "htb",
> +		qd_config);
> +	NETDEV_ADD_TRAFFIC_CLASS(DEVNAME, qd_handle, clsid, "htb", cls_config);
> +	NETDEV_ADD_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP, 1,
> +		"tcindex", f_config);
> +	NETDEV_REMOVE_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP,
> +		1, "tcindex");
> +	tst_res(TINFO, "Trying to add removed tcindex filter again...");
> +	NETDEV_ADD_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP, 1,
> +		"tcindex", f_config);

I suppose that this will now produce TBROK in case of vunerable kernel?

I wonder if we can turn that somehow into TFAIL instead so that it's
clear that the kernel is vunerable and that this isn't broken test.

Maybe we can pass down a flag to modify_qdisc() that would use
tst_res_(TFAIL, ...) in a case that the send_validate() has failed, pass
it down as disabled in all the current macros and create
NETDEV_TEST_ADD_TRAFIC_FITLER() that would pass the flag enabled.

> +	NETDEV_REMOVE_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle, "htb");
> +	tst_res(TPASS, "Removing tcindex filter works correctly");
>  }
>  
>  static void cleanup(void)
> -- 
> 2.41.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
