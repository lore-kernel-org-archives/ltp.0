Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S4SwD-0007fu-1Z
	for ltp-list@lists.sourceforge.net; Mon, 05 Mar 2012 08:06:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S4Sw6-0001dI-MS
	for ltp-list@lists.sourceforge.net; Mon, 05 Mar 2012 08:06:33 +0000
Message-ID: <4F5473BF.6040204@cn.fujitsu.com>
Date: Mon, 05 Mar 2012 16:05:19 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1329994678-10121-1-git-send-email-filippo.arcidiacono@st.com>
	<4f50dbc8.a868320a.04b0.03b4SMTPIN_ADDED@mx.google.com>
	<4F547158.7050501@casparzhang.com>
In-Reply-To: <4F547158.7050501@casparzhang.com>
Subject: Re: [LTP] [PATCH v2] getrusage04: add opportunity to increase the
 max [us]time increment
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

On 03/05/2012 03:55 PM, Caspar Zhang wrote:

> On 03/02/2012 10:39 PM, Filippo ARCIDIACONO wrote:
>>> -----Original Message-----
>>> From: Filippo ARCIDIACONO [mailto:filippo.arcidiacono@st.com]
>>> Sent: Thursday, February 23, 2012 11:58 AM
>>> To: ltp-list@lists.sourceforge.net
>>> Cc: Filippo Arcidiacono; Salvatore Cro
>>> Subject: [PATCH v2] getrusage04: add opportunity to increase the max
>>> [us]time increment
>>>
>>> On slow systems it could be needed to increase the max value [us]time
>>> increment beetween two getrusage calls.
>>>
>>> Signed-off-by: Filippo Arcidiacono <filippo.arcidiacono@st.com>
>>> Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
>>> ---
> 
> ...
> 
>> Is this version ok for you, or there are any other comments?
> 
> I meet some `DOS line endings` errors when I am trying to merge this
> patch. Could you double check your patch with checkpatch.pl from kernel
> source tree? (or my mail client is broken :-(...



Hi Caspar:

You can pull this patch from http://github.com/gaowanlong/ltp master

Thanks
-Wanlong Gao

> 
> Thanks,
> Caspar
> 
> ------------------------------------------------------------------------------
> Try before you buy = See our experts in action!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-dev2
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
