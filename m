Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TvNEh-0004UM-Af
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 07:16:35 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TvNEf-00067X-78
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 07:16:35 +0000
Message-ID: <50F653D3.9050407@cn.fujitsu.com>
Date: Wed, 16 Jan 2013 15:16:35 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <d586a4f2cfdf91b3e480c8e275f53fae34a00705.1357732655.git.zliu@redhat.com>
	<50ED5C7A.2050301@redhat.com>
In-Reply-To: <50ED5C7A.2050301@redhat.com>
Subject: Re: [LTP] [PATCH] numa/numa01.sh: fixed errors under noncontinuous
 numa nodes list
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 01/09/2013 08:03 PM, Zhouping Liu wrote:
> On 01/09/2013 07:58 PM, Zhouping Liu wrote:
>> > The previous code numa01.sh thought all NUMA system had continuous
>> > numa nodes list, and node id started from 0, but in fact it does not.
>> >
>> > There are lots of system contains noncontinuous numa nodes list
>> >   e.g:
>> >   # numactl --hardware
>> >   available: 4 nodes (0,2,4,7)
>> >   node 0 cpus: 0 4 8 12 16 20 24 28
>> >   node 0 size: 4061 MB
>> >   node 0 free: 3756 MB
>> >   node 2 cpus: 1 5 9 13 17 21 25 29
>> >   node 2 size: 4096 MB
>> >   node 2 free: 3196 MB
>> >   node 4 cpus: 2 6 10 14 18 22 26 30
>> >   node 4 size: 4096 MB
>> >   node 4 free: 3885 MB
>> >   node 7 cpus: 3 7 11 15 19 23 27 31
>> >   node 7 size: 4095 MB
>> >   node 7 free: 3947 MB
>> >   node distances:
>> >   node   0   2   4   7
>> >     0:  10  20  20  20
>> >     2:  20  10  20  20
>> >     4:  20  20  10  20
>> >     7:  20  20  20  10
>> >
>> > in such discontinuous nodes system, numa01.sh would fail with
>> > such error log:
>> >   libnuma: Warning: node argument 1 is out of range
>> >
>> > The patch fixed it, and removed some useless/redundancy val/func,
>> > such as 'max_node' val and 'getmax' func, also make some cleanup.
> I tested the patch on continuous/non-continuous NUMA system, also did on 
> non-NUMA system.

Applied, thank you.

Wanlong Gao

> 
> Thanks,
> Zhouping
> 


------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
