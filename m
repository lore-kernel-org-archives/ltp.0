Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Yxbwc-0001VH-Az
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 14:04:30 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yxbwa-0007BF-6r
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2015 14:04:30 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t4RE4LbQ017498
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2015 14:04:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t4RE4LSo004382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2015 14:04:21 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t4RE4Lqw013587
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2015 14:04:21 GMT
Message-ID: <5565CEDF.7040607@oracle.com>
Date: Wed, 27 May 2015 17:04:15 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <20150526095837.GE2940@rei.suse.de>
	<1432635670-25539-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1432635670-25539-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V2 2/2] Unmap the futexes backend file in tst_rmdir
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com



On 05/26/2015 01:21 PM, Stanislav Kholmanskikh wrote:
> As of now, test cases utilizing tst_checkpoint framework fail on NFS
> with similar errors:
>
> creat07     0  TWARN  :  tst_tmpdir.c:206: tst_rmdir: rmobj(/tmpdir/ltp-0IVQPP0NK6/creigi0kV) failed: remove(/tmpdir/ltp-0IVQPP0NK6/creigi0kV) failed; errno=66: Directory not empty
>
> This happens because we keep the futex page mapped while tst_rmdir() is running.
>
> Let's unmap it before the actual delete procedure.
>
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
> Changes since V1:
>   * renamed 'futex_t *futexes' to 'futex_t *tst_futexes'

Pushed this patch and "[PATCH 1/2] Move futex_t into a common header".

Thanks.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
