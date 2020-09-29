From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Sep 2020 10:41:14 +0200
Subject: [LTP] [PATCH 1/1] io_destroy01: TCONF when unsupported
In-Reply-To: <5F72E52E.40609@cn.fujitsu.com>
References: <20200929073501.4598-1-pvorel@suse.cz>
 <5F72E52E.40609@cn.fujitsu.com>
Message-ID: <20200929084114.GA7482@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> Hi Petr
> Why not using kconfig in tst_test struct.

We should probably use tst_syscall().
But using kconfig is not 1) needed (tst_syscall() most reliable way) 2) kconfig
requires having kernel config available, which is not on some platforms.

(I plan to introduce TWARN_IF_NO_CONFIG to print only warning for platforms
which don't have kconfig available, see
https://github.com/linux-test-project/ltp/issues/700).

Kind regards,
Petr
