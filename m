From: Kshitij Malik <Kshitij.Malik@mitel.com>
Date: Wed, 23 Mar 2016 02:54:59 +0000
Subject: [LTP] readahead02 failure on PPC
Message-ID: <f688d3da-69f3-4199-b3a4-e603130414d1@email.android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Julio,

Thank you for the update.

I was also getting the /proc/pid/io error to start with and I fixed it by enabling kernel configurations CONFIG_TASKSTATS, CONFIG_TASK_IO_ACCOUNTING and other related configs.

These configs creates the io directory for a thread in proc.

Jan,

Do you think your fix can be used as an official patch?

Thanks
KK

On Mar 22, 2016 22:39, Julio Cruz Barroso <julio.cruz@smartmatic.com> wrote:
>
> Hi Jan, Kshitij,
>
> Checking my logs (imx6 32bits based platform) the error is similar [1]:
>
> readahead02 0 TWARN : readahead02.c:324: using less cache than expected
>
> However, the results were not consistent, because, once time PASS and another FAIL (with previous TWARN).
>
> Another thing different was (in my case):
>
> readahead02 3 TCONF : readahead02.c:309: Your system doesn't have /proc/pid/io, unable to determine read bytes during test
>
> This last one, is the part 1 of the test case (read bytes during test). The part 2 (verify the cache) is the same TWARN.
>
> At the end, I skipped this test case because the results were not consistent and need further analysis.
>
> Regards,
> Julio
>
>
> [1] logs for imx6: https://justpaste.it/s4zk
>
> -----Original Message-----
> From: ltp [mailto:ltp-bounces+julio.cruz=smartmatic.com@lists.linux.it] On Behalf Of Julio Cruz Barroso
> Sent: Tuesday, March 22, 2016 11:19 PM
> To: Jan Stancek
> Cc: Julio Cruz; Kshitij Malik; ltp@lists.linux.it
> Subject: Re: [LTP] readahead02 failure on PPC
>
> Hi Jan, Kshitij,
>
> I just saw this email!
>
> I will review the issue because I cannot remember the result details and let you know tomorrow (CST).
>
> I expect also to upload the others patchs reviewed.
>
> Regards
>
> Julio
>
>
> > On Mar 22, 2016, at 5:50 PM, Jan Stancek <jstancek@redhat.com> wrote:
> >
> > Kshitij
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
________________________________
NOTE: This e-mail (including any attachments) is for the sole use of the intended recipient(s) and may contain information that is confidential and/or protected by legal privilege. Any unauthorized review, use, copy, disclosure or distribution of this e-mail is strictly prohibited. If you are not the intended recipient, please notify Mitel immediately and destroy all copies of this e-mail. Mitel does not accept any liability for breach of security, error or virus that may result from the transmission of this message.
