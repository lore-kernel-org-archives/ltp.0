Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1S8Tlk-0008B2-Pf
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 09:48:20 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1S8Tlf-0006NR-CQ
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 09:48:20 +0000
Received: by ggcy3 with SMTP id y3so4767658ggc.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Mar 2012 02:48:10 -0700 (PDT)
References: <4F62A9E1.2040502@cn.fujitsu.com>
	<1331884731-11231-1-git-send-email-penght@cn.fujitsu.com>
	<4F62F3F8.5080707@cn.fujitsu.com>
In-Reply-To: <4F62F3F8.5080707@cn.fujitsu.com>
Mime-Version: 1.0 (1.0)
Message-Id: <42CC829C-0CD7-4CDB-A713-80BE6DA95EC5@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Fri, 16 Mar 2012 02:48:02 -0700
Subject: Re: [LTP] [PATCH v4] aio_read:8-1.c: Forget initializing struct
	aiocb before using it
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
To: "gaowanlong@cn.fujitsu.com" <gaowanlong@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Mar 16, 2012, at 1:04 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:

> On 03/16/2012 03:58 PM, Peng Haitao wrote:
> 
>> There are 2 changes in this patch.
>> 1. Initialize the aiocb struct before using it.
>> 2. If Prioritized Input and Output option is supported, submit the
>>    aiocb with invalid aio_reqprio, else submit the aiocb with invalid
>>    aio_fildes
>> 
>> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> 
> 
> Looks good to me , Cyril?

Why not always set fildes == -1 and test that way?

>> .../conformance/interfaces/aio_read/8-1.c              |   14 ++++++++------
>> .../conformance/interfaces/aio_write/6-1.c             |   16 +++++++++-------
>> 2 files changed, 17 insertions(+), 13 deletions(-)
>> 
>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/8-1.c
>> index 8054eeb..009aeb2 100644
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/8-1.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/8-1.c
>> @@ -14,7 +14,9 @@
>>  *
>>  * method:
>>  *
>> - *    - fill in an aiocb with a NULL aio_buf
>> + *    - if Prioritized Input and Output option is supported, fill in an
>> + *      aiocb with invalid aio_reqprio, else submit the aiocb with invalid
>> + *      aio_fildes
>>  *    - call aio_read
>>  *    - check aio_read return value
>>  */
>> @@ -41,11 +43,11 @@ int main()
>>    if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
>>        return PTS_UNSUPPORTED;
>> 
>> -    /* submit a request with a NULL buffer */
>> -    aiocb.aio_fildes = 0;
>> -    aiocb.aio_buf = NULL;
>> -    aiocb.aio_nbytes = 0;
>> -    aiocb.aio_offset = 0;
>> +    memset(&aiocb, 0, sizeof(struct aiocb));
>> +    if (sysconf(_SC_PRIORITIZED_IO) < 200112L)
>> +        aiocb.aio_fildes = -1;
>> +    else
>> +        aiocb.aio_reqprio = -1;
>> 
>>    if (aio_read(&aiocb) != -1) {
>>        printf(TNAME " aio_read() should fail!\n");
>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/6-1.c
>> index 98b8d0d..9234fe6 100644
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/6-1.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/6-1.c
>> @@ -14,7 +14,9 @@
>>  *
>>  * method:
>>  *
>> - *    - fill in an aiocb with a NULL aio_buf
>> + *    - if Prioritized Input and Output option is supported, fill in an
>> + *      aiocb with invalid aio_reqprio, else submit the aiocb with invalid
>> + *      aio_fildes
>>  *    - call aio_write
>>  *    - check aio_write return value
>>  *
>> @@ -42,11 +44,11 @@ int main()
>>    if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L)
>>        return PTS_UNSUPPORTED;
>> 
>> -    /* submit a request with a NULL buffer */
>> -    aiocb.aio_fildes = 0;
>> -    aiocb.aio_buf = NULL;
>> -    aiocb.aio_nbytes = 0;
>> -    aiocb.aio_offset = 0;
>> +    memset(&aiocb, 0, sizeof(struct aiocb));
>> +    if (sysconf(_SC_PRIORITIZED_IO) < 200112L)
>> +        aiocb.aio_fildes = -1;
>> +    else
>> +        aiocb.aio_reqprio = -1;
>> 
>>    if (aio_write(&aiocb) != -1)
>>    {
>> @@ -62,4 +64,4 @@ int main()
>> 
>>    printf ("Test PASSED\n");
>>    return PTS_PASS;
>> -}
>> \ No newline at end of file
>> +}
> 
> 
> 
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here 
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
