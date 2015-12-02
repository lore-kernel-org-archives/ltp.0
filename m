From: Lijin(Euler Dept 8) <lijin14@huawei.com>
Date: Wed, 2 Dec 2015 14:05:03 +0800
Subject: [LTP] [PATCH] Fix wrong pattern used by fnmatch in test case
 proc01.c
In-Reply-To: <20151201171023.GA11288@tarantula.localdomain>
References: <1448606649-141790-1-git-send-email-King.lijin@huawei.com>
 <1448606649-141790-2-git-send-email-King.lijin@huawei.com>
 <733187539.20734579.1448887572067.JavaMail.zimbra@redhat.com>
 <565CF833.4070101@huawei.com>
 <619455416.21202777.1448958949649.JavaMail.zimbra@redhat.com>
 <565D69AA.1030604@huawei.com> <20151201171023.GA11288@tarantula.localdomain>
Message-ID: <565E8A0F.7060105@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2015/12/2 1:10, Jeffrey Bastian wrote:
> On Tue, Dec 01, 2015 at 05:34:34PM +0800, Lijin(Euler Dept 8) wrote:
>> On 2015/12/1 16:35, Jan Stancek wrote:
>>> I'm curious on what distro and glibc version original code is failing for you.
>>
>> redhat RHEL 6 and /lib64/libc.so.6 - GNU C Library (GNU libc) stable release version 2.17, by Roland McGrath et al.
> 
> RHEL6 had glibc-2.12 and kernel-2.6.32, so you must have a locally built
> version of glibc-2.17 and kernel-4.1?

Hi Jeffrey and Jan

Use this thread for future discuss.


Jan,

Sorry for wrong info in the last email. The right glibc and kernel version should be:

[root@localhost ~]# cat /etc/redhat-release
Red Hat Enterprise Linux Server release 7.0 (Maipo)
[root@localhost ~]#
[root@localhost ~]# rpm -qa glibc
glibc-2.17-68.sa1.4.aarch64
[root@localhost ~]# uname -r
4.1.12

> 
> What locale are you using?  There is an open bug about the * glob not
> working on multibyte characters, and although there should not be any
> multibyte characters in the /proc/sys/net/ipv6/conf/*/stable_secret
> path, I wonder if this is somehow related?
>   https://sourceware.org/bugzilla/show_bug.cgi?id=14185
> 
> It might be worth trying different values of $LANG and/or $LC_ALL to see
> if that helps or not, especially LANG=C and LC_ALL=C.

Jeffrey,

Thanks your info. My default locale is "en_US.UTF-8". Then I set the locale as follows but get the same error

[root@localhost ~]# export LC_ALL=C
[root@localhost ~]# export LANG=C
[root@localhost ~]# ./proc01
proc01      0  TINFO  :  /proc/sys/fs/binfmt_misc/register: is write-only.
proc01      1  TFAIL  :  proc01.c:392: read failed: /proc/sys/net/ipv6/conf/all/stable_secret: errno=EIO(5): Input/output error
proc01      2  TFAIL  :  proc01.c:392: read failed: /proc/sys/net/ipv6/conf/bond0/stable_secret: errno=EIO(5): Input/output error


Regards,

Jin
> 


