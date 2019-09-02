From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Sep 2019 16:55:24 +0200
Subject: [LTP] [PATCH v4 0/4] Basic eBPF tests
In-Reply-To: <1492475067.8173800.1566829761941.JavaMail.zimbra@redhat.com>
References: <20190826111024.19053-1-chrubis@suse.cz>
 <1492475067.8173800.1566829761941.JavaMail.zimbra@redhat.com>
Message-ID: <20190902145524.GB10860@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There's one EPERM I can reproduce reliably with bpf_map test, which appears
> to originate from "bpf_charge_memlock".
> 
> There's a deferred component to map freeing, and unchange appears to be part of it:
>   bpf_map_release
>     bpf_map_put
>       INIT_WORK(&map->work, bpf_map_free_deferred);
>         (deferred) bpf_uncharge_memlock
> 
> When I lower max locked memory, it's easy to hit:
> # ulimit  -l 128; ./bpf_map01 -i 100
> ...
> bpf_map01.c:52: CONF: bpf() requires CAP_SYS_ADMIN on this system: EPERM
> 
> Can you try bumping max locked memory to some high value and check
> if that helps your case?

Looks like this was the case, with high enough value the tests works
without a problem. The question is if and/or what should be done about
this...

-- 
Cyril Hrubis
chrubis@suse.cz
