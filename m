Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SWOa6-0000xX-Kq
	for ltp-list@lists.sourceforge.net; Mon, 21 May 2012 09:07:10 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SWOa1-0008JI-87
	for ltp-list@lists.sourceforge.net; Mon, 21 May 2012 09:07:10 +0000
Received: by yhjj56 with SMTP id j56so5009428yhj.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 21 May 2012 02:06:59 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1257)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4FBA047D.7070703@cn.fujitsu.com>
Date: Mon, 21 May 2012 02:06:55 -0700
Message-Id: <78627B6C-762E-4643-8E2D-38D2BF6B3332@gmail.com>
References: <1337589516-9731-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<DC37D748-ECAA-4E0D-886F-7119C7F007CE@gmail.com>
	<4FBA047D.7070703@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] getcpu: remove the useless and improper kernel
	version check
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

On May 21, 2012, at 2:01 AM, Wanlong Gao wrote:

> On 05/21/2012 04:55 PM, Garrett Cooper wrote:
> 
>> On May 21, 2012, at 1:38 AM, Wanlong Gao wrote:
>> 
>>> Now, kernel version up to 3.x, check for 2.6.x is useless.
>> 
>> I don't agree with this statement. LTP needs to be usable on 2.6.x for at least 2 years after 3.x's inception.
>> 
>>> Additionally, we already checked the kernel version in the
>>> program itself.
>>> Meanwhile, check the kernel version at compiling time is wrong,
>>> we may not do testing on the same machine as compiling.
>> 
>> Agreed. I think that this check was incorrectly implemented. Furthermore, this causes confusion when the test case doesn't exist; it's better to stub out the test case in the source.
>> 
>> I would just remove the first line -- the rest of the info is valid.
> 
> You mean the commit log?

Yeah..
-Garrett


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
