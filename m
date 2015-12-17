From: Li Wang <liwang@redhat.com>
Date: Thu, 17 Dec 2015 16:45:33 +0800
Subject: [LTP] [PATCH] syscalls/creat/creat09: fix error check of create
	syscall
In-Reply-To: <CAEemH2dhqL8jjLSKA9=S4vTL9mDNqBo9wZjpVS-N3jVHvtDYqg@mail.gmail.com>
References: <330BE2030BD7834286495D8B7FCF1FB71D338D22@mbx01.itr.canon-is.co.jp>
 <CAEemH2dhqL8jjLSKA9=S4vTL9mDNqBo9wZjpVS-N3jVHvtDYqg@mail.gmail.com>
Message-ID: <CAEemH2dj8rRKLjTpDDqW2xs-XmuewNA=+=qyuUjgJ3EuQ7zqpg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Thu, Dec 17, 2015 at 3:27 PM, Li Wang <liwang@redhat.com> wrote:

> Hi,
>
>>
>>
>> diff -uprN a/testcases/kernel/syscalls/creat/creat09.c
>> b/testcases/kernel/syscalls/creat/creat09.c
>> --- a/testcases/kernel/syscalls/creat/creat09.c 2015-12-03
>> 05:53:41.000000000 +0900
>> +++ b/testcases/kernel/syscalls/creat/creat09.c 2015-12-06
>> 01:48:34.757125367 +0900
>> @@ -139,9 +139,13 @@ int main(int ac, char **av)
>>
>>                 TEST(creat(fname, 0700));
>>
>> -               if (TEST_RETURN == -1) {
>> +               if (TEST_RETURN != -1) {
>>                         tst_resm(TPASS, "creat(%s, 0700) returned %ld",
>>                                  fname, TEST_RETURN);
>> +               } else {
>> +                       tst_resm(TFAIL | TTERRNO, "creat(%s, 0700)
>> FAILED",
>> +                                fname);
>> +                       continue;
>
>
> why using continue here?   it will skip some cleanup codes in the
> following.
>
>
oops!! if no "continue" here,  the process will going to handle wrong file
descriptor.

you are right, sorry for make noise here, pls ignore my comments.

---
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151217/a1b8e7aa/attachment.html>
