Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UxRSR-0001Ir-Hm
	for ltp-list@lists.sourceforge.net; Fri, 12 Jul 2013 00:43:35 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UxRSN-000312-En
	for ltp-list@lists.sourceforge.net; Fri, 12 Jul 2013 00:43:35 +0000
Message-ID: <51DF5134.8010308@cn.fujitsu.com>
Date: Fri, 12 Jul 2013 08:43:32 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1373532432-26471-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1445326660.2227578.1373533139274.JavaMail.root@redhat.com>
In-Reply-To: <1445326660.2227578.1373533139274.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] kmsg01: fix test failure caused by not compiling
	it
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On 07/11/2013 04:58 PM, Jan Stancek wrote:
> 
> 
> 
> ----- Original Message -----
>> > From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
>> > To: "LTP" <ltp-list@lists.sourceforge.net>
>> > Cc: jstancek@redhat.com, "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
>> > Sent: Thursday, 11 July, 2013 10:47:12 AM
>> > Subject: [PATCH] kmsg01: fix test failure caused by not compiling it
>> > 
>> > We didn't compile and install this case, so this case will
>> > fail by "No such file":
>> > 
>> > initiation_status="pan(26250): execvp of 'kmsg01' (tag kmsg01) failed.
>> > errno:2  No such file or directory"
>> > 
>> > Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Reviewed-by: Jan Stancek <jstancek@redhat.com>
> 
> Good catch, I made a full build and install to confirm it builds.

Pushed, thank you for your review.

Wanlong Gao

> 
> Thanks,
> Jan
> 


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
