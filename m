Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1W5QNd-0000QB-Sn
	for ltp-list@lists.sourceforge.net; Tue, 21 Jan 2014 01:43:53 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W5QNd-0004Sq-4C
	for ltp-list@lists.sourceforge.net; Tue, 21 Jan 2014 01:43:53 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s0L1hkgp012007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jan 2014 01:43:47 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s0L1hkm8023207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jan 2014 01:43:46 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s0L1hjBR011761
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jan 2014 01:43:45 GMT
Message-ID: <52DDD0BA.4070906@oracle.com>
Date: Tue, 21 Jan 2014 09:43:22 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <1386729875-487-1-git-send-email-xu.simon@oracle.com>
	<52BA384B.3070308@oracle.com>
In-Reply-To: <52BA384B.3070308@oracle.com>
Subject: Re: [LTP] [PATCH] xinetd_tests.sh: explicitly enable IPv6
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

Could anyone help to review this?

Thanks
Simon

On 2013/12/25 9:43, Simon Xu wrote:
> Could anyone help to review this?
>
> Thanks
> Simon
>
> On 2013/12/11 10:44, Simon Xu wrote:
>> Explicitly enable IPv6 because on older systems xinetd only listens
>> on IPv4 by default.
>>
>> Signed-off-by: Simon Xu <xu.simon@oracle.com>
>> ---
>>    testcases/network/xinetd/xinetd_tests.sh | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
>> index 5024280..dac23a8 100755
>> --- a/testcases/network/xinetd/xinetd_tests.sh
>> +++ b/testcases/network/xinetd/xinetd_tests.sh
>> @@ -134,6 +134,7 @@ service telnet
>>        server          = /usr/sbin/in.telnetd
>>        server_args     = -n
>>        no_access       =
>> +    flags           = IPv6
>>    }
>>    EOF
>>    RC=$?

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
