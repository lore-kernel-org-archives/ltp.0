Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1YkVAs-0008Ot-7Q
	for ltp-list@lists.sourceforge.net; Tue, 21 Apr 2015 10:13:02 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YkVAm-0005Z3-Ur
	for ltp-list@lists.sourceforge.net; Tue, 21 Apr 2015 10:13:02 +0000
Date: Tue, 21 Apr 2015 06:12:50 -0400 (EDT)
From: Matus Marhefka <mmarhefk@redhat.com>
Message-ID: <2141999078.2469339.1429611170193.JavaMail.zimbra@redhat.com>
In-Reply-To: <5536168E.8000604@oracle.com>
References: <1424800340-10357-1-git-send-email-mmarhefk@redhat.com>
	<1424955461-21111-1-git-send-email-mmarhefk@redhat.com>
	<909321360.19304114.1424956944232.JavaMail.zimbra@redhat.com>
	<725550533.1886644.1429525732892.JavaMail.zimbra@redhat.com>
	<5536168E.8000604@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] containers: semctl replaced with semop in
 sysvipc/sem_comm.c
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

no problem and yes, the patches

b681672752634a70ba1bd6b1c6b5ae2967ac13e5 ("Keep the definition of union 
semun in one place")
586b51bf334b189d3e48760676ffeb39ce2a4371 ("sem_comm: pass a semun union 
to semctl()")

fixes the issue and so my old patch became redundant, thanks for pointing it out.


----- Original Message -----
From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
To: "Matus Marhefka" <mmarhefk@redhat.com>, "Jan Stancek" <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net
Sent: Tuesday, April 21, 2015 11:21:18 AM
Subject: Re: [LTP] [PATCH v2] containers: semctl replaced with semop in sysvipc/sem_comm.c

Hi.

On 04/20/2015 01:28 PM, Matus Marhefka wrote:
> Hi,
>
> please consider pushing this reviewed patch.
>
> Thanks,
> Matus Marhefka
>
>
> ----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Matus Marhefka" <mmarhefk@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Thursday, February 26, 2015 2:22:24 PM
> Subject: Re: [LTP] [PATCH v2] containers: semctl replaced with semop in	sysvipc/sem_comm.c
>
>
>
>
>
> ----- Original Message -----
>> From: "Matus Marhefka" <mmarhefk@redhat.com>
>> To: ltp-list@lists.sourceforge.net
>> Sent: Thursday, 26 February, 2015 1:57:41 PM
>> Subject: [LTP] [PATCH v2] containers: semctl replaced with semop in	sysvipc/sem_comm.c
>>
>> semctl call replaced with semop call for setting up semaphores initial
>> values because semctl needs non-standard type (not in sys/sem.h).

Emm, when I was preparing patches:

b681672752634a70ba1bd6b1c6b5ae2967ac13e5 ("Keep the definition of union 
semun in one place")
586b51bf334b189d3e48760676ffeb39ce2a4371 ("sem_comm: pass a semun union 
to semctl()")

I overlooked your patch. Sorry.

It seems the above patches fixes what you were trying to fix with your 
patch, and so it became redundant.

Do you agree?

Sorry again.


>>
>> Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
>
> Looks good to me.
> Reviewed-by: Jan Stancek <jstancek@redhat.com>
>
> Regards,
> Jan
>
>> ---
>>   testcases/kernel/containers/sysvipc/sem_comm.c | 24 ++++++++++++++----------
>>   1 file changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/testcases/kernel/containers/sysvipc/sem_comm.c
>> b/testcases/kernel/containers/sysvipc/sem_comm.c
>> index b44be6d..fba6767 100644
>> --- a/testcases/kernel/containers/sysvipc/sem_comm.c
>> +++ b/testcases/kernel/containers/sysvipc/sem_comm.c
>> @@ -59,14 +59,17 @@ int chld1_sem(void *arg)
>>   	int id;
>>   	struct sembuf sm;
>>
>> -	id = semget(TESTKEY, 1, IPC_CREAT);
>> +	id = semget(TESTKEY, 1, IPC_CREAT|S_IRUSR|S_IWUSR|IPC_EXCL);
>>   	if (id == -1) {
>>   		perror("semget");
>>   		return 2;
>>   	}
>>
>> -	if (semctl(id, 0, SETVAL, 1) == -1) {
>> -		perror("semctl");
>> +	sm.sem_num = 0;
>> +	sm.sem_op = 1;
>> +	sm.sem_flg = IPC_NOWAIT;
>> +	if (semop(id, &sm, 1) == -1) {
>> +		perror("semop");
>>   		semctl(id, 0, IPC_RMID);
>>   		return 2;
>>   	}
>> @@ -74,9 +77,7 @@ int chld1_sem(void *arg)
>>   	/* tell child2 to continue and wait for it to create the semaphore */
>>   	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
>>
>> -	sm.sem_num = 0;
>>   	sm.sem_op = -1;
>> -	sm.sem_flg = IPC_NOWAIT;
>>   	if (semop(id, &sm, 1) == -1) {
>>   		perror("semop");
>>   		semctl(id, 0, IPC_RMID);
>> @@ -101,14 +102,19 @@ int chld2_sem(void *arg)
>>   	/* wait for child1 to create the semaphore */
>>   	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
>>
>> -	id = semget(TESTKEY, 1, IPC_CREAT);
>> +	/* IPC_EXCL is excluded because we do not want semget call to fail
>> +	 * if namespaces logic doesn't work correctly */
>> +	id = semget(TESTKEY, 1, IPC_CREAT|S_IRUSR|S_IWUSR);
>>   	if (id == -1) {
>>   		perror("semget");
>>   		return 2;
>>   	}
>>
>> -	if (semctl(id, 0, SETVAL, 1) == -1) {
>> -		perror("semctl");
>> +	sm.sem_num = 0;
>> +	sm.sem_op = 1;
>> +	sm.sem_flg = IPC_NOWAIT;
>> +	if (semop(id, &sm, 1) == -1) {
>> +		perror("semop");
>>   		semctl(id, 0, IPC_RMID);
>>   		return 2;
>>   	}
>> @@ -116,9 +122,7 @@ int chld2_sem(void *arg)
>>   	/* tell child1 to continue and wait for it to lock the semaphore */
>>   	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
>>
>> -	sm.sem_num = 0;
>>   	sm.sem_op = -1;
>> -	sm.sem_flg = IPC_NOWAIT;
>>   	if (semop(id, &sm, 1) == -1) {
>>   		if (errno == EAGAIN) {
>>   			rval = 1;
>> --
>> 1.8.3.1
>>
>
> ------------------------------------------------------------------------------
> BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
> Develop your own process in accordance with the BPMN 2 standard
> Learn Process modeling best practices with Bonita BPM through live exercises
> http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
> source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
