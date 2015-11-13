From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Nov 2015 13:36:46 +0300
Subject: [LTP] new user to ltp
In-Reply-To: <5645B10B.9030708@aqueos.com>
References: <5645B10B.9030708@aqueos.com>
Message-ID: <5645BD3E.1040709@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 11/13/2015 12:44 PM, Ghislain wrote:
> - vanilla 4.1.12 (lock_torture_re)
> Nov  9 10:12:53 62-210-125-37 kernel: [    0.000000] Linux version 
> 4.1.12 (root@buildjessie64.aqueos.net) (gcc version 4.9.2 (Debian 
> 4.9.2-10) ) #1 SMP Mon Nov 9 09:16:13 CET 2015
> Nov  9 14:51:47 62-210-125-37 kernel: [16455.811285] Writes: Total: 
> 191554485  Max/Min: 0/0   Fail: 0
> Nov  9 14:51:47 62-210-125-37 kernel: [16455.838665] 
> spin_lock_irq-torture: Stopping lock_torture_stats
> Nov  9 14:51:47 62-210-125-37 kernel: [16455.864328] Writes: Total: 
> 191554485  Max/Min: 0/0   Fail: 0
> Nov  9 14:51:47 62-210-125-37 kernel: [16455.888892] 
> spin_lock_irq-torture:--- End of test: SUCCESS: nwriters_stress=8 
> nreaders_stress=0 stat_interval=60 verbose=1 shuffle_interval=3 
> stutter=5 shutdown_secs=0 onoff_interval=0 onoff_holdoff=0
> Nov  9 14:51:47 62-210-125-37 kernel: [16455.954404] 
> rw_lock-torture:--- Start of test: nwriters_stress=4 nreaders_stress=4 
> stat_interval=60 verbose=1 shuffle_interval=3 stutter=5 
> shutdown_secs=0 onoff_interval=0 onoff_holdoff=0
> Nov  9 14:51:47 62-210-125-37 kernel: [16456.016119] rw_lock-torture: 
> Creating torture_shuffle task
> Nov  9 14:51:48 62-210-125-37 kernel: [16456.048085] rw_lock-torture: 
> Creating torture_stutter task
> Nov  9 14:51:48 62-210-125-37 kernel: [16456.048122] rw_lock-torture: 
> torture_shuffle task started
> Nov  9 14:51:48 62-210-125-37 kernel: [16456.109988] rw_lock-torture: 
> Creating lock_torture_writer task
> Nov  9 14:51:48 62-210-125-37 kernel: [16456.110020] rw_lock-torture: 
> torture_stutter task started
> Nov  9 14:51:48 62-210-125-37 kernel: [16456.171992] rw_lock-torture: 
> Creating lock_torture_reader task
> Nov  9 14:51:48 62-210-125-37 kernel: [16456.171996] rw_lock-torture: 
> lock_torture_writer task started
> Nov  9 14:51:48 62-210-125-37 kernel: [16456.233841] rw_lock-torture: 
> Creating lock_torture_writer task
> Nov  9 14:51:48 62-210-125-37 kernel: [16456.233870] rw_lock-torture: 
> lock_torture_reader task started
> Nov  9 14:51:48 62-210-125-37 kernel: [16456.297098] rw_lock-torture: 
> Creating lock_torture_reader task
> Nov  9 14:51:48 62-210-125-37 kernel: [16456.297127] rw_lock-torture: 
> lock_torture_writer task started
>

This test on vanilla Linux kernel prior 4.2-rc1 can trigger kernel panic 
(when running rw_lock_irq test-case).

Here is the fix in upstream:

commit f548d99ef4f5ec8f7080e88ad07c44d16d058ddc
Author: Alexey Kodanev <alexey.kodanev@oracle.com>
Date:   Sat Mar 7 03:06:53 2015 +0300

     locktorture: fix deadlock in 'rw_lock_irq' type

     torture_rwlock_read_unlock_irq() must use read_unlock_irqrestore()
     instead of write_unlock_irqrestore().


Thanks,
Alexey
