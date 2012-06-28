Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Sk9Hj-0003fA-LR
	for ltp-list@lists.sourceforge.net; Thu, 28 Jun 2012 07:37:03 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sk9Hd-00074a-1G
	for ltp-list@lists.sourceforge.net; Thu, 28 Jun 2012 07:37:03 +0000
Message-ID: <4FEC0991.7010602@cn.fujitsu.com>
Date: Thu, 28 Jun 2012 15:36:49 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4FC48906.6030109@redhat.com> <4FEC07E6.6030308@redhat.com>
In-Reply-To: <4FEC07E6.6030308@redhat.com>
Subject: Re: [LTP] [PATCH v2 0/4] dont use hardcoded NUMA node ids
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
Cc: ltp-list@lists.sourceforge.net

On 06/28/2012 03:29 PM, Jan Stancek wrote:
> Hi,
> 
> any thoughts on this version?

Hi Jan,

you sent many series of patches, but it's hard to find out that
which patch belongs to this series. 

So, can you send patch set like this.
[0]-xxxxxxxxxxxxxxxxxxxxxxx
  |_[1]xxxxxxxxxxxxxxxxxxxxxxxxx
  |_[2]xxxxxxxxxxxxxxxxxxxxxxxx

I mean, one series in one thread ?

Thanks,
Wanlong Gao

> 
> Regards,
> Jan
> 
> On 05/29/2012 10:29 AM, Jan Stancek wrote:
>> Changes in v2:
>> get_allowed_pages()
>> - removed tst_resm(TFAIL,..)
>> - added break
>> - for ret == -3, set errno to EINVAL
>> move_pages_support.c
>> - check return value from get_allowed_nodes_arr()
>> mbind, get_mempolicy, move_pages
>> - removed curly brackets in single statement ifs
>>
>> This patch series is a combination of:
>> [PATCH v3] mbind01, get_mempolicy01: dont use hardcoded node 0
>> [PATCH 1/2] move_pages_support: use only allowed nodes
>> [PATCH 2/2] move_pages: dont use hardcoded node numbers
>>
>> so that all testcases use same shared code, which resides in libnuma_helper.a.
>> This library defines get_allowed_nodes() and get_allowed_nodes_arr() functions
>> to obtain list of nodes tests can use.
>>
>> I tested it with following setups. Note that setup 4 and 5 will
>> end with TCONF as there is only 1 node with memory.
>>
>> 1.
>> # numactl -H
>> available: 8 nodes (2,4-10)
>> node 2 cpus: 0
>> node 2 size: 127 MB
>> node 2 free: 9 MB
>> node 4 cpus:
>> node 4 size: 128 MB
>> node 4 free: 9 MB
>> node 5 cpus:
>> node 5 size: 128 MB
>> node 5 free: 64 MB
>> node 6 cpus:
>> node 6 size: 128 MB
>> node 6 free: 121 MB
>> node 7 cpus:
>> node 7 size: 128 MB
>> node 7 free: 121 MB
>> node 8 cpus:
>> node 8 size: 128 MB
>> node 8 free: 121 MB
>> node 9 cpus:
>> node 9 size: 128 MB
>> node 9 free: 121 MB
>> node 10 cpus:
>> node 10 size: 127 MB
>> node 10 free: 123 MB
>>
>> 2.
>> # numactl -H
>> available: 4 nodes (0-3)
>> node 0 cpus: 0 1 2 3 4 5
>> node 0 size: 2047 MB
>> node 0 free: 564 MB
>> node 1 cpus: 6 7 8 9 10 11
>> node 1 size: 2046 MB
>> node 1 free: 451 MB
>> node 2 cpus: 18 19 20 21 22 23
>> node 2 size: 2048 MB
>> node 2 free: 595 MB
>> node 3 cpus: 12 13 14 15 16 17
>> node 3 size: 2048 MB
>> node 3 free: 236 MB
>> node distances:
>> node   0   1   2   3 
>>   0:  10  16  16  16 
>>   1:  16  10  16  16 
>>   2:  16  16  10  16 
>>   3:  16  16  16  10
>>
>> 3.
>> # numactl -H
>> available: 2 nodes (2-3)
>> node 2 cpus: 0
>> node 2 size: 511 MB
>> node 2 free: 154 MB
>> node 3 cpus:
>> node 3 size: 511 MB
>> node 3 free: 490 MB
>>
>>
>> 4.
>> # numactl -H
>> available: 2 nodes (0-1)
>> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
>> node 0 size: 0 MB
>> node 0 free: 0 MB
>> node 1 cpus:
>> node 1 size: 12288 MB
>> node 1 free: 9689 MB
>> node distances:
>> node   0   1 
>>   0:  10  40 
>>   1:  40  10 
>>
>> 5.
>> # numactl -H
>> available: 1 nodes (0)
>> node 0 cpus: 0
>> node 0 size: 1023 MB
>> node 0 free: 654 MB
>> node distances:
>> node   0 
>>   0:  10 
>>
>>
>> Jan Stancek (4):
>>   add libnuma_helper.a
>>   mbind01: dont use hardcoded NUMA node ids
>>   get_mempolicy01: dont use hardcoded NUMA node ids
>>   move_pages: dont use hardcoded NUMA node ids
>>
>>  testcases/kernel/syscalls/get_mempolicy/Makefile   |    7 +-
>>  .../syscalls/get_mempolicy/get_mempolicy01.c       |    8 +-
>>  testcases/kernel/syscalls/mbind/Makefile           |    3 +-
>>  testcases/kernel/syscalls/mbind/mbind01.c          |    9 +-
>>  testcases/kernel/syscalls/move_pages/Makefile      |    5 +-
>>  .../kernel/syscalls/move_pages/move_pages02.c      |   11 +-
>>  .../kernel/syscalls/move_pages/move_pages03.c      |   11 +-
>>  .../kernel/syscalls/move_pages/move_pages04.c      |   11 +-
>>  .../kernel/syscalls/move_pages/move_pages05.c      |   11 +-
>>  .../kernel/syscalls/move_pages/move_pages06.c      |    9 +-
>>  .../kernel/syscalls/move_pages/move_pages07.c      |   11 +-
>>  .../kernel/syscalls/move_pages/move_pages08.c      |    9 +-
>>  .../kernel/syscalls/move_pages/move_pages09.c      |    7 +-
>>  .../kernel/syscalls/move_pages/move_pages10.c      |   11 +-
>>  .../kernel/syscalls/move_pages/move_pages11.c      |   11 +-
>>  .../syscalls/move_pages/move_pages_support.c       |   44 +++++--
>>  .../syscalls/move_pages/move_pages_support.h       |    1 +
>>  .../syscalls/{get_mempolicy => numa}/Makefile      |   13 +--
>>  .../{get_mempolicy/Makefile => numa/Makefile.inc}  |   20 ++--
>>  .../syscalls/{get_mempolicy => numa/lib}/Makefile  |   15 +--
>>  testcases/kernel/syscalls/numa/lib/numa_helper.c   |  135 ++++++++++++++++++++
>>  testcases/kernel/syscalls/numa/lib/numa_helper.h   |   34 +++++
>>  22 files changed, 304 insertions(+), 92 deletions(-)
>>  copy testcases/kernel/syscalls/{get_mempolicy => numa}/Makefile (73%)
>>  copy testcases/kernel/syscalls/{get_mempolicy/Makefile => numa/Makefile.inc} (69%)
>>  copy testcases/kernel/syscalls/{get_mempolicy => numa/lib}/Makefile (71%)
>>  create mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.c
>>  create mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.h
>>
>>
>> ------------------------------------------------------------------------------
>> Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and 
>> threat landscape has changed and how IT managers can respond. Discussions 
>> will include endpoint security, mobile security and the latest in malware 
>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
