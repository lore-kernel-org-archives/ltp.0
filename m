From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 25 Aug 2016 15:00:33 +0300
Subject: [LTP] [PATCH V2 05/11] syscalls/waitpid: implement
 waitpid_ret_test()
In-Reply-To: <20160825112858.GE10490@rei.lan>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1472041679-29759-6-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160825112858.GE10490@rei.lan>
Message-ID: <57BEDDE1.6070105@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 08/25/2016 02:28 PM, Cyril Hrubis wrote:
> Hi!
>> +	if (TST_TRACE(waitpid_ret_test(-1, &status, WNOHANG | WUNTRACED,
>> +				       0, 0)))
>>  		return;
> 
> Hmm, I know this is merely cosmetic but as far as I can tell the line
> fits into 80 chars. Or did checkpatch complained since it has precisely
> 80 chars?

No, it didn't complain about that. I'll put this all on one line.

> 
> If that is the case what about shortening the waitpid_ret_test() to
> waitpid_test()?
> 
