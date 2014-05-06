Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1Whb8s-0006EU-Cm
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 08:54:26 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Whb8r-00044a-J3
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 08:54:26 +0000
Message-ID: <5368A32E.7070805@oracle.com>
Date: Tue, 06 May 2014 16:54:06 +0800
From: Shuang Qiu <shuang.qiu@oracle.com>
MIME-Version: 1.0
References: <1389353374.2061.9.camel@G08JYZSD130126>
	<1389409991.2061.14.camel@G08JYZSD130126>
	<20140224193305.GC31562@rei>
	<1393309618.1952.52.camel@G08JYZSD130126>
In-Reply-To: <1393309618.1952.52.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v3] linkat/linkat02.c: add new error number tests
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hello,
On 02/25/2014 02:26 PM, Zeng Linggang wrote:
> +
> +	SAFE_TOUCH(cleanup, TEST_EMLINK, 0666, NULL);
> +
> +	while (1) {
> +		sprintf(lname, "%s%ld", BASENAME, ++link_max);
> +		TEST(link(TEST_EMLINK, lname));
> +		if (TEST_RETURN == -1) {
> +			switch (TEST_ERRNO) {
> +			case EMLINK:
> +				tst_resm(TINFO, "for %s the max links is %ld",
> +					 fstype, link_max);
> +				break;
> +			default:
> +				tst_brkm(TBROK | TTERRNO, cleanup,
> +					 "Unexpected error: ");
> +				break;
> +			}
> +			break;
> +		}
> +	}
> +}
>
Should it give a limit max number here when test EMLINK to handler the 
filesystems which unlimited link count.
AFAIK,it use 2^31 - 1 with xfs:
/*
  * The 32 bit link count in the inode theoretically maxes out at UINT_MAX.
  * Since the pathconf interface is signed, we use 2^31 - 1 instead.
  * The old inode format had a 16 bit link count, so its maximum is 
USHRT_MAX.
  */
#define XFS_MAXLINK             ((1U << 31) - 1U)
#define XFS_MAXLINK_1           65535U

We are not able to reach such limitation.

Thanks
Shuang

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
