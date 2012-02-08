Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Rv3DS-00034D-0z
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 08:49:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rv3DM-000292-FD
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 08:49:25 +0000
Message-ID: <4F3236CD.9070702@cn.fujitsu.com>
Date: Wed, 08 Feb 2012 16:48:13 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1328689302-5506-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1328689302-5506-2-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F3232EC.4030007@casparzhang.com>
	<4F32345F.5030909@cn.fujitsu.com>
	<4F323531.3060105@casparzhang.com>
In-Reply-To: <4F323531.3060105@casparzhang.com>
Subject: Re: [LTP] [PATCH v3 1/4] hugemmap01: auto mount the temporary dir
 for testing
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

On 02/08/2012 04:41 PM, Caspar Zhang wrote:

> On 02/08/2012 04:37 PM, Wanlong Gao wrote:
>>>> Hi, I just have another concern, that you might want to keep the initial
>>>> value of nr_hugepages and restore it once the test is done.
>>
>> as set_sys_tune defined in mem lib, this restore work should be done there,
>> too.
> 
> no, set_sys_tune only set the value and verify the content if the third
> parameter is setting to "1".
> 
> You should save the original value by using get_sys_tune in setup() and
> restore it in cleanup() by using set_sys_tune again.


Ah, OK. I will do.

Thanks
-Wanlong Gao

> 
> Thanks,
> Caspar
> 



------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
