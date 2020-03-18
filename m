From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Mar 2020 14:16:14 +0100
Subject: [LTP] [PATCH v2] syscalls/add_key05: add maxbytes/maxkeys test
 under unprivileged user
In-Reply-To: <aae4670a-74eb-36e7-6115-b41eff951405@cn.fujitsu.com>
References: <20200224153112.GB2210@rei>
 <1582879661-1951-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200317123203.GA21921@dell5510>
 <aae4670a-74eb-36e7-6115-b41eff951405@cn.fujitsu.com>
Message-ID: <20200318131614.GA12354@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > Hm, I get this failure, I guess both are because missing your fix
> > 2e356101e72ab1361821b3af024d64877d9a798d, right?
> Yes, if your kernel is only with commit ("KEYS: allow reaching the keys
> quotas exact"), add_key(test_max) will fail because we don't remove this
> limit when initializing the key.

Great, thanks for a confirmation, that was my main concern.

> > add_key05.c:106: PASS: add_key(test_inv) failed as expected: EDQUOT (122)
> > add_key05.c:125: FAIL: add_key(test_max) failed unexpectedly: EDQUOT (122)
> > no crontab for ltp_add_key05
> > userdel: ltp_add_key05 home directory (/home/ltp_add_key05) not found

> > The rest looks ok to me.
> Thanks for your reivew. I will send v3 (also add save_store for keys/btyes )
OK, I'll wait for v3 (but I could also merge just this one and fix that tiny
formatting issues, up to you).

Kind regards,
Petr
