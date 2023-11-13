Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C8FC4332F
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 15:49:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 038193CE5CF
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 16:49:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE0A93CE5B8
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 16:49:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1E9E8600041
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 16:49:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 465501F6E6;
 Mon, 13 Nov 2023 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699890583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tRBv7BVkP5vCP6OrnMj/JI6IaTvx+oSgRClG7t/zuq8=;
 b=NjbozcSwxMWDULOwEpd1y41rLLmNEujv/vm1asj/guZtSrjvbf225UCzLlQGhDgX0i68lj
 95piVOoVtooBbxpUvt5NnzP5Jq/WCo0Y+tLJxoV36hB/DsDGBtr1lE0mCLCDGOIOtWYpd1
 Yy6SR896p6ahmxtaP12IPkDWNkSMik0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699890583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tRBv7BVkP5vCP6OrnMj/JI6IaTvx+oSgRClG7t/zuq8=;
 b=S0YUQm1BapLb7SIMDaT/EeZKvFHEm7hBNPuyriBFG0rJXvDEBOEMV1J/RliWnch2xbpmME
 nrjELKLLseHZn1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D26E11358C;
 Mon, 13 Nov 2023 15:49:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6mNMLZZFUmWbVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Nov 2023 15:49:42 +0000
Date: Mon, 13 Nov 2023 16:49:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20231113154941.GA2231337@pevik>
References: <20230919114701.15327-1-mdoucha@suse.cz>
 <20230919114701.15327-4-mdoucha@suse.cz> <ZQ2Dth3NZO2rhzXP@yuki>
 <20230925132449.GD60471@pevik>
 <681b8c4b-1965-40ae-4489-ace37f45dad1@suse.cz>
 <20230925174057.GA90566@pevik>
 <1ce87b4d-88f6-4255-9483-fe860e41c93a@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1ce87b4d-88f6-4255-9483-fe860e41c93a@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 25. 09. 23 19:40, Petr Vorel wrote:
> > Hi,

> > ...
> > > > > > -			umount $local_dir
> > > > > > +			umount $local_dir || tst_res TFAIL "Unmount failed"

> > > > > I suppose that this should be TBROK instead. And that this, apart from

> > > > Right, TBROK looks to be the best.
> > > > Martin, if you're ok with the change, I'll update it before merge (after the
> > > > release).
> > > I don't see the point. This is a cleanup function. The TBROK will be changed
> > > to TWARN and the test will continue anyway.

> > But TFAIL in cleanup function looks to me strange as well. Should we endup with
> > TWARN then?

> TWARN makes sense. Feel free to change it during merge.

Good, changed and merged. Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
