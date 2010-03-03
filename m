Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NmnDW-00076q-L4
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 11:58:18 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NmnDU-0006Ye-Er
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 11:58:18 +0000
Received: by pwi5 with SMTP id 5so735939pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Mar 2010 03:58:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100303105028.GC23601@linux.vnet.ibm.com>
References: <4B8E3C08.2080901@in.ibm.com>
	<20100303105028.GC23601@linux.vnet.ibm.com>
Date: Wed, 3 Mar 2010 03:58:10 -0800
Message-ID: <364299f41003030358n1efb1bf4p2b94d8d099779976@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Version file from Feb LTP release still contains 20100131
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
To: Sachin Sant <sachinp@in.ibm.com>, ltp-list@lists.sourceforge.net, yanegomi@gmail.com

On Wed, Mar 3, 2010 at 2:50 AM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Wed, Mar 03, 2010 at 04:08:00PM +0530, Sachin Sant wrote:
>> Not a major issue, but noticed something with latest LTP tarball
>> from Feb.
>
> Actually the script design is like that, it will update the version file
> once you compiled and build, reading from Changelog.
>
> Can you confirm if you are not having Changelog starting from :
> LTP-20100228 .
>
> Mostly it will not be there as you would have extracted next branch. But
> it will be always available with master branch.
>
> Thanks
> Rishi
>>
>> The Version file still contains 20100131.
>>
>> :/home/sachin/work # cat ltp-full-20100228/Version LTP-20100131
>> :/home/sachin/work #
>>
>> Should this be 20100228 ?

Uh, ChangeLog wasn't updated for last month's commits like Subrata
normally does...
HTH,
-Garrett

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
