From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Jul 2020 09:48:44 +0200
Subject: [LTP] [RFC PATCH 1/1] testscripts: Remove exportfs.sh
In-Reply-To: <5F165D1A.80605@cn.fujitsu.com>
References: <20200720183208.3140-1-pvorel@suse.cz>
 <5F165D1A.80605@cn.fujitsu.com>
Message-ID: <20200721074844.GB4088@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> LGTM.

> Acked-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Thanks! Waiting whether there are more responses.

> One question:
> We need to mount the specified filesystem(e.g. a partition formated with xfs) on $TMPDIR
> manually if we try to test nfs with different underlying filesystems. Right?
Yes. We don't have shell API variant for .all_filesystems = 1 (from C API),
otherwise we could consider converting one NFS tests into all filesystems
variant.

Kind regards,
Petr
