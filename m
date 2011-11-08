Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RNg0c-0000G8-Py
	for ltp-list@lists.sourceforge.net; Tue, 08 Nov 2011 07:22:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RNg0a-0001fK-4Q
	for ltp-list@lists.sourceforge.net; Tue, 08 Nov 2011 07:22:14 +0000
Message-ID: <4EB8D85D.1060602@cn.fujitsu.com>
Date: Tue, 08 Nov 2011 15:21:01 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <f8f55a57-966a-4523-ae6a-94179b2636bc@zmail16.collab.prod.int.phx2.redhat.com>
In-Reply-To: <f8f55a57-966a-4523-ae6a-94179b2636bc@zmail16.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] recvmsg01: kill child only if one was forked
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 11/08/2011 03:14 PM, Jan Stancek wrote:

> 
> 
> ----- Original Message -----
>> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Tuesday, November 8, 2011 4:07:56 AM
>> Subject: Re: [LTP] [PATCH] recvmsg01: kill child only if one was forked
>>
>> On 11/07/2011 08:53 PM, Jan Stancek wrote:
>>
>>>
>>> If start_server() fails, then pid will end up with -1 and
>>> cleanup() will do kill(-1, SIGKILL), which kills everything
>>> this process can kill.
>>>
>>> Change the test to kill pid (child) only when it successfully
>>> creates one.
>>>
>>
>>
>> Yeah, but this can't fix the problem in this case?
>>
>> recvmsg01    1  TBROK  :  server bind failed: errno=???(98): Address
>> already in use
>> recvmsg01    2  TBROK  :  Remaining cases broken
>>
> 
> I'm not sure I follow you here.
> In case you described start_server() returns -1,
> so pid = -1, and cleanup won't do kill(-1, SIGKILL).
> 


Yeah, I understood you.

But we wanna fix the case to TPASS but not TBROK, do we?
So, I mean that the issues of this case is not only what you said.

Thanks
-Wanlong Gao

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
