From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 8 Sep 2016 12:39:43 +0300
Subject: [LTP] [PATCH] memcg_process: cleanup the SHM segment
In-Reply-To: <20160906160126.GA21090@rei.lan>
References: <1472819042-25151-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160906160126.GA21090@rei.lan>
Message-ID: <57D131DF.3000307@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 09/06/2016 07:01 PM, Cyril Hrubis wrote:
> Hi!
>> Let's mark the segment for removal right after we attach it.
>> This way memcg* test cases will no longer leave unused
>> segments after they finish.
>>
>> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>> ---
>>  .../controllers/memcg/functional/memcg_process.c   |    9 ++++-----
>>  1 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_process.c
>> index fbb76e2..e2c60de 100644
>> --- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
>> +++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
>> @@ -234,9 +234,6 @@ static void shm(void)
>>  		if (key == -1)
>>  			err(1, "ftok() failed");
>>  
>> -		shmid = shmget(key, memsize, flag);
>> -		if (shmid == -1)
>> -			err(1, "shmget() failed");
>>  		shmctl(shmid, IPC_RMID, NULL);
>                      ^
> Shouldn't we remove this IPC_RMID as well?
> 

Agreed. It's better to remove it.

> 
> Otherwise it looks fine.
> 

Pushed with the removal of the above IPC_RMID call.

Thank you.
