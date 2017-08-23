From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Aug 2017 12:46:35 +0200
Subject: [LTP] [RFC PATCH v8 10/11] network: Add tools for setup IP
 related environment variables
In-Reply-To: <139abe87-0496-8023-1386-788e289aaf2d@oracle.com>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-11-pvorel@suse.cz>
 <139abe87-0496-8023-1386-788e289aaf2d@oracle.com>
Message-ID: <20170823104635.lgludmsupnax2w2v@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Here is the thread with minor comments that still applicable to this
> version:

> http://lists.linux.it/pipermail/ltp/2017-June/004838.html
Sorry for forgetting on it.
I've fixed warning for C sources (tst_net_vars.c, tst_net_ip_prefix.c,
tst_net_iface_prefix.c), except false positives ("do not add new typedefs" and "open brace
'{' following function declarations go on the next line" for NLMSG_OK() macro).

I haven't found any other usage for SAFE_* macros than SAFE_SOCKET() and SAFE_SEND().


Kind regards,
Petr
