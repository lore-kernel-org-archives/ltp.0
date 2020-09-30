From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Sep 2020 11:10:21 +0200
Subject: [LTP] [PATCH 1/1] io_destroy01: TCONF when unsupported
In-Reply-To: <87v9fwx0re.fsf@suse.de>
References: <20200929073501.4598-1-pvorel@suse.cz>
 <5F72E52E.40609@cn.fujitsu.com> <20200929084114.GA7482@dell5510>
 <5F730501.7050505@cn.fujitsu.com> <87v9fwx0re.fsf@suse.de>
Message-ID: <20200930091021.GA21717@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Yang Xu <xuyang2018.jy@cn.fujitsu.com> writes:

> > Hi Petr

> >> Hi Yang,

> >>> Hi Petr
> >>> Why not using kconfig in tst_test struct.

> >> We should probably use tst_syscall().
> >> But using kconfig is not 1) needed (tst_syscall() most reliable way) 2) kconfig
> >> requires having kernel config available, which is not on some platforms.
> > I see. At the first, I prefer to like to use kconfig because it only 
> > tests io_destory one time on kernel without CONFIG_AIO  when we use -i 
> > parameters,  but using libaio wrapper is stable. So it is ok.

> Kconfig can even be wrong (most likely with out-of-tree patches) or we
> might look at the wrong option as things are moved around
> sometimes. This is another instance of us trying to guess if something
> can be done without trying it.

> I guess there are some things where it is not as simple as trying a
> system call, but in cases where ENOSYS will be returned there is no need
> to look at the config except maybe for diagnostic purposes. If you are
> concerned about '-i' then you can even just make in invalid syscall in
> setup to see what error it returns.
@Yang: Yes, have a look at various foo_supported_by_kernel() helper functions in
include/lapi/ (added by Viresh Kumar).

Kind regards,
Petr
