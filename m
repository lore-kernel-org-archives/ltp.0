Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1PfU2B-00058H-Mm
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 09:08:55 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfU2A-0000HB-66
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 09:08:55 +0000
Message-ID: <4D36AA2C.9050009@cn.fujitsu.com>
Date: Wed, 19 Jan 2011 17:09:00 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D369E98.4060602@cn.fujitsu.com>
	<AANLkTi=z3=QTuMR5ofejRB=8A95WXHc8MKT-0+syVv-W@mail.gmail.com>
In-Reply-To: <AANLkTi=z3=QTuMR5ofejRB=8A95WXHc8MKT-0+syVv-W@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fsync02: fix error of overflow from MUL
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

Garrett Cooper said the following on 2011-1-19 16:47:
> 
>     How about the following item?
>     Please try the attached patch over the following -- it's just
> there for review.

  The patch is OK, thanks:)

-- 
Best Regards,
Peng Haitao

> Thanks,
> -Garrett
> 
> $ git diff testcases/kernel/syscalls/fsync/fsync02.c
> diff --git a/testcases/kernel/syscalls/fsync/fsync02.c
> b/testcases/kernel/syscalls/fsync/fsync02.c
> index 213eac3..6227a84 100644
> --- a/testcases/kernel/syscalls/fsync/fsync02.c
> +++ b/testcases/kernel/syscalls/fsync/fsync02.c
> @@ -102,7 +102,8 @@ int main(int ac, char **av)
>                 }
> 
>                 for (i = 1; i <= data_blocks; i++) {
> -                       offset = (i * BLOCKSIZE * max_block) /
> data_blocks - BUFSIZ;
> +                       offset = i * ((BLOCKSIZE * max_block) / data_blocks);
> +                       offset -= BUFSIZ;
>                         if ((offsetret = lseek(fd, offset, SEEK_SET)) != offset)
>                                 tst_brkm(TBROK|TERRNO, cleanup, "lseek
> failed: %ld, %ld", offsetret, offset);
>                         if ((ret = write(fd, pbuf, BUFSIZ)) != BUFSIZ)
> @@ -197,4 +198,4 @@ void cleanup()
> 
>         tst_rmdir();
> 
> -}
> \ No newline at end of file
> +}


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
