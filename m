From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Aug 2021 17:32:14 +0200
Subject: [LTP] [PATCH v1] shmget02: check if CONFIG_HUGETLBFS enabled in
 kernel
In-Reply-To: <VI1PR04MB49588E7EF259841E40FD6CAE93EF9@VI1PR04MB4958.eurprd04.prod.outlook.com>
References: <20210802143236.28791-1-bogdan.lezhepekov@suse.com>
 <YQgET2rMo4BSNnrq@yuki>
 <VI1PR04MB49588E7EF259841E40FD6CAE93EF9@VI1PR04MB4958.eurprd04.prod.outlook.com>
Message-ID: <YQgP/l/raDZlW5W7@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks a lot for reviewing.
> 
> I agree that reading kconfig every time is not fun. But would it be better to read it once into global variable? My concern is that your solution implicitly changes expected values that might confuse people who occasionally don't look at the bottom of program.
> 
> How about:
> 
> inline void _hugetlbfs_supported()
> {
> struct tst_kconfig_var kconfig = {
> .id = CONFIG_HUGETLBFS,
> .id_len = sizeof(CONFIG_HUGETLBFS)-1,
> };
> 
> tst_kconfig_read(&kconfig, 1);
> hugetlbfs_supported = kconfig.choice == 'y';
> }
> ....
> 
> static void do_test(unsigned int n)
> {
> struct tcase *tc = &tcases[n];
> pid_t pid;
> 
> if (((tc->flags & SHM_HUGETLB) == SHM_HUGETLB) && ! hugetlbfs_supported)
> {
> tst_brk(TCONF,
> "Unsuitable kernel config: CONFIG_HUGETLBFS missing");
> }
> ....

This does not check that we get a proper error when SHM_HUGETLB is not
supported by the kernel though, which is something that should be
checked as well.

-- 
Cyril Hrubis
chrubis@suse.cz
