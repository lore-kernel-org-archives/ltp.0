Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420AAC54EE9
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 11:20:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48E9F3CAD6C
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 13:20:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BD573C1BC9
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 13:20:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3A2E8200FCA
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 13:20:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C07D21A3E;
 Thu, 22 Sep 2022 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663845617;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7Wb3ZwisN2EjwVlv5TItCUrFW1r2HdsGp/N0MpG0oo=;
 b=Ne3BvmRsQWeaciAPMe0pL/8FaaLLeIS+jL6djIQBeia4oR9IZG4RBTpFTlOjKycGW37sCa
 Dyn+4L+xBbNmtO1yGRjqbsuyQZkYdoS+ZVjr5Qy6IDME/sYQQJfA6l3J1+C9uca5ju6cay
 h49FBJaMladiSWuBLVXu8vNj+aHiiYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663845617;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F7Wb3ZwisN2EjwVlv5TItCUrFW1r2HdsGp/N0MpG0oo=;
 b=zG64pkykZEdi8aPS7FSDif2U4Y796hkddAoYDBIsvlVUd1ofnEcqBgRJUJwySTAWdZblOQ
 P5AGZtLP406ymdBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E25A13AA5;
 Thu, 22 Sep 2022 11:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Cxg+DfFELGOLNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 22 Sep 2022 11:20:17 +0000
Date: Thu, 22 Sep 2022 13:20:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyxE7yEZH+E9UXoE@pevik>
References: <20220921155006.13360-1-mdoucha@suse.cz>
 <CAEemH2eoxjDha9Ldu9shqO6MUUFfvT3dkFExAHGyH-38E5drVg@mail.gmail.com>
 <YywknXj4nL48PaR6@pevik>
 <CAEemH2fy8zK1ABe5PrqFM=0J6s6oyPPva8pN9MF=2OrXEPcT2A@mail.gmail.com>
 <Yyw7osX47bnvNFr2@pevik> <Yyw/CYzZ2XjbQdxu@rei>
 <5541d648-f9ba-16c1-6767-4d8838863a25@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5541d648-f9ba-16c1-6767-4d8838863a25@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_supported_fs: Implement checking paths
 against skiplist
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 22. 09. 22 12:55, Cyril Hrubis wrote:
> > The real problem is that the line between ext2, ext3 and ext4 is really
> > blurry to an extend where it's hard to say which filesystem are you
> > working with. For example while ext2 kernel driver still exists and is
> > in use on embedded hardware modern distributions use single ext driver
> > to handle all three filesystems. Also I think that it was possible to
> > mount ext3 with ext2 driver at some point which disabled the journaling.

Should I understand this that you don't trust /proc/self/mountinfo output?
(show_mountinfo() in fs/proc_namespace.c in kernel git)?

Petr

> Still, I'd argue that blindly assuming any FS with ext2/3/4 magic number is
> always mounted as ext4 is a better solution than returning a string that
> never matches skiplists.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
