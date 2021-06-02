From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 Jun 2021 13:04:14 +0200
Subject: [LTP] [LTP PATCH v2 3/3] nfs_lib.sh: Check running rpc.mountd,
 rpc.statd
In-Reply-To: <02781c77-9fed-b111-c3ad-3043a6e0ca29@bell-sw.com>
References: <20210526172503.18621-1-pvorel@suse.cz>
 <20210526172503.18621-3-pvorel@suse.cz>
 <02781c77-9fed-b111-c3ad-3043a6e0ca29@bell-sw.com>
Message-ID: <YLdlrnMj6FmyAWCV@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > -TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs"
> > +TST_NEEDS_CMDS="$TST_NEEDS_CMDS exportfs mount"

> Does it change anything?

Just sort alphabetically (not a problem here, but in longer list it's easier to
read).

> The rest looks good.
Thx!

Kind regards,
Petr
