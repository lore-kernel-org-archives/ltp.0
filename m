Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z5vEs-0000W4-0Q
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 12:17:42 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z5vEr-0007FD-1V
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 12:17:41 +0000
Message-ID: <55840924.2090404@oracle.com>
Date: Fri, 19 Jun 2015 15:20:52 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <144413988.54651434713150877.JavaMail.weblogic@ep2mlwas06b>
	<55840688.1010202@oracle.com>
In-Reply-To: <55840688.1010202@oracle.com>
Subject: Re: [LTP] [PATCH]: Fix memory leak by freeing buf
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
To: manjeet.p@samsung.com, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, AKHILESH KUMAR <akhilesh.k@samsung.com>


On 06/19/2015 03:09 PM, Alexey Kodanev wrote:
> Hi!
> On 06/19/2015 02:25 PM, Manjeet Pawar wrote:
>> From: Manjeet Pawar <manjeet.p@samsung.com>
>> Date: Fri, 19 Jun 2015 16:45:54 +0530
>> Subject: [PATCH] testcases/open_posix_testsuite/functional/semaphores: Fix memory leak by freeing buf
>>
>> This patch fix memory leak by freeing memory leak before function return
>>
>> Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
>> Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
>> ---
>>    .../functional/semaphores/sem_conpro.c             |    5 +++++
>>    1 file changed, 5 insertions(+)
>>
>> diff --git a/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c b/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
>> index f5f1abf..f3a4cfb 100644
>> --- a/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
>> +++ b/testcases/open_posix_testsuite/functional/semaphores/sem_conpro.c
>> @@ -106,19 +106,23 @@ int main(int argc, char *argv[])
>>    
>>    #ifndef  _POSIX_SEMAPHORES
>>    	printf("_POSIX_SEMAPHORES is not defined \n");
>> +	free(buf);
>>    	return PTS_UNRESOLVED;
>>    #endif
>>    	if (-1 == sem_init(&(buf->occupied), shared, occupied_value)) {
>>    		perror("sem_init didn't return success \n");
>>    		printf("hello \n");

Also, do you know why it prints "hello"? It should be removed I guess.

Thanks,
Alexey

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
