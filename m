From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 23 Jun 2016 14:56:55 +0300
Subject: [LTP] [PATCH 2/2] nfs05: rewrite the test,
 make use of new library
In-Reply-To: <20160622123017.GC13962@rei.lan>
References: <1466076425-12790-1-git-send-email-alexey.kodanev@oracle.com>
 <1466076425-12790-2-git-send-email-alexey.kodanev@oracle.com>
 <20160622123017.GC13962@rei.lan>
Message-ID: <576BCE87.5070403@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 06/22/2016 03:30 PM, Cyril Hrubis wrote:
> Hi!
>> --- a/testcases/network/nfs/nfs_stress/Makefile
>> +++ b/testcases/network/nfs/nfs_stress/Makefile
>> @@ -19,7 +19,7 @@ top_srcdir		?= ../../../..
>>   include $(top_srcdir)/include/mk/env_pre.mk
>>   
>>   nfs04_create_file: CPPFLAGS += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
>> -nfs05_make_tree: LDLIBS += -lpthread
>> +nfs05_make_tree: LDLIBS += -I../../../kernel/include -lltp -lpthread
> Hmm, shouldn't we rather include testcase.mk to get the -lltp and
> the include path?
>
> And even if we don't the -I directive should go to CPPFLAGS instead.
Agree.

>>   INSTALL_TARGETS		:= nfs_lib.sh \
>>   			   nfs01 \
>> diff --git a/testcases/network/nfs/nfs_stress/nfs05 b/testcases/network/nfs/nfs_stress/nfs05
>> index 0e15c8c..26977ab 100755
>> --- a/testcases/network/nfs/nfs_stress/nfs05
>> +++ b/testcases/network/nfs/nfs_stress/nfs05
>> @@ -34,8 +34,12 @@ THREAD_NUM=${THREAD_NUM:-"8"}
>>   nfs_setup
> Shouldn't we check that make and gcc is installed at this point?

I'll add a check to make sure they are available.

>
>> ...
>> -			}
>> +static void *thread_fn(LTP_ATTRIBUTE_UNUSED void *args)
>> +{
>> +	const char prog_buf[] = "main()\n{\n\t printf(\"hello world\");\n}\n";
>> +	const size_t prog_buf_size = strlen(prog_buf);
>                                       ^
> 				     sizeof(prog_buf) - 1

Right, we can calculate the size at compile-time.

>> +	
>>   
>> -			dprt("pid[%d]: init_compile(): status = %d\n",
>> -			     gettid(), status);
>> -			dprt("we are here %d\n", __LINE__);
>> -			return status;
>> +			SAFE_WRITE(1, fd, prog_buf, prog_buf_size);
>> +			fsync(fd);
> Why do we fsync(fd) here? Isn't the whole point of this test to find a
> race conditions?

And given the fact that we have close(fd) thereafter, should make it 
useless...

Thanks,
Alexey
