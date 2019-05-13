From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 13 May 2019 03:16:11 -0400 (EDT)
Subject: [LTP] LTP: Syscalls: 274 failures: EROFS(30): Read-only file
	system
In-Reply-To: <CA+G9fYuLXPnCmpnnLqBf5qinV6wrFx=HBH2KrB8s1HmCxLM=Zw@mail.gmail.com>
References: <CA+G9fYuLXPnCmpnnLqBf5qinV6wrFx=HBH2KrB8s1HmCxLM=Zw@mail.gmail.com>
Message-ID: <1723398651.22256606.1557731771283.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> We have noticed 274 syscall test failures on x86_64 and i386 due to
> Make the temporary directory in one shot using mkdtemp failed.
> tst_tmpdir.c:264: BROK: tst_tmpdir:
> mkdtemp(/scratch/ltp-7D8vAcYeFG/OXuquJ) failed: EROFS

Looks like ext4 bug:

[ 1916.032087] EXT4-fs error (device sda): ext4_find_extent:909: inode #8: comm jbd2/sda-8: pblk 121667583 bad header/extent: invalid extent entries - magic f30a, entries 8, max 340(340), depth 0(0)
[ 1916.073840] jbd2_journal_bmap: journal block not found at offset 4455 on sda-8
[ 1916.081071] Aborting journal on device sda-8.
[ 1916.348652] EXT4-fs error (device sda): ext4_journal_check_start:61: Detected aborted journal
[ 1916.357222] EXT4-fs (sda): Remounting filesystem read-only

So best place for report is likely linux-ext4@vger.kernel.org

> 
> Failed log:
> ------------
> pread01     1  TBROK  :  tst_tmpdir.c:264: tst_tmpdir:
> mkdtemp(/scratch/ltp-7D8vAcYeFG/preAUvXAE) failed: errno=EROFS(30):
> Read-only file system
> pread01     2  TBROK  :  tst_tmpdir.c:264: Remaining cases broken
> 
> full test log,
> --------------
> https://lkft.validation.linaro.org/scheduler/job/711826#L7834
> 
> LTP Version: 20190115
> 
> Kernel bad commit:
> ------------
> git branch master
> git commit dd5001e21a991b731d659857cd07acc7a13e6789
> git describe v5.1-3486-gdd5001e21a99
> git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> Kernel good commit:
> ------------
> git branch master
> git commit d3511f53bb2475f2a4e8460bee5a1ae6dea2a433
> git describe v5.1-3385-gd3511f53bb24
> git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> Best regards
> Naresh Kamboju
> 
