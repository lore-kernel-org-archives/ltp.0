From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 5 May 2017 15:50:11 +0200
Subject: [LTP] [PATCH] runtest/net.nfs: fix version typo
In-Reply-To: <ede2fc8b-4486-ce87-4742-92ad4ea00d28@oracle.com>
References: <1489575310-3488-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <ede2fc8b-4486-ce87-4742-92ad4ea00d28@oracle.com>
Message-ID: <20170505135011.GD16729@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >  nfs3_02 nfs02 -v 3 -t udp
> > -nfs4_02 nfs02 -v 3 -t tcp
> > +nfs4_02 nfs02 -v 4 -t tcp
> 
> I wonder if we should add back test-cases with NFSv3 over TCP,
> something like this:
> nfs3t_02  nfs01 -v 3 -t tcp
> ...

Sounds reasonable, feel free to commit this before the release.

-- 
Cyril Hrubis
chrubis@suse.cz
