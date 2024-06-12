Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D435C27C79
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 03:14:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 800123D0B9B
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 05:14:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA8233D0B64
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 05:14:10 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=none (no SPF record)
 smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff;
 helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk;
 receiver=lists.linux.it)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk
 [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E18A1200AEF
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 05:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=FIjGGRABJCKKFF6YXfYjcpA9fG0vbhL8bpLfh5T2c90=; b=X4IPrzcWTALi93DkoznpTOtARS
 je5oPERYb9xGG9pTKd/dsMWBTNe2+JZ2gw4ZLFbIx1fGxzcTItnJ3tyLc3JUGIzvjGZSZlw1dLQMt
 1dDHbBbLiSFCk664b2MFZRnjz6P3OI/k5VIJqkz6t63mZKXZDXHWNiQqt3Zd6ucIplqJERbTjCSF8
 Kx0SEwVhAFWsHi1km9OEsrHDPTGT5Kc8n8WPH4dgY7JfAoW29QGavz74h3Ip0zEDMt33l0+v4KS8Y
 b60QRZ1B7j/npy/BhcxWRhUJMTK3OZ1k/uyg5H7wWhb7AqhjWZUCYuDcCc5qrU0ShX8EFnoUNxfGe
 oSY5IZoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1sHER2-00Eioe-0n; Wed, 12 Jun 2024 03:14:04 +0000
Date: Wed, 12 Jun 2024 04:14:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Message-ID: <20240612031404.GH1629371@ZenIV>
References: <171815791109.14261.10223988071271993465@noble.neil.brown.name>
 <20240612023748.GG1629371@ZenIV>
 <171816094008.14261.10304380583720747013@noble.neil.brown.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <171816094008.14261.10304380583720747013@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jun 12, 2024 at 12:55:40PM +1000, NeilBrown wrote:
> > 	IF we don't care about that, we might as well take fsnotify_open()
> > out of vfs_open() and, for do_open()/do_tmpfile()/do_o_path(), into
> > path_openat() itself.  I mean, having
> >         if (likely(!error)) {
> >                 if (likely(file->f_mode & FMODE_OPENED)) {
> > 			fsnotify_open(file);
> >                         return file;
> > 		}
> > in there would be a lot easier to follow...  It would lose fsnotify_open()
> > in a few more failure exits, but if we don't give a damn about having it
> > paired with fsnotify_close()...
> > 
> 
> Should we have fsnotify_open() set a new ->f_mode flag, and
> fsnotify_close() abort if it isn't set (and clear it if it is)?
> Then we would be guaranteed a balance - which does seem like a good
> idea.

Umm...  In that case, I would rather have FMODE_NONOTIFY set just before
the fput() in path_openat() - no need to grab another flag from ->f_mode
(not a lot of unused ones there) and no need to add any overhead on
the fast path.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
