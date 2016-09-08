From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 8 Sep 2016 11:38:08 +0300
Subject: [LTP] [PATCH 3/4] memcg_lib.sh: Get rid of sleep 1 in
 signal_memcg_process
In-Reply-To: <20160907101902.GA14864@rei.suse.cz>
References: <1472750315-30848-1-git-send-email-chrubis@suse.cz>
 <1472750315-30848-3-git-send-email-chrubis@suse.cz>
 <57C94968.5070609@oracle.com> <20160907101902.GA14864@rei.suse.cz>
Message-ID: <57D12370.9000803@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 09/07/2016 01:19 PM, Cyril Hrubis wrote:
> Hi!
>> A side note.
>>
>> In fact, in LTP we use 'local' in test cases written for '/bin/sh',
>> whereas 'local' is not in POSIX. Maybe document this fact in the test
>> writing guidelines?
> 
> Something like that?

Yes.

> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index c7d301f..f927fc6 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -61,6 +61,11 @@ When writing testcases in shell write in *portable shell* only, it's a good
>  idea to try to run the test using alternative shell (alternative to bash, for
>  example dash) too.
> 
> +*Portable shell* means Shell Command Language as defined by POSIX with a
> +exception of few widely used extensions, namely 'local' keyword used inside of
> +functions and '-o' and '-a' test parameters (that are marked as obsolete in
> +POSIX).
> +
>  You can either try to run the testcases on Debian which has '/bin/sh' pointing
>  to 'dash' by default or install 'dash' on your favorite distribution and use
>  it to run the tests. If your distribution lacks 'dash' package you can always
> 
