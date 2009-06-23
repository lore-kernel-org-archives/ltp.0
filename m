Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MJ84R-0003yW-5A
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:38:03 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJ84P-0003XG-Et
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:38:03 +0000
Date: Tue, 23 Jun 2009 17:41:15 +0200
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
MIME-Version: 1.0
References: <200906220117.n5M1HTVJ004183@e2.ny.us.ibm.com>
	<1245768543.4860.65.camel@subratamodak.linux.ibm.com>
Message-ID: <op.uvzhu1pnu2flwt@debian>
In-Reply-To: <1245768543.4860.65.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Fix cleanup procedure in the setuid04 test
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

On Tue, 23 Jun 2009 16:49:03 +0200, Subrata Modak  
<subrata@linux.vnet.ibm.com> wrote:

> On Tue, 2009-05-12 at 19:06 +0200, Jiri Palecek wrote:
>> Cleanup has to be made only once in the parent process; when the
>>  child makes the cleanup itself, the parent has nothing to cleanup,
>>  which makes him sad.
>>
>> Signed-off-by: Jiri Palecek <jpalecek@web.de>
>
> Thanks.

Oh no, at the second sight I see I've posted a wrong (old) version of the  
patch. I'll send a correction shortly.

Sorry for the buzz

   Jiri Palecek

>> ---
>>  testcases/kernel/syscalls/setuid/setuid04.c |    7 +++----
>>  1 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/setuid/setuid04.c  
>> b/testcases/kernel/syscalls/setuid/setuid04.c
>> index 18f1d90..26a3868 100644
>> --- a/testcases/kernel/syscalls/setuid/setuid04.c
>> +++ b/testcases/kernel/syscalls/setuid/setuid04.c
>> @@ -114,7 +114,7 @@ void do_master_child()
>>  	int status;
>>
>>  	if (setuid(ltpuser->pw_uid) == -1) {
>> -		tst_brkm(TBROK, cleanup,
>> +		tst_brkm(TBROK, tst_exit,
>>  			 "setuid failed to set the effective uid to %d",
>>  			 ltpuser->pw_uid);
>>  	}
>> @@ -143,7 +143,7 @@ void do_master_child()
>>
>>  		pid = FORK_OR_VFORK();
>>  		if (pid < 0)
>> -			tst_brkm(TBROK, cleanup, "Fork failed");
>> +			tst_brkm(TBROK, tst_exit, "Fork failed");
>>
>>  		if (pid == 0) {
>>  			int tst_fd2;
>> @@ -160,13 +160,12 @@ void do_master_child()
>>
>>  			if (TEST_ERRNO == EACCES) {
>>  				tst_resm(TPASS, "open returned errno EACCES");
>> -				exit(0);
>>  			} else {
>>  				tst_resm(TFAIL,
>>  					 "open returned unexpected errno - %d",
>>  					 TEST_ERRNO);
>> -				exit(-1);
>>  			}
>> +			tst_exit();
>>  		} else {
>>  			/* Wait for son completion */
>>  			waitpid(pid, &status, 0);
>



-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/

------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
