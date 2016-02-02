From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 2 Feb 2016 17:37:20 +0300
Subject: [LTP] [PATCH] syscalls/fchmodat: fix test,
 don't use test current directory
In-Reply-To: <20160202141415.GB19199@rei.lan>
References: <1454408074-3149-1-git-send-email-alexey.kodanev@oracle.com>
 <20160202141415.GB19199@rei.lan>
Message-ID: <56B0BF20.3070007@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 02/02/2016 05:14 PM, Cyril Hrubis wrote:
> Hi!
>> @@ -73,6 +73,7 @@ int main(int ac, char **av)
>>   {
>>   	int lc;
>>   	int i;
>> +	size_t k;
>>   
>>   	/* Disable test if the version of the kernel is less than 2.6.16 */
>>   	if ((tst_kvercmp(2, 6, 16)) < 0) {
>> @@ -104,6 +105,12 @@ int main(int ac, char **av)
>>   			}
>>   		}
>>   
>> +		for (k = 0; k < ARRAY_SIZE(tst_fds); ++k)
>> +			SAFE_CLOSE(cleanup, tst_fds[k]);
>> +
>> +		SAFE_UNLINK(cleanup, testfile);
>> +		SAFE_UNLINK(cleanup, testfile3);
>> +		SAFE_RMDIR(cleanup, pathname);
> Is there any reason why we call the setup_every_copy() for each
> iteration instead of doing it once in the setup()?

Hard to say, it seems this test never used with '-i' parameter.

I think we can change the test-case and move setup_every_copy()
to setup(), as the only difference with permissions will be that the 
test directory
mode won't be changed from 0700 -> 0600 on every iteration.

Thanks,
Alexey

>
>
> Otherwise the patch looks good.
>

