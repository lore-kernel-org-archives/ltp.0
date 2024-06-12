Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFB9C27C78
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 02:38:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B56A43D0BA5
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 04:38:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24D4B3CE1F3
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 04:37:57 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=none (no SPF record)
 smtp.mailfrom=ftp.linux.org.uk (client-ip=2a03:a000:7:0:5054:ff:fe1c:15ff;
 helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk;
 receiver=lists.linux.it)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk
 [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 67C721400DD5
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 04:37:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TcipHWc8SNr6o/D0UUcsakyzLLgeKSo+R3zQgMvpZ6g=; b=aHkoDEj2pEFv5B+kORwT+xARb1
 7ojPndYqAPP0qEKlaiN5OvqLYJFt0mpT3kD8LnvHBlikn/acRUowlNIgUMLp9BP/ivOZyjD86+dr+
 ZpCCnNnrhQs5rHEE3kDFCkZXvYS6i6RSAzLXB593+4ApI/LXNZaSLIGV6fKYBkCTbs15y877Kn84b
 htT8nYHxoXT/0WlW0GvarFCi1Xc1sAtngV6VVi0lCceXt6cAPlz1rHOepnv+rJoNb5NKMcG9JaGjh
 CZ9vnNHIVzqFN9eIYz6lR/Q6Kbwmux2pRJ1Um+q1VnSFn9iVkv4hrYEUgdJiI9D664wRS/2eV7yYM
 ZdXs942Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1sHDrw-00Ee2t-1o; Wed, 12 Jun 2024 02:37:48 +0000
Date: Wed, 12 Jun 2024 03:37:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Message-ID: <20240612023748.GG1629371@ZenIV>
References: <171815791109.14261.10223988071271993465@noble.neil.brown.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <171815791109.14261.10223988071271993465@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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

On Wed, Jun 12, 2024 at 12:05:11PM +1000, NeilBrown wrote:

> For finish_open() there are three cases:
>  - finish_open is used in ->atomic_open handlers.  For these we add a
>    call to fsnotify_open() in do_open() if FMODE_OPENED is set - which
>    means do_dentry_open() has been called. This happens after fsnotify_create().

	Hummm....  There's a bit of behaviour change; in case we fail in
may_open(), we used to get fsnotify_open()+fsnotify_close() and with that
patch we's get fsnotify_close() alone.

	IF we don't care about that, we might as well take fsnotify_open()
out of vfs_open() and, for do_open()/do_tmpfile()/do_o_path(), into
path_openat() itself.  I mean, having
        if (likely(!error)) {
                if (likely(file->f_mode & FMODE_OPENED)) {
			fsnotify_open(file);
                        return file;
		}
in there would be a lot easier to follow...  It would lose fsnotify_open()
in a few more failure exits, but if we don't give a damn about having it
paired with fsnotify_close()...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
