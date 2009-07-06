Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MNrtf-0000iO-VM
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 17:22:31 +0000
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNrtf-00011g-G3
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 17:22:31 +0000
MIME-Version: 1.0
In-Reply-To: <4A51E745.3060105@linux.vnet.ibm.com>
References: <4A51CEDC.6080605@linux.vnet.ibm.com> <4A51E253.200@st.com>
	<4A51E745.3060105@linux.vnet.ibm.com>
Date: Mon, 6 Jul 2009 10:22:30 -0700
Message-ID: <364299f40907061022u669a8644k722afed62f69339f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] cgroups: conditionally enable building cgroup
	tests
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
To: gowrishankar <gomuthuk@linux.vnet.ibm.com>
Cc: ltp-list@lists.sf.net

On Mon, Jul 6, 2009 at 5:00 AM, gowrishankar<gomuthuk@linux.vnet.ibm.com> wrote:
> Hi Francesco,
>
> Francesco RUNDO wrote:
>> Hi Gowri,
>>
>> I've already fixed the same issue you reported. I've tested it successfully.
>>
>> Subrata has already merged my patch (please, find it in attachment).
>>
>> Please, check it before to submit another patch.
>>
>
> I had already seen your patch and generated mine on top of Jun release (which
> has your fix for CROSS_COMPILE).Your patch could not help in a scenario where
> kernel has cgroup support but cgroupstat.h file is missing in base OS, and
> build failed. And hence, I am proposing this patch.

It sounds like your issue is build related on your side, or the fact
that whatever checks are run don't appropriately take into account
necessary CFLAGS / CPPFLAGS.
Thanks,
-Garrett

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
