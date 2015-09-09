Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xcf733520@sina.com>) id 1ZZZKZ-0007ZV-26
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2015 06:58:07 +0000
Received: from mail3-164.sinamail.sina.com.cn ([202.108.3.164]
	helo=smtp545-121.mail.sina.com.cn)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1ZZZKP-0006oQ-T4
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2015 06:58:07 +0000
Date: Wed, 9 Sep 2015 14:56:35 +0800
From: xcf733520 <xcf733520@sina.com>
References: <201509081939589887103@sina.com>, 
	<55EED49C.8080309@oracle.com>
Mime-Version: 1.0
Message-ID: <201509091456312784422@sina.com>
Subject: Re: [LTP] about testscript run
Reply-To: xcf733520 <xcf733520@sina.com>
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>


>
>Hi,
>On 09/08/2015 02:39 PM, xcf733520 wrote:
>> Hi all,
>>
>>       I try to run testscript in the directory of /opt/ltp/testscripts, when try networkstress.sh/networktests.sh  it show as below,
>>
>>       ./network.sh: line 5: test_net.sh: No such file or directory
>
>test_net.sh script should be in the PATH. Usually, installation 
>directory /opt/ltp/testcases/bin is set to the PATH. Then you can run 
>./networktests.sh.
>
>Alternatively, you can try to set the PATH to networkstress.sh or 
>networktests.sh:
>
>$ PATH=/opt/ltp/testcases/bin:$PATH ./networktests.sh
>
>Thanks,
>Alexey
>
>
>

Hi Alexey,
  Thanks for your help, add the $PATH "PATH=/opt/ltp/testcases/bin:$PATH" , it can be run normally. 
------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
