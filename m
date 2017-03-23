From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Mar 2017 14:13:41 +0100
Subject: [LTP] [PATCH 1/1] rpc: Add missing header
In-Reply-To: <20170323130515.hgxdgqs6absurzjf@dell5510>
References: <20170322202820.15989-1-pvorel@suse.cz>
 <20170323113530.GD351@rei.lan>
 <20170323130515.hgxdgqs6absurzjf@dell5510>
Message-ID: <20170323131341.GF351@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Hmm, the man 3 rpc only states that <rpc/rpc.h> needs to be included,
> > what distro this fails on?
> Error is:
> rpc_server.c: In function ???main???:
> rpc_server.c:78:2: warning: implicit declaration of function ???pmap_unset??? [-Wimplicit-function-declaration]
>   pmap_unset(program, version);
> 
> But maybe I'm wrong, doing some mistake.

Looks to me like glibc bug. Since the tirpc/rpc/rpc.h includes the
rpc/pmap_clnt.h while the glibc equivalent does not. But I'm not expect
on RPC either. I guess that we should better ask on the glibc ML.

-- 
Cyril Hrubis
chrubis@suse.cz
