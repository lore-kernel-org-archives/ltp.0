Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1RrtQt-0000At-A7
	for ltp-list@lists.sourceforge.net; Mon, 30 Jan 2012 15:46:15 +0000
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RrtQr-0000SA-IO
	for ltp-list@lists.sourceforge.net; Mon, 30 Jan 2012 15:46:15 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C887125
	for <ltp-list@lists.sourceforge.net>;
	Mon, 30 Jan 2012 15:45:51 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CC65927A8
	for <ltp-list@lists.sourceforge.net>;
	Mon, 30 Jan 2012 15:45:51 +0000 (GMT)
Message-ID: <4F26BB2C.9040307@st.com>
Date: Mon, 30 Jan 2012 16:45:48 +0100
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
MIME-Version: 1.0
References: <1327481724-28367-1-git-send-email-salvatore.cro@st.com>
	<4F1FEEEF.2080506@st.com> <4F1FF526.7030701@st.com>
In-Reply-To: <4F1FF526.7030701@st.com>
Subject: Re: [LTP] [PATCH] syscalls: fix creat07 setup and argv to execve
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
To: ltp-list@lists.sourceforge.net

On 25/01/2012 13.27, Salvatore CRO' wrote:
> On 1/25/2012 1:00 PM, Carmelo AMOROSO wrote:
>> On 25/01/2012 9.55, Salvatore CRO' wrote:
>>> Fix test_path variable logic in setup function.
>>> Also use a new argv variable to be passed to execve.
>>>
>>> Signed-off-by: Salvatore Cro<salvatore.cro@st.com>
>>> ---
>>>   testcases/kernel/syscalls/creat/creat07.c |   12 ++++++------
>>>   1 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
>>> index 4ed2c22..43a6030 100644
>>> --- a/testcases/kernel/syscalls/creat/creat07.c
>>> +++ b/testcases/kernel/syscalls/creat/creat07.c
>>> @@ -90,9 +90,8 @@ int main(int ac, char **av)
>>>   			tst_brkm(TBROK|TERRNO, cleanup, "fork #1 failed");
>>>
>>>   		if (pid == 0) {
>>> -			char *av[1];
>>> -			av[0] = basename(test_app);
>>> -			(void)execve(test_app, av, NULL);
>>> +			char *argv[] = { test_app, NULL };
>>> +			(void)execve(test_app, argv, NULL);
>>>   			perror("execve failed");
>>>   			exit(1);
>>>   		}
>>> @@ -138,14 +137,15 @@ void setup(char *app)
>>>   	char *cmd, *pwd = NULL;
>>>   	char test_path[MAXPATHLEN];
>>>
>>> -	if (test_app[0] == '/')
>>> -		strncpy(test_path, test_app, sizeof(test_app));
>>> +	if (app[0] == '/')
>>> +		snprintf(test_path, sizeof(test_path), "%s/%s",
>>> +				dirname(app), test_app);
>>>   	else {
>>>   		if ((pwd = get_current_dir_name()) == NULL)
>>>   			tst_brkm(TBROK|TERRNO, NULL, "getcwd failed");
>>>
>>>   		snprintf(test_path, sizeof(test_path), "%s/%s",
>>> -		    pwd, basename(test_app));
>>> +		    pwd, test_app);
>>>
>>>   		free(pwd);
>>>   	}
>> Hi Salvo,
>> could you clarify why this change is needed ?
> 
> test_app is defined as follows :
> 
> #define test_app "test1"
> 
> so
> 
> if (test_app[0] == '/')
> 
> was a typo and segfaulting in uClibc.
> 
> The test (app) could have been invoked either from 1) <test path> or 2) 
> from another path :
>   - 1) test_path for test_app is pwd/test_app (not pwd/basename(test_path))
>   - 2) test_path is dirname(app)/test_app (not test_app)
> 
> Furthermore change related to argv variable is mostly a tidy-up plus 
> again drop of
> basename(test_app).
> 
> Hope it's clear enough ;-)
> 
> 

Hi Salvo,
could you re-elaborate the patch description, and post it again.
Great catch anyway !

Cheers,
Carmelo

>> cheers
>>
>> ------------------------------------------------------------------------------
>> Keep Your Developer Skills Current with LearnDevNow!
>> The most comprehensive online learning library for Microsoft developers
>> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
>> Metro Style Apps, more. Free future releases when you subscribe now!
>> http://p.sf.net/sfu/learndevnow-d2d
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 
> ------------------------------------------------------------------------------
> Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-d2d
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
