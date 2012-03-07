Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S55Hm-0004T2-Vt
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 01:03:22 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S55Hl-0004cX-A2
	for ltp-list@lists.sourceforge.net; Wed, 07 Mar 2012 01:03:22 +0000
Message-ID: <4F56B39A.1080709@cn.fujitsu.com>
Date: Wed, 07 Mar 2012 09:02:18 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1331029739-32353-1-git-send-email-markos.chandras@imgtec.com>
	<CAGH67wTM0b+USqri2yCpUOcnKi2ma7OamuOM81dRP5YGCm6poA@mail.gmail.com>
In-Reply-To: <CAGH67wTM0b+USqri2yCpUOcnKi2ma7OamuOM81dRP5YGCm6poA@mail.gmail.com>
Subject: Re: [LTP] [PATCH] runltp: Remove excess quotes from final message
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
To: Markos Chandras <markos.chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

On 03/06/2012 10:45 PM, Garrett Cooper wrote:

> On Tue, Mar 6, 2012 at 2:28 AM, Markos Chandras
> <markos.chandras@imgtec.com> wrote:
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>>  runltp |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/runltp b/runltp
>> index 4ef8b38..fc3515b 100755
>> --- a/runltp
>> +++ b/runltp
>> @@ -948,11 +948,11 @@ main()
>>     {
>>     cat <<-EOF >&1
>>
>> -       ###############################################################"
>> +       ###############################################################
>>
>> -            Done executing testcases."
>> +            Done executing testcases.
>>             LTP Version:  $version_date
>> -       ###############################################################"
>> +       ###############################################################
>>
>>        EOF
>>     }
> 
> Reviewed-by: Garrett Cooper <yanegomi@gmail.com>


Picked to my tree, thanks

-Wanlong Gao

> 
> ------------------------------------------------------------------------------
> Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-d2d
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
