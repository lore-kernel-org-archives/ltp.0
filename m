From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Nov 2015 17:00:46 +0800
Subject: [LTP] [PATCH v2] hugetlb: checking if hugepage is supported on
 target system
In-Reply-To: <5656C72C.4090203@oracle.com>
References: <1448506629-12150-1-git-send-email-liwang@redhat.com>
 <5656C72C.4090203@oracle.com>
Message-ID: <CAEemH2cUXFEMk1MXt=-eyjc3s0sinn4X2J89CxPmyKy5uZr3uw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Thu, Nov 26, 2015 at 4:47 PM, Alexey Kodanev <alexey.kodanev@oracle.com>
wrote:

> Hi,
> On 11/26/2015 05:57 AM, Li Wang wrote:
>
>> Signed-off-by: Li Wang <liwang@redhat.com>
>> ---
>>
> ...
>
>> -       if (write(fd, nr_hugepages,
>> +       if ((unsigned int)write(fd, nr_hugepages,
>>                   strlen(nr_hugepages)) != strlen(nr_hugepages))
>>                 tst_resm(TWARN | TERRNO, "write");
>>         close(fd);
>> @@ -271,7 +270,7 @@ static void cleanup(void)
>>                 tst_resm(TWARN | TERRNO, "open");
>>         tst_resm(TINFO, "restore nr_overcommit_hugepages to %s.",
>>                  nr_overcommit_hugepages);
>> -       if (write(fd, nr_overcommit_hugepages,
>> strlen(nr_overcommit_hugepages))
>> +       if ((unsigned int)write(fd, nr_overcommit_hugepages,
>> strlen(nr_overcommit_hugepages))
>>             != strlen(nr_overcommit_hugepages))
>>
>
> It would be better to use ssize_t, that way you won't exceed 80c per line
> as well.
>
> if (write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
>             != (ssize_t)strlen(nr_overcommit_hugepages))
>

good.


>
>
>                 tst_resm(TWARN | TERRNO, "write");
>>         close(fd);
>> @@ -287,7 +286,7 @@ static void cleanup(void)
>>         tst_rmdir();
>>   }
>>   -static void setup(void)
>> +void setup(void)
>>
>
> forgot "static"?
>

no, it will be conflict with the prototype in mem.h and get compiler error
like:
-------
hugemmap05.c:253: error: static declaration of ?cleanup? follows non-static
declaration
/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150903/testcases/kernel/mem/include/mem.h:100:
note: previous declaration of ?cleanup? was here
hugemmap05.c:295: error: static declaration of ?setup? follows non-static
declaration
/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150903/testcases/kernel/mem/include/mem.h:101:
note: previous declaration of ?setup? was here
make: *** [hugemmap05] Error 1



>
> ...
>
>>   diff --git a/testcases/kernel/mem/lib/mem.c
>> b/testcases/kernel/mem/lib/mem.c
>> index 215c052..84af3ce 100644
>> --- a/testcases/kernel/mem/lib/mem.c
>> +++ b/testcases/kernel/mem/lib/mem.c
>> @@ -314,6 +314,12 @@ static void verify(char **memory, char value, int
>> proc,
>>         free(s);
>>   }
>>
>>
> ...
>
>> +       if (access(PATH_HUGEPAGES, F_OK) == -1)
>>
> Could be
> if (access(PATH_HUGEPAGES, F_OK))
>        tss_brkm(...);
>

looks good.


>
> +               tst_brkm(TCONF, NULL, "Huge page is not supported.");
>> +
>>         tst_tmpdir();
>>         SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
>>
>
> Thanks,
> Alexey
>

thanks for reviewing.

-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151126/0b39a56f/attachment.html>
