Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri187-00070N-4D
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 09:58:03 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri186-0006js-3a
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 09:58:03 +0000
Message-ID: <4F02D122.7090704@imgtec.com>
Date: Tue, 3 Jan 2012 09:57:54 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <4F02CBDE.70400@imgtec.com>
	<CAGH67wSFbMM+3Dr_pe=_+w_B4Su6p6wZ42LpP5vUwVE1hiH6QQ@mail.gmail.com>
In-Reply-To: <CAGH67wSFbMM+3Dr_pe=_+w_B4Su6p6wZ42LpP5vUwVE1hiH6QQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH 02/21] lib/self_exec: Remove extra argument from
 tst_resm function call
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

On 01/03/2012 09:50 AM, Garrett Cooper wrote:
> On Tue, Jan 3, 2012 at 1:35 AM, Markos Chandras
> <Markos.Chandras@imgtec.com>  wrote:
>> Hi, please review the attached patch
>
>      Converting the function to tst_brkm and removing the tst_exit call
> below it would be better.
> Thanks!
> -Garrett
Agreed, but to make this consistent, all the tst_resm && tst_exit pairs 
should be replaced with tst_brkm. I will prepare a patch

-- 
markos


------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
