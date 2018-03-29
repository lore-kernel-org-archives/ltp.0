From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Mar 2018 08:12:24 +0200
Subject: [LTP] [PATCH v2 1/2] include/lapi: add sctp.h
In-Reply-To: <210efb77-c661-5fdd-abd3-16e419103461@oracle.com>
References: <1521819449-27489-1-git-send-email-alexey.kodanev@oracle.com>
 <1521819449-27489-2-git-send-email-alexey.kodanev@oracle.com>
 <20180326105555.GA7242@x230>
 <210efb77-c661-5fdd-abd3-16e419103461@oracle.com>
Message-ID: <20180329061224.GA31604@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > BTW SCTP_SOCKOPT_BINDX_ADD is defined in both <linux/sctp.h> and <netinet/sctp.h>, so if we
> > ever in future want to have some definitions from netinet/sctp.h, I'd be to create special
> > file include/lapi/netinet_sctp.h (the same like include/lapi/netinet_in.h - taking that
> > default is for "kernel/").


> I think if we have netinet/sctp.h it should take precedences
> over linux/sctp.h. In OL7 it is provided by optional
> lksctp-tools-devel package.
But linux/sctp.h has much more definitions than netinet/sctp.h and we use some kernel
specific definitions (e.g. SOL_UDPLITE is just in linux/sctp.h, SOL_SCTP is in both).

> Thanks,
> Alexey


Kind regards,
Petr
