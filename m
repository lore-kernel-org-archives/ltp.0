From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 15 Sep 2018 06:50:41 -0400 (EDT)
Subject: [LTP] LTP master: arm64: execveat03: execveat() returned
 unexpected errno: EINVAL
In-Reply-To: <CA+G9fYsEqrXhTK=TJ0m8aTDonEG39HT1aLnV4GnsZuHB7c38ow@mail.gmail.com>
References: <CA+G9fYsEqrXhTK=TJ0m8aTDonEG39HT1aLnV4GnsZuHB7c38ow@mail.gmail.com>
Message-ID: <811224868.48837664.1537008641635.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> LTP master testing on Hikey (arm64) device reported newly added
> execveat03 failed.

Looks expected if your kernel doesn't have commit:
      355139a8dba4 ("cap_inode_getsecurity: use d_find_any_alias()
                     instead of d_find_alias()")

Can you confirm?

> 
> Test output,
> execveat03.c:74: FAIL: execveat() returned unexpected errno: EINVAL
> 
> Full log link,
> https://lkft.validation.linaro.org/scheduler/job/420924#L2941
> 
> FYI,
> LTP Version: 20180515-270-ge7bab6188
> 
> Best regards
> 
> Naresh Kamboju
> 
