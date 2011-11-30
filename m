Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RVeZw-0002Dq-Os
	for ltp-list@lists.sourceforge.net; Wed, 30 Nov 2011 07:27:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RVeZv-00017p-8f
	for ltp-list@lists.sourceforge.net; Wed, 30 Nov 2011 07:27:40 +0000
Message-ID: <4ED5DAA0.1070601@cn.fujitsu.com>
Date: Wed, 30 Nov 2011 15:26:24 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4ED31B4E.5030405@sx.jp.nec.com>
In-Reply-To: <4ED31B4E.5030405@sx.jp.nec.com>
Subject: Re: [LTP] ext4-online-defrag test doesn't work due to too old
 e4defrag command
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Kazuya Mio <k-mio@sx.jp.nec.com>
Cc: ltp-list@lists.sourceforge.net

Hi Kazuya:

> Hi,
> 
> I tried to test ext4-online-defrag, but it didn't work well due to
> the following errors:
> 
> ext4-online-defrag    0  TINFO  :  defrag type: 1, defrag obj: 2, block size: 1024
>  "/opt/ltp/testcases/bin/mnt_point/data0"
>         File is not regular file                [ NG ]
>         Failed to defrag:Bad file descriptor    [ NG ]
>         Failed to defrag:Bad file descriptor    [ NG ]
> <snip>
>         Failed to defrag:Bad file descriptor    [ NG ]
>         Failed to defrag:Bad file descriptor    [ NG ]
> ext4-online-defrag    2  TPASS  :  ext4 online defrag test pass
> 
> This is because e4defrag is too old to defrag the file in the latest kernel.
> I think we should use the latest e4defrag command that is contained in e2fsprogs.


Are you sure that the latest e4defrag can PASS? Did you test with it already?

Thanks
-Wanlong Gao

> 
> Regards,
> Kazuya Mio
> 
> ------------------------------------------------------------------------------
> All the data continuously generated in your IT infrastructure 
> contains a definitive record of customers, application performance, 
> security threats, fraudulent activity, and more. Splunk takes this 
> data and makes sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-novd2d
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
