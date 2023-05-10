Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81734C77B7C
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 15:20:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40BFC3CE0A7
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 17:19:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 874883CB4CD
 for <ltp@lists.linux.it>; Wed, 10 May 2023 17:19:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 10D091A0092F
 for <ltp@lists.linux.it>; Wed, 10 May 2023 17:19:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5BC8A1F88D;
 Wed, 10 May 2023 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683731988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZhDB3tAwF9/VGhAFpWSsccereaT2PEwxlv/owGp0tqo=;
 b=zRYnLvGwp1eBi5OeEyJAwGdtXzRKqEWVn9csz8HplYVOEi/OinJqAzGb8qmPlNtToxnisS
 L96Zixabiii+FLaJmaxmoHh76TCrmZFsPlRSwwiPM/QoBUFINs4e8ffpq4+Mxe43yUVI/i
 xeFMVMTLdz4pPZ1o/SMzeGhC7WqC8Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683731988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZhDB3tAwF9/VGhAFpWSsccereaT2PEwxlv/owGp0tqo=;
 b=O6ORiMKLLIzpe7evde9LRbj7xTv1g4FJ8AGiF7IvMBHTTFNr0isEzJLixxv6pXkFWmrrCL
 cWvd5yRRWZfOzHAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26E4613519;
 Wed, 10 May 2023 15:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j6w1BhS2W2SRTQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 10 May 2023 15:19:48 +0000
Date: Wed, 10 May 2023 17:20:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Pengfei Xu <pengfei.xu@intel.com>
Message-ID: <ZFu2TXDwVRfe8RNj@yuki>
References: <cover.1683274510.git.pengfei.xu@intel.com>
 <efa47acd652c93a54fb66e17183524b54e561533.1683274510.git.pengfei.xu@intel.com>
 <ZFo1hUZCCXbfhEXY@yuki> <ZFpTIVcGoMTKyRCD@xpf.sh.intel.com>
 <ZFpUW8OAYPVViMBv@yuki> <ZFpYNARm7y4b2QBl@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZFpYNARm7y4b2QBl@xpf.sh.intel.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] libs: libltpnuma: Fix one fake failure
 when CXL(Compute eXpress Link) node memory is not used
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
Cc: Heng Su <heng.su@intel.com>, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>   Yes, below patch works well and as expected for all nodes memory check now.
> 
>   Below way is better and correct.

I've pushed these changes along with your description, thanks!

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
