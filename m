From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Jun 2020 15:23:00 +0200
Subject: [LTP] [PATCH] network/nfs_lib.sh: Use double quotes for grep
 pattern
In-Reply-To: <3e8b407b-fd12-c637-e199-3651fd280bbc@oracle.com>
References: <20200608142744.274287-1-yangx.jy@cn.fujitsu.com>
 <20200608145831.GA2746544@x230>
 <423c55db-a393-d1d9-6de6-28f65f76557a@oracle.com>
 <20200617184356.GA7422@dell5510>
 <3e8b407b-fd12-c637-e199-3651fd280bbc@oracle.com>
Message-ID: <20200618132300.GA7101@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > And removing it from all 3 variants would be great (keeping them to be the same,
> > also it might allow to also use shell functions, which doesn't work with sh -c
> > "..."). Why was sh -c "..." used anyway?

> Hi Petr,

> Don't remember, so if all work without it I would remove it. For rsh,
> I doubt that's is used now days, let's remove it too? The replacement (ssh)
> in the tst_rhost_run() has been for a long time already.
+1 agree, go ahead :).

Kind regards,
Petr
