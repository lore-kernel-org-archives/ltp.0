Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4546DC32771
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 14:32:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBF433CA1C0
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 16:32:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C7433C98BF
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 16:32:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 26E6C100023E
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 16:32:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D10A1F996;
 Fri, 19 Aug 2022 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660919559;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP2FM5cnfr/l82Nj8vhXAo1G16VrYXdftc522MJ9ZD8=;
 b=dQ8CU+v98fPZ8gueJNP1/Fe/XWhly0lXMmvsQ3dCUuS8USy3gIuWo4T3D2HBfYNZb20wGD
 hKDi4kneESwddesIQgDM6mqUfjuEoNT+54mVozoBMW57PGI6s3kCmVDAiTsIOWFt8Eeehv
 tLdkneASgJvE/rX0Q1MNk4n46wBeVWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660919559;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP2FM5cnfr/l82Nj8vhXAo1G16VrYXdftc522MJ9ZD8=;
 b=5BnSsAs/oAzLMnrNsesVf3jMOdv7z9eevoIJz4LDtfMcPBSQ7mR0sBiAKYneRhQKjFZm4T
 xI3vxrdP9ZLMJbBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0781A13AC1;
 Fri, 19 Aug 2022 14:32:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3JRyAAef/2KWdwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 19 Aug 2022 14:32:39 +0000
Date: Fri, 19 Aug 2022 16:32:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yv+fBabMjCy3CLlo@pevik>
References: <20220819090704.17219-1-pvorel@suse.cz>
 <950bbc2f-1af9-581b-c7a2-e6d39fc276ec@fujitsu.com>
 <269bbc89-2a89-9eac-e4f9-69b66a862a23@fujitsu.com>
 <CAEemH2d97boX8x3+XKS23djO93S3+og+5r9RDFp3gzo97mMp+A@mail.gmail.com>
 <75b595dd-fdcb-73db-0e71-d36d665bbad8@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <75b595dd-fdcb-73db-0e71-d36d665bbad8@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] statx04: Remove kernel comments in docparse
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

thanks all for their input.

> Hi Li

> >     So for me, If remove kernel commit in description, then I only see
> >     useless commit id number, unless I go to search them in kernel org.


> > Not exactly, another thing to make people's attention is test fail with =

> > hint,
> > then we can simply click the link.

> I remember Amir also added a similar feature[1] to xfstests when he =

> become xfs 5.10 stable kernel maintainer.

> So maybe we can add a third colume in tst_test struct's tag field  to =

> cover kernel commit title? Then this kernel comment can be removed.

Amir got inspiration from LTP, but I'm not a big fan of adding manually git
subject which is now added by script.  Also I'd like to address the change =
we
agree also in fanotify sources.

> Also, I don't have strong obejection to this patch because it seems =

> duplicate, but I just want to keep kernel commit title by using simple wa=
y.

I also wonder why people add commits in this verbose form:

 *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
 *  Author: yangerkun <yangerkun@huawei.com>
 *  Date:   Mon Feb 18 09:07:02 2019 +0800
 *
 *  ext2: support statx syscall

If commits are really necessary I'd add them inline, i.e.:

$ git log --pretty=3Dformat:'%h ("%s")' -1 93bc420ed41d
93bc420ed41d ("ext2: support statx syscall")

But again, having git hash at the bottom and then full commit on the top lo=
oks
to me just a redundancy (I often want to see changes in kernel thus run git=
 show
hash anyway + there is that link in docparse.

So let's wait for opinion of other people.

Kind regards,
Petr

> [1]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3D4f=
b72cffd9e3251149d9fa25daa96b2e26b62eab

> Best Regards
> Yang Xu


> >  =A0 =A0 58	HINT: You _MAY_ be missing kernel fixes:
> >  =A0 =A0 59	=

> >  =A0 =A0 60	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3D93bc420ed41d  <https://git.kernel.org/pub/scm/linux/ke=
rnel/git/torvalds/linux.git/commit/?id=3D93bc420ed41d>
> >  =A0 =A0 61	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3D99652ea56a41  <https://git.kernel.org/pub/scm/linux/ke=
rnel/git/torvalds/linux.git/commit/?id=3D99652ea56a41>
> >  =A0 =A0 62	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3D04a87e347282  <https://git.kernel.org/pub/scm/linux/ke=
rnel/git/torvalds/linux.git/commit/?id=3D04a87e347282>  =

> >  =A0 =A0 63https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/commit/?id=3D5f955f26f3d4  <https://git.kernel.org/pub/scm/linux/ker=
nel/git/torvalds/linux.git/commit/?id=3D5f955f26f3d4>


> > -- =

> > Regards,
> > Li Wang

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
