Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RfoeE-0001Yh-Vt
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 08:14:06 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RfoeD-0003uH-Cg
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 08:14:06 +0000
Message-ID: <4EFACF87.7090905@cn.fujitsu.com>
Date: Wed, 28 Dec 2011 16:12:55 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <76bf538a-270a-456b-8b7b-9c651396d76a@zmail13.collab.prod.int.phx2.redhat.com>
	<4EFABB82.7090002@casparzhang.com>
	<4EFAC9C4.7020901@cn.fujitsu.com>
	<4EFACEDD.1040101@casparzhang.com>
In-Reply-To: <4EFACEDD.1040101@casparzhang.com>
Subject: Re: [LTP] [PATCH v6 1/2] mem/lib: add vm tunable file
 read/write/check func
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

On 12/28/2011 04:10 PM, Caspar Zhang wrote:

> On 12/28/2011 03:48 PM, Wanlong Gao wrote:
>> On 12/28/2011 02:47 PM, Caspar Zhang wrote:
>>
>>> On 11/15/2011 09:14 PM, Zhouping Liu wrote:
>>>> hi, Cyril & Garrett
>>>> v5 -> v6: updated the sscanf() function in read_meminfo() in order to avoid buffer overflow.
>>>>
>>>> please feel free to comment the patch.
>>>> BTW: you would miss the patch.
>>>>
>>>> There are several vm tunable files under /proc/sys/vm, I will compose
>>>> some cases for testing the basic functions of them. This patch is adding
>>>> the read/write/check functions to mem lib so that I can include them in
>>>> my testcases.
>>>>
>>>> set_sys_tune():   set a long long integer value to a vm tunable file.
>>>> get_sys_tune():   get a long long integer value from a vm tunable file.
>>>> check_sys_tune(): check to confirm the value in tunable file meets our
>>>>                   expectation.
>>>> read_meminfo():   read the special value from /proc/meminfo.
>>>>
>>>> Since most of the values in vm tunable files contain only single
>>>> integer, the functions I added only read/write long long values for now.
>>>> For those files not storing single interger (e.g. lowmem_reserve_ratio),
>>>> these functions will not be used in the case.
>>>>
>>>> Signed-off-by: Zhouping Liu <zliu@redhat.com>
>>>> ---
>>>>  runtest/mm                         |    7 +++
>>>>  testcases/kernel/mem/include/mem.h |    7 +++
>>>>  testcases/kernel/mem/lib/mem.c     |   84 +++++++++++++++++++++++++++++++++++-
>>>>  3 files changed, 97 insertions(+), 1 deletions(-)
>>>
>>> After talking to Zhouping Liu, I committed this patch with some
>>> modifications.
>>
>>
>> I saw that the patch you just committed defined an unused "PATH_SYSVM",
>> but as your comment of this patch, the set/get functions is just for sysfiles
>> under PATH_SYSVM, if so, you should do things like below first?
>>
>> snprintf(buf, BUFSIZ, "%s%s", PATH_KSM, path);
> 
> Hi, the original design was to pass full path to set/get_sys_tune()
> functions, PATH_SYSVM will be used in other files. I agree with your
> idea, it looks like sys_file is better to be filename only. I'll merge

> your request.
> 


Yeah, after this, I can then use set_sys_tune() in my patches.

Thanks
-Wanlong Gao

> Thanks,
> Caspar
> 



------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
