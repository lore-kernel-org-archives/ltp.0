Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Xr0Qq-0001gJ-RH
	for ltp-list@lists.sourceforge.net; Wed, 19 Nov 2014 08:16:08 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xr0Qp-0001di-NB
	for ltp-list@lists.sourceforge.net; Wed, 19 Nov 2014 08:16:08 +0000
Message-ID: <546C51BA.5060304@oracle.com>
Date: Wed, 19 Nov 2014 11:15:54 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <20141031133917.GA3195@localhost.localdomain>	<54608048.4000201@oracle.com>
	<20141113075747.GA19392@localhost.localdomain>
In-Reply-To: <20141113075747.GA19392@localhost.localdomain>
Subject: Re: [LTP] chown and 16 bit syscall testing
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
To: ltp-list@lists.sourceforge.net



On 11/13/2014 10:57 AM, Han Pingtian wrote:
> On Mon, Nov 10, 2014 at 12:07:20PM +0300, Stanislav Kholmanskikh wrote:
>> Hi!
>>
>> On 10/31/2014 04:39 PM, Han Pingtian wrote:
>>> Hey there,
>>>
>>> I found that looks like all chown test cases will be compiled to 16 bit
>>> compat test case, but they just call chown() something like
>>>
>>>      TEST(chown(fname, uid, gid));
>>>
>>> which won't test if there is a 16 bit chown() syscall. I think maybe we
>>> should change it to something like below:
>>>
>>>      TEST(CHOWN(fname, uid, guid));
>>>
>>> then define CHOWN like this
>>>
>>>      UID_T CHOWN(void (cleanup)(void))
>>>      {
>>>              LTP_CREATE_SYSCALL(chown, cleanup);
>>>      }
>>>
>>> ?
>>
>> I think, this is a good idea.
>>
>> And there are more such test cases, which are not fixed for the 16-bit
>> compat case. For example, setresuid.
>>
>> So if it's possible, fixing them will be good as well;)
>>
> Looks like those cases need to be fixed for the 16-bit compat, right?
>
> chown0[1-5] fchown0[1-5] lchown03 setresgid0[1-4] setresuid0[1-3,5]

Looks so.

Sorry for the late response.

>
>
> ------------------------------------------------------------------------------
> Comprehensive Server Monitoring with Site24x7.
> Monitor 10 servers for $9/Month.
> Get alerted through email, SMS, voice calls or mobile push notifications.
> Take corrective actions from your mobile device.
> http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
