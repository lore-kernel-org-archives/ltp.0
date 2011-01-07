Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PbB3n-0005qL-Ow
	for ltp-list@lists.sourceforge.net; Fri, 07 Jan 2011 12:04:47 +0000
Received: from mail-px0-f175.google.com ([209.85.212.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PbB3m-0000fW-Ry
	for ltp-list@lists.sourceforge.net; Fri, 07 Jan 2011 12:04:47 +0000
Received: by pxi17 with SMTP id 17so3458091pxi.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 07 Jan 2011 04:04:41 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <AANLkTinFbVBZtA_hCfRqTK=sZW+ZBSi3KbjA7Butkfum@mail.gmail.com>
Date: Fri, 7 Jan 2011 04:04:34 -0800
Message-Id: <F3972A55-1F53-4B70-A858-E041E01F246D@gmail.com>
References: <4D259E4A.2050704@cn.fujitsu.com>
	<AANLkTinX9M3EsBxSDsVy56iKqskSWKQE4vMhXy0kcxNG@mail.gmail.com>
	<20B25B11-E8BD-45A7-AAD5-209D62BC6274@gmail.com>
	<AANLkTi=L8Vai5_=fn0psJeovura_Y=VjdN28ufiqBiiA@mail.gmail.com>
	<AANLkTin-yaUcPd8GZHgWnoYkxpOxDFs4enEik8afaeEc@mail.gmail.com>
	<AANLkTinFbVBZtA_hCfRqTK=sZW+ZBSi3KbjA7Butkfum@mail.gmail.com>
Subject: Re: [LTP] [PATCH 00/13]Fix a few syntax error
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Jan 6, 2011, at 1:46 PM, Mike Frysinger wrote:

> On Thu, Jan 6, 2011 at 4:38 PM, Garrett Cooper wrote:
>> On Thu, Jan 6, 2011 at 1:30 PM, Mike Frysinger wrote:
>>> On Thu, Jan 6, 2011 at 2:35 PM, Garrett Cooper wrote:
>>>> A really bad merge (I posted a reply to it a while ago in the archives).
>>> 
>>> is there a way for us to manage the git hooks ?  we could have them
>>> reject trivial merge commits (ones that should be fast forwards), and
>>> commits with merge cruft in it ...
>> 
>>   This was nastier. A lot of the problems I caused was ignorance and
>> human error based -- in particular I thought that git reset --hard
>> would actually reset merges (but it didn't!)
> 
> sure it will ... you just have to reset to before the merge
> 
>> I didn't bother to fake the push before I did it and the rest is history.
> 
> if you caught it soon, you could have pushed up an old one and forced
> it back to the sane state ...
> git push --force origin <older commit>:refs/head/master
> 
>> So I don't know if adding hooks would fix that
> 
> i saw that you had actual conflicts in there, and the hook would have
> caught that (">>>>>>>>>" and "=========" and such)
> 
> but i'm not sure if your non-trivial merge would have been detected as
> a trivial merge since we dont want that (it'd prevent people from
> being able to pull a branch from someone else)

	Ok -- good to note for next time I guess. I fixed all of the compilation errors so now people can report runtime issues. There are a handful of them.
Thanks,
-Garrett


------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
