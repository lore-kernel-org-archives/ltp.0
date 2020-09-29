From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 29 Sep 2020 17:57:21 +0800
Subject: [LTP] [PATCH 1/1] io_destroy01: TCONF when unsupported
In-Reply-To: <20200929084114.GA7482@dell5510>
References: <20200929073501.4598-1-pvorel@suse.cz>
 <5F72E52E.40609@cn.fujitsu.com> <20200929084114.GA7482@dell5510>
Message-ID: <5F730501.7050505@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

> Hi Yang,
>
>> Hi Petr
>> Why not using kconfig in tst_test struct.
>
> We should probably use tst_syscall().
> But using kconfig is not 1) needed (tst_syscall() most reliable way) 2) kconfig
> requires having kernel config available, which is not on some platforms.
I see. At the first, I prefer to like to use kconfig because it only 
tests io_destory one time on kernel without CONFIG_AIO  when we use -i 
parameters,  but using libaio wrapper is stable. So it is ok.
>
> (I plan to introduce TWARN_IF_NO_CONFIG to print only warning for platforms
> which don't have kconfig available, see
> https://github.com/linux-test-project/ltp/issues/700).

I have seen this ticket, if I understand it corretly,

if platform has kernel config without needed kconfig, test cases still 
will report TCONF

if platform doesn't have  kernel config, test cases only reports 
warning(system doesn't have kernel config file) and continue to run test 
and it maybe lead to a unexpected stat/failure. And we don't add extra 
check in tests case such as ENOSYS/EINVAL check because it is redundant 
against kconfig check.

Best Regards
Yang Xu

>
> Kind regards,
> Petr
>
>
> .
>



