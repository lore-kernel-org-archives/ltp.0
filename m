From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Jul 2020 12:55:50 +0200
Subject: [LTP] [PATCH 1/1] semctl: Fix 32 bit build
In-Reply-To: <20200730161344.GA18804@dell5510>
References: <20200730092637.487-1-pvorel@suse.cz>
 <20200730094842.GB3457@yuki.lan> <20200730101643.GA6381@dell5510>
 <20200730122226.GD3457@yuki.lan> <20200730125329.GA31867@dell5510>
 <20200730140912.GE3457@yuki.lan> <20200730161344.GA18804@dell5510>
Message-ID: <20200731105550.GA2768@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> https://travis-ci.org/github/pevik/ltp/jobs/713370407
> /usr/bin/ld: /tmp/ccaGt1eJ.o: in function `main':
> /usr/src/ltp/testcases/network/nfsv4/locks/locktests.c:1012: undefined reference to `configureClient'
> /usr/bin/ld: /usr/src/ltp/testcases/network/nfsv4/locks/locktests.c:1015: undefined reference to `getConfiguration'
> /usr/bin/ld: /usr/src/ltp/testcases/network/nfsv4/locks/locktests.c:1008: undefined reference to `configureServer'
> /usr/bin/ld: /usr/src/ltp/testcases/network/nfsv4/locks/locktests.c:1009: undefined reference to `setupClients'
> 
> Obviously using LTPLDLIBS doesn't apply here. But I don't see what is missing /
> wrong.

Well it matched our explicit rule instead of (different) implicit one,
looks like we have to define a full set, I will send a patchset later
on.

-- 
Cyril Hrubis
chrubis@suse.cz
