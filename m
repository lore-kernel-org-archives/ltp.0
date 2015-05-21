Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1YvMmY-0006oh-T6
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2015 09:28:50 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YvMmS-0001Mv-TC
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2015 09:28:50 +0000
Message-ID: <555DA53C.10008@huawei.com>
Date: Thu, 21 May 2015 17:28:28 +0800
From: s00318865 <sunyuan3@huawei.com>
MIME-Version: 1.0
References: <1430827933-219682-1-git-send-email-cuibixuan@huawei.com>
	<555D8E94.20605@huawei.com>
In-Reply-To: <555D8E94.20605@huawei.com>
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
Content-Type: multipart/mixed; boundary="===============4600030550000222402=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net, peifeiyue@huawei.com

--===============4600030550000222402==
Content-Type: multipart/alternative;
	boundary="------------080209050406070206060703"

--------------080209050406070206060703
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 2015/5/21 15:51, Cui Bixuan wrote:
>
>
> -------- Original Message --------
> Subject: [LTP] [PATCH] commands/logrotate:run the case once again will failed
> Date: Tue, 5 May 2015 12:12:13 +0000
> From: Cui Bixuan <cuibixuan@huawei.com>
> To: <ltp-list@lists.sourceforge.net>
> CC: <lijinyue@huawei.com>, <zhanyongming@huawei.com>, <zhuyanpeng@huawei.com>, Cui Bixuan <cuibixuan@huawei.com>
>
> For the first time,case do 'logrotate -fv tst_logrotate.conf' that will
> create the 'half-rotated' file(messages-20150416.gz). When run case again,
> the case will fail:
> 'error: destination /var/log/messages-20150416.gz already exists,skipping
> rotation'
>
> 'Logrotate' does't expect to find an already existing "half-rotated" file
> (http://centos.1050465.n5.nabble.com/CentOS-Logrotate-errors-td5725868.html).
> Clean the "half-rotated" file,and the case will pass all the time.
>
> Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
> ---
>   testcases/commands/logrotate/logrotate_tests.sh |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
> index 2a793cc..5b14ca0 100755
> --- a/testcases/commands/logrotate/logrotate_tests.sh
> +++ b/testcases/commands/logrotate/logrotate_tests.sh
> @@ -191,6 +191,7 @@ test01()
>   	do
>   		rm -f $files > /dev/null 2>&1
>   	done
> +	rm -f /var/log/*`date '+%Y%m%d'`* > /dev/null 2>&1

If the current time is 23:59:59, a problem would occur. It is good to 
use the following command.
rm [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]
Of course, it is better if you can find a way to use regular expressions 
to match it.
>
>   	chmod 644 $LTPTMP/tst_logrotate.conf
>   	logrotate -fv $LTPTMP/tst_logrotate.conf > $LTPTMP/tst_logrotate.out 2>&1 \


--------------080209050406070206060703
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <div class="moz-cite-prefix">On 2015/5/21 15:51, Cui Bixuan wrote:<br>
    </div>
    <blockquote cite="mid:555D8E94.20605@huawei.com" type="cite">
      <pre wrap="">


-------- Original Message --------
Subject: [LTP] [PATCH] commands/logrotate:run the case once again will failed
Date: Tue, 5 May 2015 12:12:13 +0000
From: Cui Bixuan <a class="moz-txt-link-rfc2396E" href="mailto:cuibixuan@huawei.com">&lt;cuibixuan@huawei.com&gt;</a>
To: <a class="moz-txt-link-rfc2396E" href="mailto:ltp-list@lists.sourceforge.net">&lt;ltp-list@lists.sourceforge.net&gt;</a>
CC: <a class="moz-txt-link-rfc2396E" href="mailto:lijinyue@huawei.com">&lt;lijinyue@huawei.com&gt;</a>, <a class="moz-txt-link-rfc2396E" href="mailto:zhanyongming@huawei.com">&lt;zhanyongming@huawei.com&gt;</a>, <a class="moz-txt-link-rfc2396E" href="mailto:zhuyanpeng@huawei.com">&lt;zhuyanpeng@huawei.com&gt;</a>, Cui Bixuan <a class="moz-txt-link-rfc2396E" href="mailto:cuibixuan@huawei.com">&lt;cuibixuan@huawei.com&gt;</a>

For the first time,case do 'logrotate -fv tst_logrotate.conf' that will
create the 'half-rotated' file(messages-20150416.gz). When run case again,
the case will fail:
'error: destination /var/log/messages-20150416.gz already exists,skipping
rotation'

'Logrotate' does't expect to find an already existing "half-rotated" file
(<a class="moz-txt-link-freetext" href="http://centos.1050465.n5.nabble.com/CentOS-Logrotate-errors-td5725868.html">http://centos.1050465.n5.nabble.com/CentOS-Logrotate-errors-td5725868.html</a>).
Clean the "half-rotated" file,and the case will pass all the time.

Signed-off-by: Cui Bixuan <a class="moz-txt-link-rfc2396E" href="mailto:cuibixuan@huawei.com">&lt;cuibixuan@huawei.com&gt;</a>
---
 testcases/commands/logrotate/logrotate_tests.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
index 2a793cc..5b14ca0 100755
--- a/testcases/commands/logrotate/logrotate_tests.sh
+++ b/testcases/commands/logrotate/logrotate_tests.sh
@@ -191,6 +191,7 @@ test01()
 	do
 		rm -f $files &gt; /dev/null 2&gt;&amp;1
 	done
+	rm -f /var/log/*`date '+%Y%m%d'`* &gt; /dev/null 2&gt;&amp;1</pre>
    </blockquote>
    <div id="item_1432199513542" class="item"><br>
      <div id="item-body_1432199513542" class="item-body"><span
          id="im-content_1432199513542" class="im-content"><font
            style="FONT-SIZE: 14px" face="微软雅黑">If the current time is
            23:59:59, a problem would occur. It is good to use the following
            command.<br>
            rm [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]<br>
            Of course, it is better if you can find a way to use regular
            expressions to match it.<br>
          </font></span></div>
    </div>
    <blockquote cite="mid:555D8E94.20605@huawei.com" type="cite">
      <pre wrap="">

 	chmod 644 $LTPTMP/tst_logrotate.conf
 	logrotate -fv $LTPTMP/tst_logrotate.conf &gt; $LTPTMP/tst_logrotate.out 2&gt;&amp;1 \
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------080209050406070206060703--


--===============4600030550000222402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
--===============4600030550000222402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4600030550000222402==--

