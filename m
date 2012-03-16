Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S8VBH-0000fs-Hj
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 11:18:47 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S8VBG-0004iu-8u
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 11:18:47 +0000
Received: by dado14 with SMTP id o14so6802838dad.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Mar 2012 04:18:40 -0700 (PDT)
Message-ID: <4F632142.5040306@casparzhang.com>
Date: Fri, 16 Mar 2012 19:17:22 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F58E36E.5000306@casparzhang.com>
	<4F594DE2.4040603@cn.fujitsu.com>
	<4F62EB70.7010400@casparzhang.com>
	<3985A069-7EF2-4014-9016-E0B2BB9288EE@gmail.com>
In-Reply-To: <3985A069-7EF2-4014-9016-E0B2BB9288EE@gmail.com>
Subject: Re: [LTP] [RFC] make mce-test a submodule
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

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

After `git submodule update`, it's always HEAD of mce-test.git

Actually, we don't store any files in LTP tree if mce-test becomes a
submodule. A user need to execute "git submodule init && git submodule
update" manually after cloning LTP if he wants to see mce-test sources
inside LTP tree. If he needs to run mce-test with certain version, he
can just do git checkout <mce-test-commit> insides
testcases/kernel/mce-test/;

This would be a problem when doing release, git archive cannot include
submodules, so we need to manually move mce-test sources into released
package.

Thanks,
Caspar

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
