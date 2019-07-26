From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Jul 2019 15:31:24 +0200
Subject: [LTP] [PATCH v2] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <CAEemH2c96sB1ZA_vnTxSaBy-v=G_WnR58LX+Wt=Q8=UxO0dNtQ@mail.gmail.com>
References: <20190725033713.8551-1-liwang@redhat.com>
 <20190726121255.GA28028@rei.lan>
 <CAEemH2c96sB1ZA_vnTxSaBy-v=G_WnR58LX+Wt=Q8=UxO0dNtQ@mail.gmail.com>
Message-ID: <20190726133124.GC28028@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -----system env-----
> # uname -r
> 5.3.0-rc1+
> 
> # numactl -H
> available: 4 nodes (0-3)
> node 0 cpus: 0 1 2 3 16 17 18 19
> node 0 size: 32171 MB
> node 0 free: 25358 MB
> node 1 cpus: 4 5 6 7 20 21 22 23
> node 1 size: 16125 MB
> node 1 free: 5565 MB
> node 2 cpus: 8 9 10 11 24 25 26 27
> node 2 size: 96765 MB
> node 2 free: 90646 MB
> node 3 cpus: 12 13 14 15 28 29 30 31
> node 3 size: 64482 MB
> node 3 free: 60820 MB
> node distances:
> node   0   1   2   3
>   0:  10  11  11  11
>   1:  11  10  11  11
>   2:  11  11  10  11
>   3:  11  11  11  10
> 
> So, maybe we have to re-evaluate this patch V2 and to figure out why
> the retry mmap() hitting SIGBUS fails.

One possibility would be that the numa_move_pages() triggers SIGBUS
while we do the usleep() before we attempt to retry the mmap(). In that
case the race was present in the test all the time but couldn't be
triggered because the window where the memory is unmapped was very
short. If that is the case we should as well set up a handler to SIGBUS
and ignore it as well.

-- 
Cyril Hrubis
chrubis@suse.cz
