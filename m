From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 1 Dec 2016 11:51:29 +0100
Subject: [LTP] [PATCH 1/3] ltp/numa: waiting for numastat refresh
In-Reply-To: <CAEemH2fRor7ORDSzfDf8podzjXc5jAYWn+L6d3kcudkW7kcGmg@mail.gmail.com>
References: <1479872202-29920-1-git-send-email-liwang@redhat.com>
 <20161123125727.GF3346@rei.lan>
 <CAEemH2fRor7ORDSzfDf8podzjXc5jAYWn+L6d3kcudkW7kcGmg@mail.gmail.com>
Message-ID: <20161201105129.GB5626@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've been looking into the problem and found much better solution. We
can, instead of quering the whole system statistic, read statistic for a
single process.

What about we do:

1. Change support_numa.c to sleep in wait() instead of exitting when
   allocating memory
2. Run the numactl ... command on background with &
3. Then we can get statistic for a single process with numastat -p $pid
   Alternatively we can change the support_numa.c to allocate the memory
   with mmap and parse /proc/$pid/numa_maps to match the pointer address
   and figure out if the mapping(s) are distributed correctly
4. Then we can kill the $pid

-- 
Cyril Hrubis
chrubis@suse.cz
