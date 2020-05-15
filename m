From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 May 2020 13:45:07 +0200
Subject: [LTP] [PATCH v2 1/1] rpc: TCONF when tests aren't compiled +
 remove kill warning
In-Reply-To: <20200514144729.GA19276@dell5510>
References: <20200512201416.8299-1-pvorel@suse.cz>
 <20200514144729.GA19276@dell5510>
Message-ID: <20200515114507.GA3395@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > with this implementation (suggested by Alexey), we get TCONF twice. It's
> > a bit strange, but I'll keep it, because I like that required binary is
> > printed:
> > rpc_test 1 TCONF: 'tirpc_rpcb_getaddr' not found
> > rpc_test 1 TCONF: LTP compiled without TI-RPC support?
> Please any comment for 2x TCONF. It's a bit strange, but just a tiny detail.
> I'd like to have this fix in the release.

I do not really care how many TCONF the test prints as long as the user
gets a reasonable message.

With that the patch looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
