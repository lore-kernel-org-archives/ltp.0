Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZC7Ne-0005Tp-6N
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2015 14:28:22 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZC7Nd-0005Kb-Bv
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2015 14:28:22 +0000
Message-ID: <559A9148.8060200@oracle.com>
Date: Mon, 06 Jul 2015 17:31:36 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1430827933-219682-1-git-send-email-cuibixuan@huawei.com>
	<5593E172.1050800@huawei.com> <5593F4E2.1040804@oracle.com>
	<55952961.30906@huawei.com> <5595490E.1010509@oracle.com>
	<55974D10.5050808@huawei.com>
In-Reply-To: <55974D10.5050808@huawei.com>
Subject: Re: [LTP] [PATCH] commands/logrotate:run the case once again will
 failed
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: zhuyanpeng@huawei.com, ltp-list@lists.sourceforge.net, zhanyongming@huawei.com

Hi,
On 07/04/2015 06:03 AM, Cui Bixuan wrote:
> Hi,
> Your method is better than mine (I learned that how to use logrotate command again yesterday and
> found that remove messages-* is not a good idea).
>
> We can remove 'include /etc/logrotate.d' and delete 'grep including /etc/logrotate.d $LTPTMP/tst_logrotate.out'
> in case to fix it, what do you think?  If ok, I will send a new patch.

OK.

> In addition, I have a question, Why including the rules in /etc/logrotate.d/ will cause the case failed
> when run it at the second time?

You have already written the explanation -  it failed because file with 
the same name exists. Moreover, I can't reproduce it in my system. You 
should check what kind of rules do you have for "/var/log/messages" in 
/etc/logrotate.d/.

Thanks,
Alexey

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
