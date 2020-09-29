From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Sep 2020 15:02:59 +0200
Subject: [LTP] [PATCH 1/1] io_destroy01: TCONF when unsupported
In-Reply-To: <5F72E52E.40609@cn.fujitsu.com>
References: <20200929073501.4598-1-pvorel@suse.cz>
 <5F72E52E.40609@cn.fujitsu.com>
Message-ID: <20200929130259.GC2717@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Why not using kconfig in tst_test struct.

Well because this is much simpler and does the same job.

There is a different case for kconfig, i.e. some people would like to be
able to syntetize kconfig for testing by extracting the data from tests,
but that is completely different problem and would need a different
solution.

-- 
Cyril Hrubis
chrubis@suse.cz
