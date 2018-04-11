From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Apr 2018 11:45:28 +0200
Subject: [LTP] [RFC PATCH v6 6/7] tst_net_stress.sh: Migrate with
 dependencies to new API + rename
In-Reply-To: <12b040ea-626d-d9f5-6e2c-26d76cbe78bc@oracle.com>
References: <20180406123118.21309-1-pvorel@suse.cz>
 <20180406123118.21309-7-pvorel@suse.cz>
 <2fe8858d-81a3-bb1c-12f6-447dd30464e4@oracle.com>
 <20180410173715.pssexrwrxmfvvw53@dell5510>
 <12b040ea-626d-d9f5-6e2c-26d76cbe78bc@oracle.com>
Message-ID: <20180411094528.t7xvkmmoxjqou2xt@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> >>> -TST_TOTAL=2
> >>> -
> >>> +TST_CNT=2

> >> may be TST_CNT=1? otherwise it will run TST_TESTFUNC twice...
> > It should be run twice: first for ifconfig, second for ip. With TST_CNT=1 it would skip
> > testing with 'ip':

> I thought you divide the tests into ip and ifconfig here,
> there is still TST_CNT=2 in if-lib.sh, in the last patch.
I'm sorry, correct, TST_CNT=2 cannot be in 7/7. I removed it for v7.
I removed it from the last patch. I also removed TST_CNT=1, as it's redundant.


Kind regards,
Petr

> Thanks,
> Alexey
