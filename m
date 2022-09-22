Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA629C6FA82
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 09:03:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 638053CAD55
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 11:03:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5702A3CA0DB
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 11:03:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7ECDD200DE8
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 11:03:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A5C88219B7;
 Thu, 22 Sep 2022 09:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663837398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWRDV6+nqoLSCBrJ0OXW4LVn8Ol7LARkCkX2wiNQY8I=;
 b=ouAqA4JVFhBmDIWpf1tZZyI2VsOHfqny1ePpuBmEalenYBi5T9AV6U/mGEaFwrtaBw+Q4K
 ba4l97N9gZMzwtketGRPquKEoo/L/XNCILyH4Cd/5WH1/6w0GH4Kz4D4vE7uO4UX1PwzcO
 BEOONr13P9jmr2kYpu+ix7b+3QvZZfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663837398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWRDV6+nqoLSCBrJ0OXW4LVn8Ol7LARkCkX2wiNQY8I=;
 b=bpIsm3JdZOxd4z4TyOtDs/Cq52ifc3OeIordW/YEpzZ0wD4Dwh+MlgNZqfRUNkWGKBcwYA
 As+OozRQqeWQn0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70D181346B;
 Thu, 22 Sep 2022 09:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id he3MGdYkLGNocwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 22 Sep 2022 09:03:18 +0000
Date: Thu, 22 Sep 2022 11:02:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YywknXj4nL48PaR6@pevik>
References: <20220921155006.13360-1-mdoucha@suse.cz>
 <CAEemH2eoxjDha9Ldu9shqO6MUUFfvT3dkFExAHGyH-38E5drVg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eoxjDha9Ldu9shqO6MUUFfvT3dkFExAHGyH-38E5drVg@mail.gmail.com>
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

Hi all,

> > Although the tst_fs_type_name() functions could use some improvements,
> > e.g. ext4 must be specified in skiplist as "ext2/ext3/ext4" to get properly

> Yes, that's true, we need to make it keep consistent with two
> skipping ways. Otherwise below test output "ext2/ext3/ext4"
> looks like a bit mess to remember.

> Better going with a single FS for matching (i.e. "ext4" for both fs_type
> and '-d path').
> But we can solve this in a separate patch later.

> $ df -T . | tail -1 | awk '{print $2}'
> ext4

> $ ./tst_supported_fs -s "ext4" ext4
> tst_supported_fs.c:135: TCONF: ext4 is skipped
> $ echo $?
> 32

> $ ./tst_supported_fs -s "ext4" -d .
> tst_supported_fs.c:137: TINFO: ext2/ext3/ext4 is not skipped
> $ echo $?
> 0

> $ ./tst_supported_fs -s "ext2/ext3/ext4" -d .
> tst_supported_fs.c:135: TCONF: ext2/ext3/ext4 is skipped
> $ echo $?
> 32

The same problem is for .skip_filesystems on tests which does not use
.all_filesystems. We only haven't noticed, because there was no reason to skip
ext[234] so far. I'm looking into this.

BTW .skip_filesystems without .all_filesystems have other problems, e.g. using
filesystems which aren't in fs_type_whitelist[] array (e.g. ramfs, nfs).
That'd be nice to fix after the release.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
