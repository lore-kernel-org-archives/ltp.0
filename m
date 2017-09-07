From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 7 Sep 2017 13:26:20 +0300
Subject: [LTP] [PATCH 1/1] lib6/in6_01.c: Remove IPv6 addresses which do
 not comply RFC 2373
In-Reply-To: <20170906124801.GE24177@rei.lan>
References: <20170831195517.22786-1-pvorel@suse.cz>
 <20170906124801.GE24177@rei.lan>
Message-ID: <60834195-f075-03de-fccf-90b2f7925b92@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 06.09.2017 15:48, Cyril Hrubis wrote:
> Hi!
>> glibc 2.26 starts rejecting IPv6 addresses which do not comply RFC 2373.
>>
>> commit 9a0cc8c1bd7645bf3c988890ffb59639c07a5812
>> Author: Florian Weimer <fweimer@redhat.com>
>> Date:   Fri Jun 23 22:51:00 2017 +0200
>>
>>     inet_pton: Reject IPv6 addresses with many leading zeros [BZ #16637]
>>
>>     2001:db8:00001::f is not a valid IPv6 address according to RFC 2373.
>>
>> See also:
>> https://sourceware.org/bugzilla/show_bug.cgi?id=16637
>>
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> ---
>>  testcases/network/lib6/in6_01.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/testcases/network/lib6/in6_01.c b/testcases/network/lib6/in6_01.c
>> index f7186b480..3a96ed17d 100644
>> --- a/testcases/network/lib6/in6_01.c
>> +++ b/testcases/network/lib6/in6_01.c
>> @@ -40,8 +40,6 @@ static struct {
>>  	{ "::ffff:10.0.0.1", 1 },
>>  	{ "::fffe:10.0.0.1", 0 },
>>  	{ "::7fff:10.0.0.1", 0 },
>> -	{ "0:0:0:0:0:0:ffff:0a001", 0 },
>> -	{ "0:0:1:0:0:0:ffff:0a001", 0 },
>                             ^
> 			    Shouldn't we just delete this leading zeroes
> 			    from the last two lines and be donw with it?

Agree, we should change the last segments to 'a001' and keep these
test-cases.

Best regards,
Alexey

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170907/420f1fa5/attachment.html>
