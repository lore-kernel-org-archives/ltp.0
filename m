From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Aug 2021 09:03:40 +0200
Subject: [LTP] [PATCH 1/1] doc: TST_MNTPOINT should be full path
In-Reply-To: <YSZZrdiYVCUa2zeI@yuki>
References: <20210825071420.5751-1-pvorel@suse.cz>
 <YSZZrdiYVCUa2zeI@yuki>
Message-ID: <YSiOTPs69AZw8hCu@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > -If the path passed (optional, defaults to '$TST_MNTPOINT') to the 'tst_umount' is
> > -not mounted (present in '/proc/mounts') it's noop.
> > +If the path passed (optional, should be full path, defaults to '$TST_MNTPOINT')
>                                   ^          ^
> 				  must     absolute

I used 'should' because the warning, but 'must' is more appropriate.
Fixed and merged.

Kind regards,
Petr
