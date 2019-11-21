From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Nov 2019 19:34:01 +0100
Subject: [LTP] [PATCH] memcg_lib/memcg_process: Better synchronization
 of signal USR1
In-Reply-To: <365bdf26-4e52-2159-17cd-52f2fb22e7fd@jv-coder.de>
References: <20191106073621.58738-1-lkml@jv-coder.de>
 <365bdf26-4e52-2159-17cd-52f2fb22e7fd@jv-coder.de>
Message-ID: <20191121183401.GA20889@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> > diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> > index aadaae4d2..7440e1eee 100755
> > --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> > +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> > @@ -124,6 +124,7 @@ signal_memcg_process()
> >   	local usage_start=$(cat ${path}memory.usage_in_bytes)
> >   	kill -s USR1 $pid 2> /dev/null
> > +	TST_CHECKPOINT_WAIT 1
> Actually this does not work like this, because some of the
> tests trigger the oom killer and TEST_CHECKPOINT_WAIT calling
> tst_checkpoint uses ROD. Is it ok to directly call

> tst_checkpoint wait 10000 "1"

> and ignore the result here?

> BTW: Is there no such thing like TST_CHECKPOINT in the new
> shell test library?
No, there is no support for TST_CHECKPOINT in shell.
To be honest I have no idea how to implement it.
It could be done in some form of checking some file content and in a loop and
sleep in the meantime (ineffective), but sync between C and shell API is IMHO
not possible.

Kind regards,
Petr
