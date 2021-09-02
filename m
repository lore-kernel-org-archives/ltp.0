From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 2 Sep 2021 17:09:55 +0200
Subject: [LTP] [PATCH 0/4] checkbashisms.pl in make check + fixed docs
In-Reply-To: <015140e9-0eba-4057-4a91-35d958af2bb8@jv-coder.de>
References: <20210902103740.19446-1-pvorel@suse.cz>
 <015140e9-0eba-4057-4a91-35d958af2bb8@jv-coder.de>
Message-ID: <YTDpQxDDPY3HCli6@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Hi

> one general question about this: How to we want to handle false-positives?
Good point, thanks! Generally we can disable things which does not work for us.
I'd be pragmatic, if something works on most of shells and let's disable it,
just not disable needed test just due one false positive.

> e.g.:

> $ checkbashisms testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> possible bashism in
> testcases/kernel/controllers/memcg/functional/memcg_lib.sh line 387 ('(('
> should be '$(('):
> ??????? local limit_down=$(( PAGESIZE * ((limit + PAGESIZE - 1) / PAGESIZE)
> ))

> This is obviously a false positive, but could probably be adding a space
> between the brackets.

The only thing how to get away this was to introduce another variable:
	local limit_psize=$((limit + PAGESIZE - 1))
	local limit_down=$((PAGESIZE * (limit_psize / PAGESIZE)))

I'm not sure if it's not POSIX, but works because supported by all shells
(similar case to 'typo' not being POSIX but POSIX extensions). Maybe we should
report it.

> or

> $ checkbashisms testcases/kernel/connectors/pec/cn_pec.sh
> possible bashism in testcases/kernel/connectors/pec/cn_pec.sh line 127
> (should be >word 2>&1):
> ??????????????? done <&${fd_act}

> This one is just a false positive and I have no clue how to prevent this.
> I think the script does not like the <&, but this is posix...
The same here, I'm not sure if it's POSIX. &> definitely is not POSIX.
I remember we were talking about it. Can we avoid it somehow?

Kind regards,
Petr


> Joerg
