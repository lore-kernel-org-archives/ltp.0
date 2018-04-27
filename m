From: Li Wang <liwang@redhat.com>
Date: Fri, 27 Apr 2018 10:59:28 +0800
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <20180426134726.GA14157@x230>
References: <20180426132418.19495-1-schlad@suse.de>
 <20180426132418.19495-2-schlad@suse.de>
 <20180426134726.GA14157@x230>
Message-ID: <CAEemH2cudV8HNH6GqhTVSkfhwYt_YuZ4W=cBxhAiMHtx9GASDg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, Apr 26, 2018 at 9:47 PM, Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> > Test cases testing commands are often outdated or not maintained.
> > Those test cases also do not fit in with current LTP project status.
>
> > Signed-off-by: Sebastian Chlad <schlad@suse.de>
> > ---
> this is controversial, as some people might be using some of them.
> But I'd be for removing most of these - these are mostly smoke tests which
> should be
> in upstream repositories (I guess live projects has better tests than
> these), where they
> have better change to stay up to date.
> Upstream tests are then can be run by packagers (and IMHO they're run, if
> they're
> available).
>

​I often run these command test on upstream kernel, but it always looks
look from the result.
I have no objection to remove them, but keep more test on linux distro is
better i think.



>
> IMHO LTP should aim to test kernel, not userspace tools for Linux distros.
>
>
Yes i agree, ​at least those crossover test case should be cleanup.

​

commands Passed:
Test Start Time: Wed Apr 25 05:19:56 2018
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
ar                             PASS       0
ld01                           PASS       0
ldd01                          PASS       0
nm01                           PASS       0
file01                         PASS       0
tar01                          PASS       0
cron                           PASS       0
logrotate                      PASS       0
cpio01                         PASS       0
unzip01                        PASS       0
gzip01                         PASS       0
cp01                           PASS       0
ln01                           PASS       0
mkdir01                        PASS       0
mv01                           PASS       0
du01                           PASS       0
df01_ext2                      PASS       0
df01_ext3                      PASS       0
df01_ext4                      PASS       0
df01_xfs                       PASS       0
df01_vfat                      CONF       32
df01_exfat                     CONF       32
df01_ntfs                      CONF       32
mkfs01                         PASS       0
mkfs01_ext2                    PASS       0
mkfs01_ext3                    PASS       0
mkfs01_ext4                    PASS       0
mkfs01_xfs                     CONF       32
mkfs01_btrfs                   CONF       32
mkfs01_minix                   CONF       32
mkfs01_msdos                   CONF       32
mkfs01_vfat                    CONF       32
mkfs01_ntfs                    CONF       32
mkswap01                       PASS       0
which01                        PASS       0
lsmod01                        PASS       0
insmod01                       PASS       0
wc01                           PASS       0
keyctl01                       PASS       0
gdb01                          PASS       0
unshare01                      PASS       0
sysctl01                       PASS       0

-----------------------------------------------
Total Tests: 42
Total Skipped Tests: 9
Total Failures: 0
Kernel Version: 4.17.0-rc2
Machine Architecture: x86_64

​

-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180427/f818656f/attachment.html>
