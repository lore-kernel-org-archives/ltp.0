From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Feb 2020 14:36:22 +0100
Subject: [LTP] ksm03, ksm04 testcases don't work with cgroup
In-Reply-To: <BM1PR0101MB145982BF4AAC059931EA2013EE130@BM1PR0101MB1459.INDPRD01.PROD.OUTLOOK.COM>
References: <BM1PR0101MB145982BF4AAC059931EA2013EE130@BM1PR0101MB1459.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <20200220133622.GA29116@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am running ksm03 and kms04 on my RISC  v system wth linux 5.4.3,LTP Version: 20200120-55-g537fb6535
> with custom Yocto distro,the test is getting failed with following errors.why it is failing?
> 
> root@exaleapsemi:~/pankaj_ltp/ltp/testcases/kernel/mem/ksm# ./ksm03
> tst_test.c:1215: INFO: Timeout per run is 0h 05m 00s
> safe_macros.c:167: BROK: mem.c:750: mkdir(/dev/cgroup,0777) failed: EEXIST (17)

That's more of the system problem than anything else, kernel itself does
not mount cgroups anywhere, that's usually done it the boot process and
it ends up under /sys/fs/cgroups/ on most of the recent distributions.

It looks like something has mounted cgroups over the /dev/cgroup on your
system, it's up to you to figure out why is it mounted there.

-- 
Cyril Hrubis
chrubis@suse.cz
