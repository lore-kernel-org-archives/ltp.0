Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SGBsh-0007Uz-IW
	for ltp-list@lists.sourceforge.net; Fri, 06 Apr 2012 16:19:23 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SGBsg-0006Nb-ON
	for ltp-list@lists.sourceforge.net; Fri, 06 Apr 2012 16:19:23 +0000
Received: by dadz9 with SMTP id z9so3485075dad.33
	for <ltp-list@lists.sourceforge.net>;
	Fri, 06 Apr 2012 09:19:16 -0700 (PDT)
Message-ID: <4F7F177C.50100@casparzhang.com>
Date: Sat, 07 Apr 2012 00:19:08 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <alpine.BSF.2.00.1204032222300.25027@toaster.local>
	<201204042028.52373.vapier@gentoo.org>
	<alpine.BSF.2.00.1204041732320.25027@toaster.local>
	<201204042149.20439.vapier@gentoo.org>
	<CAGH67wQcNtAkP4aMmGELSyEavEx-AbWqhjJxd_M-mh-u6qdn+w@mail.gmail.com>
In-Reply-To: <CAGH67wQcNtAkP4aMmGELSyEavEx-AbWqhjJxd_M-mh-u6qdn+w@mail.gmail.com>
Subject: Re: [LTP] [PATCH 0/4] Replace commonly used perl tools with awk
	equivalents
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
Cc: LTP list <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

On 04/06/2012 11:34 AM, Garrett Cooper wrote:
> On Wed, Apr 4, 2012 at 6:49 PM, Mike Frysinger <vapier@gentoo.org> wrote:
>> On Wednesday 04 April 2012 20:33:40 Garrett Cooper wrote:
>>> On Wed, 4 Apr 2012, Mike Frysinger wrote:
>>>> On Wednesday 04 April 2012 15:18:53 Garrett Cooper wrote:
>>>>> On Wed, Apr 4, 2012 at 10:54 AM, Mike Frysinger wrote:
>>>>>> On Wednesday 04 April 2012 13:31:10 Garrett Cooper wrote:
>>>>>>> On Wed, Apr 4, 2012 at 10:22 AM, Mike Frysinger wrote:
>>>>>>>> On Wednesday 04 April 2012 01:23:43 Garrett Cooper wrote:
>>>>>>>>> The intent behind these changes are to remove unnecessary perl
>>>>>>>>> dependencies in LTP by using awk in its stead. It was something that
>>>>>>>>> was discussed a while ago on ltp-list@.
>>>>>>>>
>>>>>>>> i like awk over perl a lot.  my only concern is non-POSIX stuff
>>>>>>>> slipping in (such as people who have gawk installed).  should we add
>>>>>>>> a local wrapper script that sees if the awk accepts a --posix flag
>>>>>>>> and automatically pass it ?
>>>>>>>
>>>>>>> That's actually a gawk-ism :)...
>>>>>>
>>>>>> yes, that's why i phrased it "if the awk accepts"
>>>>>>
>>>>>> awk --help | grep -q -e --posix && args="${args} --posix"
>>>>>
>>>>> This makes sense and it would protect against gawk'isms, but not other
>>>>> *awk-isms.
>>>>
>>>> sure, but some protection is better than none.  if other awks have
>>>> similar knobs, we can leverage them too.
>>>
>>> Agreed, but this should be handled in other commits, right?
>>
>> sure, i'm not saying let's hold up the conversion from perl.  but we should do
>> it at some point imo.
> 
>     Are there any objections to the proposed [final?] patches I
> submitted for this patch set?
> Thanks!

looks good to me.

Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
