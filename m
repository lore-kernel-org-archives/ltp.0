Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yxu@suse.de>) id 1P3Ox9-0004ZO-Si
	for ltp-list@lists.sourceforge.net; Wed, 06 Oct 2010 08:02:19 +0000
Message-ID: <4CAC2D03.3040001@suse.de>
Date: Wed, 06 Oct 2010 10:02:11 +0200
From: Yi Xu <yxu@suse.de>
MIME-Version: 1.0
References: <4CA9D1B2.7070107@suse.de>
	<AANLkTinZCKnwAofMwYU9iVsVog8K4TFxLttsfH5QL2e1@mail.gmail.com>
In-Reply-To: <AANLkTinZCKnwAofMwYU9iVsVog8K4TFxLttsfH5QL2e1@mail.gmail.com>
Subject: Re: [LTP] patch to define PTRACE_KILL and PTRACE_CONT
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
Cc: ltp-list@lists.sf.net

Hi,

I couldn't reproduce it. :(
You could ignore the patch.

thanks,
Yi
On 10/04/2010 03:48 PM, Garrett Cooper wrote:
> On Mon, Oct 4, 2010 at 6:08 AM, Yi Xu <yxu@suse.de> wrote:
>> Hi,
>>
>> this patch solves compiling error that appears with certain GCC version.
> 
> Hi Yi,
> 
> You most likely need to fix your headers or your compiler:
> 
> [gcooper@bayonetta /scratch/ltp]$ grep -r __PTRACE_KILL__ .
> [gcooper@bayonetta /scratch/ltp]$ grep -r __PTRACE_CONT__ .
> [gcooper@bayonetta /scratch/ltp]$
> 
> Nowhere in the sourcebase are those symbols defined / used (at least
> not directly).
> 
> Furthermore, rwatson@'s search indexer returns NIL for the symbol:
> 
> http://fxr.watson.org/fxr/trackident?v=linux-2.6;i=__PTRACE_KILL__
> 
> If you provided your error logs we might be able to help you...
> 
> Thanks,
> -Garrett

-- 
Yi Xu                           yxu@suse.de
SUSE LINUX Products GmbH        R&D-OPS-QA
Maxfeldstr. 5                   +49 (0)911-74053 - 607
D-90409 Nuernberg               http://www.suse.de

SUSE LINUX Products GmbH, GF: Markus Rex, HRB 16746 (AG Nuernberg)

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
