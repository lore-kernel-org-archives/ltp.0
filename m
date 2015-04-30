Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1Ynkon-0006i2-1o
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 09:31:41 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ynkoj-0005oJ-A0
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 09:31:41 +0000
Message-ID: <5541F669.6020302@huawei.com>
Date: Thu, 30 Apr 2015 17:31:21 +0800
From: Cui Bixuan <cuibixuan@huawei.com>
MIME-Version: 1.0
References: <55418B02.3080104@huawei.com>
	<1430384287-16073-1-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1430384287-16073-1-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 0/3] commands/fileutils/mv: cleanup and add new
	test
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
Cc: ltp-list@lists.sourceforge.net

On 2015/4/30 16:58, Zeng Linggang wrote:
> Hi, Mr Cui
> 
> I have written some patches for mv tests(some cleanup and add new test),
> that maybe save your some time.
The patches look very nice (smile).

Thanks,
Cui Bixuan

> 
>  testcases/commands/fileutils/mv/mv_tests.sh | 263 ++++++++--------------------
>  1 file changed, 73 insertions(+), 190 deletions(-)
>  testcases/commands/fileutils/mv/00_Descriptions.txt | 3 ---
>  1 file changed, 3 deletions(-)
>  testcases/commands/fileutils/mv/mv_tests.sh | 40 ++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> Best regards,
> zeng
> 


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
