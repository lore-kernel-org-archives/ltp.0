Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lizf@cn.fujitsu.com>) id 1P5vru-0001y3-GP
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 07:35:22 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5vrt-0004RF-GR
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 07:35:22 +0000
Message-ID: <4CB5615C.4070406@cn.fujitsu.com>
Date: Wed, 13 Oct 2010 15:35:56 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
References: <4C85A88D.10700@cn.fujitsu.com>		<1285689961.11429.12.camel@subratamodak.linux.ibm.com>	<1286954486.4893.15.camel@subratamodak.linux.ibm.com>
	<4CB55FE6.6000604@cn.fujitsu.com>
In-Reply-To: <4CB55FE6.6000604@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] Add ftrace-stress-test to LTP
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

Li Zefan wrote:
> Subrata Modak wrote:
>> Li,
>>
>> Can you kindly fix the below issues and send me a new patch ?
>>
> 
> Sure, I will.
> 

At a first glance, the kernel bug doesn't seem to come from ftrace,
at least not directly from it.

Question:

Can you trigger this bug in latest kernel (2.6.36-rc7)? If you
haven't tried it, could you test it? Thanks!


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
