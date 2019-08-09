From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Aug 2019 16:13:54 +0200
Subject: [LTP] [PATCH ltp 2/5] runtest: rename gf*** and rwtest{1..5} in
 lvm.part{1, 2} and scsi_debug.part1
In-Reply-To: <20190809062000.8671-2-yixin.zhang@intel.com>
References: <20190809062000.8671-1-yixin.zhang@intel.com>
 <20190809062000.8671-2-yixin.zhang@intel.com>
Message-ID: <20190809141354.GF32115@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There are lots tests with duplicated name gf*** and rwtest0{1..5} in the
> 3 runtest file but they are testing different fs. Rename them to
> distingulish.
> 
> 1. Change gf*** to gf***_lvm/gf***_scsi
> 2. Chagne rwtest** to rwtest{1..8}**_lvm/rwtest{1..8}**_scsi, which the
>    code 1..8 is the code for the target filesystem

I'm undecided on this one. On one hand I do not think that maintaining
unique names across different runtest files is feasible. On the other
hand this case is probably fine since it's unlikely that we will change
these files frequently.

Does anybody have strong opinion on this?

-- 
Cyril Hrubis
chrubis@suse.cz
