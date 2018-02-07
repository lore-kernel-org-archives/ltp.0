From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Feb 2018 16:32:09 +0100
Subject: [LTP] [PATCH v2] skipfile: allow regular expressions
In-Reply-To: <008001d3999a$1e8a26a0$5b9e73e0$@toshiba.co.jp>
References: <1516089674-16119-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
 <20180122151926.GA16105@rei>
 <008001d3999a$1e8a26a0$5b9e73e0$@toshiba.co.jp>
Message-ID: <20180207153209.GC31084@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Sorry for the delay. I found that my patch had a flaw while testing it on runltplite.sh.
> For example, "rwtest.*" doesn't work for rwtest:  
> rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s -f sync ..
> 
> The reason is that "rwtest.*"  matches too much. If I use "rwtest[a-zA-Z0-9]" as a regex on the skipfile
> then it works as expected
> 
> Example:
> $ STRING="rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s -f"
> $ sed "s/^\(rwtest.*\)\s.*/\1 exit 32;/" <<< $STRING
>     rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s -f exit 32  (BAD!!)
> $ sed "s/^\(rwtest[a-zA-Z0-9]*\)\s.*/\1 exit 32;/" <<< $STRING
> rwtest01 exit 32 (GOOD!!)

Ah looks like your first attempt ends up eating the source greadily
so \1 ends up being everything to the last whitespace.

I guess that s/^\(rwtest[\S]*\).*/\1 exit 32;/ should work, since it
will stop at first whitespace.

-- 
Cyril Hrubis
chrubis@suse.cz
