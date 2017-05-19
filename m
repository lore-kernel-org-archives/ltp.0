From: Li Wang <liwang@redhat.com>
Date: Fri, 19 May 2017 15:08:50 +0800
Subject: [LTP] [PATCH 1/2] ltp/numa: add new test11
In-Reply-To: <20170518134655.GD29477@rei.lan>
References: <1488526490-22120-1-git-send-email-liwang@redhat.com>
 <20170518134655.GD29477@rei.lan>
Message-ID: <CAEemH2fh57oNuNVhCg5xCYHDb1+2MNqQfMUngwjqsSFt1Nny1g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 18, 2017 at 9:46 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> @@ -52,16 +52,43 @@ static void help(void)
>>       printf("Input:  Describe input arguments to this program\n");
>>       printf("        argv[1] == 1 then allocate 1MB of memory\n");
>>       printf("        argv[1] == 2 then allocate 1MB of share memory\n");
>> -     printf("        argv[1] == 3 then pause the program to catch sigint\n");
>> +     printf("        argv[1] == 3 then allocate 1HUGE PAGE SIZE of memory\n");
>> +     printf("        argv[1] == 4 then pause the program to catch sigint\n");
>>       printf("Exit:   On failure - Exits with non-zero value\n");
>>       printf("        On success - exits with 0 exit value\n");
>
> Can we, pretty please, change this parameter to a string that describes
> the operation?

Sure, sounds good. But I hope to change this in a new patch, because
these exist two are focus on different issues.  I don't wanna mess
things up.


-- 
Regards,
Li Wang
Email: liwang@redhat.com
