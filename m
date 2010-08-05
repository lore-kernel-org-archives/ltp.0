Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yaneurabeya@gmail.com>) id 1Oh07h-0003I3-9q
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 13:04:37 +0000
Received: from mail-px0-f175.google.com ([209.85.212.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oh07g-0007hq-Dy
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 13:04:37 +0000
Received: by pxi16 with SMTP id 16so288564pxi.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 05 Aug 2010 06:04:30 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1081)
From: Garrett Cooper <yaneurabeya@gmail.com>
In-Reply-To: <4C5A8B95.9020709@linux.vnet.ibm.com>
Date: Thu, 5 Aug 2010 06:04:26 -0700
Message-Id: <26A1127D-4C27-470E-B338-082790313597@gmail.com>
References: <1280829868-10286-1-git-send-email-harsh@linux.vnet.ibm.com>
	<AANLkTikOv_F0fVP2xqxJL1wz1zOrmpZiCXrcET8KZMe0@mail.gmail.com>
	<4C5A8B95.9020709@linux.vnet.ibm.com>
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
To: Harsh Bora <harsh@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Aug 5, 2010, at 2:59 AM, Harsh Bora wrote:

> On 08/03/2010 09:56 PM, Garrett Cooper wrote:
>> On Tue, Aug 3, 2010 at 3:04 AM, Harsh Prateek Bora
>> <harsh@linux.vnet.ibm.com>  wrote:
>>   
>>> Current testcase for setrlimit for parameter RLIMIT_FSIZE
>>> does not convey the number of bytes actually written from
>>> child process to parent, as the child process writes to its
>>> own copy of global variable. This patch introduces a pipe
>>> to send the information from child to the parent process.
>>>     
>> 1. The style's a bit wonky, but that might be the fault with how the
>> original test was written.
>>   
> So, what change do you suggest in the style? Can you be precise?

Sorry... there's a mixture of tabs and spaces (based on the patch provided) and we need to use straight tabs like Linux does.

>> 2. You aren't checking how many bytes are actually being read/written
>> in your patch but assuming that the stream `bytes' is correctly
>> written each time ;)...
>>   
> I hope you are talking about verifying expected number of bytes after reading/writing from pipe, shall do that.

Yes. read(2) and write(2) pass back the number of bytes read and written from a file descriptor. It's a common mistake that others have made in many LTP testcases, assuming that alll reads and writes will be successful...

Thanks!
-Garrett
------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
