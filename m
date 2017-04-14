From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Apr 2017 11:12:22 +0200
Subject: [LTP] [RFC PATCH v4 0/3] Simplify network setup
In-Reply-To: <5d196274-519f-fb5c-f971-29ece892330d@oracle.com>
References: <20170405204418.3240-1-pvorel@suse.cz>
 <5d196274-519f-fb5c-f971-29ece892330d@oracle.com>
Message-ID: <20170414091222.ahrdtbid4pydsm2o@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Alexey,

> Please also use checkpatch and fix any errors/warnings reported:
>     total: 5 errors, 37 warnings
I fixed all errors but "line over 80 characters".
How does checkpatch.pl [1] counts line length As I get many "line over 80
characters", but my Vim shows that line is less than 80 chars.

> Got compiler errors as well:
> tst_net_vars.c: In function ‘get_ipv4_host’:
> tst_net_vars.c:317: error: ‘for’ loop initial declarations are only
> allowed in C99 mode
> tst_net_vars.c:317: note: use option -std=c99 or -std=gnu99 to compile
> your code
> tst_net_vars.c: In function ‘get_ipv4_net_rev’:
> tst_net_vars.c:349: error: ‘for’ loop initial declarations are only
> allowed in C99 mode
> tst_net_vars.c: In function ‘get_ipv4_network’:
> tst_net_vars.c:385: error: ‘for’ loop initial declarations are only
> allowed in C99 mode

Silly question, but how did you compile to get this error? I don't get them
$ i=testcases/lib/tst_net_vars; rm -fv $i; ma -C `dirname $i`

Thanks!
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl
