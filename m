Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XWOec-0001l5-Uu
	for ltp-list@lists.sourceforge.net; Tue, 23 Sep 2014 11:53:10 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XWOec-0006Wr-1h
	for ltp-list@lists.sourceforge.net; Tue, 23 Sep 2014 11:53:10 +0000
Message-ID: <54215F1B.5000601@oracle.com>
Date: Tue, 23 Sep 2014 15:52:59 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <722837953.31209749.1410431446352.JavaMail.zimbra@redhat.com>
	<5411ABF0.9070704@oracle.com>
	<867308142.34479006.1411109217618.JavaMail.zimbra@redhat.com>
In-Reply-To: <867308142.34479006.1411109217618.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 1/3] fcntl14: dup code clean up
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
To: Xiong Zhou <xzhou@redhat.com>, ltp-list@lists.sourceforge.net

Hi!

On 09/19/2014 10:46 AM, Xiong Zhou wrote:
>
>
> ----- Original Message -----
>> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
>> To: "Xiong Zhou" <xzhou@redhat.com>, ltp-list@lists.sourceforge.net
>> Sent: Thursday, September 11, 2014 10:04:32 PM
>> Subject: Re: [LTP] [PATCH 1/3] fcntl14: dup code clean up
>>
>> Hi!
>>
>> On 09/11/2014 02:30 PM, Xiong Zhou wrote:
>>> And block3 description message fix from "mandatory locking"
>>> to "negative whence".
>>>
>>> Signed-off-by: Xiong Zhou <xzhou@redhat.com>
>>> ---
>>>    testcases/kernel/syscalls/fcntl/fcntl14.c | 36
>>>    +++++++++++--------------------
>>>    1 file changed, 13 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c
>>> b/testcases/kernel/syscalls/fcntl/fcntl14.c
>>> index 30a1ea9..9db88e8 100644
>>> --- a/testcases/kernel/syscalls/fcntl/fcntl14.c
>>> +++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
>>> @@ -969,6 +969,15 @@ void catch1(int sig)
>>>    	got1++;
>>>    }
>>>
>>> +static void testcheck_end(int check_fail, char *msg)
>>> +{
>>> +	if (check_fail) {
>>> +		tst_resm(TFAIL, "%s FAILED", msg);
>>> +	} else {
>>> +		tst_resm(TPASS, "%s PASSED", msg);
>>> +	}
>>> +}
>>
>> There are many places left in fcntl14.c where you can put this
>> "deduplication". Why aren't you doing it? ;)
>
> I think I have done all of them, I cannot find other places which are applicable to this function.

Sorry, but by "many places" I meant block 2.

Last time I commented your [PATCH 2/3] with "And testcheck_end() to 
block 2 should be introduced in the previous patch."

Could you please add all testcheck_end() invocations in the first patch 
of the series?

Thanks.


>
> I will resend this series based on your last comments.
>
> Thanks.
>
>>
>>> +
>>>    int main(int ac, char **av)
>>>    {
>>>    	int lc;
>>> @@ -1009,20 +1018,11 @@ int main(int ac, char **av)
>>>    		 * mandatory locking
>>>    		 */
>>>    		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, 0, 0, 36);
>>> -		if (fail) {
>>> -			tst_resm(TFAIL, "Block 1, test 1 FAILED");
>>> -		} else {
>>> -			tst_resm(TPASS, "Block 1, test 1 PASSED");
>>> -		}
>>> +		testcheck_end(fail, "Block 1, test 1");
>>>
>>>    		/* Now try with negative values for L_start and L_len */
>>>    		(void)run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, 5, 36, 45);
>>> -
>>> -		if (fail) {
>>> -			tst_resm(TFAIL, "Block 1, test 2 FAILED");
>>> -		} else {
>>> -			tst_resm(TPASS, "Block 1, test 2 PASSED");
>>> -		}
>>> +		testcheck_end(fail, "Block 1, test 2");
>>>
>>>    		tst_resm(TINFO, "Exit block 1");
>>>
>>> @@ -1094,13 +1094,7 @@ int main(int ac, char **av)
>>>    		close(fd);
>>>    		unlink(tmpname);
>>>
>>> -		if (fail) {
>>> -			tst_resm(TINFO, "Test with mandatory "
>>> -				 "locking FAILED");
>>> -		} else {
>>> -			tst_resm(TINFO, "Test with mandatory "
>>> -				 "locking PASSED");
>>> -		}
>>> +		testcheck_end(fail, "Test with negative whence locking");
>>>    		tst_resm(TINFO, "Exit block 3");
>>>
>>>    /* //block4: */
>>> @@ -1223,11 +1217,7 @@ int main(int ac, char **av)
>>>    		close(fd);
>>>    		unlink(tmpname);
>>>
>>> -		if (fail) {
>>> -			tst_resm(TINFO, "Test of locks on file FAILED");
>>> -		} else {
>>> -			tst_resm(TINFO, "Test of locks on file PASSED");
>>> -		}
>>> +		testcheck_end(fail, "Test of locks on file");
>>>    		tst_resm(TINFO, "Exit block 4");
>>>    	}
>>>    	cleanup();
>>>
>>

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
