Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A216C433FE
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 13:51:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 334973CA8BE
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 15:51:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 395B33CA2E6
 for <ltp@lists.linux.it>; Thu,  5 May 2022 15:51:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7A6AE200231
 for <ltp@lists.linux.it>; Thu,  5 May 2022 15:51:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 881861F8DA;
 Thu,  5 May 2022 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651758666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N0BCfc4HSz4Y6nHm/ODzm+n8z+Uf68HRjKVmWV96xWw=;
 b=QrNA+ngpm2xGef01zjUDMayCm7c8gL+8xGewMdWY8eCjPlSbjhnzSvH43nEBdoblQpmh7B
 xNR3dwhq5lAEyTsxUolAlShJU+SS/+BZd62h8dYleJY7uWQ9QuvsV7Yf/85bNbskKdMigm
 B71rYJ+01AoTlloNfin3USa6epwVnM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651758666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N0BCfc4HSz4Y6nHm/ODzm+n8z+Uf68HRjKVmWV96xWw=;
 b=vAGKnTHezCreNJtfZ+HG+vlS2TE7cVZxVKtMF7OvvG8LW31P41T1tPOiPbqUIDW/2zW9lB
 5nm3xutDYKgVRMDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70FBB13B11;
 Thu,  5 May 2022 13:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YW1jGkrWc2JVKAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 05 May 2022 13:51:06 +0000
Date: Thu, 5 May 2022 15:53:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YnPW0gfMAUGZYPSM@yuki>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
 <3d85635f6b87c73a2389627bc94c847c52165dc7.1651176646.git.luke.nowakowskikrijger@canonical.com>
 <YnOH4h8rTbg1NzCO@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YnOH4h8rTbg1NzCO@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 11/19] controllers: Expand cgroup_lib shell
 library
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
Cc: ltp@lists.linux.it,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +_cgroup_check_return()
> > +{
> > +	local ret="$1"
> > +	local msg="$2"
> > +
> > +	tst_flag2mask TBROK
> > +	[ "$ret" = "$?" ] && tst_brk TBROK "$msg"
> > +
> > +	tst_flag2mask TCONF
> > +	[ "$ret" = "$?" ] && tst_brk TCONF "$msg"
> > +}
> As I wrote in previous patch likely we can avoid tst_flag2mask in new API.
> 
> In few cases where needed we hardwired numbers (IMHO POSIX shell does not
> support constants, which would be better than variables which can be changed).
> 
> In this case you could probably use ROD() or EXPECT_PASS_BRK().

Or we can just passthrough the result, as long as it's non-zero we can
do exit $ret and be done with it.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
