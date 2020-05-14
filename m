From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 May 2020 16:47:29 +0200
Subject: [LTP] [PATCH v2 1/1] rpc: TCONF when tests aren't compiled +
 remove kill warning
In-Reply-To: <20200512201416.8299-1-pvorel@suse.cz>
References: <20200512201416.8299-1-pvorel@suse.cz>
Message-ID: <20200514144729.GA19276@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> with this implementation (suggested by Alexey), we get TCONF twice. It's
> a bit strange, but I'll keep it, because I like that required binary is
> printed:
> rpc_test 1 TCONF: 'tirpc_rpcb_getaddr' not found
> rpc_test 1 TCONF: LTP compiled without TI-RPC support?
Please any comment for 2x TCONF. It's a bit strange, but just a tiny detail.
I'd like to have this fix in the release.

Kind regards,
Petr

