From: vaishnavi.d <vaishnavi.d@zilogic.com>
Date: Wed, 26 Dec 2018 06:57:49 -0000
Subject: [LTP] [PATCH v2] Test statx syscall for SYNC_FLAGS
References: <20180917075248.28004-1-kewal@zilogic.com>
 <20181220082009.GA27700@dell5510>
 <7723ae02218c2bbca1a40d9c701a7bb2.squirrel@pike.zilogic.com>
 <20181221122206.GC25762@dell5510>
Message-ID: <92333ec721ba800b7dae0caac2d4bf1e.squirrel@pike.zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

> ok, I'm sorry, I got confused as you're both working on the same test.
> But the problem remain even on v5 [1]: missing _GNU_SOURCE definition
> while
> using lapi/stat.h.

Sorry, I failed to check that. Have added _GNU_SOURCE definition in
lapi/stat.h in patch v6.

Regards,
Vaishnavi D


