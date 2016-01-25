From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 25 Jan 2016 12:03:39 +0300
Subject: [LTP] Some LTP testcases are getting failed
In-Reply-To: <MA1PR01MB00562DFACF1908498176882C82C70@MA1PR01MB0056.INDPRD01.PROD.OUTLOOK.COM>
References: <MA1PR01MB00562DFACF1908498176882C82C70@MA1PR01MB0056.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <56A5E4EB.4050802@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 01/25/2016 11:02 AM, Raghavendra Kakarla wrote:
> Hi All,
>
> I built the LTP for the yocto and ran it on the My board which has the
> Mips interaptive CPU.
>
> After running all tests 42 test are getting failed.
>
> I have examine the each failed test case and noted down the issue.
>
> Following test cases are failed:
>
> 1.bind02 - unable to open the socket to testuser
> 2.chmod06 - Device busy error.
> 3.getrusage03 - memory allocation failed
> 4.Readahead02 - Page cache on our system is too small to hold whole
> testfile.
> 5.rt_sigaction01 - Gives the buss error.

Regarding rt_sigaction01. Just a wild guess. Maybe ltp_rt_sigaction() in 
include/lapi/rt_sigaction.h needs some MIPS-specific changes. Anyway, it 
would be better if you provided the test output.




>
> Could you please help me to resolving this issues.
>
> Thanks in Advance.
>
> Regards,
> Raghavendra K.
>
>
>
>
