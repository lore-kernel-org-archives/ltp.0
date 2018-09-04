From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 4 Sep 2018 16:27:17 +0800
Subject: [LTP] [PATCH] syscalls/mlock203: Add new regression testcase
In-Reply-To: <1090164327.44377797.1536049202389.JavaMail.zimbra@redhat.com>
References: <1535008217-27041-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1090164327.44377797.1536049202389.JavaMail.zimbra@redhat.com>
Message-ID: <5B8E41E5.308@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/09/04 16:20, Jan Stancek wrote:
>
> ----- Original Message -----
>> This issue has been fixed in kernel:
>> 'b155b4fde5bd("mm: mlock: avoid increase mm->locked_vm on mlock() when
>> already mlock2(,MLOCK_ONFAULT)")'
>>
>> Note:
>> This patch is based on the following patch set:
>> http://lists.linux.it/pipermail/ltp/2018-August/009086.html
>> http://lists.linux.it/pipermail/ltp/2018-August/009085.html
>> http://lists.linux.it/pipermail/ltp/2018-August/009084.html
>> http://lists.linux.it/pipermail/ltp/2018-August/009087.html
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Pushed with tweaked commit message.
Hi Jan,

Thank you for the whole patchset review.

Thanks,
Xiao Yang

> Thanks,
> Jan
>
>
>



