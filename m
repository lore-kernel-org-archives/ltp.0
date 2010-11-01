Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <guijianfeng@cn.fujitsu.com>) id 1PCpJk-0003j5-49
	for ltp-list@lists.sourceforge.net; Mon, 01 Nov 2010 08:00:36 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PCpJi-0005sb-Eh
	for ltp-list@lists.sourceforge.net; Mon, 01 Nov 2010 08:00:36 +0000
Message-ID: <4CCE73A6.9020901@cn.fujitsu.com>
Date: Mon, 01 Nov 2010 16:00:38 +0800
From: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
MIME-Version: 1.0
References: <000001cb798d$1aaa0210$4ffe0630$@co.jp>
	<AANLkTiktyyfpSX+ZkOucGCNg2vSajcVPQ8Q60z4Uj8kh@mail.gmail.com>
In-Reply-To: <AANLkTiktyyfpSX+ZkOucGCNg2vSajcVPQ8Q60z4Uj8kh@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix "sigaction" tests
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
Cc: ltp-list@lists.sourceforge.net, =?UTF-8?B?55W25bqnIOWBpeW4gg==?= <toza@ryobi.co.jp>, Mitani <mitani@ryobi.co.jp>

Garrett Cooper wrote:
> 2010/10/31 Mitani <mitani@ryobi.co.jp>:
...
>>  int main()
>>  {
>> @@ -133,6 +152,12 @@
>>
>>        struct sigaction sa;
>>
>> +       /* Checking for Kernel Version */
>> +       if ( kernel_ver_cmp(2, 6, 21) != 0 )
>> +       {
>> +               UNTESTED( "sem_wait() returned EINTR on kernel versions
>> lower than 2.6.22" );
>> +       }
>> +
>>        /* Initialize output */
>>        output_init();
>>
>> ============
>>
>> Above patch is revision only for templates.
>> The following procedure is necessary after applying patch:
>> ------------
>> #cd testcases/open_posix_testsuite/conformance/interfaces/sigaction/
>> #./gentests.pl
>> ------------
>>
>> Similar revisions are necessary for other 25 "sigaction" tests.
> 
>     Sorry, but Linux-isms can't leak into the open_posix_testsuite.
> Same with BSDisms (at least they shouldn't... if they do, then slap me
> or whoever did the commit).

Do you mean the culprit is Linux-isms?
IMO, the test cases are good.

Gui

> Thanks!
> -Garrett
> 

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
