From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 18 Sep 2018 04:59:49 +0530
Subject: [LTP] LTP master: arm64: execveat03: execveat() returned
 unexpected errno: EINVAL
In-Reply-To: <811224868.48837664.1537008641635.JavaMail.zimbra@redhat.com>
References: <CA+G9fYsEqrXhTK=TJ0m8aTDonEG39HT1aLnV4GnsZuHB7c38ow@mail.gmail.com>
 <811224868.48837664.1537008641635.JavaMail.zimbra@redhat.com>
Message-ID: <CA+G9fYvJuTiu88fo5Qwsrb1jLZ6abB=iAivow-j2-YWcNpa4Fg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 15 September 2018 at 16:20, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
>> LTP master testing on Hikey (arm64) device reported newly added
>> execveat03 failed.
>
> Looks expected if your kernel doesn't have commit:
>       355139a8dba4 ("cap_inode_getsecurity: use d_find_any_alias()
>                      instead of d_find_alias()")
>
> Can you confirm?

This required patch was not included on the kernel that have tested.
Thanks for sharing information.

- Naresh
