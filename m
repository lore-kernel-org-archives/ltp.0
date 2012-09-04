Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1T8oje-0003lw-Vd
	for ltp-list@lists.sourceforge.net; Tue, 04 Sep 2012 08:43:50 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T8oja-0000nh-NN
	for ltp-list@lists.sourceforge.net; Tue, 04 Sep 2012 08:43:50 +0000
Message-ID: <5045BEBA.80901@cn.fujitsu.com>
Date: Tue, 04 Sep 2012 16:41:30 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1344508258-25054-1-git-send-email-kai.kang@windriver.com>
	<1344508258-25054-3-git-send-email-kai.kang@windriver.com>
	<504592C6.8060100@cn.fujitsu.com> <5045BB7D.7050502@windriver.com>
In-Reply-To: <5045BB7D.7050502@windriver.com>
Subject: Re: [LTP] [PATCH 2/3] mq_open/16-1: use tmp file to share info
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Zhenfeng.Zhao@windriver.com

On 09/04/2012 04:27 PM, Kang Kai wrote:
> 
> Hi Wanlong,
> 
>> Why not use anonymous map? in that case you will not need to create a file.
> 
> It seems MAP_ANONYMOS is not specified in POSIX specification.

OK, but in this case, you should think about Jan's question about SIGBUS now.

Thanks,
Wanlong Gao

> 
> Regards,
> Kai


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
