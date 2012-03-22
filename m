Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1SAf4s-0006d2-7F
	for ltp-list@lists.sourceforge.net; Thu, 22 Mar 2012 10:17:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SAf4l-0001Yp-Pj
	for ltp-list@lists.sourceforge.net; Thu, 22 Mar 2012 10:17:06 +0000
Message-ID: <4F6AFC0E.8090405@cn.fujitsu.com>
Date: Thu, 22 Mar 2012 18:16:46 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <20120322132353.AB97.38390934@jp.panasonic.com>
	<4F6AE07A.4050509@cn.fujitsu.com>
	<20120322183640.ABAE.38390934@jp.panasonic.com>
In-Reply-To: <20120322183640.ABAE.38390934@jp.panasonic.com>
Subject: Re: [LTP] [PATCH] mq_timedreceive: 10-2.c: check timeout error
 rather than invalid parameter error
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
To: Akira Takeuchi <takeuchi.akr@jp.panasonic.com>
Cc: ltp-list@lists.sourceforge.net


Akira Takeuchi said the following on 2012-3-22 17:36:
>>> On the other hand, actually, timeout error should not be returned when message
>>> can be performed immediately.
>>>
>>
>> POSIX spec does not say this, so I think it is not necessary to check timeout error.
> 
> Really ? POSIX spec describes as below:
> 
>   Under no circumstance shall the operation fail with a timeout
>   if a message can be removed from the message queue immediately.
> 
>   http://pubs.opengroup.org/onlinepubs/009604499/functions/mq_receive.html
> 
> My reading of this is that timeout error must not be returned
> when message can be performed immediately. What do you think of it ?
> 

Yeah.
I am sorry missing it:(

The patch looks good.

-- 
Best Regards,
Peng

> 
> Regards,
> Akira Takeuchi
> 
> 
> 



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
