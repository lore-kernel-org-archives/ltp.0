From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Nov 2019 22:10:53 +0800
Subject: [LTP] [PATCH 1/2] Wrapper for Syzkaller reproducers
In-Reply-To: <87ftitdwjq.fsf@rpws.prws.suse.cz>
References: <20191107153458.16917-1-rpalethorpe@suse.com>
 <20191107153458.16917-2-rpalethorpe@suse.com>
 <CACT4Y+aYVH=e+ZJhF2b-b92dkJZwjnPP4keup509twcQqK+wMg@mail.gmail.com>
 <CAEemH2eVR4U8dHR6anmirX_X5Y3hXKgL4cHxekeVXH_wSHnnpA@mail.gmail.com>
 <87ftitdwjq.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2eAnkr-n+DxtioUY1M3nbLN8sORWO2k2LBgacPTgGMKhA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 12, 2019 at 10:00 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello,
>
> Li Wang <liwang@redhat.com> writes:
>
> >
> >
> > Just to try build it in LTP and hit errors:
> >
> > # cd ltp-new/
> > # make autotools
> > # ./configure --with-syzkaller-repros
> > # make -j32
> > ...
> > error: pathspec '/root/ltp-new/testcases/linux-arts' did not match any
> > file(s) known to git
> > make[3]: ***
> [/root/ltp-new/testcases/kernel/syzkaller-repros/Makefile:26:
> > /root/ltp-new/testcases/linux-arts/syzkaller-repros/linux] Error 1
> > make[3]: Leaving directory
> '/root/ltp-new/testcases/kernel/syzkaller-repros'
> > make[2]: *** [../../include/mk/generic_trunk_target.inc:93: all] Error 2
> > make[2]: Leaving directory '/root/ltp-new/testcases/kernel'
> > make[1]: *** [../include/mk/generic_trunk_target.inc:93: all] Error 2
> > make[1]: Leaving directory '/root/ltp-new/testcases'
> > make: *** [Makefile:108: testcases-all] Error 2
> >
> >
>
> What happens if you try to pull the git submodule manually?
>
# pwd
/root/ltp-new

# git submodule update --init testcases/linux-arts
error: pathspec 'testcases/linux-arts' did not match any file(s) known to
git


>
> i.e. do git submodule update --init testcases/linux-arts
>
> It looks like it failed on the line where it gets the submodule, so I am
> wondering if you have an old git version?


Not sure if that related to git-version, I'm trying to look into it.

# git --version
git version 2.23.0

# uname -r
5.3.8-300.fc31.x86_64

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191112/bc3ad8ad/attachment-0001.htm>
