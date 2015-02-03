Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YIbDv-0006pb-VX
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 11:00:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIbDs-0007py-WA
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 11:00:51 +0000
Message-ID: <54D0AA57.20608@redhat.com>
Date: Tue, 03 Feb 2015 12:00:39 +0100
From: Jiri Jaburek <jjaburek@redhat.com>
MIME-Version: 1.0
References: <54CB92BC.8020605@redhat.com> <54D0A873.6080503@oracle.com>
In-Reply-To: <54D0A873.6080503@oracle.com>
Subject: Re: [LTP] the mandatory (?) nature of testscripts
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>, ltp-list@lists.sourceforge.net

On 02/03/2015 11:52 AM, Alexey Kodanev wrote:
> Hi Jiri!
> On 30.01.2015 17:18, Jiri Jaburek wrote:
>> Hello all,
>> I normally execute the ltp suite using runltp with -f, specifying just
>> the runtest files I want to execute, possibly even writing my own ones
>> and using the fact that runltp detects absolute paths in the comma-
>> separated list and looks for them outside /opt/ltp.
>>
>> >From this viewpoint, and also looking at things like
>> testscripts/syscalls.sh, this approach seems perfectly valid (there's
>> at least nothing against it in the documentation, as far as I can tell).
>> My impression was therefore that testscripts are just convenient
>> (or legacy?) ways to run big chunks of the suite.
>>
>> However then I found testscripts/network.sh and all the "mandatory"
>> variables it exports - not using it resulted in the ping01 test failing
>> due to recent rewrite in cbab2eed06. And, as it turns out, network.sh
>> is not alone.
> 
> network.sh lists network variables which are needed to run all network 
> tests (stress group includes additional parameters, not yet moved them 
> to network.sh from networkstress.sh). In general, it is essential to 
> define remote host name, test interface names, IP addresses before 
> running network tests. Not all of them run with localhost, e.g. ping01 
> was modified to support various network configuration, you can now run 
> it on several interfaces (probably testing various NIC drivers, make 
> test traffic run over particular net-link, etc.) or running with 
> localhost, for example:

Thanks, but I can read that from git commits and the code - I understand
what has changed and can guess why it happened and it makes perfect
sense, just asking about the "design" of it.

> 
> $ echo 'ping601 ping01 -6' > runtest/ping_ipv6
> $ RHOST_IPV6_HOST=':1' ./runltp -f ping_ipv6

Unfortunately, from what I see, I need to export the "network" and
"host" part separately, by network classes (therefore networks not
using full class boundaries apparently can't be used) - see tst_ipaddr.

Meaning I can make the ping01 test work like it used to via

ping export LTPROOT; export IPV4_NETWORK=127.0.0; export
RHOST_IPV4_HOST=1; ping01

in my runtest file.

Still, my question was rather about the concept (for the future),
ie. whether it's okay to introduce something in network.sh which makes
it impossible to run tests separately (without patches) or whether
the tests *need* to remain executable separately.

Thanks.

> 
>> Therefore I would like to ask (since I didn't find this documented);
>> is running individual tests via runltp -f something "officially"
>> supported and the network tests should be altered to get their defaults
>> in another way, or is runltp -f wild west and I'm on my own, with the
>> only supported way to run the suite being the testscripts?
> 
> Test network configuration should be explicitly defined beforehand. You 
> could set required parameters in your test environment, then use 
> "runltp" as usual. I'm not sure right now if it is ok to add these 
> parameters with default values to runltp, then export those variables 
> inside it.
> 
> Best regards,
> Alexey
> 
> 
> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming. The Go Parallel Website,
> sponsored by Intel and developed in partnership with Slashdot Media, is your
> hub for all things parallel software development, from weekly thought
> leadership blogs to news, videos, case studies, tutorials and more. Take a
> look and join the conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
