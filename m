From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 May 2021 11:07:32 +0200
Subject: [LTP] [PATCH v3 4/6] Add rtnetlink helper library
In-Reply-To: <20210505081845.7024-4-mdoucha@suse.cz>
References: <20210505081845.7024-1-mdoucha@suse.cz>
 <20210505081845.7024-4-mdoucha@suse.cz>
Message-ID: <YJj31Le8Nvarlgof@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> This library provides simple interface for creating arbitrary rtnetlink
> messages with complex attributes, sending requests and receiving results.

I wonder if it'd be good to rewrite route-change-netlink.c to use
tst_netdevice.c instead of libmnl (it'd be nice to get rid of libmnl dependency,
but on the other hand using it means also testing it).

Kind regards,
Petr
