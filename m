Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S8TxC-0002tW-NU
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 10:00:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S8Tx6-0002Gp-Ld
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 10:00:10 +0000
Message-ID: <4F630EE2.60108@cn.fujitsu.com>
Date: Fri, 16 Mar 2012 17:58:58 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F58E36E.5000306@casparzhang.com>
	<4F594DE2.4040603@cn.fujitsu.com>
	<4F62EB70.7010400@casparzhang.com>
	<3985A069-7EF2-4014-9016-E0B2BB9288EE@gmail.com>
In-Reply-To: <3985A069-7EF2-4014-9016-E0B2BB9288EE@gmail.com>
Subject: Re: [LTP] [RFC] make mce-test a submodule
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "andi.kleen@intel.com" <andi.kleen@intel.com>, "ying.huang@intel.com" <ying.huang@intel.com>, LTP list <ltp-list@lists.sourceforge.net>

On 03/16/2012 05:53 PM, Garrett Cooper wrote:

> On Mar 16, 2012, at 12:27 AM, Caspar Zhang <caspar@casparzhang.com> wrote:
> 
>> Hi all, I'll merge this change to master if I don't hear any objections
>> from you by today.
>>
>>
>> On 03/09/2012 08:25 AM, Wanlong Gao wrote:
>>> On 03/09/2012 12:50 AM, Caspar Zhang wrote:
>>>
>>>> Hi Garrett, Andi, and all:
>>>>
>>>> When I looked into current LTP tree, I found it a little messy due to
>>>> some mce-test stuff, such as
>>>>
>>>>  - mce-test docs goes to $TOPDIR/README, and
>>>>  - some mce-test files still lying under testcase/mce-test/.
>>>>
>>>> I think we need a cleanup for it.
>>>
>>>
>>> yes, I think so.
>>>
>>>>
>>>> Also an idea comes to my mind, that we can try to make mce-test a
>>>> submodule of LTP.
>>>
>>>
>>> Not a bad idea.
>>>
>>>>
>>>> I am also thinking about the pros and cons:
>>>>
>>>> pro(s):
>>>>  - easier for code maintenance, no need to sync periodically from
>>>> maintainer side
>>>>
>>>> con(s):
>>>>  - two extra steps added for LTP users, they have to do:
>>>>    $ git submodule init
>>>>    $ git submodule update
>>>> to enable using mce-test.
>>>>
>>>> mce-test could no longer be found at kernel.org, so I cloned it from
>>>> Andi's github repo, not sure if it is the right place:
>>>>
>>>>    git://github.com/andikleen/mce-test.git
>>>
>>>
>>> The tree seems just a few update every month now, I wonder why intel guys
>>> didn't sync the commits to LTP ?
>>>
>>>>
>>>> I have made this change to my personal LTP fork, you can review it here:
>>>>
>>>>    https://github.com/casparant/ltp/commit/5cca17f633
>>>
>>>
>>> The patch loooks good.
>>
>> Wanlong, thanks for review.
> 
> The goals for the patch are good and what I briefly looked over looked ok too. Can you pull certain versions of the mce-test submodule, or is it always HEAD?
> 


I think the submodule head should be pulled by hand every time the mce tree updated.

Thanks,
Wanlong Gao

> Thanks!
> -Garrett



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
