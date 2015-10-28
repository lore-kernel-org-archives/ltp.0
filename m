From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 28 Oct 2015 15:33:18 +0800
Subject: [LTP] [PATCH 10/11] ipc/shmctl: Testcase failed when no root
 user run it
In-Reply-To: <1446016345.17485.3.camel@G08FNSTD140232>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
 <1446001907-43525-10-git-send-email-cuibixuan@huawei.com>
 <1446016345.17485.3.camel@G08FNSTD140232>
Message-ID: <56307A3E.2060008@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2015/10/28 15:12, Zeng Linggang wrote:
> Hi,
> 
>>  {
>>  	tst_sig(FORK, sighandler, cleanup);
>>  
>> +	Add tst_require_root();
>> +
> 
> tst_requite_root();
> 
> Thanks,
> Zeng

Thank you :-)

Cui Bixuan
> 
>>  	TEST_PAUSE;
>>  
>>  	tst_tmpdir();
>> -- 
>> 1.6.0.2
>>
>>
> 
> 
> 
> 

