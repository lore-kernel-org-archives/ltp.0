From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 26 Aug 2019 10:29:21 -0400 (EDT)
Subject: [LTP] [PATCH v4 0/4] Basic eBPF tests
In-Reply-To: <20190826111024.19053-1-chrubis@suse.cz>
References: <20190826111024.19053-1-chrubis@suse.cz>
Message-ID: <1492475067.8173800.1566829761941.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> I've ended up playing with the patchset and fixed a few loose ends on
> the map test and as I had the code at hand I decided to send v4 instead
> of pointing out the mistakes in a review.
> 
> There were numerous small changes for the map test:
> 
> * Make sure the key buffer is sized exactly for the content
> 
> * Initialized the array/hash element value in test setup
> 
> * Made the code flow a bit more obvious, it was hard to tell which
>   part was run for n == 0 and which for n == 1
> 
> Also it looks that for me the test that loads the eBPF program ends up
> with EPERM randomly at about 10th iteration both as unpriviledged and
> priviledged user, which is really strange.

There's one EPERM I can reproduce reliably with bpf_map test, which appears
to originate from "bpf_charge_memlock".

There's a deferred component to map freeing, and unchange appears to be part of it:
  bpf_map_release
    bpf_map_put
      INIT_WORK(&map->work, bpf_map_free_deferred);
        (deferred) bpf_uncharge_memlock

When I lower max locked memory, it's easy to hit:
# ulimit  -l 128; ./bpf_map01 -i 100
...
bpf_map01.c:52: CONF: bpf() requires CAP_SYS_ADMIN on this system: EPERM

Can you try bumping max locked memory to some high value and check
if that helps your case?

Regards,
Jan

