Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SAI8t-0001o2-4O
	for ltp-list@lists.sourceforge.net; Wed, 21 Mar 2012 09:47:43 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SAI8n-0006kQ-Gl
	for ltp-list@lists.sourceforge.net; Wed, 21 Mar 2012 09:47:43 +0000
Received: by dajr28 with SMTP id r28so1948058daj.33
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Mar 2012 02:47:31 -0700 (PDT)
Message-ID: <4F69A35A.7060109@casparzhang.com>
Date: Wed, 21 Mar 2012 17:46:02 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1332257989-22829-1-git-send-email-salvatore.cro@st.com>
	<4F69A24D.6030903@redhat.com>
In-Reply-To: <4F69A24D.6030903@redhat.com>
Subject: Re: [LTP] [PATCH] setrlimit01: wait for all children to exit in
	test3
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
To: ZhoupingLiu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 03/21/2012 05:41 PM, ZhoupingLiu wrote:
> On 03/20/2012 11:39 PM, Salvatore CRO' wrote:
>> In test3, parent just wait for one child to exit but it
>> actually has 10.
> hi, Salvatore
> 
> yes, you are right, but your patch didn't resolve the issue completely.
> comments in-line.
> 
>> As it could happen there may be other children around that
>> didn't get yet the chance to exit, they will get signaled
>> by ltp-pan (SIGTERM) and pollute the output of subsequent
>> test (setrlimit02).
>> Parent definitely needs to wait for all children to exit.
>>
>> Signed-off-by: Salvatore Cro<salvatore.cro@st.com>
>> ---
>>   testcases/kernel/syscalls/setrlimit/setrlimit01.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
>> index ac32450..430835c 100644
>> --- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
>> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
>> @@ -267,7 +267,7 @@ void test3()
>>   			exit(0);
>>   		}
>>   	}
>> -	waitpid(pid,&status, 0);
>> +	while(wait(&status)>  0) { /* no-op */ ; }
>>   	if (WEXITSTATUS(status) != 0) {
>>   		tst_resm(TFAIL, "RLIMIT_NPROC functionality is not correct");
>>   	} else {
> if one child exit unexpectedly, e.g: exit(9);
> the case can't catch it. how about this patch set:
> 
> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c 
> b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
> index ac32450..ec3e54e 100644
> --- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
> @@ -226,6 +226,8 @@ void test2()
>    */
>   void test3()
>   {
> +       int flag = 0;
> +
>          if (getrlimit(RLIMIT_NPROC, &save_rlim) < 0) {
>                  tst_brkm(TBROK, cleanup, "getrlimit failed, errno: %d", 
> errno);
>          }
> @@ -267,12 +269,16 @@ void test3()
>                          exit(0);
>                  }
>          }
> -       waitpid(pid, &status, 0);
> -       if (WEXITSTATUS(status) != 0) {
> -               tst_resm(TFAIL, "RLIMIT_NPROC functionality is not 
> correct");
> -       } else {
> -               tst_resm(TPASS, "RLIMIT_NPROC functionality is correct");
> +       while (wait(&status) > 0) {
> +               if (WEXITSTATUS(status) != 0) {
> +                       tst_resm(TFAIL,
> +                           "RLIMIT_NPROC functionality is not correct");
> +                       flag = 1;
> +               }
>          }
> +
> +       if (flag == 0)
> +               tst_resm(TPASS, "RLIMIT_NPROC functionality is correct");

flag is not necessary. no TFAIL means TPASS. Rest looks good for your patch.

Thanks,
Caspar

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
