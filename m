Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PLucG-00006q-Iv
	for ltp-list@lists.sourceforge.net; Fri, 26 Nov 2010 09:29:16 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLucF-0003xt-Ms
	for ltp-list@lists.sourceforge.net; Fri, 26 Nov 2010 09:29:16 +0000
Received: by ywt2 with SMTP id 2so898286ywt.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 26 Nov 2010 01:29:10 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1566760762.501801290751932675.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Fri, 26 Nov 2010 01:29:06 -0800
Message-Id: <EDD0AF13-7D60-41BC-BD81-F47218CD96DA@gmail.com>
References: <1566760762.501801290751932675.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v2]extend the -I option value
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
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Nov 25, 2010, at 10:12 PM, Zhouping Liu wrote:

> 
> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
> 
>> From: "Garrett Cooper" <yanegomi@gmail.com>
>> To: "Zhouping Liu" <zliu@redhat.com>
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Friday, November 26, 2010 4:41:24 AM GMT +08:00 Beijing / Chongqing / Hong Kong / Urumqi
>> Subject: Re: [LTP] [PATCH v2]extend the -I option value
>> 
>> On Thu, Nov 25, 2010 at 1:23 AM, Zhouping Liu <zliu@redhat.com>
>> wrote:
>>> Hi,all
>>> I found it just support a small value for -I option.
>>> when I run '#./hugemmap04 -I 3600 -H /var/hugetlbfs',the test
>> returned
>>> immediately.
>>> the -I option details :
>>> -I x Execute test for x seconds
>>> And if you give a much bigger value to -I option such as 3600 or
>> larger, you
>>> will find the -I option disabled,
>>> so I changed the lib/parse_opts.c file, and just modified the
>> stop_time
>>> variable type from 'int' to 'double',
>>> after changed, it can support a very bigger value for -I option.
>> 
>>    Or maybe this should be time_t or long?
>>    Honestly, this could potentially introduce a lot of headache if
>> done improperly in lib/parse_opts.c (especially if you use a double
>> precisioned time amount as this could seriously impact architectures
>> without FPUs).
> yeah,you're right, then I think it should change long long type,as there
> is no apparent difference between int type and long type.(the long long
> type can arrive at the maximum:9223372036854775807,and it can support a much bigger value.)

Are you so sure about that statement?

(amd64 FreeBSD CURRENT)
$ ~/test_int_and_long 
(I) 4294967295, (L) 18446744073709551615

(i386 Fedora 13)
$ ~/test_int_and_long
(I) 4294967295, (L) 4294967295

$ cat test_int_and_long.c 
#include <limits.h>
#include <stdio.h>

int
main(void)
{
	printf("(I) %u, (L) %lu\n", UINT_MAX, ULONG_MAX);
	return (0);
}

Longs are 32-bit integers on 32-bit architectures and 64-bit integers on 64-bit architectures...

> ( but I also have a question: why the STD_LOOP_DURATION (defined in lib/parse_opts.c) use float type? )

Don't know... I'll have to look.
Thanks,
-Garrett
------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
