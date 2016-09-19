From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Sep 2016 14:11:55 +0200
Subject: [LTP] LTP Release
In-Reply-To: <57DA7580.8070006@oracle.com>
References: <20160914112947.GA7366@rei>
 <57DA7580.8070006@oracle.com>
Message-ID: <20160919121155.GB6220@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Network tests looks good, I have sent patches with new/rewritten tests 
> that could be part of release.
> All are well tested on OL6 and OL7 except NFS multi-mount test:
> 
> * busy_poll: new busy_poll03 test over UDP + added support for UDP in 
> tcp_fastopen (I guess we should rename it later to a more generic name):
>    patch-set "network/tcp_fastopen: use UDP optionally"
> 
> * arp: rewritten arp01 test + added support for IPv6 ndisc:
>    patch-set "network/tcp_cmds/arp01: use test_net.sh and add test-cases 
> with 'ip neigh'";
> 
> * ping: new ping02 test instead of removed perf_lan:
>    patch-set: "network/ping01: rename file and update runtest files";
> 
> * nfs: added support for multiple mounts in nfs_lib.sh, rewritten nfs06 
> test:
>    patch-set "network/nfs_lib: add support for multiple mounts"

I've commented some minor issue for the ping tests, the rest looks good
to me.

-- 
Cyril Hrubis
chrubis@suse.cz
