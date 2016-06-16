From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 16 Jun 2016 11:46:17 +0300
Subject: [LTP] new ltp lib doesn't print actual error
In-Reply-To: <488657345.6790022.1466011700050.JavaMail.zimbra@redhat.com>
References: <57618B7B.9070402@oracle.com>
 <488657345.6790022.1466011700050.JavaMail.zimbra@redhat.com>
Message-ID: <57626759.9020707@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 06/15/2016 08:28 PM, Jan Stancek wrote:
>
>
>
> ----- Original Message -----
>> From: "Alexey Kodanev" <alexey.kodanev@oracle.com>
>> To: ltp@lists.linux.it
>> Sent: Wednesday, 15 June, 2016 7:08:11 PM
>> Subject: [LTP] new ltp lib doesn't print actual error
>>
>> Hi,
>>
>> When running a test with the new LTP lib, noticed that if some error
>> occurs in a library (tst_tmpdir.c), it'll print the same message:
>>
>> TMPDIR=/usr ./creat01
>> tst_tmpdir.c:155: BROK: Non-NULL cleanup in newlib!
>>
>> but should be:
>> TMPDIR=/usr ./creat01
>> tst_tmpdir.c:155: BROK: tst_tmpdir: mkdtemp(/usr/creF5DhMS) failed: EACCES
>>
>>
>> May be we should remove the strict check in tst_res.c? Otherwise we
>> don't see the actual error.
> Or turn it into warning, so that we get both failures. tst_tmpdir() needs
> a fix to not pass cleanup function for newlib testcases.
>
> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index b388d0d2e516..ab9759b9263b 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -548,8 +548,8 @@ void tst_brkm_(const char *file, const int lineno, int ttype,
>
>          if (tst_test) {
>                  if (func) {
> -                       tst_brk_(file, lineno, TBROK,
> -                                "Non-NULL cleanup in newlib!");
> +                       tst_resm(TWARN, "Non-NULL cleanup in newlib! %s:%d",
> +                               file, lineno);
>                  }
>
>                  tst_brk_(file, lineno, ttype, "%s", tmesg);

OK, we can do that, I just thought why we need to print it as it's not 
related to the test...

Best regards,
Alexey
