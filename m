From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 26 May 2018 01:45:00 +0200
Subject: [LTP] Tests using more libraries and new shell API
Message-ID: <20180525234459.sd4rklfxrzgqq7mp@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

Network libraries using tst_net.sh started to use TST_OPTS and
TST_PARSE_ARGS:
89a83d8a0 net/ipsec_lib.sh: Process getopts parameters with TST_OPTS and TST_PARSE_ARGS
ce920a5a4 network/virt_lib.sh: Process getopts parameters with TST_OPTS and TST_PARSE_ARGS

macsec0{1,2}.sh tests load more libraries: virt_lib.sh and ipsec_lib.sh. Currently
tst_net.sh doesn't expect more libraries using it, so the later one wins.
These two tests doesn't use any getopts, so it does not break, but help is affected by
this. We could revert it, but this is going to be issue for new API.

I tried to allow handling more libraries being sourced in tst_net.sh, but failed.
I'll probably try once more, but I fear the solution will be too complicated.
It'd help if one library used the other, but that's not going to happen, there are
independent and about the same size.

Am I missing something obvious? Any idea how to solve it?


Kind regards,
Petr
