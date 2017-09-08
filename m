From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 8 Sep 2017 14:42:24 +0200
Subject: [LTP] [RFC PATCH v9 6/7] network: Add tools for setup IP
 related environment variables
In-Reply-To: <852799515.10801870.1504872485595.JavaMail.zimbra@redhat.com>
References: <20170824234436.18145-1-pvorel@suse.cz>
 <20170824234436.18145-7-pvorel@suse.cz>
 <6796162e-c84e-05a4-8350-c94feb5d2513@oracle.com>
 <837915861.10699397.1504863146663.JavaMail.zimbra@redhat.com>
 <98448ca4-600c-af66-d18f-e842068f6198@oracle.com>
 <852799515.10801870.1504872485595.JavaMail.zimbra@redhat.com>
Message-ID: <20170908124222.4kmrkuuoqsfmqfog@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > Looks like a known problem with rtnetlink include:

> > https://www.spinics.net/lists/netdev/msg171723.html

> > We should includesys/socket.hbefore rtnetlink.h.Is it fixing the build?

> Yes, this fixed the build for me.
Thank you for fixing it!

> tst_net_iface_prefix.c:80: warning: comparison between signed and unsigned
I'll post a fix for this warning.


Kind regards,
Petr
