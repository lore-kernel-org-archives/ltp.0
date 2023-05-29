Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F89C77B7E
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 08:27:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B321D3CCFF7
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 10:27:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47EE63CCDC9
 for <ltp@lists.linux.it>; Mon, 29 May 2023 10:27:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B65F51400127
 for <ltp@lists.linux.it>; Mon, 29 May 2023 10:27:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B220421A72;
 Mon, 29 May 2023 08:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685348851;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QLgzKsizlP/Tte/pPhRcNMO8i4u/6uwen/dNVFo1a9Y=;
 b=sWia+w+JfDNSpXs8Pu5LuD52CfypDFNN24Gw+nz7AD30YXNM0wv7DgH+OewVoV/uwmuKsK
 Y33rns3a8B+qgNZDxSxTOmRn8jG5mOc2LqAQzvEp7MGIGrtkERxLfE1qzfFJGDKaUVJpQq
 vEnPIALH41L1rIXnzgUKGmCJD4XwE64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685348851;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QLgzKsizlP/Tte/pPhRcNMO8i4u/6uwen/dNVFo1a9Y=;
 b=7Ynjtk7jG8WR5XQqPNLoIP5On8it1JDeXQfpsPW9ynLkekai2hrfeXHyrpMSJT5SD+6JMn
 NIhlanMNoufBYfCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 861A913466;
 Mon, 29 May 2023 08:27:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id etGrH/NhdGT9WQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 May 2023 08:27:31 +0000
Date: Mon, 29 May 2023 10:27:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230529082730.GA18615@pevik>
References: <20230526133435.7369-1-mdoucha@suse.cz>
 <20230526133435.7369-5-mdoucha@suse.cz>
 <20230529055110.GC6579@pevik>
 <0023ff26-0798-6f37-4bb8-e733bfed1fcb@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0023ff26-0798-6f37-4bb8-e733bfed1fcb@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/7] KVM: Add async communication helper
 functions
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Nicolai Stange <nstange@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 29. 05. 23 7:51, Petr Vorel wrote:
> > Hi Martin,

> > > Test programs using these functions must have at least two host threads.
> > IMHO we don't have flags to require this. I guess KVM hosts nowadays should have
> > more than 2 threads (these tests are for bare metal), thus we don't have to note
> > this also in the code, right?

> We have tst_test.min_cpus, used e.g. in kvm_svm03. But this is a note to
> programmers that they must use pthreads, otherwise tst_kvm_wait_guest() will
> always time out or lock up. The signaling can work even on single CPU unless
> you somehow manage to break task switching in the host kernel (like in
> kvm_svm03).

+1, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
