Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <harsh@linux.vnet.ibm.com>) id 1OgxF4-0005qP-Lo
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 10:00:02 +0000
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OgxF2-0005VD-2J
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 10:00:02 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id o759tmE4028194
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Aug 2010 19:55:48 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o759xqCr1233054
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Aug 2010 19:59:52 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o759xp9c020826
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Aug 2010 19:59:52 +1000
Message-ID: <4C5A8B95.9020709@linux.vnet.ibm.com>
Date: Thu, 05 Aug 2010 15:29:49 +0530
From: Harsh Bora <harsh@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <1280829868-10286-1-git-send-email-harsh@linux.vnet.ibm.com>
	<AANLkTikOv_F0fVP2xqxJL1wz1zOrmpZiCXrcET8KZMe0@mail.gmail.com>
In-Reply-To: <AANLkTikOv_F0fVP2xqxJL1wz1zOrmpZiCXrcET8KZMe0@mail.gmail.com>
Subject: Re: [LTP] [PATCH] setrlimit testcase fix
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

On 08/03/2010 09:56 PM, Garrett Cooper wrote:
> On Tue, Aug 3, 2010 at 3:04 AM, Harsh Prateek Bora
> <harsh@linux.vnet.ibm.com>  wrote:
>    
>> Current testcase for setrlimit for parameter RLIMIT_FSIZE
>> does not convey the number of bytes actually written from
>> child process to parent, as the child process writes to its
>> own copy of global variable. This patch introduces a pipe
>> to send the information from child to the parent process.
>>      
> 1. The style's a bit wonky, but that might be the fault with how the
> original test was written.
>    
So, what change do you suggest in the style? Can you be precise?
> 2. You aren't checking how many bytes are actually being read/written
> in your patch but assuming that the stream `bytes' is correctly
> written each time ;)...
>    
I hope you are talking about verifying expected number of bytes after 
reading/writing from pipe, shall do that.
> Thanks,
> -Garrett
>    


------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
