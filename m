Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF86C6FD18
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 15:38:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A25CB3CC040
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 17:38:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B20703CAC3E
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 17:38:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 027016009F3
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 17:38:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 11675219A7;
 Wed, 19 Apr 2023 15:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1681918716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMV8hhsOSzSyYnHh4bvqftBSLmPvynySjOQE+WSWHfU=;
 b=Lniv9Xe+Lwp6RZ1SDY10ANUv/RdHj0eieelD2MV7gMRD9hTn3ZQJF6g9FWQo2ucWalR123
 nh837OISZ12tXViCC6nFG+ZJs6ZEw6KEkvddM4ak5f1dzYGMAmDSlduNnpmEoY13qDFBzl
 yeYJd5KeYLgSnKuBhn0duAMwyOJU/fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1681918716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMV8hhsOSzSyYnHh4bvqftBSLmPvynySjOQE+WSWHfU=;
 b=dTKzbC+JtarIXX9TCvWL6mry6pLVXYyxj88YXuu1AMl8k4Ws/3khB+t9zTgKwQN4CWqtE3
 por1C4xu//40UQAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 862E01390E;
 Wed, 19 Apr 2023 15:38:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5x28FvsKQGR2GgAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 19 Apr 2023 15:38:35 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Wed, 19 Apr 2023 21:08:33 +0530
Message-ID: <10996503.sxSfETX4zk@localhost>
Organization: SUSE
In-Reply-To: <20230419114144.1219505-1-tsahu@linux.ibm.com>
References: <20230419114144.1219505-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Hugetlb: Test to detect bug with freeing
 gigantic hugetlb pages
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

Hi Tarun,

You are missing the runtest/hugetlb and .gitignore entries for this new test.


--
Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
