Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26D6EB64D8
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 07:59:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53E2E3CD993
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 09:59:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E06033C9B2C
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 09:59:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EDC771400DC0
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 09:59:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5C94203F1;
 Thu, 22 Jun 2023 07:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687420776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y8UtH7gU84fxdekvJY/AM16EfFJszLpCobK2E/vW70Y=;
 b=gig58Clv8nLaebHHBdCRN9rz1WvPzyoUwuoPpVS5A/HD2nGeiPZxJih6y25Uzmpt88xTtF
 4qiWdrFk+SuFZlmBZU0BcK8VK0TihG5Wp+b16oYClCHo6w9/bs2SbCaamPrtCwzm/1QPKj
 XXam6SrpvlW6owI2k+Hmw+pGdzOJ03Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687420776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y8UtH7gU84fxdekvJY/AM16EfFJszLpCobK2E/vW70Y=;
 b=zDtqdnK8vDwkTjG6Gw/Q8ahT5J51Ye9akvh733KFwsFJ9CFO61xgfAGFGUt4jIh63cuL5c
 0iZh/EnsAvw8GtCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FF3A13905;
 Thu, 22 Jun 2023 07:59:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Gvq7IWj/k2REcwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 22 Jun 2023 07:59:36 +0000
Date: Thu, 22 Jun 2023 10:00:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Message-ID: <ZJP_qPeJ37H4qhEN@yuki>
References: <202306192248.1ece4c29-oliver.sang@intel.com>
 <61f22c1d-6b04-d193-57c9-8cad1c555e4b@kernel.org>
 <ZJLxbwCno-it2xBB@yuki> <ZJMYP/CCVviG6IMq@x1-carbon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZJMYP/CCVviG6IMq@x1-carbon>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [scsi] eca2040972:
 ltp.ioprio_set03.fail
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
Cc: "lkp@intel.com" <lkp@intel.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 kernel test robot <oliver.sang@intel.com>, Hannes Reinecke <hare@suse.de>,
 "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
 Christoph Hellwig <hch@lst.de>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> But... shouldn't the installed uapi headers match the running kernel?

Genearlly this is tough nut to crack. It's nearly impossible for headers
to actually match the running kernel in testing environments, since
quite often the testsuite is compiled beforehand and only retrieved,
since recompiling for each testrun is wasting too many cycles. I would
say that the best we can have is that UAPI headers shouldn't be newer
than running kernel.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
