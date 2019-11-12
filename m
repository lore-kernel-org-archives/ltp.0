From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 12 Nov 2019 15:00:25 +0100
Subject: [LTP] [PATCH 1/2] Wrapper for Syzkaller reproducers
In-Reply-To: <CAEemH2eVR4U8dHR6anmirX_X5Y3hXKgL4cHxekeVXH_wSHnnpA@mail.gmail.com>
References: <20191107153458.16917-1-rpalethorpe@suse.com>
 <20191107153458.16917-2-rpalethorpe@suse.com>
 <CACT4Y+aYVH=e+ZJhF2b-b92dkJZwjnPP4keup509twcQqK+wMg@mail.gmail.com>
 <CAEemH2eVR4U8dHR6anmirX_X5Y3hXKgL4cHxekeVXH_wSHnnpA@mail.gmail.com>
Message-ID: <87ftitdwjq.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

>
>
> Just to try build it in LTP and hit errors:
>
> # cd ltp-new/
> # make autotools
> # ./configure --with-syzkaller-repros
> # make -j32
> ...
> error: pathspec '/root/ltp-new/testcases/linux-arts' did not match any
> file(s) known to git
> make[3]: *** [/root/ltp-new/testcases/kernel/syzkaller-repros/Makefile:26:
> /root/ltp-new/testcases/linux-arts/syzkaller-repros/linux] Error 1
> make[3]: Leaving directory '/root/ltp-new/testcases/kernel/syzkaller-repros'
> make[2]: *** [../../include/mk/generic_trunk_target.inc:93: all] Error 2
> make[2]: Leaving directory '/root/ltp-new/testcases/kernel'
> make[1]: *** [../include/mk/generic_trunk_target.inc:93: all] Error 2
> make[1]: Leaving directory '/root/ltp-new/testcases'
> make: *** [Makefile:108: testcases-all] Error 2
>
>

What happens if you try to pull the git submodule manually?

i.e. do git submodule update --init testcases/linux-arts

It looks like it failed on the line where it gets the submodule, so I am
wondering if you have an old git version?

-- 
Thank you,
Richard.
