From: yangx.jy@fujitsu.com <yangx.jy@fujitsu.com>
Date: Wed, 17 Mar 2021 11:12:34 +0000
Subject: [LTP] =?gb2312?b?u9i4tDogIFtQQVRDSCB2Ml0gY2xlYW51cDogVW5pZnkg?=
 =?gb2312?b?dGhlIGFubm90YXRpb24gc3R5bGUgYW5kIHJlbW92ZSBSZWR1bmRhbnQgY29k?=
 =?gb2312?b?ZQ==?=
In-Reply-To: <YFHghQWbAmjmKDx3@pevik>
References: <20210317100154.20389-1-zhaogongyi@huawei.com>
 <YFHghQWbAmjmKDx3@pevik>
Message-ID: <OS0PR01MB6371A1E607BDFBC2421E6788836A9@OS0PR01MB6371.jpnprd01.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



-----????-----
???: ltp <ltp-bounces+yangx.jy=cn.fujitsu.com@lists.linux.it> ?? Petr Vorel
????: 2021?3?17? 18:57
???: Zhao Gongyi <zhaogongyi@huawei.com>
??: ltp@lists.linux.it
??: Re: [LTP] [PATCH v2] cleanup: Unify the annotation style and remove Redundant code

Hi Gongyi,

> Change 'DESCRIPTION' to 'Description' and change 'ALGORITHM' to 
> 'Algorithm', and remove Redundant tst_reap_children since 
> tst_reap_children has been called in the test skeleton.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Hi Petr,

If we want to unify the format of 'Description' and 'Algorithm' in test, it seems redundant to do the conversion in testinfo.pl, right?

Can we use either of them(not both of them) because it is unnecessary to do the same thing twice.

Kind regards,
Petr

--
Mailing list info: https://lists.linux.it/listinfo/ltp


