Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1Tr1bw-0003AF-MM
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 07:22:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tr1bv-0008Vt-85
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 07:22:36 +0000
Message-ID: <50E682DF.3050901@redhat.com>
Date: Fri, 04 Jan 2013 15:21:03 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <cover.1357277005.git.zliu@redhat.com>
	<50E67F91.106@casparzhang.com>
In-Reply-To: <50E67F91.106@casparzhang.com>
Subject: Re: [LTP] [PATCH v2 0/2] updated create_same_memory() inside
	lib/mem.c
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 01/04/2013 03:06 PM, Caspar Zhang wrote:
> On 01/04/2013 02:12 PM, Zhouping Liu wrote:
>> changed in v2:
>>   - modified '_function_name' as 'function_name'
>>   - added 'static' key word for internal function
>>   - updated a little commit log
>>
>> Zhouping Liu (2):
>>    mm/lib: rewrote create_same_memory()
>>    mm/include: removed the global var 'memory'
>>
>>   testcases/kernel/mem/include/_private.h |   2 +-
>>   testcases/kernel/mem/include/mem.h      |   5 -
>>   testcases/kernel/mem/lib/mem.c          | 425 
>> +++++++++++++-------------------
>>   3 files changed, 170 insertions(+), 262 deletions(-)
>>
>
> Since there is no function updated in the patch, I'm OK to apply it if 
> a unit-test is executed (better testing in a wide range of systems) 
> and get ACKs from other reviewers. Zhouping, would you mind pasting 
> some test details against your patch before we apply it?

This is an example of output log with the patch on Fedora 17:

[root@ZhoupingLiu ksm]# ./ksm01 -s 1 -n 6
ksm01       0  TINFO  :  child 0 stops.
ksm01       0  TINFO  :  child 1 stops.
ksm01       0  TINFO  :  child 2 stops.
ksm01       0  TINFO  :  child 3 stops.
ksm01       0  TINFO  :  wait for all children to stop.
ksm01       0  TINFO  :  child 4 stops.
ksm01       0  TINFO  :  child 5 stops.
ksm01       0  TINFO  :  KSM merging...
ksm01       0  TINFO  :  resume all children.
ksm01       0  TINFO  :  child 0 continues...
ksm01       0  TINFO  :  child 1 continues...
ksm01       0  TINFO  :  child 0 allocates 1 MB filled with 'c'
ksm01       0  TINFO  :  child 1 allocates 1 MB filled with 'a'
ksm01       0  TINFO  :  child 4 continues...
ksm01       0  TINFO  :  child 4 allocates 1 MB filled with 'c'
ksm01       0  TINFO  :  child 2 continues...
ksm01       0  TINFO  :  child 2 allocates 1 MB filled with 'a'
ksm01       0  TINFO  :  child 3 continues...
ksm01       0  TINFO  :  child 3 allocates 1 MB filled with 'c'
ksm01       0  TINFO  :  child 0 stops.
ksm01       0  TINFO  :  child 2 stops.
ksm01       0  TINFO  :  child 3 stops.
ksm01       0  TINFO  :  child 5 continues...
ksm01       0  TINFO  :  child 5 allocates 1 MB filled with 'c'
ksm01       0  TINFO  :  child 4 stops.
ksm01       0  TINFO  :  child 1 stops.
ksm01       0  TINFO  :  child 5 stops.
ksm01       0  TINFO  :  ksm daemon takes 20s to scan all mergeable pages
ksm01       0  TINFO  :  check!
ksm01       0  TINFO  :  run is 1.
ksm01       0  TINFO  :  pages_shared is 2.
ksm01       0  TINFO  :  pages_sharing is 1534.
ksm01       0  TINFO  :  pages_volatile is 0.
ksm01       0  TINFO  :  pages_unshared is 0.
ksm01       0  TINFO  :  sleep_millisecs is 0.
ksm01       0  TINFO  :  pages_to_scan is 1536.
ksm01       0  TINFO  :  wait for all children to stop.
ksm01       0  TINFO  :  resume all children.
ksm01       0  TINFO  :  child 1 verifies memory content.
ksm01       0  TINFO  :  child 0 verifies memory content.
ksm01       0  TINFO  :  child 2 verifies memory content.
ksm01       0  TINFO  :  child 1 continues...
ksm01       0  TINFO  :  child 0 continues...
ksm01       0  TINFO  :  child 2 continues...
ksm01       0  TINFO  :  child 1 allocates 1 MB filled with 'b'
ksm01       0  TINFO  :  child 0 allocates 1 MB filled with 'c'
ksm01       0  TINFO  :  child 2 allocates 1 MB filled with 'a'
ksm01       0  TINFO  :  child 2 stops.
ksm01       0  TINFO  :  child 4 verifies memory content.
ksm01       0  TINFO  :  child 5 verifies memory content.
ksm01       0  TINFO  :  child 0 stops.
ksm01       0  TINFO  :  child 1 stops.
ksm01       0  TINFO  :  child 3 verifies memory content.
ksm01       0  TINFO  :  child 4 continues...
ksm01       0  TINFO  :  child 5 continues...
ksm01       0  TINFO  :  child 5 allocates 1 MB filled with 'c'
ksm01       0  TINFO  :  child 4 allocates 1 MB filled with 'c'
ksm01       0  TINFO  :  child 3 continues...
ksm01       0  TINFO  :  child 3 allocates 1 MB filled with 'c'
ksm01       0  TINFO  :  child 5 stops.
ksm01       0  TINFO  :  child 3 stops.
ksm01       0  TINFO  :  child 4 stops.
ksm01       0  TINFO  :  ksm daemon takes 20s to scan all mergeable pages
ksm01       0  TINFO  :  check!
ksm01       0  TINFO  :  run is 1.
ksm01       0  TINFO  :  pages_shared is 3.
ksm01       0  TINFO  :  pages_sharing is 1533.
ksm01       0  TINFO  :  pages_volatile is 0.
ksm01       0  TINFO  :  pages_unshared is 0.
ksm01       0  TINFO  :  sleep_millisecs is 0.
ksm01       0  TINFO  :  pages_to_scan is 1536.
ksm01       0  TINFO  :  wait for all children to stop.
ksm01       0  TINFO  :  resume all children.
ksm01       0  TINFO  :  child 1 verifies memory content.
ksm01       0  TINFO  :  child 0 verifies memory content.
ksm01       0  TINFO  :  child 2 verifies memory content.
ksm01       0  TINFO  :  child 1 continues...
ksm01       0  TINFO  :  child 1 allocates 1 MB filled with 'd'
ksm01       0  TINFO  :  child 0 continues...
ksm01       0  TINFO  :  child 2 continues...
ksm01       0  TINFO  :  child 0 allocates 1 MB filled with 'd'
ksm01       0  TINFO  :  child 2 allocates 1 MB filled with 'd'
ksm01       0  TINFO  :  child 3 verifies memory content.
ksm01       0  TINFO  :  child 3 continues...
ksm01       0  TINFO  :  child 3 allocates 1 MB filled with 'd'
ksm01       0  TINFO  :  child 1 stops.
ksm01       0  TINFO  :  child 0 stops.
ksm01       0  TINFO  :  child 2 stops.
ksm01       0  TINFO  :  child 5 verifies memory content.
ksm01       0  TINFO  :  child 4 verifies memory content.
ksm01       0  TINFO  :  child 5 continues...
ksm01       0  TINFO  :  child 5 allocates 1 MB filled with 'd'
ksm01       0  TINFO  :  child 3 stops.
ksm01       0  TINFO  :  child 4 continues...
ksm01       0  TINFO  :  child 4 allocates 1 MB filled with 'd'
ksm01       0  TINFO  :  child 5 stops.
ksm01       0  TINFO  :  child 4 stops.
ksm01       0  TINFO  :  ksm daemon takes 20s to scan all mergeable pages
ksm01       0  TINFO  :  check!
ksm01       0  TINFO  :  run is 1.
ksm01       0  TINFO  :  pages_shared is 1.
ksm01       0  TINFO  :  pages_sharing is 1535.
ksm01       0  TINFO  :  pages_volatile is 0.
ksm01       0  TINFO  :  pages_unshared is 0.
ksm01       0  TINFO  :  sleep_millisecs is 0.
ksm01       0  TINFO  :  pages_to_scan is 1536.
ksm01       0  TINFO  :  wait for all children to stop.
ksm01       0  TINFO  :  resume all children.
ksm01       0  TINFO  :  child 1 verifies memory content.
ksm01       0  TINFO  :  child 0 verifies memory content.
ksm01       0  TINFO  :  child 2 verifies memory content.
ksm01       0  TINFO  :  child 4 verifies memory content.
ksm01       0  TINFO  :  child 1 continues...
ksm01       0  TINFO  :  child 1 allocates 1 MB filled with 'd' except 
one page with 'e'
ksm01       0  TINFO  :  child 0 continues...
ksm01       0  TINFO  :  child 2 continues...
ksm01       0  TINFO  :  child 0 allocates 1 MB filled with 'd'
ksm01       0  TINFO  :  child 2 allocates 1 MB filled with 'd'
ksm01       0  TINFO  :  child 4 continues...
ksm01       0  TINFO  :  child 4 allocates 1 MB filled with 'd'
ksm01       0  TINFO  :  child 1 stops.
ksm01       0  TINFO  :  child 0 stops.
ksm01       0  TINFO  :  child 2 stops.
ksm01       0  TINFO  :  child 3 verifies memory content.
ksm01       0  TINFO  :  child 5 verifies memory content.
ksm01       0  TINFO  :  child 3 continues...
ksm01       0  TINFO  :  child 3 allocates 1 MB filled with 'd'
ksm01       0  TINFO  :  child 4 stops.
ksm01       0  TINFO  :  child 5 continues...
ksm01       0  TINFO  :  child 5 allocates 1 MB filled with 'd'
ksm01       0  TINFO  :  child 3 stops.
ksm01       0  TINFO  :  child 5 stops.
ksm01       0  TINFO  :  ksm daemon takes 20s to scan all mergeable pages
ksm01       0  TINFO  :  check!
ksm01       0  TINFO  :  run is 1.
ksm01       0  TINFO  :  pages_shared is 1.
ksm01       0  TINFO  :  pages_sharing is 1534.
ksm01       0  TINFO  :  pages_volatile is 0.
ksm01       0  TINFO  :  pages_unshared is 1.
ksm01       0  TINFO  :  sleep_millisecs is 0.
ksm01       0  TINFO  :  pages_to_scan is 1536.
ksm01       0  TINFO  :  wait for all children to stop.
ksm01       0  TINFO  :  KSM unmerging...
ksm01       0  TINFO  :  resume all children.
ksm01       0  TINFO  :  child 1 verifies memory content.
ksm01       0  TINFO  :  child 1 verifies memory content.
ksm01       0  TINFO  :  child 0 verifies memory content.
ksm01       0  TINFO  :  child 4 verifies memory content.
ksm01       0  TINFO  :  child 4 finished.
ksm01       0  TINFO  :  child 1 finished.
ksm01       0  TINFO  :  child 0 finished.
ksm01       0  TINFO  :  child 5 verifies memory content.
ksm01       0  TINFO  :  child 5 finished.
ksm01       0  TINFO  :  child 2 verifies memory content.
ksm01       0  TINFO  :  child 3 verifies memory content.
ksm01       0  TINFO  :  child 2 finished.
ksm01       0  TINFO  :  child 3 finished.
ksm01       0  TINFO  :  ksm daemon takes 10s to scan all mergeable pages
ksm01       0  TINFO  :  check!
ksm01       0  TINFO  :  run is 2.
ksm01       0  TINFO  :  pages_shared is 0.
ksm01       0  TINFO  :  pages_sharing is 0.
ksm01       0  TINFO  :  pages_volatile is 0.
ksm01       0  TINFO  :  pages_unshared is 0.
ksm01       0  TINFO  :  sleep_millisecs is 0.
ksm01       0  TINFO  :  pages_to_scan is 1536.
ksm01       0  TINFO  :  stop KSM.
ksm01       0  TINFO  :  ksm daemon takes 10s to scan all mergeable pages
ksm01       0  TINFO  :  check!
ksm01       0  TINFO  :  run is 0.
ksm01       0  TINFO  :  pages_shared is 0.
ksm01       0  TINFO  :  pages_sharing is 0.
ksm01       0  TINFO  :  pages_volatile is 0.
ksm01       0  TINFO  :  pages_unshared is 0.
ksm01       0  TINFO  :  sleep_millisecs is 0.
ksm01       0  TINFO  :  pages_to_scan is 1536.

Thanks,
Zhouping

------------------------------------------------------------------------------
Master HTML5, CSS3, ASP.NET, MVC, AJAX, Knockout.js, Web API and
much more. Get web development skills now with LearnDevNow -
350+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122812
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
