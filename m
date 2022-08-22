Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B9AC28D13
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 10:17:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07D2D3CA2D4
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 12:17:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D93C3CA277
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 12:17:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2954B100093F
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 12:17:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 684B61F97A;
 Mon, 22 Aug 2022 10:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661163447;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/XEU96J/kN6JNminnAstpWvC0KKiUTPpaF5HJiCJMdY=;
 b=YtRbIWd3517qgecf6NLRyLkqzQUKz2XeJNNfec6lXxWVM8Dqvl+Mf0SAlaqTqbu35sCFMq
 FkD4bgpdreLC7yByfKQ04Mg0GOUd3GAHejNtZY4rMDXuTWdunSW3KO+V6H/xjCZqzSLyGY
 kbcmGJxll02Hbr5jpilIFcjtSEieM3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661163447;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/XEU96J/kN6JNminnAstpWvC0KKiUTPpaF5HJiCJMdY=;
 b=01C1Ri9JPU+F0euRiPY89PgSL1nrw/Y6/QuvNk86cwkkGGuT2Ioei9lSmN0HlRIYPK1HGr
 itK+Hrqh5v3zsSAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DC2B1332D;
 Mon, 22 Aug 2022 10:17:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xaU5CLdXA2M9CgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 22 Aug 2022 10:17:27 +0000
Date: Mon, 22 Aug 2022 12:17:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YwNXtcTF1e5TJdfr@pevik>
References: <20220819090704.17219-1-pvorel@suse.cz>
 <950bbc2f-1af9-581b-c7a2-e6d39fc276ec@fujitsu.com>
 <269bbc89-2a89-9eac-e4f9-69b66a862a23@fujitsu.com>
 <CAEemH2d97boX8x3+XKS23djO93S3+og+5r9RDFp3gzo97mMp+A@mail.gmail.com>
 <75b595dd-fdcb-73db-0e71-d36d665bbad8@fujitsu.com>
 <Yv+fBabMjCy3CLlo@pevik>
 <CAEemH2ddjBnyWXt5J-u7qb7DJmQbehVAHXYF50CTWtm74DiFOA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ddjBnyWXt5J-u7qb7DJmQbehVAHXYF50CTWtm74DiFOA@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Xu, all,

> Hi Xu, Petr,

> Petr Vorel <pvorel@suse.cz> wrote:

> > I remember Amir also added a similar feature[1] to xfstests when he
> > > become xfs 5.10 stable kernel maintainer.

> > > So maybe we can add a third colume in tst_test struct's tag field  to
> > > cover kernel commit title? Then this kernel comment can be removed.


> We can achieve that but the complexity outweighs the benefits (for LTP).
+1



> > Amir got inspiration from LTP, but I'm not a big fan of adding manually git
> > subject which is now added by script.  Also I'd like to address the change
> > we
> > agree also in fanotify sources.


> > > Also, I don't have strong obejection to this patch because it seems
> > > duplicate, but I just want to keep kernel commit title by using simple
> > way.

> > I also wonder why people add commits in this verbose form:


> That's legacy way in writing comments, but obviously it need unify in format
> for better management in future.
+1 (that was the reason, why I posted it even it's trivial formatting patch, I
should also have posted it as RFC).



> >  *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
> >  *  Author: yangerkun <yangerkun@huawei.com>
> >  *  Date:   Mon Feb 18 09:07:02 2019 +0800
> >  *
> >  *  ext2: support statx syscall

> > If commits are really necessary I'd add them inline, i.e.:

> > $ git log --pretty=format:'%h ("%s")' -1 93bc420ed41d
> > 93bc420ed41d ("ext2: support statx syscall")


> +1, at most we add this format in normal C comments.
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fanotify/fanotify14.c#L17



> > But again, having git hash at the bottom and then full commit on the top
> > looks
> > to me just a redundancy (I often want to see changes in kernel thus run
> > git show
> > hash anyway + there is that link in docparse.


> me as well.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
