Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6E4ECAAD5
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 08:41:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2BDD3CAAA9
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 10:41:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C21893C91EE
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 10:41:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DF1E31000187
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 10:41:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C6A4D1FB91;
 Mon, 12 Sep 2022 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662972101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yu4gesKnNyLjfpbn46QiDh9F1m6+cevrA6grXESzotc=;
 b=ToGVJgZIgbHOXfAXR8Qp9/DkLqxTBywb0q3eOn0hxS8vNVos464OURqm4ibmqkNqVebSNk
 mHuo7G9jcLrf/uGMhBXtWf3aQQ4mQvprQmWSj/ndzvN4UaQF+zJgXZ+uoc3eeJi4eznUA7
 1vYUnlOWUe36emVDozzLVVJeur2VcHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662972101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yu4gesKnNyLjfpbn46QiDh9F1m6+cevrA6grXESzotc=;
 b=3Bee2QnM7QsAA/ZEIo3n8Ph1nC8xPLEHdI2a0HXBd4NyhV9qxOUGR5yQEVj8jNhWD+9cgu
 SBN/mZ6/ub/i/9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6EE0139E0;
 Mon, 12 Sep 2022 08:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id O17rJsXwHmMgMAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 12 Sep 2022 08:41:41 +0000
Date: Mon, 12 Sep 2022 10:43:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Yx7xOGLqy2lVE9tI@yuki>
References: <20220908173947.17956-1-tsahu@linux.ibm.com>
 <YxsCJi8O+HmMpefq@yuki>
 <2412537e2e07ebf62fe95971a3022336cde9833a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2412537e2e07ebf62fe95971a3022336cde9833a.camel@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] Hugetlb: Migrating hugetlb tests from
 libhugetlbfs
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
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ltp@lists.linux.it,
 aneesh.kumar@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> As mentioned in the patch description, there is a conflict in license,
> That is why, I have avoided to put any of them in the header. Once
> confirmed within the community, I can add the original license here.
> (GPL2.1+) as 
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
> this says only to add code with GPL2.0+.

As far as I can tell there is no GPL2.1+ the only 2.1 version in
existence is LGPL.

GPL2.1+ usually happens to be an error when someone takes library header
with LGPL2.1+ license and removes the "Lesser" part.

However it looks like the whole libhugetlbfs is under LGPL2.1+ which
kind of makes sense for a library, but not so much for the tests since
these do not provide a library that can be linked againts at all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
