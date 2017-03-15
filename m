From: Li Wang <liwang@redhat.com>
Date: Wed, 15 Mar 2017 10:36:28 +0800
Subject: [LTP] [PATCH] ltp: detect the test id automatically
In-Reply-To: <20170314164947.GA9183@rei.lan>
References: <20170314072529.24567-1-liwang@redhat.com>
 <20170314164947.GA9183@rei.lan>
Message-ID: <CAEemH2e=GzAU5U9AMbzmw2BaSD7YvrOMNutS5ZOrHNOvMa2F=g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 15, 2017 at 12:49 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> +static void get_tid(char *argv[])
>> +{
>> +     char *p;
>> +
>> +     tst_test->tid = (p = strrchr(argv[0], '/')) ? p+1 : argv[0];
>> +}
>
> This is interesting idea, but this oneliner is ugly and does not work
> when you execute the testcase by full path, i.e.
> /opt/ltp/testcases/bin/foo01 would end up with
> opt/ltp/testcases/bin/foo01 in tid.

Really?

This words is cut from strrchr() Manual page.

"DESCRIPTION

       The strrchr() function returns a pointer to the last occurrence
 of  the  character  c  in  the
       string s.
"

And it does work while testing from this simple C program:

$ cat get_filename.c

#include <stdio.h>
#include <string.h>

void main(int argc, char *argv[])
{
    char *f, *p ;

    f = (p=strrchr(argv[0],'/')) ? p+1 : argv[0];

    printf("file name = %s\n", f);
}


$ gcc get_filename.c -o get_filename

$ ./testcases/kernel/syscalls/ioctl/get_filename
file name = get_filename


Actually I have tested some kind of situation and compile the whole
LTP with this change, I didn't find any abnormal things which involved
by this path :)

>
> And I wonder if we can avoid runtime detection, which is always tricky.
> Maybe we can just do:
>
> struct tst_test test = {
>         .id = __FILE__,
> };
>
> And strip the .c suffix in the test library if present. That way we
> would avoid this kind of copy&paste errors.

Hmm, I have no objection with this method, but it seems still need the
author to write ".tid = __FILE__" each time. To strip the .c suffix is
also need additional work in some place.



-- 
Regards,
Li Wang
Email: liwang@redhat.com
