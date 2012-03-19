Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1S9ZqW-0005bU-1V
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 10:29:48 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S9ZqR-0005M0-SY
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 10:29:48 +0000
Message-ID: <4F670A75.9010406@redhat.com>
Date: Mon, 19 Mar 2012 18:29:09 +0800
From: ZhoupingLiu <zliu@redhat.com>
MIME-Version: 1.0
References: <465d054c01aef04f1adb43e0aaee4023a76c2bc3.1332143157.git.zliu@redhat.com>
	<4F66EBF2.3080903@cn.fujitsu.com>
In-Reply-To: <4F66EBF2.3080903@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] mem/oom: avoid unexpected error when no memcg
 swap accounting
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
To: gaowanlong@cn.fujitsu.com
Cc: Cai Qian <caiqian@redhat.com>, LTP List <ltp-list@lists.sourceforge.net>

On 03/19/2012 04:18 PM, Wanlong Gao wrote:
> On 03/19/2012 04:03 PM, Zhouping Liu wrote:
>
>> Since commit http://git.kernel.org/linus/a42c390cfa0c,
>> which added an option to control memcg swap, when kernel
>> neither set CGROUP_MEM_RES_CTLR_SWAP_ENABLED nor add
>> 'swapcount=1' kernel parameter, that indicates memcg swap
>> accounting is disabled, it will have no such file:
>> memory.memsw.*, then oom03&  oom04 cases will fail.
>>
>> The patch fixed it, removed memsw cases when memcg swap
>> accounting is disabled, and add a TINFO:
>> tst_resm(TINFO,"memcg swap accounting disabled");
>>
>> Signed-off-by: Zhouping Liu<zliu@redhat.com>
>
> Looks good to me except the typo. thanks Zhouping.

Wanlong, Thanks for your reviewing.
I have sent a v3, please review it again.

thanks,
Zhouping

>
> Reviewed-by: Wanlong Gao<gaowanlong@cn.fujitsu.com>
>
> Regards,
> Wanlong Gao
>
>> ---
>>   testcases/kernel/mem/oom/oom03.c |   14 ++++++++++++--
>>   testcases/kernel/mem/oom/oom04.c |   32 ++++++++++++++++++++++----------
>>   2 files changed, 34 insertions(+), 12 deletions(-)
>>
>> diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
>> index b90d4d7..d5e598b 100644
>> --- a/testcases/kernel/mem/oom/oom03.c
>> +++ b/testcases/kernel/mem/oom/oom03.c
>> @@ -66,8 +66,18 @@ int main(int argc, char *argv[])
>>   		write_file(MEMCG_PATH_NEW "/memory.limit_in_bytes", mem);
>>   		testoom(0, 0, 0);
>>
>> -		write_file(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes", mem);
>> -		testoom(0, 1, 0);
>> +		if (access(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
>> +		    F_OK) == -1) {
>> +			if (errno == ENOENT)
>> +				tst_resm(TINFO,
>> +				    "memcg swap accounting disabled");
>> +			else
>> +				tst_brkm(TBROK|TERRNO, NULL, "access");
>> +		} else {
>> +			write_file(MEMCG_PATH_NEW
>> +			     "/memory.memsw.limit_in_bytes", mem);
>> +			testoom(0, 1, 0);
>> +		}
>>   	}
>>   	cleanup();
>>   	tst_exit();
>> diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
>> index fb35f96..2bbf4f1 100644
>> --- a/testcases/kernel/mem/oom/oom04.c
>> +++ b/testcases/kernel/mem/oom/oom04.c
>> @@ -76,16 +76,28 @@ int main(int argc, char *argv[])
>>   		tst_resm(TINFO, "process mempolicy.");
>>   		testoom(1, 0, 1);
>>
>> -		write_file(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes", mem);
>> -		testoom(1, 1, 1);
>> -
>> -		tst_resm(TINFO, "process cpuset.");
>> -
>> -		write_file(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes", "-1");
>> -		testoom(0, 0, 1);
>> -
>> -		write_file(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes", mem);
>> -		testoom(0, 1, 1);
>> +		if (access(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
>> +		    F_OK) == -1) {
>> +			if (errno == ENOENT)
>> +				tst_resm(TINFO,
>> +				    "memcg swap accounting disabled");
>> +			else
>> +				tst_brkm(TBROK|TERRNO, NULL, "access");
>> +		} else {
>> +			write_file(MEMCG_PATH_NEW
>> +			    "/memory.memsw.limit_in_bytes", mem);
>> +			testoom(1, 1, 1);
>> +
>> +			tst_resm(TINFO, "process cpuset.");
>> +
>> +			write_file(MEMCG_PATH_NEW
>> +			    "/memory.memsw.limit_in_bytes", "-1");
>> +			testoom(0, 0, 1);
>> +
>> +			write_file(MEMCG_PATH_NEW
>> +			    "/memory.memsw.limit_in_bytes", mem);
>> +			testoom(0, 1, 1);
>> +		}
>>   	}
>>   	cleanup();
>>   	tst_exit();
>


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
