From: xuyang <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 14 May 2019 13:24:52 +0800
Subject: [LTP] [PATCH] ltp-cap.m4: add libcap version detection && fix
 compiler error
In-Reply-To: <20190513131451.GA22761@dell5510>
References: <1557732392-7049-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190513131451.GA22761@dell5510>
Message-ID: <5CDA5124.3070708@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/05/13 21:14, Petr Vorel wrote:

> Hi Yang,
>
>
>> Current ltp-cap.m4 defines cap_libs when libcap has
>> cap_compare function.  This function was introduced by
>> libcap-2. It is only used for the two places, and another
>> places work fines with libcap-1. So add libcap version
>> detection.
> Can't we just fix these possible compiler errors for old distros and require
> libcap v2?  TCONF for very old distros looks OK for me.
> libcap-2.00 was released 12 years ago (2007), these distros does not have it:
> SLES 10 SP3 [1], RHEL-4.8 [2], Debian 4.0 [3]. Do we really want to care about
> these old distros (it looks like only RHEL is supported)?
> We also dropped libnuma v1 support (in 2c98cbbaf), v2 was released at similar
> date (2008).
Hi Peter

   I sent a mail to you last Friday mentioned this problem. At the beginning, I
   think it makes no sense because libcap-1 is too old.  But I notices that ltp-quota.m4
   has quota_v1 and quota_v2. I changes my mind.

   Since we have drop libnuma v1, I agree with you that we also drop libcap v1(too old).
   Also, I think we should drop quota_v1 because it is too old (since Linux 2.4.22, Q_GETINFO has
   been supported in kernel).

Kind Regards,
Yang Xu

> Kind regards,
> Petr
>
> [1] https://distrowatch.com/table.php?distribution=sle&pkglist=true&version=10-sp3#pkglist
> [2] https://distrowatch.com/table.php?distribution=redhat&pkglist=true&version=rhel-4.8#pkglist
> [3] https://distrowatch.com/table.php?distribution=debian&pkglist=true&version=4.0#pkglist
>
>



