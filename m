Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matthltc@us.ibm.com>) id 1MMIYx-0005Ut-Pz
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 09:26:39 +0000
Received: from [32.97.110.149] (helo=e31.co.us.ibm.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMIYo-0003Gl-4F
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 09:26:39 +0000
Date: Thu, 2 Jul 2009 02:13:41 -0700
From: Matt Helsley <matthltc@us.ibm.com>
Message-ID: <20090702091341.GG19135@count0.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [RFC][PATCH] Use prefix and other autoconf variables uniformly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sf.net>

Configure variables are currently not used to fill out the .pc,
.spec, and various Makefiles. This includes variables like prefix,
datarootdir, and mandir. Furthermore, several tests include their
own configure scripts which I suspect should use a similar 
configuration.

This patch extends the autoconfig scripts to substitute those
variables, subconfigure those tests that have their own configure
scripts, and causes all Makefiles to have a uniform PREFIX definition.

The result is a build and install of LTP that doesn't always write files
in /usr/share/man and /opt. Instead it honors --prefix just like any
other autoconf-ified tree.

Since the first step of a build from CVS is "make autotools", we
cannot simply generate the toplevel Makefile from a Makefile.in
with:
	PREFIX=@prefix@

Instead we do that in config.mk.in and include config.mk from all
the Makefiles in LTP. This adds one line to approximately 750 Makefiles,
making this patch relatively large. This can be done in the shell/vim with
something roughly like:

	find ./ -name 'Makefile*' -print0 | xargs -r0 vim
	:silent bufdo 0r!echo include %:h:gs?[^/]\{2,}?..?/config.mk
	update|bnext

Where there's a [Ctrl-V][Ctrl-J] following "config.mk". The "silent"
saves the user from having to page through 750 Vim messages which takes quite
some time.

The ballista/configHints.txt changes may not be correct. Could someone
with knowledge of that test have a look?

This patch modifies both Makefile.in and Makefile.am when it should
really only modify Makefile.am. It may be the case that it's more
effective to regenerate the patch from the shell/vim snippet than to
apply all of the Makefile changes below. Hence this patch is largely
for eliciting comments :).

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
 config.mk.in                                                                                                  |    2 
 configure.ac                                                                                                  |    3 
 doc/man1/Makefile                                                                                             |    3 
 doc/man3/Makefile                                                                                             |    1 
 include/Makefile                                                                                              |    3 
 lib/Makefile                                                                                                  |    4 
 lib/ltp.pc                                                                                                    |   11 
 lib/ltp.pc.in                                                                                                 |   11 
 ltp-devel.spec                                                                                                |   68 
 ltp-devel.spec.in                                                                                             |   68 
 m4/GNUmakefile                                                                                                |    2 
 m4/Makefile.am                                                                                                |    1 
 pan/Makefile                                                                                                  |    3 
 testcases/DOTS/Makefile                                                                                       |    1 
 testcases/DOTS/src/Makefile                                                                                   |    1 
 testcases/DOTS/src/dots/advcase/Makefile                                                                      |    1 
 testcases/DOTS/src/dots/basecase/Makefile                                                                     |    1 
 testcases/DOTS/src/dots/framework/Makefile                                                                    |    1 
 testcases/DOTS/src/dots/perfmon/Makefile                                                                      |    1 
 testcases/Makefile                                                                                            |    1 
 testcases/ballista/Makefile                                                                                   |    1 
 testcases/ballista/ballista/Makefile                                                                          |    1 
 testcases/ballista/ballista/MakefileHost.dist                                                                 |    1 
 testcases/ballista/ballista/MakefileTarget.dist                                                               |    1 
 testcases/ballista/ballista/compile/Makefile                                                                  |    1 
 testcases/ballista/ballista/configHints.txt                                                                   |    2 
 testcases/ballista/ballista/templates/Makefile                                                                |    1 
 testcases/commands/Makefile                                                                                   |    1 
 testcases/commands/ade/Makefile                                                                               |    1 
 testcases/commands/ade/ar/Makefile                                                                            |    1 
 testcases/commands/ade/file/Makefile                                                                          |    1 
 testcases/commands/ade/ld/Makefile                                                                            |    1 
 testcases/commands/ade/ldd/Makefile                                                                           |    1 
 testcases/commands/ade/nm/Makefile                                                                            |    1 
 testcases/commands/ade/objdump/Makefile                                                                       |    1 
 testcases/commands/ade/size/Makefile                                                                          |    1 
 testcases/commands/at/Makefile                                                                                |    1 
 testcases/commands/cpio/Makefile                                                                              |    1 
 testcases/commands/cron/Makefile                                                                              |    1 
 testcases/commands/eject/Makefile                                                                             |    1 
 testcases/commands/fileutils/Makefile                                                                         |    1 
 testcases/commands/fileutils/cp/Makefile                                                                      |    1 
 testcases/commands/fileutils/ln/Makefile                                                                      |    1 
 testcases/commands/fileutils/mkdir/Makefile                                                                   |    1 
 testcases/commands/fileutils/mv/Makefile                                                                      |    1 
 testcases/commands/gzip/Makefile                                                                              |    1 
 testcases/commands/logrotate/Makefile                                                                         |    1 
 testcases/commands/mail/Makefile                                                                              |    1 
 testcases/commands/su/Makefile                                                                                |    1 
 testcases/commands/tar/Makefile                                                                               |    1 
 testcases/commands/tpm-tools/Makefile                                                                         |    1 
 testcases/commands/tpm-tools/tpm/Makefile                                                                     |    1 
 testcases/commands/tpm-tools/tpm/tpm_changeauth/Makefile                                                      |    1 
 testcases/commands/tpm-tools/tpm/tpm_clear/Makefile                                                           |    1 
 testcases/commands/tpm-tools/tpm/tpm_getpubek/Makefile                                                        |    1 
 testcases/commands/tpm-tools/tpm/tpm_restrictpubek/Makefile                                                   |    1 
 testcases/commands/tpm-tools/tpm/tpm_selftest/Makefile                                                        |    1 
 testcases/commands/tpm-tools/tpm/tpm_takeownership/Makefile                                                   |    1 
 testcases/commands/tpm-tools/tpm/tpm_version/Makefile                                                         |    1 
 testcases/commands/tpm-tools/tpmtoken/Makefile                                                                |    1 
 testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/Makefile                                                |    1 
 testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/Makefile                                                  |    1 
 testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/Makefile                                               |    1 
 testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/Makefile                                               |    1 
 testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/Makefile                                             |    1 
 testcases/commands/unzip/Makefile                                                                             |    1 
 testcases/kdump/Makefile                                                                                      |    1 
 testcases/kdump/lib/Makefile                                                                                  |    1 
 testcases/kdump/lib/crasher/Makefile                                                                          |    1 
 testcases/kdump/lib/kprobes/Makefile                                                                          |    1 
 testcases/kdump/lib/lkdtm/Makefile                                                                            |    1 
 testcases/kernel/Makefile                                                                                     |    1 
 testcases/kernel/connectors/Makefile                                                                          |    1 
 testcases/kernel/connectors/pec/Makefile                                                                      |    1 
 testcases/kernel/containers/Makefile                                                                          |    1 
 testcases/kernel/containers/libclone/Makefile                                                                 |    1 
 testcases/kernel/containers/mqns/Makefile                                                                     |    1 
 testcases/kernel/containers/netns/Makefile                                                                    |    1 
 testcases/kernel/containers/pidns/Makefile                                                                    |    1 
 testcases/kernel/containers/sysvipc/Makefile                                                                  |    1 
 testcases/kernel/containers/utsname/Makefile                                                                  |    1 
 testcases/kernel/controllers/Makefile                                                                         |    1 
 testcases/kernel/controllers/cgroup/Makefile                                                                  |    1 
 testcases/kernel/controllers/cpuctl/Makefile                                                                  |    1 
 testcases/kernel/controllers/cpuset/Makefile                                                                  |    1 
 testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile                                             |    1 
 testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile                                            |    1 
 testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile                                            |    1 
 testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile                                              |    1 
 testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile                                              |    1 
 testcases/kernel/controllers/cpuset/cpuset_lib/Makefile                                                       |    1 
 testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile                                         |    1 
 testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile                                      |    1 
 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile                                        |    1 
 testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile                                               |    1 
 testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile                                              |    1 
 testcases/kernel/controllers/freezer/Makefile                                                                 |    1 
 testcases/kernel/controllers/io-throttle/Makefile                                                             |    1 
 testcases/kernel/controllers/libcontrollers/Makefile                                                          |    1 
 testcases/kernel/controllers/memcg/Makefile                                                                   |    1 
 testcases/kernel/controllers/memctl/Makefile                                                                  |    1 
 testcases/kernel/device-drivers/acpi/Makefile                                                                 |    1 
 testcases/kernel/device-drivers/agp/kernel_space/Makefile                                                     |    1 
 testcases/kernel/device-drivers/agp/user_space/Makefile                                                       |    1 
 testcases/kernel/device-drivers/base/tbase/Makefile                                                           |    1 
 testcases/kernel/device-drivers/base/user_base/Makefile                                                       |    1 
 testcases/kernel/device-drivers/block/kernel_space/Makefile                                                   |    1 
 testcases/kernel/device-drivers/dev_sim_framework/kernel_space/Makefile                                       |    1 
 testcases/kernel/device-drivers/dev_sim_framework/user_space/Makefile                                         |    1 
 testcases/kernel/device-drivers/drm/kernel_space/Makefile                                                     |    1 
 testcases/kernel/device-drivers/drm/user_space/Makefile                                                       |    1 
 testcases/kernel/device-drivers/include/Makefile                                                              |    1 
 testcases/kernel/device-drivers/misc_modules/per_cpu_allocator_module/Makefile                                |    1 
 testcases/kernel/device-drivers/misc_modules/per_cpu_atomic_operations_vs_interrupt_disabling_module/Makefile |    1 
 testcases/kernel/device-drivers/nls/Makefile                                                                  |    1 
 testcases/kernel/device-drivers/pci/tpci/Makefile                                                             |    1 
 testcases/kernel/device-drivers/pci/user_tpci/Makefile                                                        |    1 
 testcases/kernel/device-drivers/tbio/kernel_space/Makefile                                                    |    1 
 testcases/kernel/device-drivers/tbio/user_space/Makefile                                                      |    1 
 testcases/kernel/device-drivers/usb/tusb/Makefile                                                             |    1 
 testcases/kernel/device-drivers/usb/user_usb/Makefile                                                         |    1 
 testcases/kernel/device-drivers/v4l/kernel_space/Makefile                                                     |    1 
 testcases/kernel/device-drivers/v4l/user_space/Makefile                                                       |    1 
 testcases/kernel/fs/Makefile                                                                                  |    1 
 testcases/kernel/fs/acls/Makefile                                                                             |    1 
 testcases/kernel/fs/dmapi/Makefile                                                                            |    1 
 testcases/kernel/fs/doio/Makefile                                                                             |    1 
 testcases/kernel/fs/fs-bench/Makefile                                                                         |    1 
 testcases/kernel/fs/fs_bind/Makefile                                                                          |    1 
 testcases/kernel/fs/fs_bind/bin/Makefile                                                                      |    1 
 testcases/kernel/fs/fs_di/Makefile                                                                            |    1 
 testcases/kernel/fs/fs_inod/Makefile                                                                          |    1 
 testcases/kernel/fs/fs_perms/Makefile                                                                         |    1 
 testcases/kernel/fs/fsstress/Makefile                                                                         |    1 
 testcases/kernel/fs/fsx-linux/Makefile                                                                        |    1 
 testcases/kernel/fs/ftest/Makefile                                                                            |    1 
 testcases/kernel/fs/inode/Makefile                                                                            |    1 
 testcases/kernel/fs/lftest/Makefile                                                                           |    1 
 testcases/kernel/fs/linktest/Makefile                                                                         |    1 
 testcases/kernel/fs/openfile/Makefile                                                                         |    1 
 testcases/kernel/fs/quota_remount/Makefile                                                                    |    1 
 testcases/kernel/fs/racer/Makefile                                                                            |    1 
 testcases/kernel/fs/scsi/ltpfs/Makefile                                                                       |    1 
 testcases/kernel/fs/scsi/ltpscsi/Makefile                                                                     |    1 
 testcases/kernel/fs/stream/Makefile                                                                           |    1 
 testcases/kernel/hotplug/memory_hotplug/Makefile                                                              |    1 
 testcases/kernel/include/Makefile                                                                             |    1 
 testcases/kernel/io/Makefile                                                                                  |    1 
 testcases/kernel/io/aio/Makefile                                                                              |    1 
 testcases/kernel/io/direct_io/Makefile                                                                        |    1 
 testcases/kernel/io/disktest/Makefile                                                                         |    1 
 testcases/kernel/io/disktest/Makefile.aix                                                                     |    1 
 testcases/kernel/io/disktest/Makefile.linux                                                                   |    1 
 testcases/kernel/io/disktest/Makefile.windows                                                                 |    1 
 testcases/kernel/io/ltp-aiodio/Makefile                                                                       |    1 
 testcases/kernel/io/stress_cd/Makefile                                                                        |    1 
 testcases/kernel/io/stress_floppy/Makefile                                                                    |    1 
 testcases/kernel/io/writetest/Makefile                                                                        |    1 
 testcases/kernel/ipc/Makefile                                                                                 |    1 
 testcases/kernel/ipc/ipc_stress/Makefile                                                                      |    1 
 testcases/kernel/ipc/ipc_stress/Makefile.linux                                                                |    1 
 testcases/kernel/ipc/pipeio/Makefile                                                                          |    1 
 testcases/kernel/ipc/semaphore/Makefile                                                                       |    1 
 testcases/kernel/mem/Makefile                                                                                 |    1 
 testcases/kernel/mem/hugetlb/Makefile                                                                         |    1 
 testcases/kernel/mem/hugetlb/hugemmap/Makefile                                                                |    1 
 testcases/kernel/mem/hugetlb/hugeshmat/Makefile                                                               |    1 
 testcases/kernel/mem/hugetlb/hugeshmctl/Makefile                                                              |    1 
 testcases/kernel/mem/hugetlb/hugeshmdt/Makefile                                                               |    1 
 testcases/kernel/mem/hugetlb/hugeshmget/Makefile                                                              |    1 
 testcases/kernel/mem/hugetlb/lib/Makefile                                                                     |    1 
 testcases/kernel/mem/libmm/Makefile                                                                           |    1 
 testcases/kernel/mem/mem/Makefile                                                                             |    1 
 testcases/kernel/mem/mmapstress/Makefile                                                                      |    1 
 testcases/kernel/mem/mtest01/Makefile                                                                         |    1 
 testcases/kernel/mem/mtest05/Makefile                                                                         |    1 
 testcases/kernel/mem/mtest06/Makefile                                                                         |    1 
 testcases/kernel/mem/mtest07/Makefile                                                                         |    1 
 testcases/kernel/mem/page/Makefile                                                                            |    1 
 testcases/kernel/mem/shmt/Makefile                                                                            |    1 
 testcases/kernel/mem/vmtests/Makefile                                                                         |    1 
 testcases/kernel/module/Makefile                                                                              |    1 
 testcases/kernel/module/create_module/Makefile                                                                |    1 
 testcases/kernel/module/delete_module/Makefile                                                                |    1 
 testcases/kernel/module/query_module/Makefile                                                                 |    1 
 testcases/kernel/numa/Makefile                                                                                |    1 
 testcases/kernel/performance_counters/Makefile                                                                |    1 
 testcases/kernel/power_management/Makefile                                                                    |    1 
 testcases/kernel/pty/Makefile                                                                                 |    1 
 testcases/kernel/sched/Makefile                                                                               |    1 
 testcases/kernel/sched/cfs-scheduler/Makefile                                                                 |    1 
 testcases/kernel/sched/clisrv/Makefile                                                                        |    1 
 testcases/kernel/sched/hyperthreading/Makefile                                                                |    1 
 testcases/kernel/sched/hyperthreading/ht_affinity/Makefile                                                    |    1 
 testcases/kernel/sched/hyperthreading/ht_enabled/Makefile                                                     |    1 
 testcases/kernel/sched/hyperthreading/ht_interrupt/Makefile                                                   |    1 
 testcases/kernel/sched/nptl/Makefile                                                                          |    1 
 testcases/kernel/sched/process_stress/Makefile                                                                |    1 
 testcases/kernel/sched/pthreads/Makefile                                                                      |    1 
 testcases/kernel/sched/sched_stress/Makefile                                                                  |    1 
 testcases/kernel/sched/tool/Makefile                                                                          |    1 
 testcases/kernel/security/Makefile                                                                            |    1 
 testcases/kernel/security/cap_bound/Makefile                                                                  |    1 
 testcases/kernel/security/digsig/Makefile                                                                     |    1 
 testcases/kernel/security/digsig/twiddlebit/Makefile                                                          |    1 
 testcases/kernel/security/digsig/writeexec/Makefile                                                           |    1 
 testcases/kernel/security/filecaps/Makefile                                                                   |    1 
 testcases/kernel/security/integrity/Makefile                                                                  |    1 
 testcases/kernel/security/integrity/ima/Makefile                                                              |    1 
 testcases/kernel/security/integrity/ima/policy/Makefile                                                       |    1 
 testcases/kernel/security/integrity/ima/tests/Makefile                                                        |    1 
 testcases/kernel/security/mmc_security/Makefile                                                               |    1 
 testcases/kernel/security/selinux-testsuite/Makefile                                                          |    1 
 testcases/kernel/security/selinux-testsuite/policy/Makefile                                                   |    1 
 testcases/kernel/security/selinux-testsuite/refpolicy/Makefile                                                |    1 
 testcases/kernel/security/selinux-testsuite/refpolicy/redhat/5/Makefile                                       |    1 
 testcases/kernel/security/selinux-testsuite/tests/Makefile                                                    |    1 
 testcases/kernel/security/selinux-testsuite/tests/bounds/Makefile                                             |    2 
 testcases/kernel/security/selinux-testsuite/tests/capable_file/Makefile                                       |    1 
 testcases/kernel/security/selinux-testsuite/tests/capable_net/Makefile                                        |    1 
 testcases/kernel/security/selinux-testsuite/tests/capable_sys/Makefile                                        |    1 
 testcases/kernel/security/selinux-testsuite/tests/domain_trans/Makefile                                       |    1 
 testcases/kernel/security/selinux-testsuite/tests/dyntrace/Makefile                                           |    1 
 testcases/kernel/security/selinux-testsuite/tests/dyntrans/Makefile                                           |    1 
 testcases/kernel/security/selinux-testsuite/tests/entrypoint/Makefile                                         |    1 
 testcases/kernel/security/selinux-testsuite/tests/execshare/Makefile                                          |    1 
 testcases/kernel/security/selinux-testsuite/tests/exectrace/Makefile                                          |    1 
 testcases/kernel/security/selinux-testsuite/tests/execute_no_trans/Makefile                                   |    1 
 testcases/kernel/security/selinux-testsuite/tests/fdreceive/Makefile                                          |    1 
 testcases/kernel/security/selinux-testsuite/tests/file/Makefile                                               |    1 
 testcases/kernel/security/selinux-testsuite/tests/inherit/Makefile                                            |    1 
 testcases/kernel/security/selinux-testsuite/tests/ioctl/Makefile                                              |    1 
 testcases/kernel/security/selinux-testsuite/tests/link/Makefile                                               |    1 
 testcases/kernel/security/selinux-testsuite/tests/mkdir/Makefile                                              |    1 
 testcases/kernel/security/selinux-testsuite/tests/msg/Makefile                                                |    1 
 testcases/kernel/security/selinux-testsuite/tests/open/Makefile                                               |    1 
 testcases/kernel/security/selinux-testsuite/tests/ptrace/Makefile                                             |    1 
 testcases/kernel/security/selinux-testsuite/tests/readlink/Makefile                                           |    1 
 testcases/kernel/security/selinux-testsuite/tests/relabel/Makefile                                            |    1 
 testcases/kernel/security/selinux-testsuite/tests/rename/Makefile                                             |    1 
 testcases/kernel/security/selinux-testsuite/tests/rxdir/Makefile                                              |    1 
 testcases/kernel/security/selinux-testsuite/tests/sem/Makefile                                                |    1 
 testcases/kernel/security/selinux-testsuite/tests/setattr/Makefile                                            |    1 
 testcases/kernel/security/selinux-testsuite/tests/setnice/Makefile                                            |    1 
 testcases/kernel/security/selinux-testsuite/tests/shm/Makefile                                                |    1 
 testcases/kernel/security/selinux-testsuite/tests/sigkill/Makefile                                            |    1 
 testcases/kernel/security/selinux-testsuite/tests/stat/Makefile                                               |    1 
 testcases/kernel/security/selinux-testsuite/tests/sysctl/Makefile                                             |    1 
 testcases/kernel/security/selinux-testsuite/tests/task_create/Makefile                                        |    1 
 testcases/kernel/security/selinux-testsuite/tests/task_getpgid/Makefile                                       |    1 
 testcases/kernel/security/selinux-testsuite/tests/task_getscheduler/Makefile                                  |    1 
 testcases/kernel/security/selinux-testsuite/tests/task_getsid/Makefile                                        |    1 
 testcases/kernel/security/selinux-testsuite/tests/task_setnice/Makefile                                       |    1 
 testcases/kernel/security/selinux-testsuite/tests/task_setpgid/Makefile                                       |    1 
 testcases/kernel/security/selinux-testsuite/tests/task_setscheduler/Makefile                                  |    1 
 testcases/kernel/security/selinux-testsuite/tests/wait/Makefile                                               |    1 
 testcases/kernel/security/smack/Makefile                                                                      |    1 
 testcases/kernel/syscalls/Makefile                                                                            |    1 
 testcases/kernel/syscalls/abort/Makefile                                                                      |    1 
 testcases/kernel/syscalls/accept/Makefile                                                                     |    1 
 testcases/kernel/syscalls/accept4/Makefile                                                                    |    1 
 testcases/kernel/syscalls/access/Makefile                                                                     |    1 
 testcases/kernel/syscalls/acct/Makefile                                                                       |    1 
 testcases/kernel/syscalls/add_key/Makefile                                                                    |    1 
 testcases/kernel/syscalls/adjtimex/Makefile                                                                   |    1 
 testcases/kernel/syscalls/alarm/Makefile                                                                      |    1 
 testcases/kernel/syscalls/asyncio/Makefile                                                                    |    1 
 testcases/kernel/syscalls/bdflush/Makefile                                                                    |    1 
 testcases/kernel/syscalls/bind/Makefile                                                                       |    1 
 testcases/kernel/syscalls/brk/Makefile                                                                        |    1 
 testcases/kernel/syscalls/cacheflush/Makefile                                                                 |    1 
 testcases/kernel/syscalls/capget/Makefile                                                                     |    1 
 testcases/kernel/syscalls/capset/Makefile                                                                     |    1 
 testcases/kernel/syscalls/chdir/Makefile                                                                      |    1 
 testcases/kernel/syscalls/chmod/Makefile                                                                      |    1 
 testcases/kernel/syscalls/chown/Makefile                                                                      |    1 
 testcases/kernel/syscalls/chroot/Makefile                                                                     |    1 
 testcases/kernel/syscalls/clock_getres/Makefile                                                               |    1 
 testcases/kernel/syscalls/clock_nanosleep/Makefile                                                            |    1 
 testcases/kernel/syscalls/clock_nanosleep2/Makefile                                                           |    1 
 testcases/kernel/syscalls/clone/Makefile                                                                      |    1 
 testcases/kernel/syscalls/close/Makefile                                                                      |    1 
 testcases/kernel/syscalls/confstr/Makefile                                                                    |    1 
 testcases/kernel/syscalls/connect/Makefile                                                                    |    1 
 testcases/kernel/syscalls/creat/Makefile                                                                      |    1 
 testcases/kernel/syscalls/dup/Makefile                                                                        |    1 
 testcases/kernel/syscalls/dup2/Makefile                                                                       |    1 
 testcases/kernel/syscalls/dup3/Makefile                                                                       |    1 
 testcases/kernel/syscalls/epoll/Makefile                                                                      |    1 
 testcases/kernel/syscalls/epoll2/examples/Makefile                                                            |    1 
 testcases/kernel/syscalls/epoll_create1/Makefile                                                              |    1 
 testcases/kernel/syscalls/eventfd2/Makefile                                                                   |    1 
 testcases/kernel/syscalls/execl/Makefile                                                                      |    1 
 testcases/kernel/syscalls/execle/Makefile                                                                     |    1 
 testcases/kernel/syscalls/execlp/Makefile                                                                     |    1 
 testcases/kernel/syscalls/execv/Makefile                                                                      |    1 
 testcases/kernel/syscalls/execve/Makefile                                                                     |    1 
 testcases/kernel/syscalls/execvp/Makefile                                                                     |    1 
 testcases/kernel/syscalls/exit/Makefile                                                                       |    1 
 testcases/kernel/syscalls/exit_group/Makefile                                                                 |    1 
 testcases/kernel/syscalls/faccessat/Makefile                                                                  |    1 
 testcases/kernel/syscalls/fadvise/Makefile                                                                    |    1 
 testcases/kernel/syscalls/fallocate/Makefile                                                                  |    1 
 testcases/kernel/syscalls/fchdir/Makefile                                                                     |    1 
 testcases/kernel/syscalls/fchmod/Makefile                                                                     |    1 
 testcases/kernel/syscalls/fchmodat/Makefile                                                                   |    1 
 testcases/kernel/syscalls/fchown/Makefile                                                                     |    1 
 testcases/kernel/syscalls/fchownat/Makefile                                                                   |    1 
 testcases/kernel/syscalls/fcntl/Makefile                                                                      |    1 
 testcases/kernel/syscalls/fdatasync/Makefile                                                                  |    1 
 testcases/kernel/syscalls/flock/Makefile                                                                      |    1 
 testcases/kernel/syscalls/fmtmsg/Makefile                                                                     |    1 
 testcases/kernel/syscalls/fork/Makefile                                                                       |    1 
 testcases/kernel/syscalls/fpathconf/Makefile                                                                  |    1 
 testcases/kernel/syscalls/fstat/Makefile                                                                      |    1 
 testcases/kernel/syscalls/fstatat/Makefile                                                                    |    1 
 testcases/kernel/syscalls/fstatfs/Makefile                                                                    |    1 
 testcases/kernel/syscalls/fsync/Makefile                                                                      |    1 
 testcases/kernel/syscalls/ftruncate/Makefile                                                                  |    1 
 testcases/kernel/syscalls/futimesat/Makefile                                                                  |    1 
 testcases/kernel/syscalls/get_mempolicy/Makefile                                                              |    1 
 testcases/kernel/syscalls/get_robust_list/Makefile                                                            |    1 
 testcases/kernel/syscalls/getcontext/Makefile                                                                 |    1 
 testcases/kernel/syscalls/getcpu/Makefile                                                                     |    1 
 testcases/kernel/syscalls/getcwd/Makefile                                                                     |    1 
 testcases/kernel/syscalls/getdents/Makefile                                                                   |    1 
 testcases/kernel/syscalls/getdomainname/Makefile                                                              |    1 
 testcases/kernel/syscalls/getdtablesize/Makefile                                                              |    1 
 testcases/kernel/syscalls/getegid/Makefile                                                                    |    1 
 testcases/kernel/syscalls/geteuid/Makefile                                                                    |    1 
 testcases/kernel/syscalls/getgid/Makefile                                                                     |    1 
 testcases/kernel/syscalls/getgroups/Makefile                                                                  |    1 
 testcases/kernel/syscalls/gethostid/Makefile                                                                  |    1 
 testcases/kernel/syscalls/gethostname/Makefile                                                                |    1 
 testcases/kernel/syscalls/getitimer/Makefile                                                                  |    1 
 testcases/kernel/syscalls/getpagesize/Makefile                                                                |    1 
 testcases/kernel/syscalls/getpeername/Makefile                                                                |    1 
 testcases/kernel/syscalls/getpgid/Makefile                                                                    |    1 
 testcases/kernel/syscalls/getpgrp/Makefile                                                                    |    1 
 testcases/kernel/syscalls/getpid/Makefile                                                                     |    1 
 testcases/kernel/syscalls/getppid/Makefile                                                                    |    1 
 testcases/kernel/syscalls/getpriority/Makefile                                                                |    1 
 testcases/kernel/syscalls/getresgid/Makefile                                                                  |    1 
 testcases/kernel/syscalls/getresuid/Makefile                                                                  |    1 
 testcases/kernel/syscalls/getrlimit/Makefile                                                                  |    1 
 testcases/kernel/syscalls/getrusage/Makefile                                                                  |    1 
 testcases/kernel/syscalls/getsid/Makefile                                                                     |    1 
 testcases/kernel/syscalls/getsockname/Makefile                                                                |    1 
 testcases/kernel/syscalls/getsockopt/Makefile                                                                 |    1 
 testcases/kernel/syscalls/gettid/Makefile                                                                     |    1 
 testcases/kernel/syscalls/gettimeofday/Makefile                                                               |    1 
 testcases/kernel/syscalls/getuid/Makefile                                                                     |    1 
 testcases/kernel/syscalls/inotify/Makefile                                                                    |    1 
 testcases/kernel/syscalls/inotify_init/Makefile                                                               |    1 
 testcases/kernel/syscalls/ioctl/Makefile                                                                      |    1 
 testcases/kernel/syscalls/ioperm/Makefile                                                                     |    1 
 testcases/kernel/syscalls/iopl/Makefile                                                                       |    1 
 testcases/kernel/syscalls/ipc/Makefile                                                                        |    1 
 testcases/kernel/syscalls/ipc/lib/Makefile                                                                    |    1 
 testcases/kernel/syscalls/ipc/msgctl/Makefile                                                                 |    1 
 testcases/kernel/syscalls/ipc/msgget/Makefile                                                                 |    1 
 testcases/kernel/syscalls/ipc/msgrcv/Makefile                                                                 |    1 
 testcases/kernel/syscalls/ipc/msgsnd/Makefile                                                                 |    1 
 testcases/kernel/syscalls/ipc/semctl/Makefile                                                                 |    1 
 testcases/kernel/syscalls/ipc/semget/Makefile                                                                 |    1 
 testcases/kernel/syscalls/ipc/semop/Makefile                                                                  |    1 
 testcases/kernel/syscalls/ipc/shmat/Makefile                                                                  |    1 
 testcases/kernel/syscalls/ipc/shmctl/Makefile                                                                 |    1 
 testcases/kernel/syscalls/ipc/shmdt/Makefile                                                                  |    1 
 testcases/kernel/syscalls/ipc/shmget/Makefile                                                                 |    1 
 testcases/kernel/syscalls/keyctl/Makefile                                                                     |    1 
 testcases/kernel/syscalls/kill/Makefile                                                                       |    1 
 testcases/kernel/syscalls/lchown/Makefile                                                                     |    1 
 testcases/kernel/syscalls/libevent/Makefile.am                                                                |    1 
 testcases/kernel/syscalls/libevent/Makefile.in                                                                |    1 
 testcases/kernel/syscalls/libevent/sample/Makefile.am                                                         |    1 
 testcases/kernel/syscalls/libevent/sample/Makefile.in                                                         |    1 
 testcases/kernel/syscalls/libevent/test/Makefile.am                                                           |    1 
 testcases/kernel/syscalls/libevent/test/Makefile.in                                                           |    1 
 testcases/kernel/syscalls/link/Makefile                                                                       |    1 
 testcases/kernel/syscalls/linkat/Makefile                                                                     |    1 
 testcases/kernel/syscalls/listen/Makefile                                                                     |    1 
 testcases/kernel/syscalls/llseek/Makefile                                                                     |    1 
 testcases/kernel/syscalls/lseek/Makefile                                                                      |    1 
 testcases/kernel/syscalls/lstat/Makefile                                                                      |    1 
 testcases/kernel/syscalls/madvise/Makefile                                                                    |    1 
 testcases/kernel/syscalls/mallopt/Makefile                                                                    |    1 
 testcases/kernel/syscalls/memcmp/Makefile                                                                     |    1 
 testcases/kernel/syscalls/memcpy/Makefile                                                                     |    1 
 testcases/kernel/syscalls/memmap/Makefile                                                                     |    1 
 testcases/kernel/syscalls/memset/Makefile                                                                     |    1 
 testcases/kernel/syscalls/mincore/Makefile                                                                    |    1 
 testcases/kernel/syscalls/mkdir/Makefile                                                                      |    1 
 testcases/kernel/syscalls/mkdirat/Makefile                                                                    |    1 
 testcases/kernel/syscalls/mknod/Makefile                                                                      |    1 
 testcases/kernel/syscalls/mknodat/Makefile                                                                    |    1 
 testcases/kernel/syscalls/mlock/Makefile                                                                      |    1 
 testcases/kernel/syscalls/mlockall/Makefile                                                                   |    1 
 testcases/kernel/syscalls/mmap/Makefile                                                                       |    1 
 testcases/kernel/syscalls/modify_ldt/Makefile                                                                 |    1 
 testcases/kernel/syscalls/mount/Makefile                                                                      |    1 
 testcases/kernel/syscalls/move_pages/Makefile                                                                 |    2 
 testcases/kernel/syscalls/mprotect/Makefile                                                                   |    1 
 testcases/kernel/syscalls/mq_notify/Makefile                                                                  |    1 
 testcases/kernel/syscalls/mq_open/Makefile                                                                    |    1 
 testcases/kernel/syscalls/mq_timedreceive/Makefile                                                            |    1 
 testcases/kernel/syscalls/mq_timedsend/Makefile                                                               |    1 
 testcases/kernel/syscalls/mq_unlink/Makefile                                                                  |    1 
 testcases/kernel/syscalls/mremap/Makefile                                                                     |    1 
 testcases/kernel/syscalls/msync/Makefile                                                                      |    1 
 testcases/kernel/syscalls/munlock/Makefile                                                                    |    1 
 testcases/kernel/syscalls/munlockall/Makefile                                                                 |    1 
 testcases/kernel/syscalls/munmap/Makefile                                                                     |    1 
 testcases/kernel/syscalls/nanosleep/Makefile                                                                  |    1 
 testcases/kernel/syscalls/newuname/Makefile                                                                   |    1 
 testcases/kernel/syscalls/nftw/Makefile                                                                       |    1 
 testcases/kernel/syscalls/nice/Makefile                                                                       |    1 
 testcases/kernel/syscalls/open/Makefile                                                                       |    1 
 testcases/kernel/syscalls/openat/Makefile                                                                     |    1 
 testcases/kernel/syscalls/paging/Makefile                                                                     |    1 
 testcases/kernel/syscalls/pathconf/Makefile                                                                   |    1 
 testcases/kernel/syscalls/pause/Makefile                                                                      |    1 
 testcases/kernel/syscalls/pcllib/Makefile.am                                                                  |    1 
 testcases/kernel/syscalls/pcllib/Makefile.in                                                                  |    1 
 testcases/kernel/syscalls/pcllib/include/Makefile.am                                                          |    1 
 testcases/kernel/syscalls/pcllib/include/Makefile.in                                                          |    1 
 testcases/kernel/syscalls/pcllib/man/Makefile.am                                                              |    1 
 testcases/kernel/syscalls/pcllib/man/Makefile.in                                                              |    1 
 testcases/kernel/syscalls/pcllib/pcl/Makefile.am                                                              |    1 
 testcases/kernel/syscalls/pcllib/pcl/Makefile.in                                                              |    1 
 testcases/kernel/syscalls/pcllib/test/Makefile.am                                                             |    1 
 testcases/kernel/syscalls/pcllib/test/Makefile.in                                                             |    1 
 testcases/kernel/syscalls/personality/Makefile                                                                |    1 
 testcases/kernel/syscalls/pipe/Makefile                                                                       |    1 
 testcases/kernel/syscalls/pipe2/Makefile                                                                      |    1 
 testcases/kernel/syscalls/poll/Makefile                                                                       |    1 
 testcases/kernel/syscalls/ppoll/Makefile                                                                      |    1 
 testcases/kernel/syscalls/prctl/Makefile                                                                      |    1 
 testcases/kernel/syscalls/pread/Makefile                                                                      |    1 
 testcases/kernel/syscalls/profil/Makefile                                                                     |    1 
 testcases/kernel/syscalls/pselect/Makefile                                                                    |    1 
 testcases/kernel/syscalls/ptrace/Makefile                                                                     |    1 
 testcases/kernel/syscalls/pwrite/Makefile                                                                     |    1 
 testcases/kernel/syscalls/read/Makefile                                                                       |    1 
 testcases/kernel/syscalls/readdir/Makefile                                                                    |    1 
 testcases/kernel/syscalls/readlink/Makefile                                                                   |    1 
 testcases/kernel/syscalls/readlinkat/Makefile                                                                 |    1 
 testcases/kernel/syscalls/readv/Makefile                                                                      |    1 
 testcases/kernel/syscalls/reboot/Makefile                                                                     |    1 
 testcases/kernel/syscalls/recv/Makefile                                                                       |    1 
 testcases/kernel/syscalls/recvfrom/Makefile                                                                   |    1 
 testcases/kernel/syscalls/recvmsg/Makefile                                                                    |    1 
 testcases/kernel/syscalls/remap_file_pages/Makefile                                                           |    1 
 testcases/kernel/syscalls/rename/Makefile                                                                     |    1 
 testcases/kernel/syscalls/renameat/Makefile                                                                   |    1 
 testcases/kernel/syscalls/rmdir/Makefile                                                                      |    1 
 testcases/kernel/syscalls/rt_sigaction/Makefile                                                               |    1 
 testcases/kernel/syscalls/rt_sigprocmask/Makefile                                                             |    1 
 testcases/kernel/syscalls/rt_sigqueueinfo/Makefile                                                            |    1 
 testcases/kernel/syscalls/rt_sigsuspend/Makefile                                                              |    1 
 testcases/kernel/syscalls/sbrk/Makefile                                                                       |    1 
 testcases/kernel/syscalls/sched_get_priority_max/Makefile                                                     |    1 
 testcases/kernel/syscalls/sched_get_priority_min/Makefile                                                     |    1 
 testcases/kernel/syscalls/sched_getparam/Makefile                                                             |    1 
 testcases/kernel/syscalls/sched_getscheduler/Makefile                                                         |    1 
 testcases/kernel/syscalls/sched_rr_get_interval/Makefile                                                      |    1 
 testcases/kernel/syscalls/sched_setparam/Makefile                                                             |    1 
 testcases/kernel/syscalls/sched_setscheduler/Makefile                                                         |    1 
 testcases/kernel/syscalls/sched_yield/Makefile                                                                |    1 
 testcases/kernel/syscalls/select/Makefile                                                                     |    1 
 testcases/kernel/syscalls/send/Makefile                                                                       |    1 
 testcases/kernel/syscalls/sendfile/Makefile                                                                   |    1 
 testcases/kernel/syscalls/sendmsg/Makefile                                                                    |    1 
 testcases/kernel/syscalls/sendto/Makefile                                                                     |    1 
 testcases/kernel/syscalls/set_robust_list/Makefile                                                            |    1 
 testcases/kernel/syscalls/set_thread_area/Makefile                                                            |    1 
 testcases/kernel/syscalls/set_tid_address/Makefile                                                            |    1 
 testcases/kernel/syscalls/setdomainname/Makefile                                                              |    1 
 testcases/kernel/syscalls/setegid/Makefile                                                                    |    1 
 testcases/kernel/syscalls/setfsgid/Makefile                                                                   |    1 
 testcases/kernel/syscalls/setfsuid/Makefile                                                                   |    1 
 testcases/kernel/syscalls/setgid/Makefile                                                                     |    1 
 testcases/kernel/syscalls/setgroups/Makefile                                                                  |    1 
 testcases/kernel/syscalls/sethostname/Makefile                                                                |    1 
 testcases/kernel/syscalls/setitimer/Makefile                                                                  |    1 
 testcases/kernel/syscalls/setpgid/Makefile                                                                    |    1 
 testcases/kernel/syscalls/setpgrp/Makefile                                                                    |    1 
 testcases/kernel/syscalls/setpriority/Makefile                                                                |    1 
 testcases/kernel/syscalls/setregid/Makefile                                                                   |    1 
 testcases/kernel/syscalls/setresgid/Makefile                                                                  |    1 
 testcases/kernel/syscalls/setresuid/Makefile                                                                  |    1 
 testcases/kernel/syscalls/setreuid/Makefile                                                                   |    1 
 testcases/kernel/syscalls/setrlimit/Makefile                                                                  |    1 
 testcases/kernel/syscalls/setsid/Makefile                                                                     |    1 
 testcases/kernel/syscalls/setsockopt/Makefile                                                                 |    1 
 testcases/kernel/syscalls/settimeofday/Makefile                                                               |    1 
 testcases/kernel/syscalls/setuid/Makefile                                                                     |    1 
 testcases/kernel/syscalls/sgetmask/Makefile                                                                   |    1 
 testcases/kernel/syscalls/sigaction/Makefile                                                                  |    1 
 testcases/kernel/syscalls/sigaltstack/Makefile                                                                |    1 
 testcases/kernel/syscalls/sighold/Makefile                                                                    |    1 
 testcases/kernel/syscalls/signal/Makefile                                                                     |    1 
 testcases/kernel/syscalls/signalfd/Makefile                                                                   |    1 
 testcases/kernel/syscalls/signalfd4/Makefile                                                                  |    1 
 testcases/kernel/syscalls/sigpending/Makefile                                                                 |    1 
 testcases/kernel/syscalls/sigprocmask/Makefile                                                                |    1 
 testcases/kernel/syscalls/sigrelse/Makefile                                                                   |    1 
 testcases/kernel/syscalls/sigreturn/Makefile                                                                  |    1 
 testcases/kernel/syscalls/sigsuspend/Makefile                                                                 |    1 
 testcases/kernel/syscalls/socket/Makefile                                                                     |    1 
 testcases/kernel/syscalls/socketcall/Makefile                                                                 |    1 
 testcases/kernel/syscalls/socketpair/Makefile                                                                 |    1 
 testcases/kernel/syscalls/sockioctl/Makefile                                                                  |    1 
 testcases/kernel/syscalls/splice/Makefile                                                                     |    1 
 testcases/kernel/syscalls/ssetmask/Makefile                                                                   |    1 
 testcases/kernel/syscalls/stat/Makefile                                                                       |    1 
 testcases/kernel/syscalls/statfs/Makefile                                                                     |    1 
 testcases/kernel/syscalls/statvfs/Makefile                                                                    |    1 
 testcases/kernel/syscalls/stime/Makefile                                                                      |    1 
 testcases/kernel/syscalls/string/Makefile                                                                     |    1 
 testcases/kernel/syscalls/swapoff/Makefile                                                                    |    1 
 testcases/kernel/syscalls/swapon/Makefile                                                                     |    1 
 testcases/kernel/syscalls/switch/Makefile                                                                     |    1 
 testcases/kernel/syscalls/symlink/Makefile                                                                    |    1 
 testcases/kernel/syscalls/symlinkat/Makefile                                                                  |    1 
 testcases/kernel/syscalls/sync/Makefile                                                                       |    1 
 testcases/kernel/syscalls/sync_file_range/Makefile                                                            |    1 
 testcases/kernel/syscalls/syscall/Makefile                                                                    |    1 
 testcases/kernel/syscalls/sysconf/Makefile                                                                    |    1 
 testcases/kernel/syscalls/sysctl/Makefile                                                                     |    1 
 testcases/kernel/syscalls/sysfs/Makefile                                                                      |    1 
 testcases/kernel/syscalls/sysinfo/Makefile                                                                    |    1 
 testcases/kernel/syscalls/syslog/Makefile                                                                     |    1 
 testcases/kernel/syscalls/tee/Makefile                                                                        |    1 
 testcases/kernel/syscalls/time/Makefile                                                                       |    1 
 testcases/kernel/syscalls/timer_getoverrun/Makefile                                                           |    1 
 testcases/kernel/syscalls/timer_gettime/Makefile                                                              |    1 
 testcases/kernel/syscalls/timerfd/Makefile                                                                    |    1 
 testcases/kernel/syscalls/times/Makefile                                                                      |    1 
 testcases/kernel/syscalls/tkill/Makefile                                                                      |    1 
 testcases/kernel/syscalls/truncate/Makefile                                                                   |    1 
 testcases/kernel/syscalls/ulimit/Makefile                                                                     |    1 
 testcases/kernel/syscalls/umask/Makefile                                                                      |    1 
 testcases/kernel/syscalls/umount/Makefile                                                                     |    1 
 testcases/kernel/syscalls/uname/Makefile                                                                      |    1 
 testcases/kernel/syscalls/unlink/Makefile                                                                     |    1 
 testcases/kernel/syscalls/unlinkat/Makefile                                                                   |    1 
 testcases/kernel/syscalls/unshare/Makefile                                                                    |    1 
 testcases/kernel/syscalls/ustat/Makefile                                                                      |    1 
 testcases/kernel/syscalls/utime/Makefile                                                                      |    1 
 testcases/kernel/syscalls/utimensat/Makefile                                                                  |    1 
 testcases/kernel/syscalls/utimes/Makefile                                                                     |    1 
 testcases/kernel/syscalls/vfork/Makefile                                                                      |    1 
 testcases/kernel/syscalls/vhangup/Makefile                                                                    |    1 
 testcases/kernel/syscalls/vmsplice/Makefile                                                                   |    1 
 testcases/kernel/syscalls/wait/Makefile                                                                       |    1 
 testcases/kernel/syscalls/wait4/Makefile                                                                      |    1 
 testcases/kernel/syscalls/waitpid/Makefile                                                                    |    1 
 testcases/kernel/syscalls/write/Makefile                                                                      |    1 
 testcases/kernel/syscalls/writev/Makefile                                                                     |    1 
 testcases/kernel/timers/Makefile                                                                              |    1 
 testcases/kernel/timers/clock_gettime/Makefile                                                                |    1 
 testcases/kernel/timers/clock_settime/Makefile                                                                |    1 
 testcases/kernel/timers/timer_create/Makefile                                                                 |    1 
 testcases/kernel/timers/timer_delete/Makefile                                                                 |    1 
 testcases/kernel/timers/timer_settime/Makefile                                                                |    1 
 testcases/misc/Makefile                                                                                       |    1 
 testcases/misc/crash/Makefile                                                                                 |    1 
 testcases/misc/f00f/Makefile                                                                                  |    1 
 testcases/misc/math/Makefile                                                                                  |    1 
 testcases/misc/math/abs/Makefile                                                                              |    1 
 testcases/misc/math/atof/Makefile                                                                             |    1 
 testcases/misc/math/float/Makefile                                                                            |    1 
 testcases/misc/math/float/bessel/Makefile                                                                     |    1 
 testcases/misc/math/float/exp_log/Makefile                                                                    |    1 
 testcases/misc/math/float/iperb/Makefile                                                                      |    1 
 testcases/misc/math/float/power/Makefile                                                                      |    1 
 testcases/misc/math/float/trigo/Makefile                                                                      |    1 
 testcases/misc/math/fptests/Makefile                                                                          |    1 
 testcases/misc/math/nextafter/Makefile                                                                        |    1 
 testcases/misc/tcore_patch_test_suites/Makefile                                                               |    1 
 testcases/network/Makefile                                                                                    |    1 
 testcases/network/can/filter-tests/Makefile                                                                   |    1 
 testcases/network/dhcpd/Makefile                                                                              |    1 
 testcases/network/iproute/Makefile                                                                            |    1 
 testcases/network/iptables/Makefile                                                                           |    1 
 testcases/network/ipv6/Makefile                                                                               |    1 
 testcases/network/ipv6/echo6/Makefile                                                                         |    1 
 testcases/network/ipv6/finger6/Makefile                                                                       |    1 
 testcases/network/ipv6/perf_lan6/Makefile                                                                     |    1 
 testcases/network/ipv6/ping6/Makefile                                                                         |    1 
 testcases/network/ipv6/sendfile6/Makefile                                                                     |    1 
 testcases/network/ipv6/tcpdump6/Makefile                                                                      |    1 
 testcases/network/lib6/Makefile                                                                               |    1 
 testcases/network/multicast/Makefile                                                                          |    1 
 testcases/network/multicast/mc_cmds/Makefile                                                                  |    1 
 testcases/network/multicast/mc_commo/Makefile                                                                 |    1 
 testcases/network/multicast/mc_member/Makefile                                                                |    1 
 testcases/network/multicast/mc_opts/Makefile                                                                  |    1 
 testcases/network/nfs/Makefile                                                                                |    1 
 testcases/network/nfs/fsx-linux/Makefile                                                                      |    1 
 testcases/network/nfs/nfs01/Makefile                                                                          |    1 
 testcases/network/nfs/nfs02/Makefile                                                                          |    1 
 testcases/network/nfs/nfs03/Makefile                                                                          |    1 
 testcases/network/nfs/nfs04/Makefile                                                                          |    1 
 testcases/network/nfs/nfs_fsstress/Makefile                                                                   |    1 
 testcases/network/nfs/nfslock01/Makefile                                                                      |    1 
 testcases/network/nfs/nfsstat01/Makefile                                                                      |    1 
 testcases/network/nfs/nfsstress/Makefile                                                                      |    1 
 testcases/network/nfsv4/Makefile                                                                              |    1 
 testcases/network/nfsv4/acl/Makefile                                                                          |    1 
 testcases/network/nfsv4/locks/Makefile                                                                        |    1 
 testcases/network/rpc/Makefile                                                                                |    1 
 testcases/network/rpc/basic_tests/Makefile                                                                    |    1 
 testcases/network/rpc/basic_tests/rpc01/Makefile                                                              |    1 
 testcases/network/rpc/basic_tests/rpcinfo/Makefile                                                            |    1 
 testcases/network/rpc/basic_tests/rup/Makefile                                                                |    1 
 testcases/network/rpc/basic_tests/rusers/Makefile                                                             |    1 
 testcases/network/rpc/rpc-tirpc-full-test-suite/inc/Makefile.hdr                                              |    1 
 testcases/network/sctp/Makefile                                                                               |    1 
 testcases/network/sctp/func_tests/Makefile                                                                    |    1 
 testcases/network/sctp/lib/Makefile                                                                           |    1 
 testcases/network/sctp/testlib/Makefile                                                                       |    1 
 testcases/network/sockets/Makefile                                                                            |    1 
 testcases/network/stress/Makefile                                                                             |    1 
 testcases/network/stress/broken_ip/Makefile                                                                   |    1 
 testcases/network/stress/dns/Makefile                                                                         |    1 
 testcases/network/stress/ftp/Makefile                                                                         |    1 
 testcases/network/stress/http/Makefile                                                                        |    1 
 testcases/network/stress/icmp/Makefile                                                                        |    1 
 testcases/network/stress/icmp/multi-diffip/Makefile                                                           |    1 
 testcases/network/stress/icmp/multi-diffnic/Makefile                                                          |    1 
 testcases/network/stress/icmp/uni-basic/Makefile                                                              |    1 
 testcases/network/stress/interface/Makefile                                                                   |    1 
 testcases/network/stress/multicast/Makefile                                                                   |    1 
 testcases/network/stress/multicast/grp-operation/Makefile                                                     |    1 
 testcases/network/stress/multicast/packet-flood/Makefile                                                      |    1 
 testcases/network/stress/multicast/query-flood/Makefile                                                       |    1 
 testcases/network/stress/ns-tools/Makefile                                                                    |    1 
 testcases/network/stress/route/Makefile                                                                       |    1 
 testcases/network/stress/ssh/Makefile                                                                         |    1 
 testcases/network/stress/tcp/Makefile                                                                         |    1 
 testcases/network/stress/tcp/multi-diffip/Makefile                                                            |    1 
 testcases/network/stress/tcp/multi-diffnic/Makefile                                                           |    1 
 testcases/network/stress/tcp/multi-diffport/Makefile                                                          |    1 
 testcases/network/stress/tcp/multi-sameport/Makefile                                                          |    1 
 testcases/network/stress/tcp/uni-basic/Makefile                                                               |    1 
 testcases/network/stress/tcp/uni-dsackoff/Makefile                                                            |    1 
 testcases/network/stress/tcp/uni-pktlossdup/Makefile                                                          |    1 
 testcases/network/stress/tcp/uni-sackoff/Makefile                                                             |    1 
 testcases/network/stress/tcp/uni-smallsend/Makefile                                                           |    1 
 testcases/network/stress/tcp/uni-tso/Makefile                                                                 |    1 
 testcases/network/stress/tcp/uni-winscale/Makefile                                                            |    1 
 testcases/network/stress/udp/Makefile                                                                         |    1 
 testcases/network/stress/udp/multi-diffip/Makefile                                                            |    1 
 testcases/network/stress/udp/multi-diffnic/Makefile                                                           |    1 
 testcases/network/stress/udp/multi-diffport/Makefile                                                          |    1 
 testcases/network/stress/udp/uni-basic/Makefile                                                               |    1 
 testcases/network/tcp_cmds/Makefile                                                                           |    1 
 testcases/network/tcp_cmds/arp/Makefile                                                                       |    1 
 testcases/network/tcp_cmds/echo/Makefile                                                                      |    1 
 testcases/network/tcp_cmds/finger/Makefile                                                                    |    1 
 testcases/network/tcp_cmds/ftp/Makefile                                                                       |    1 
 testcases/network/tcp_cmds/host/Makefile                                                                      |    1 
 testcases/network/tcp_cmds/netstat/Makefile                                                                   |    1 
 testcases/network/tcp_cmds/perf_lan/Makefile                                                                  |    1 
 testcases/network/tcp_cmds/ping/Makefile                                                                      |    1 
 testcases/network/tcp_cmds/rcp/Makefile                                                                       |    1 
 testcases/network/tcp_cmds/rdist/Makefile                                                                     |    1 
 testcases/network/tcp_cmds/rlogin/Makefile                                                                    |    1 
 testcases/network/tcp_cmds/rsh/Makefile                                                                       |    1 
 testcases/network/tcp_cmds/rwho/Makefile                                                                      |    1 
 testcases/network/tcp_cmds/sendfile/Makefile                                                                  |    1 
 testcases/network/tcp_cmds/ssh/Makefile                                                                       |    1 
 testcases/network/tcp_cmds/tcpdump/Makefile                                                                   |    1 
 testcases/network/tcp_cmds/telnet/Makefile                                                                    |    1 
 testcases/network/traceroute/Makefile                                                                         |    1 
 testcases/network/xinetd/Makefile                                                                             |    1 
 testcases/open_hpi_testsuite/Makefile.am                                                                      |    1 
 testcases/open_hpi_testsuite/Makefile.in                                                                      |    1 
 testcases/open_hpi_testsuite/clients/Makefile.am                                                              |    1 
 testcases/open_hpi_testsuite/clients/Makefile.in                                                              |    1 
 testcases/open_hpi_testsuite/configure.ac                                                                     |  709 ----------
 testcases/open_hpi_testsuite/configure.ac.in                                                                  |  709 ++++++++++
 testcases/open_hpi_testsuite/cpp/Makefile.am                                                                  |    1 
 testcases/open_hpi_testsuite/cpp/Makefile.in                                                                  |    1 
 testcases/open_hpi_testsuite/cpp/t/Makefile.am                                                                |    1 
 testcases/open_hpi_testsuite/cpp/t/Makefile.in                                                                |    1 
 testcases/open_hpi_testsuite/docs/Makefile.am                                                                 |    1 
 testcases/open_hpi_testsuite/docs/Makefile.in                                                                 |    1 
 testcases/open_hpi_testsuite/docs/hld/Makefile.am                                                             |    1 
 testcases/open_hpi_testsuite/docs/hld/Makefile.in                                                             |    1 
 testcases/open_hpi_testsuite/docs/man/Makefile.am                                                             |    1 
 testcases/open_hpi_testsuite/docs/man/Makefile.in                                                             |    1 
 testcases/open_hpi_testsuite/hpi_shell/Makefile.am                                                            |    1 
 testcases/open_hpi_testsuite/hpi_shell/Makefile.in                                                            |    1 
 testcases/open_hpi_testsuite/marshal/Makefile.am                                                              |    1 
 testcases/open_hpi_testsuite/marshal/Makefile.in                                                              |    1 
 testcases/open_hpi_testsuite/marshal/t/Makefile.am                                                            |    1 
 testcases/open_hpi_testsuite/marshal/t/Makefile.in                                                            |    1 
 testcases/open_hpi_testsuite/openhpid/Makefile.am                                                             |    1 
 testcases/open_hpi_testsuite/openhpid/Makefile.in                                                             |    1 
 testcases/open_hpi_testsuite/plugins/Makefile.am                                                              |    1 
 testcases/open_hpi_testsuite/plugins/Makefile.in                                                              |    1 
 testcases/open_hpi_testsuite/plugins/ilo2_ribcl/Makefile.am                                                   |    1 
 testcases/open_hpi_testsuite/plugins/ilo2_ribcl/Makefile.in                                                   |    1 
 testcases/open_hpi_testsuite/plugins/ipmi/Makefile.am                                                         |    1 
 testcases/open_hpi_testsuite/plugins/ipmi/Makefile.in                                                         |    1 
 testcases/open_hpi_testsuite/plugins/ipmi/t/Makefile.am                                                       |    1 
 testcases/open_hpi_testsuite/plugins/ipmi/t/Makefile.in                                                       |    1 
 testcases/open_hpi_testsuite/plugins/ipmidirect/Makefile.am                                                   |    1 
 testcases/open_hpi_testsuite/plugins/ipmidirect/Makefile.in                                                   |    1 
 testcases/open_hpi_testsuite/plugins/ipmidirect/t/Makefile.am                                                 |    1 
 testcases/open_hpi_testsuite/plugins/ipmidirect/t/Makefile.in                                                 |    1 
 testcases/open_hpi_testsuite/plugins/oa_soap/Makefile.am                                                      |    1 
 testcases/open_hpi_testsuite/plugins/oa_soap/Makefile.in                                                      |    1 
 testcases/open_hpi_testsuite/plugins/rtas/Makefile.am                                                         |    1 
 testcases/open_hpi_testsuite/plugins/rtas/Makefile.in                                                         |    1 
 testcases/open_hpi_testsuite/plugins/simulator/Makefile.am                                                    |    1 
 testcases/open_hpi_testsuite/plugins/simulator/Makefile.in                                                    |    1 
 testcases/open_hpi_testsuite/plugins/simulator/t/Makefile.am                                                  |    1 
 testcases/open_hpi_testsuite/plugins/simulator/t/Makefile.in                                                  |    1 
 testcases/open_hpi_testsuite/plugins/snmp_bc/Makefile.am                                                      |    1 
 testcases/open_hpi_testsuite/plugins/snmp_bc/Makefile.in                                                      |    1 
 testcases/open_hpi_testsuite/plugins/snmp_bc/t/Makefile.am                                                    |    1 
 testcases/open_hpi_testsuite/plugins/snmp_bc/t/Makefile.in                                                    |    1 
 testcases/open_hpi_testsuite/plugins/sysfs/Makefile.am                                                        |    1 
 testcases/open_hpi_testsuite/plugins/sysfs/Makefile.in                                                        |    1 
 testcases/open_hpi_testsuite/plugins/watchdog/Makefile.am                                                     |    1 
 testcases/open_hpi_testsuite/plugins/watchdog/Makefile.in                                                     |    1 
 testcases/open_hpi_testsuite/scripts/Makefile.am                                                              |    1 
 testcases/open_hpi_testsuite/scripts/Makefile.in                                                              |    1 
 testcases/open_hpi_testsuite/scripts/test/Makefile.am                                                         |    1 
 testcases/open_hpi_testsuite/scripts/test/Makefile.in                                                         |    1 
 testcases/open_hpi_testsuite/snmp/Makefile.am                                                                 |    1 
 testcases/open_hpi_testsuite/snmp/Makefile.in                                                                 |    1 
 testcases/open_hpi_testsuite/src/Makefile.am                                                                  |    1 
 testcases/open_hpi_testsuite/src/Makefile.in                                                                  |    1 
 testcases/open_hpi_testsuite/src/t/Makefile.am                                                                |    1 
 testcases/open_hpi_testsuite/src/t/Makefile.in                                                                |    1 
 testcases/open_hpi_testsuite/src/t/ohpi/Makefile.am                                                           |    1 
 testcases/open_hpi_testsuite/src/t/ohpi/Makefile.in                                                           |    1 
 testcases/open_hpi_testsuite/ssl/Makefile.am                                                                  |    1 
 testcases/open_hpi_testsuite/ssl/Makefile.in                                                                  |    1 
 testcases/open_hpi_testsuite/utils/Makefile.am                                                                |    1 
 testcases/open_hpi_testsuite/utils/Makefile.in                                                                |    1 
 testcases/open_hpi_testsuite/utils/t/Makefile.am                                                              |    1 
 testcases/open_hpi_testsuite/utils/t/Makefile.in                                                              |    1 
 testcases/open_hpi_testsuite/utils/t/ann/Makefile.am                                                          |    1 
 testcases/open_hpi_testsuite/utils/t/ann/Makefile.in                                                          |    1 
 testcases/open_hpi_testsuite/utils/t/el/Makefile.am                                                           |    1 
 testcases/open_hpi_testsuite/utils/t/el/Makefile.in                                                           |    1 
 testcases/open_hpi_testsuite/utils/t/epath/Makefile.am                                                        |    1 
 testcases/open_hpi_testsuite/utils/t/epath/Makefile.in                                                        |    1 
 testcases/open_hpi_testsuite/utils/t/rpt/Makefile.am                                                          |    1 
 testcases/open_hpi_testsuite/utils/t/rpt/Makefile.in                                                          |    1 
 testcases/open_hpi_testsuite/utils/t/sahpi/Makefile.am                                                        |    1 
 testcases/open_hpi_testsuite/utils/t/sahpi/Makefile.in                                                        |    1 
 testcases/open_hpi_testsuite/utils/t/uid/Makefile.am                                                          |    1 
 testcases/open_hpi_testsuite/utils/t/uid/Makefile.in                                                          |    1 
 testcases/open_posix_testsuite/Makefile                                                                       |    1 
 testcases/open_posix_testsuite/functional/mqueues/Makefile                                                    |    1 
 testcases/open_posix_testsuite/functional/semaphores/Makefile                                                 |    1 
 testcases/open_posix_testsuite/functional/threads/Makefile                                                    |    1 
 testcases/open_posix_testsuite/functional/threads/Makefile.inc                                                |    1 
 testcases/open_posix_testsuite/functional/threads/condvar/Makefile                                            |    4 
 testcases/open_posix_testsuite/functional/threads/pi_test/Makefile                                            |    1 
 testcases/open_posix_testsuite/functional/threads/robust_test/Makefile                                        |    1 
 testcases/open_posix_testsuite/functional/threads/schedule/Makefile                                           |    1 
 testcases/open_posix_testsuite/functional/timers/Makefile                                                     |    1 
 testcases/open_posix_testsuite/functional/timers/clocks/Makefile                                              |    1 
 testcases/open_posix_testsuite/functional/timers/timers/Makefile                                              |    1 
 testcases/open_posix_testsuite/stress/mqueues/Makefile                                                        |    1 
 testcases/open_posix_testsuite/stress/semaphores/Makefile                                                     |    1 
 testcases/open_posix_testsuite/stress/threads/fork/Makefile                                                   |    1 
 testcases/open_posix_testsuite/stress/threads/pthread_cancel/Makefile                                         |    1 
 testcases/open_posix_testsuite/stress/threads/pthread_cond_init/Makefile                                      |    1 
 testcases/open_posix_testsuite/stress/threads/pthread_cond_timedwait/Makefile                                 |    1 
 testcases/open_posix_testsuite/stress/threads/pthread_create/Makefile                                         |    1 
 testcases/open_posix_testsuite/stress/threads/pthread_exit/Makefile                                           |    1 
 testcases/open_posix_testsuite/stress/threads/pthread_getschedparam/Makefile                                  |    1 
 testcases/open_posix_testsuite/stress/threads/pthread_kill/Makefile                                           |    1 
 testcases/open_posix_testsuite/stress/threads/pthread_mutex_init/Makefile                                     |    1 
 testcases/open_posix_testsuite/stress/threads/pthread_mutex_lock/Makefile                                     |    1 
 testcases/open_posix_testsuite/stress/threads/pthread_mutex_trylock/Makefile                                  |    1 
 testcases/open_posix_testsuite/stress/threads/pthread_once/Makefile                                           |    1 
 testcases/open_posix_testsuite/stress/threads/pthread_self/Makefile                                           |    1 
 testcases/open_posix_testsuite/stress/threads/sem_getvalue/Makefile                                           |    1 
 testcases/open_posix_testsuite/stress/threads/sem_init/Makefile                                               |    1 
 testcases/open_posix_testsuite/stress/threads/sem_open/Makefile                                               |    1 
 testcases/pounder21/Makefile                                                                                  |    1 
 testcases/pounder21/README                                                                                    |    2 
 testcases/pounder21/src/cpufreq/Makefile                                                                      |    1 
 testcases/pounder21/src/mem_alloc_test/Makefile                                                               |    1 
 testcases/pounder21/src/memxfer5b/Makefile                                                                    |    1 
 testcases/pounder21/src/ramsnake/Makefile                                                                     |    1 
 testcases/pounder21/src/randacoords/Makefile                                                                  |    1 
 testcases/pounder21/src/randasyscall/Makefile                                                                 |    1 
 testcases/pounder21/src/time_tests/Makefile                                                                   |    1 
 testcases/pounder21/src/xbonkers/Makefile                                                                     |    1 
 tools/Makefile                                                                                                |    1 
 tools/apicmds/Makefile                                                                                        |    1 
 tools/genload/Makefile                                                                                        |    1 
 tools/netpipe-2.4-ipv6/Makefile                                                                               |    1 
 tools/netpipe-2.4/Makefile                                                                                    |    1 
 tools/top-LTP/Makefile                                                                                        |    1 
 utils/Makefile                                                                                                |    1 
 utils/benchmark/Makefile                                                                                      |    1 
 utils/benchmark/ebizzy-0.3/Makefile                                                                           |    1 
 809 files changed, 1599 insertions(+), 800 deletions(-)

Index: ltp/include/Makefile
===================================================================
--- ltp.orig/include/Makefile
+++ ltp/include/Makefile
@@ -1,6 +1,7 @@
+include ./../config.mk
 
 
-PREFIX=/opt/ltp
+PREFIX?=/opt/ltp
 HEADERS=compiler.h dataascii.h databin.h file_lock.h forker.h open_flags.h \
 	pattern.h random_range.h rmobj.h search_path.h string_to_tokens.h \
 	str_to_bytes.h test.h tlibio.h usctest.h write_log.h \
Index: ltp/lib/Makefile
===================================================================
--- ltp.orig/lib/Makefile
+++ ltp/lib/Makefile
@@ -1,5 +1,5 @@
-
-PREFIX=/opt/ltp
+PREFIX?=/opt/ltp
+include ../config.mk
 
 CFLAGS+= -Wall
 CPPFLAGS+= -I../include 
Index: ltp/lib/ltp.pc
===================================================================
--- ltp.orig/lib/ltp.pc
+++ /dev/null
@@ -1,11 +0,0 @@
-prefix=/opt/ltp
-exec_prefix=${prefix}
-libdir=${exec_prefix}/lib
-includedir=${prefix}/include
-
-Name: LTP
-Description: Linux Test Project
-Version: 1.0
-Libs: -L${libdir} -lltp
-Cflags: -I${includedir}
-Libs.private: -L${libdir} -lltp 
Index: ltp/ltp-devel.spec
===================================================================
--- ltp.orig/ltp-devel.spec
+++ /dev/null
@@ -1,68 +0,0 @@
-#
-# RPM Package Manager (RPM) spec file for ltp-devel
-#
-Summary: Linux Test Project (LTP) Software Development Kit (SDK)
-Name: ltp-devel
-Version: 2.0
-Release: 0.0
-Prefix: /opt/ltp
-License: GPL
-Group: Development/Libraries
-URL: http://www.linuxtestproject.org
-Vendor: IBM Corp
-Packager: Subrata Modak <subrata.modak@@in.ibm.com>
-AutoReqProv:    0
-Provides:       LTP
-#ExclusiveArch:  i386
-ExclusiveOS:    linux
-%description
-This is a development package of the Linux Test Project (LTP).
-It is intended to be used to build testcases using the provided API.
-%files
-/opt/ltp/lib/libltp.a
-/usr/share/pkgconfig/ltp.pc
-/opt/ltp/bin/ltp-pan
-/opt/ltp/bin/ltp-scanner
-/opt/ltp/bin/ltp-bump
-/opt/ltp/include/linux_syscall_numbers.h
-/opt/ltp/include/libtestsuite.h
-/opt/ltp/include/usctest.h
-/opt/ltp/include/string_to_tokens.h
-/opt/ltp/include/str_to_bytes.h
-/opt/ltp/include/databin.h
-/opt/ltp/include/open_flags.h
-/opt/ltp/include/write_log.h
-/opt/ltp/include/dataascii.h
-/opt/ltp/include/forker.h
-/opt/ltp/include/compiler.h
-/opt/ltp/include/test.h
-/opt/ltp/include/tlibio.h
-/opt/ltp/include/pattern.h
-/opt/ltp/include/file_lock.h
-/opt/ltp/include/random_range.h
-/opt/ltp/include/search_path.h
-/opt/ltp/include/rmobj.h
-/usr/share/man/man3/tst_tmpdir.3
-/usr/share/man/man3/random_range_seed.3
-/usr/share/man/man3/pattern.3
-/usr/share/man/man3/parse_ranges.3
-/usr/share/man/man3/usctest.3
-/usr/share/man/man3/random_range.3
-/usr/share/man/man3/forker.3
-/usr/share/man/man3/rmobj.3
-/usr/share/man/man3/parse_open_flags.3
-/usr/share/man/man3/tst_res.3
-/usr/share/man/man3/write_log.3
-/usr/share/man/man3/str_to_bytes.3
-/usr/share/man/man3/tst_set_error.3
-/usr/share/man/man3/parse_opts.3
-/usr/share/man/man3/string_to_tokens.3
-/usr/share/man/man3/tst_sig.3
-/usr/share/man/man3/get_attrib.3
-/usr/share/man/man1/ltp-pan.1
-/usr/share/man/man1/doio.1
-/usr/share/man/man1/iogen.1
-/usr/share/man/man1/ltp-bump.1
-# Post-install stuff would go here.
-#EOF
-
Index: ltp/m4/GNUmakefile
===================================================================
--- ltp.orig/m4/GNUmakefile
+++ ltp/m4/GNUmakefile
@@ -1,6 +1,6 @@
 
 
-PREFIX=/opt/ltp
+PREFIX?=/opt/ltp
 M4MACROS=$(notdir $(wildcard *.m4))
 
 all:
Index: ltp/pan/Makefile
===================================================================
--- ltp.orig/pan/Makefile
+++ ltp/pan/Makefile
@@ -1,8 +1,9 @@
+include ./../config.mk
 
 LOADLIBES += -lm
 LFLAGS += -l -w
 CFLAGS += -w 
-PREFIX = /opt/ltp
+PREFIX ?= /opt/ltp
 
 all: ltp-pan ltp-bump ltp-scanner
 
Index: ltp/testcases/ballista/ballista/configHints.txt
===================================================================
--- ltp.orig/testcases/ballista/ballista/configHints.txt
+++ ltp/testcases/ballista/ballista/configHints.txt
@@ -132,7 +132,7 @@
 	  #  only when you want a value for a variable that you cannot
 	  #  fit on a single line.
 	  #
-	target-MISC_VARS   [WINDBASE=/opt/wind
+	target-MISC_VARS   [WINDBASE=${PREFIX}/opt/wind
 			     WIND_HOST_TYPE=sun4-solaris2
 			     LD=ld68k
 			     NM=nm68k
Index: ltp/testcases/open_posix_testsuite/functional/threads/condvar/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/functional/threads/condvar/Makefile
+++ ltp/testcases/open_posix_testsuite/functional/threads/condvar/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
@@ -6,8 +7,9 @@
 
 CFLAGS := -Wall -I../../../include -O2
 LDFLAGS := -lpthread -lrt
+PREFIX ?=
 
-include /opt/libc/Makefile.inc
+include $(PREFIX)/opt/libc/Makefile.inc
 
 TARGETS := pthread_cond_wait_1 pthread_cond_wait_2
 
Index: ltp/testcases/pounder21/README
===================================================================
--- ltp.orig/testcases/pounder21/README
+++ ltp/testcases/pounder21/README
@@ -92,6 +92,8 @@ tests/           Symlinks to run the tes
 log/             Logs from pounder runs go here.
 
 Like before, all the tests are run in parallel.
+NOTE: These paths may be supplied a prefix during the ./configure step when
+	building LTP.
 
 Note that third party test packages (LTP, kernel, etc) aren't packaged
 with pounder; the build scripts should download them and build them
Index: ltp/configure.ac
===================================================================
--- ltp.orig/configure.ac
+++ ltp/configure.ac
@@ -2,7 +2,8 @@ AC_PREREQ([2.61])
 AC_INIT([ltp], [cvs], [ltp-results@lists.sourceforge.net])
 AM_INIT_AUTOMAKE([1.10])
 AC_CONFIG_HEADERS([include/config.h])
-AC_CONFIG_FILES([config.mk m4/Makefile])
+AC_CONFIG_FILES([config.mk m4/Makefile lib/ltp.pc ltp-devel.spec])
+AC_CONFIG_SUBDIRS([testcases/open_hpi_testsuite testcases/kernel/syscalls/libevent testcases/kernel/syscalls/pcllib])
 
 AC_CANONICAL_HOST
 AC_PROG_CC
Index: ltp/lib/ltp.pc.in
===================================================================
--- /dev/null
+++ ltp/lib/ltp.pc.in
@@ -0,0 +1,11 @@
+prefix=/opt/ltp
+exec_prefix=${prefix}
+libdir=${exec_prefix}/lib
+includedir=${prefix}/include
+
+Name: LTP
+Description: Linux Test Project
+Version: 1.0
+Libs: -L${libdir} -lltp
+Cflags: -I${includedir}
+Libs.private: -L${libdir} -lltp
Index: ltp/ltp-devel.spec.in
===================================================================
--- /dev/null
+++ ltp/ltp-devel.spec.in
@@ -0,0 +1,68 @@
+#
+# RPM Package Manager (RPM) spec file for ltp-devel
+#
+Summary: Linux Test Project (LTP) Software Development Kit (SDK)
+Name: ltp-devel
+Version: 2.0
+Release: 0.0
+Prefix: @prefix@/ltp
+License: GPL
+Group: Development/Libraries
+URL: http://www.linuxtestproject.org
+Vendor: IBM Corp
+Packager: Subrata Modak <subrata.modak@@in.ibm.com>
+AutoReqProv:    0
+Provides:       LTP
+#ExclusiveArch:  i386
+ExclusiveOS:    linux
+%description
+This is a development package of the Linux Test Project (LTP).
+It is intended to be used to build testcases using the provided API.
+%files
+@prefix@/ltp/lib/libltp.a
+@datarootdir@/pkgconfig/ltp.pc
+@prefix@/ltp/bin/ltp-pan
+@prefix@/ltp/bin/ltp-scanner
+@prefix@/ltp/bin/ltp-bump
+@prefix@/ltp/include/linux_syscall_numbers.h
+@prefix@/ltp/include/libtestsuite.h
+@prefix@/ltp/include/usctest.h
+@prefix@/ltp/include/string_to_tokens.h
+@prefix@/ltp/include/str_to_bytes.h
+@prefix@/ltp/include/databin.h
+@prefix@/ltp/include/open_flags.h
+@prefix@/ltp/include/write_log.h
+@prefix@/ltp/include/dataascii.h
+@prefix@/ltp/include/forker.h
+@prefix@/ltp/include/compiler.h
+@prefix@/ltp/include/test.h
+@prefix@/ltp/include/tlibio.h
+@prefix@/ltp/include/pattern.h
+@prefix@/ltp/include/file_lock.h
+@prefix@/ltp/include/random_range.h
+@prefix@/ltp/include/search_path.h
+@prefix@/ltp/include/rmobj.h
+@mandir@/man3/tst_tmpdir.3
+@mandir@/man3/random_range_seed.3
+@mandir@/man3/pattern.3
+@mandir@/man3/parse_ranges.3
+@mandir@/man3/usctest.3
+@mandir@/man3/random_range.3
+@mandir@/man3/forker.3
+@mandir@/man3/rmobj.3
+@mandir@/man3/parse_open_flags.3
+@mandir@/man3/tst_res.3
+@mandir@/man3/write_log.3
+@mandir@/man3/str_to_bytes.3
+@mandir@/man3/tst_set_error.3
+@mandir@/man3/parse_opts.3
+@mandir@/man3/string_to_tokens.3
+@mandir@/man3/tst_sig.3
+@mandir@/man3/get_attrib.3
+@mandir@/man1/ltp-pan.1
+@mandir@/man1/doio.1
+@mandir@/man1/iogen.1
+@mandir@/man1/ltp-bump.1
+# Post-install stuff would go here.
+#EOF
+
Index: ltp/testcases/open_hpi_testsuite/configure.ac
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/configure.ac
+++ /dev/null
@@ -1,709 +0,0 @@
-dnl
-dnl autoconf and automake for openhpi
-dnl     initial file by Andrea Brugger <andrea.l.brugger@intel.com> 1/03
-dnl   various hacks by Sean Dague <http://dague.net/sean> 4/23/03
-
-
-AC_PREREQ(2.57)
-AC_INIT(openhpi, 2.14.0)
-AC_CONFIG_SRCDIR(openhpi.spec.in)
-AM_INIT_AUTOMAKE([1.8])
-
-AM_CONFIG_HEADER(config.h)
-AH_TOP([#ifndef __OPENHPI_CONFIG_H
-#define __OPENHPI_CONFIG_H])
-AH_BOTTOM([#endif /* __OPENHPI_CONFIG_H */])
-
-#
-# (major version) = (first number) - (third number)
-# (minor version) = (third number)
-# (patch version) = (second number)
-# example HPI_LIB_VERSION=13:4:11
-# major version: 2  = 13 - 11
-# minor version: 11 = 11
-# patch version: 4  = 4
-#
-HPI_LIB_VERSION=16:0:14
-HPI_PKG=$PACKAGE_NAME
-HPI_UTIL_PKG=${PACKAGE_NAME}utils
-HPI_CLIENT_PKG=${PACKAGE_NAME}client
-AC_SUBST(HPI_CLIENT_PKG)
-AC_SUBST(HPI_UTIL_PKG)
-AC_SUBST(HPI_PKG)
-AC_SUBST(HPI_LIB_VERSION)
-AC_SUBST(ac_configure_args)
-
-dnl Checks for programs
-AC_PROG_CC
-AC_LIBTOOL_DLOPEN
-AC_PROG_LIBTOOL
-AC_PROG_LN_S
-AC_PROG_CXX
-AC_PROG_CPP
-AC_PROG_INSTALL
-AC_PROG_LN_S
-AC_PROG_MAKE_SET
-
-dnl die on int != 32bits.  This is too instrumental to our code right now.
-dnl AC_MSG_CHECKING(int is 4 bytes)
-OH_SET_SIZES
-if test "x$OH_SIZEOF_INT" != "x4"; then
-    AC_MSG_ERROR([
-*** int is not 4 bytes, it is $OH_SIZEOF_INT bytes on this platform
-*** undefined behavior will result
-*** please contact the openhpi development team to fix this
-])
-fi
-
-AM_CONDITIONAL(CROSS_COMPILATION, test x$cross_compiling = xyes)
-
-dnl Check for libraries
-have_uuid=no
-have_openipmi=no
-have_fam=no
-have_sysfs=no
-have_rtas_lib=no
-
-dnl Check for GLIB
-
-AC_CHECK_PROG([found_pkg_config],[pkg-config],[yes])
-
-if test "x$found_pkg_config" != "xyes"; then
-    OH_CHECK_FAIL(pkg-config,pkg-config)
-fi
-PKG_CFG_SETPATH
-
-# check for gcc version
-
-AC_MSG_CHECKING(gcc >= 3.2.0)
-OH_CHECK_GCC(3,2,0)
-
-dnl glib 2.x checks
-GLIB_REQUIRED_VERSION=2.2.0
-GLIB=glib-2.0
-
-if pkg-config --atleast-version $GLIB_REQUIRED_VERSION $GLIB; then
-   :
-else
-   AC_MSG_ERROR([
-*** GLIB >= $GLIB_REQUIRED_VERSION is required. The latest version of
-*** GLIB is always available from ftp://ftp.gtk.org/.])
-fi
-
-exact_version=`pkg-config --modversion $GLIB`;
-GLIB_CFLAGS=`pkg-config --cflags $GLIB gthread-2.0`
-GLIB_LIBS=`pkg-config --libs $GLIB gthread-2.0`
-
-AC_MSG_CHECKING(for GLIB - version >= $GLIB_REQUIRED_VERSION)
-AC_MSG_RESULT(yes (version $exact_version))
-
-dnl if the glib is installed on a non standard place
-dnl like /opt/gnome/lib AC_CHECK_LIB will find the library.
-old_cflags=$CFLAGS
-old_libs=$LIBS
-
-CFLAGS="$CFLAGS $GLIB_CFLAGS"
-LIBS="$LIBS $GLIB_LIBS"
-
-AC_CHECK_LIB([$GLIB], [g_slist_alloc], [],
-[
-OH_CHECK_FAIL(glib,glib-devel)
-])
-
-CFLAGS=$old_cflags
-LIBS=$old_libs
-
-
-AC_CHECK_LIB([ltdl], [lt_dlopen], [], [
-    OH_CHECK_FAIL(libltdl,libltdl-devel,,
-        this is required for plugin loading)
-    ])
-
-AC_CHECK_LIB([sysfs], [sysfs_get_mnt_path], [have_sysfs=yes])
-AC_CHECK_HEADER([sysfs/libsysfs.h], [], [have_sysfs=no])
-
-OH_CHECK_NETSNMP
-
-AC_CHECK_LIB([uuid], [uuid_generate], [have_uuid=yes], [
-    OH_CHECK_FAIL(libuuid,e2fsprogs-devel)
-    ])
-
-dnl ssl is used for md2/md5 authentification in ipmidirect
-dnl and for SSL-based communication in ilo2_ribcl and oa_soap
-AC_CHECK_LIB([crypto],[MD5_Init],[CRYPTO_LIB=-lcrypto],[CRYPTO_LIB=])
-AC_SUBST(CRYPTO_LIB)
-AC_CHECK_LIB([ssl],[SSL_library_init],[SSL_LIB=-lssl],[SSL_LIB=])
-AC_SUBST(SSL_LIB)
-AC_CHECK_HEADERS([openssl/md2.h openssl/md5.h openssl/bio.h openssl/ssl.h openssl/err.h],[have_openssl=yes],[have_openssl=no])
-
-dnl xml is used for XML-based communication in ilo2_ribcl and oa_soap
-AC_CHECK_LIB([xml2],[xmlParseMemory],[XML2_LIB=-lxml2],[XML2_LIB=])
-AC_CHECK_HEADERS([libxml2/libxml/xmlexports.h],[XML2_INCLUDE="-I/usr/include/libxml2"],[XML2_INCLUDE])
-AC_SUBST(XML2_LIB)
-AC_SUBST(XML2_INCLUDE)
-
-dnl Build daemon statically or dynamically.
-openhpid_static="no"
-
-ENABLED_DIRS="$ENABLED_DIRS openhpid"
-AC_ARG_ENABLE([daemon],
-	[  --enable-dynamic-daemon   build HPI daemon and client library non-statically[[default=yes]]],
-        [if test "x$enableval" = "xno"; then
-        openhpid_static="yes"
-    fi],
-    [openhpid_static="no"])
-
-AM_CONDITIONAL(OPENHPID_STATIC, test x$openhpid_static = xyes)
-
-
-AC_ARG_ENABLE([clients],
-    [  --enable-clients        build HPI client programs [[default=yes]]],
-    [if test "x$enableval" = "xyes"; then
-        ENABLED_DIRS="$ENABLED_DIRS clients"
-    fi],
-    [ENABLED_DIRS="$ENABLED_DIRS clients"])
-
-AC_ARG_ENABLE([cpp_wrappers],
-    [  --enable-cpp_wrappers   build SaHpi C++ wrapper objects [[default=no]]],
-    [if test "x$enableval" = "xyes"; then
-        ENABLED_DIRS="$ENABLED_DIRS cpp"
-    fi])
-
-AC_SUBST(ENABLED_DIRS)
-
-dnl Checks for header files.
-AC_HEADER_STDC
-AC_CHECK_HEADERS([fcntl.h stdlib.h string.h sys/time.h unistd.h stdarg.h netinet/in.h])
-
-dnl Checks for library functions.
-AC_FUNC_ERROR_AT_LINE
-AC_FUNC_VPRINTF
-AC_CHECK_FUNCS([gettimeofday memset strdup])
-
-dnl Checks for other helper programs
-
-AC_PATH_PROGS(RPM, rpmbuild)
-
-dnl plugin enablement stanzas
-
-dnl list of static plugins
-STATIC_PLUGIN_LIST=
-STATIC_PLUGIN_EXTRA_LIBS=
-
-AC_CHECK_HEADER([linux/watchdog.h], [have_linux_watchdog_h=yes], [], [#include <linux/types.h>])
-AC_ARG_ENABLE([watchdog],
-    [  --enable-watchdog       build watchdog plugin [[default=yes if linux/watchdog.h exists]]],
-    [if test "x$enableval" = "xyes"; then
-        if test "x$have_linux_watchdog_h" = "xyes"; then
-            AC_SUBST(WATCHDOG,watchdog)
-        else
-            AC_MSG_ERROR("Can not build the watchdog plugin without linux/watchdog.h.")
-        fi
-    else
-        AC_SUBST(WATCHDOG,"")
-    fi],
-    [if test "x$have_linux_watchdog_h" = "xyes"; then
-        AC_SUBST(WATCHDOG,watchdog)
-    else
-        AC_SUBST(WATCHDOG,"")
-    fi])
-
-dnl
-dnl We really need to make ipmi enablement be contigent on OpenIPMI
-dnl
-
-if PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig pkg-config --atleast-version 1.4.20 OpenIPMI; then
-    have_openipmi=yes
-    AC_CHECK_LIB([OpenIPMI], [ipmi_smi_setup_con], [have_openipmi=yes])
-    OPENIPMI_CFLAGS=`PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig pkg-config --cflags OpenIPMI`
-    AC_SUBST(OPENIPMI_CFLAGS)
-    OPENIPMI_LIBS=`PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig pkg-config --libs OpenIPMI`
-    AC_SUBST(OPENIPMI_LIBS)
-fi
-
-AC_ARG_ENABLE([ipmi],
-    [  --enable-ipmi           build openipmi plugin [[default=yes if OpenIPMI exists]]],
-    [if test "x$enableval" = "xyes"; then
-        if test "x$have_openipmi" = "xyes"; then
-            AC_SUBST(IPMI,ipmi)
-	    AC_SUBST(WITH_IPMI,1)
-        else
-            OH_CHECK_FAIL(OpenIPMI,libOpenIPMI-devel,http://openipmi.sf.net,
-                         Can not build IPMI support without OpenIPMI >= 1.4.20)
-        fi
-    elif test "x$enableval" = "xstatic"; then
-        if test "x$have_openipmi" = "xyes"; then
-            AC_SUBST(IPMI,ipmi)
-	    AC_SUBST(WITH_IPMI,1)
-            STATIC_PLUGIN_LIST="$STATIC_PLUGIN_LIST ipmi"
-            STATIC_PLUGIN_EXTRA_LIBS="$STATIC_PLUGIN_EXTRA_LIBS"
-        else
-            OH_CHECK_FAIL(OpenIPMI,libOpenIPMI-devel,http://openipmi.sf.net,
-                         Can not build IPMI support without OpenIPMI >= 1.4.20)
-        fi
-    else
-	    AC_SUBST(WITH_IPMI,0)
-    fi],
-    [if test "x$have_openipmi" = "xyes"; then
-            AC_SUBST(IPMI,ipmi)
-	    AC_SUBST(WITH_IPMI,1)
-     else
-	    AC_SUBST(WITH_IPMI,0)
-     fi
-    ])
-
-AC_ARG_ENABLE([sysfs],
-    [  --enable-sysfs          build sysfs plugin [[default=yes if libsysfs exists]]],
-    [if test "x$enableval" = "xyes"; then
-        if test "x$have_sysfs" = "xyes"; then
-            AC_SUBST(SYSFS,sysfs)
-	    AC_SUBST(WITH_SYSFS,1)
-        else
-            OH_CHECK_FAIL(libsysfs,,http://linux-diag.sf.net,
-                Can not build sysfs support without libsysfs)
-        fi
-    else
-	    AC_SUBST(WITH_SYSFS,0)
-    fi],
-    [if test "x$have_sysfs" = "xyes"; then
-            AC_SUBST(SYSFS,sysfs)
-	    AC_SUBST(WITH_SYSFS,1)
-     else
-	    AC_SUBST(WITH_SYSFS,0)
-     fi
-    ])
-
-AC_ARG_ENABLE([snmp_bc],
-    [  --enable-snmp_bc        build IBM Blade Center plugin [[default=yes if net-snmp is installed]]],
-    [if test "x$enableval" = "xyes"; then
-        if test "x$have_netsnmp" = "xyes"; then
-            AC_SUBST(SNMP_BC,snmp_bc)
-	    AC_SUBST(WITH_SNMP_BC,1)
-            SNMPDIR=snmp
-        else
-            OH_CHECK_FAIL(net-snmp,net-snmp-devel,http://net-snmp.sourceforge.net/,
-                Can not build IBM Blade Center support without net-snmp)
-        fi
-    else
-	    AC_SUBST(WITH_SNMP_BC,0)
-    fi],
-    [if test "x$have_netsnmp" = "xyes"; then
-            AC_SUBST(SNMP_BC,snmp_bc)
-	    AC_SUBST(WITH_SNMP_BC,1)
-            SNMPDIR=snmp
-    else
-	    AC_SUBST(WITH_SNMP_BC,0)
-    fi]
-    )
-
-AC_ARG_ENABLE([ipmidirect],
-    [  --enable-ipmidirect     build direct ipmi plugin [[default=yes]]],
-    [if test "x$enableval" = "xyes"; then
-            AC_SUBST(IPMIDIRECT,ipmidirect)
-     elif test "x$enableval" = "xstatic"; then
-            AC_SUBST(IPMIDIRECT,ipmidirect)
-            STATIC_PLUGIN_LIST="$STATIC_PLUGIN_LIST ipmidirect"
-            STATIC_PLUGIN_EXTRA_LIBS="$STATIC_PLUGIN_EXTRA_LIBS $SSL_LIB -luuid -lm -lstdc++"
-     fi],
-    [AC_SUBST(IPMIDIRECT,ipmidirect)])
-
-dnl    [AC_SUBST(IPMIDIRECT,ipmidirect)])
-
-OH_CHECK_RTAS
-
-#Configure options for the RTAS plugin
-AC_ARG_ENABLE([rtas],
-    [  --enable-rtas           build rtas ppc plugin [[default=no]]],
-    [if test "x$enableval" = "xyes"; then
-        if test "x$have_rtas_lib" = "xyes"; then
-            AC_SUBST(RTAS,rtas)
-	    AC_SUBST(WITH_RTAS,1)
-        else
-            OH_CHECK_FAIL(librtas, librtas-devel, http://librtas.ozlabs.org/,
-                Cannot build RTAS plugin without the librtas library)
-        fi
-    else
-	    AC_SUBST(WITH_RTAS,0)
-    fi],
-    [AC_SUBST(WITH_RTAS,0)])
-
-# configure argument for the simulator plugin
-AC_ARG_ENABLE([simulator],
-    [  --enable-simulator      build simulator plugin [[default=yes]]],
-    [if test "x$enableval" = "xyes"; then
-        AC_SUBST(SIMULATOR,simulator)
-    fi],
-    [AC_SUBST(SIMULATOR,simulator)])
-
-# configure argument for the ilo2_ribcl plugin
-AC_ARG_ENABLE([ilo2_ribcl],
-    [  --enable-ilo2_ribcl     build ilo2_ribcl plugin [[default=no]]],
-    [if test "x$enableval" = "xyes"; then
-        if test "x$have_openssl" = "xyes"; then
-            if test -n "$XML2_INCLUDE"; then
-                AC_SUBST(ILO2_RIBCL,ilo2_ribcl)
-                AC_SUBST(WITH_ILO2_RIBCL,1)
-            else
-                OH_CHECK_FAIL(xml2-devel,,,Can not build ilo2_ribcl without xml2 headers)
-            fi
-        else
-            OH_CHECK_FAIL(openssl-devel,,,Can not build ilo2_ribcl without openssl headers)
-        fi
-    else
-        AC_SUBST(WITH_ILO2_RIBCL,0)
-    fi],
-    [if test "x$have_openssl" = "xyes" && test -n "$XML2_INCLUDE"; then
-        AC_SUBST(ILO2_RIBCL,ilo2_ribcl)
-        AC_SUBST(WITH_ILO2_RIBCL,1)
-     else
-        AC_SUBST(WITH_ILO2_RIBCL,0)
-     fi
-    ])
-
-# configure argument for the oa_soap plugin
-AC_ARG_ENABLE([oa_soap],
-    [  --enable-oa_soap        build oa_soap plugin [[default=no]]],
-    [if test "x$enableval" = "xyes"; then
-        if test "x$have_openssl" = "xyes"; then
-	    if test -n "$XML2_INCLUDE"; then
-                AC_SUBST(OA_SOAP,oa_soap)
-                AC_SUBST(WITH_OA_SOAP,1)
-	    else
-	    	OH_CHECK_FAIL(xml2-devel,,,Can not build oa_soap without xml2 headers)
-	    fi
-	else
-	    OH_CHECK_FAIL(openssl-devel,,,Can not build oa_soap without openssl headers)
-	fi
-    else
-        AC_SUBST(WITH_OA_SOAP,0)
-    fi],
-    [if test "x$have_openssl" = "xyes" && test -n "$XML2_INCLUDE"; then
-        AC_SUBST(OA_SOAP,oa_soap)
-        AC_SUBST(WITH_OA_SOAP,1)
-     else
-        AC_SUBST(WITH_OA_SOAP,0)
-     fi
-    ])
-
-dnl enable marshal library
-AC_SUBST(MARSHALDIR,marshal)
-
-dnl
-dnl create static plugin config
-dnl
-
-STATIC_PLUGIN=
-STATIC_PLUGIN_EXTERN=
-STATIC_PLUGIN_LIBS=
-
-for name in $STATIC_PLUGIN_LIST; do
-        STATIC_PLUGIN="$STATIC_PLUGIN { \"$name\", ${name}_get_interface },";
-        STATIC_PLUGIN_EXTERN="${STATIC_PLUGIN_EXTERN} extern int ${name}_get_interface(void **pp, const uuid_t uuid);";
-        STATIC_PLUGIN_LIBS="$STATIC_PLUGIN_LIBS \$(top_builddir)/plugins/$name/lib${name}.la";
-done
-
-dnl use src/plugin_static.c.in
-AC_SUBST(STATIC_PLUGIN_EXTERN)
-AC_SUBST(STATIC_PLUGIN)
-
-dnl additional libs
-AC_SUBST(STATIC_PLUGIN_LIBS)
-AC_SUBST(STATIC_PLUGIN_EXTRA_LIBS)
-
-dnl setup SNMPFLAGS
-AC_SUBST(SNMPFLAGS)
-AC_SUBST(SNMPLIBS)
-AC_SUBST(SNMPDIR)
-AC_SUBST(SSLDIR)
-
-dnl
-dnl This code was borrowed from linux-ha configure.in file
-dnl and is used for creating the proper substitutions
-dnl in the spec file. Without it, the spec file will
-dnl have ${exec_prefix}, etc. instead of the actual
-dnl directory.
-dnl
-dnl
-
-prefix=`eval echo "$prefix"`
-
-case $prefix in
-  NONE) prefix=/usr/local;;
-esac
-var() {
-  case $1 in
-    *'${'*)     res=`eval echo "$1"`;;
-    *)          res="$1";;
-  esac
-  case "$res" in
-    ""|NONE)    echo "$2";;
-    *)          echo "$res";;
-  esac
-}
-
-exec_prefix=`var "$exec_prefix" "$prefix"`
-bindir=`var "$bindir" "$exec_prefix/bin"`
-sbindir=`var "$sbindir" "$exec_prefix/sbin"`
-sysconfdir=`var "$sysconfdir" "$prefix/etc"`
-libdir=`var "$libdir" "$exec_prefix/lib"`
-includedir=`var "$includedir" "$exec_prefix/include"`
-localstatedir=`var "$localstatedir" "/var"`
-base_includedir="${includedir}"
-AC_SUBST(base_includedir)
-
-dnl
-dnl defines CONFPATH, OH_DEFAULT_CONF and OH_CLIENT_DEFAULT_CONF
-dnl
-
-#CONFPATH=${CONFPATH:=/etc/${PACKAGE_NAME}}
-
-#AC_ARG_WITH(confpath,
-#   [[  --with-confpath=PATH    use directory PATH to store openhpi configuration file [default=/etc/openhpi]]],
-#   [CONFPATH=$withval])
-
-dnl substitute @CONFPATH@ in all Makefiles
-CONFPATH=${sysconfdir}/openhpi
-AC_SUBST(CONFPATH)
-
-dnl create the #define in config.h
-AC_DEFINE_UNQUOTED(CONFPATH, "$CONFPATH",
-                   [openhpi specific config path])
-AC_DEFINE_UNQUOTED(OH_DEFAULT_CONF,"$CONFPATH/${PACKAGE_NAME}.conf",
-                   [default configfile])
-AC_DEFINE_UNQUOTED(OH_CLIENT_DEFAULT_CONF,"$CONFPATH/${HPI_CLIENT_PKG}.conf",
-                   [default client configfile])
-
-
-
-dnl defines OH_DEFAULT_UID_MAP and VARPATH
-dnl set VARPATH only if unset or null.
-VARPATH=${VARPATH:=${localstatedir}/lib/${PACKAGE_NAME}}
-
-AC_ARG_WITH(varpath,
-    [[  --with-varpath=PATH     use directory PATH to store openhpi specific data [default=$prefix/var/lib/openhpi]]],
-    [VARPATH=$withval])
-dnl substitute @VARPATH@ in all Makefiles
-AC_SUBST(VARPATH)
-dnl create the #define VARPATH and #define OH_DEFAULT_UID_MAP in config.h
-AC_DEFINE_UNQUOTED(VARPATH,"$VARPATH",[openhpi specific data path])
-AC_DEFINE_UNQUOTED(OH_DEFAULT_UID_MAP,"$VARPATH/uid_map",[uid map])
-
-
-dnl OH_PLUGIN_PATH - Directory where plugin libraries live.
-dnl default is "$libdir/openhpir"
-PLUGINPATH=${PLUGINPATH:=${libdir}/${PACKAGE_NAME}}
-AC_ARG_WITH(pluginpath,
-                [[  --with-pluginpath=PATH     use directory PATH to locate plugin libraries [default=LIBDIR/openhpi]]],
-                    [PLUGINPATH=$withval])
-dnl create #define OH_PLUGIN_PATH in config.h
-AC_DEFINE_UNQUOTED(OH_PLUGIN_PATH,"$PLUGINPATH",[openhpi plugin path])
-
-TEST_CLEAN='$(shell ls *.bb* *.da *.gcov *.gcno *.beam *.gcda *.summary)'
-AC_SUBST(TEST_CLEAN)
-
-AC_C_STRINGIZE
-
-dnl getting CFLAGS right takes some effort
-dnl we start with a good base set that has been built up
-CFLAGS="$CFLAGS $GLIB_CFLAGS"
-
-dnl next we have to do transformations to either turn on
-dnl test coverage support.
-
-AC_ARG_ENABLE([testcover],
-    [  --enable-testcover      adds test coverage and profiling support [[default=no]]],
-    [if test "x$enableval" = "xyes"; then
-            CFLAGS=`echo $CFLAGS | sed -e 's/-O\w\?\>[ ]*//g'`
-            CFLAGS="$CFLAGS -ftest-coverage -fprofile-arcs"
-            CXXFLAGS=`echo $CXXFLAGS | sed -e 's/-O\w\?\>[ ]*//g'`
-            CXXFLAGS="$CXXFLAGS -ftest-coverage -fprofile-arcs"
-    fi]
-    )
-
-dnl This makes libopenhpi debugger friendly
-dnl by eliminating optimizations and adding the -g flag
-
-AC_ARG_ENABLE([debuggable],
-    [  --enable-debuggable     adds -g flag and turns off optimization [[default=no]]],
-    [if test "x$enableval" = "xyes"; then
-            CFLAGS=`echo $CFLAGS | sed -e 's/-O\w\?\>[ ]*//g'`
-            CFLAGS=`echo $CFLAGS | sed -e 's/^-g\w*[ ]*\| -g\w*//g'`
-            CFLAGS="$CFLAGS -O0 -ggdb3"
-            CXXFLAGS=`echo $CXXFLAGS | sed -e 's/-O\w\?\>[ ]*//g'`
-            CXXFLAGS=`echo $CXXFLAGS | sed -e 's/^-g\w*[ ]*\| -g\w*//g'`
-            CXXFLAGS="$CXXFLAGS -O0 -ggdb3"
-    else
-            CFLAGS=`echo $CFLAGS | sed -e 's/^-g\w*[ ]*\| -g\w*//g'`
-            CXXFLAGS=`echo $CXXFLAGS | sed -e 's/^-g\w*[ ]*\| -g\w*//g'`
-    fi]
-    )
-
-dnl This will let the user decide whether he wants
-dnl to use dbg/trace messages.
-
-AC_ARG_ENABLE([debug-msgs],
-    [  --enable-debug-msgs     enables dynamic debug messages [[default=yes]]],
-    [if test "x$enableval" = "xyes"; then
-            AC_DEFINE([OH_DBG_MSGS],[1],[Enables dynamic debug messages])
-    fi],
-    [AC_DEFINE([OH_DBG_MSGS],[1],[Enables dynamic debug messages])]
-    )
-
-dnl Now we throw in a bunch of warnings.  C and C++ need
-dnl different sets here
-
-CC_WARNINGS="\
-        -Wall \
-        -Wmissing-prototypes \
-        -Wmissing-declarations \
-        -Wstrict-prototypes \
-        -Wpointer-arith \
-        -Wformat=2 \
-        -Wformat-security \
-        -Wformat-nonliteral \
-        -Wno-format-y2k \
-        -Wcast-qual \
-        -Wcast-align \
-        -Wno-strict-aliasing \
-	-fno-strict-aliasing \
-        -Wno-unused-value "
-
-CXX_WARNINGS="\
-        -Wall \
-        -Wpointer-arith \
-        -Wformat=2 \
-        -Wformat-security \
-        -Wformat-nonliteral \
-        -Wcast-qual \
-        -Wcast-align \
-        -Wshadow \
-        -Wwrite-strings \
-        -Wredundant-decls \
-        -Wno-strict-aliasing \
-	-fno-strict-aliasing \
-        -Wno-unused-value "
-
-if test -n "`gcc --version | grep ' 3.2'`" ; then
-        CC_WARNINGS=`echo $CC_WARNINGS | sed -e 's/-Wno-strict-aliasing//g'`
-        CXX_WARNINGS=`echo $CC_WARNINGS | sed -e 's/-Wno-strict-aliasing//g'`
-fi
-
-case $host_os in
-    solaris*)
-        CC_WARNINGS=`echo $CC_WARNINGS | sed -e 's/-Wcast-qual//g'`
-        CXX_WARNINGS=`echo $CXX_WARNINGS | sed -e 's/-Wwrite-strings//g'`
-        ;;
-esac
-
-dnl remerge the warnings into the FLAGS
-CXXFLAGS="$CFLAGS $CXX_WARNINGS"
-CFLAGS="$CFLAGS $CC_WARNINGS"
-
-dnl lastly, we add things if we are thread safe and have the openssl library
-dnl (this could probably happen earlier in this file)
-CFLAGS="$CFLAGS -D_GNU_SOURCE -D_REENTRANT -fexceptions"
-CXXFLAGS="$CXXFLAGS -D_GNU_SOURCE -D_REENTRANT -fexceptions"
-if test "x$have_openssl" = "xyes"; then
-	SSLDIR=ssl
-	AC_DEFINE([HAVE_OPENSSL],[1],[openssl library was found])
-fi
-AM_CONDITIONAL(HAVE_OPENSSL, test x$have_openssl = xyes)
-OH_SSL_INCLUDES="-I\$(top_srcdir)/ssl"
-AC_SUBST(OH_SSL_INCLUDES)
-
-OPENHPI_INCLUDES="-I\$(top_srcdir)/include -I\$(top_srcdir)/utils -I\$(top_builddir)/utils"
-dnl replace common includes here
-AC_SUBST(OPENHPI_INCLUDES)
-
-dnl Set up libs that will be linked to
-LIBS="$LIBS $SSL_LIB $GLIB_LIBS -lm -lpthread"
-
-AC_CHECK_PROG([found_docbook2html], [docbook2html], [yes])
-AC_ARG_ENABLE([docs],
-    [  --enable-docs            generate documentation [[default=yes if docbook2html exists]]],
-    [if test "x$enableval" = "xyes"; then
-        if test "x$found_docbook2html" = "xyes"; then
-            AC_SUBST(HLD,hld)
-            AC_SUBST(WITH_DOCBOOK2HTML,1)
-        else
-           OH_CHECK_FAIL(docbook2html,docbook-utils,http://sources.redhat.com/docbook-tools, Can not generate HTML design docs without docbook2html)
-	fi
-    else
-        AC_SUBST(HLD,"")
-        AC_SUBST(WITH_DOCBOOK2HTML,0)
-    fi],
-    [if test "x$found_docbook2html" = "xyes"; then
-        AC_SUBST(HLD,hld)
-        AC_SUBST(WITH_DOCBOOK2HTML,1)
-    else
-        AC_SUBST(HLD,"")
-        AC_SUBST(WITH_DOCBOOK2HTML,0)
-    fi])
-
-AC_CHECK_PROG([found_pod2man], [pod2man], [yes])
-AC_ARG_ENABLE([man],
-    [  --enable-man            generate man pages [[default=yes if pod2man exists]]],
-    [if test "x$enableval" = "xyes"; then
-        if test "x$found_pod2man" = "xyes"; then
-            AC_SUBST(MAN,man)
-        else
-            OH_CHECK_FAIL(pod2man,perl,http://www.perl.org,
-                          Can not generate man pages without pod2man)
-        fi
-    else
-        AC_SUBST(MAN,"")
-    fi],
-    [if test "x$found_pod2man" = "xyes"; then
-        AC_SUBST(MAN,man)
-    else
-        AC_SUBST(MAN,"")
-    fi])
-
-AC_CONFIG_FILES([openhpi.spec
-        openhpi.pc
-        rt-env.sh
-        Makefile
-        utils/openhpiutils.pc
-        utils/Makefile
-        utils/t/Makefile
-        utils/t/epath/Makefile
-        utils/t/rpt/Makefile
-        utils/t/sahpi/Makefile
-        utils/t/el/Makefile
-        utils/t/uid/Makefile
-        utils/t/ann/Makefile
-        marshal/Makefile
-        marshal/t/Makefile
-        plugins/Makefile
-        plugins/watchdog/Makefile
-        plugins/ipmi/Makefile
-        plugins/ipmi/t/Makefile
-        plugins/snmp_bc/Makefile
-        plugins/snmp_bc/t/Makefile
-        plugins/sysfs/Makefile
-        plugins/ipmidirect/Makefile
-        plugins/ipmidirect/t/Makefile
-        plugins/simulator/Makefile
-        plugins/simulator/t/Makefile
-        plugins/rtas/Makefile
-        plugins/ilo2_ribcl/Makefile
-        plugins/oa_soap/Makefile
-        scripts/Makefile
-        scripts/test/Makefile
-        snmp/Makefile
-	ssl/Makefile
-        src/Makefile
-        src/plugin_static.c
-        src/t/Makefile
-        src/t/ohpi/Makefile
-        docs/Makefile
-        docs/hld/Makefile
-        docs/man/Makefile
-        openhpid/Makefile
-        openhpid/openhpid.sh
-        hpi_shell/Makefile
-        cpp/Makefile
-        cpp/t/Makefile
-        clients/Makefile])
-
-AC_OUTPUT
Index: ltp/testcases/open_hpi_testsuite/configure.ac.in
===================================================================
--- /dev/null
+++ ltp/testcases/open_hpi_testsuite/configure.ac.in
@@ -0,0 +1,709 @@
+dnl
+dnl autoconf and automake for openhpi
+dnl     initial file by Andrea Brugger <andrea.l.brugger@intel.com> 1/03
+dnl   various hacks by Sean Dague <http://dague.net/sean> 4/23/03
+
+
+AC_PREREQ(2.57)
+AC_INIT(openhpi, 2.14.0)
+AC_CONFIG_SRCDIR(openhpi.spec.in)
+AM_INIT_AUTOMAKE([1.8])
+
+AM_CONFIG_HEADER(config.h)
+AH_TOP([#ifndef __OPENHPI_CONFIG_H
+#define __OPENHPI_CONFIG_H])
+AH_BOTTOM([#endif /* __OPENHPI_CONFIG_H */])
+
+#
+# (major version) = (first number) - (third number)
+# (minor version) = (third number)
+# (patch version) = (second number)
+# example HPI_LIB_VERSION=13:4:11
+# major version: 2  = 13 - 11
+# minor version: 11 = 11
+# patch version: 4  = 4
+#
+HPI_LIB_VERSION=16:0:14
+HPI_PKG=$PACKAGE_NAME
+HPI_UTIL_PKG=${PACKAGE_NAME}utils
+HPI_CLIENT_PKG=${PACKAGE_NAME}client
+AC_SUBST(HPI_CLIENT_PKG)
+AC_SUBST(HPI_UTIL_PKG)
+AC_SUBST(HPI_PKG)
+AC_SUBST(HPI_LIB_VERSION)
+AC_SUBST(ac_configure_args)
+
+dnl Checks for programs
+AC_PROG_CC
+AC_LIBTOOL_DLOPEN
+AC_PROG_LIBTOOL
+AC_PROG_LN_S
+AC_PROG_CXX
+AC_PROG_CPP
+AC_PROG_INSTALL
+AC_PROG_LN_S
+AC_PROG_MAKE_SET
+
+dnl die on int != 32bits.  This is too instrumental to our code right now.
+dnl AC_MSG_CHECKING(int is 4 bytes)
+OH_SET_SIZES
+if test "x$OH_SIZEOF_INT" != "x4"; then
+    AC_MSG_ERROR([
+*** int is not 4 bytes, it is $OH_SIZEOF_INT bytes on this platform
+*** undefined behavior will result
+*** please contact the openhpi development team to fix this
+])
+fi
+
+AM_CONDITIONAL(CROSS_COMPILATION, test x$cross_compiling = xyes)
+
+dnl Check for libraries
+have_uuid=no
+have_openipmi=no
+have_fam=no
+have_sysfs=no
+have_rtas_lib=no
+
+dnl Check for GLIB
+
+AC_CHECK_PROG([found_pkg_config],[pkg-config],[yes])
+
+if test "x$found_pkg_config" != "xyes"; then
+    OH_CHECK_FAIL(pkg-config,pkg-config)
+fi
+PKG_CFG_SETPATH
+
+# check for gcc version
+
+AC_MSG_CHECKING(gcc >= 3.2.0)
+OH_CHECK_GCC(3,2,0)
+
+dnl glib 2.x checks
+GLIB_REQUIRED_VERSION=2.2.0
+GLIB=glib-2.0
+
+if pkg-config --atleast-version $GLIB_REQUIRED_VERSION $GLIB; then
+   :
+else
+   AC_MSG_ERROR([
+*** GLIB >= $GLIB_REQUIRED_VERSION is required. The latest version of
+*** GLIB is always available from ftp://ftp.gtk.org/.])
+fi
+
+exact_version=`pkg-config --modversion $GLIB`;
+GLIB_CFLAGS=`pkg-config --cflags $GLIB gthread-2.0`
+GLIB_LIBS=`pkg-config --libs $GLIB gthread-2.0`
+
+AC_MSG_CHECKING(for GLIB - version >= $GLIB_REQUIRED_VERSION)
+AC_MSG_RESULT(yes (version $exact_version))
+
+dnl if the glib is installed on a non standard place
+dnl like /opt/gnome/lib AC_CHECK_LIB will find the library.
+old_cflags=$CFLAGS
+old_libs=$LIBS
+
+CFLAGS="$CFLAGS $GLIB_CFLAGS"
+LIBS="$LIBS $GLIB_LIBS"
+
+AC_CHECK_LIB([$GLIB], [g_slist_alloc], [],
+[
+OH_CHECK_FAIL(glib,glib-devel)
+])
+
+CFLAGS=$old_cflags
+LIBS=$old_libs
+
+
+AC_CHECK_LIB([ltdl], [lt_dlopen], [], [
+    OH_CHECK_FAIL(libltdl,libltdl-devel,,
+        this is required for plugin loading)
+    ])
+
+AC_CHECK_LIB([sysfs], [sysfs_get_mnt_path], [have_sysfs=yes])
+AC_CHECK_HEADER([sysfs/libsysfs.h], [], [have_sysfs=no])
+
+OH_CHECK_NETSNMP
+
+AC_CHECK_LIB([uuid], [uuid_generate], [have_uuid=yes], [
+    OH_CHECK_FAIL(libuuid,e2fsprogs-devel)
+    ])
+
+dnl ssl is used for md2/md5 authentification in ipmidirect
+dnl and for SSL-based communication in ilo2_ribcl and oa_soap
+AC_CHECK_LIB([crypto],[MD5_Init],[CRYPTO_LIB=-lcrypto],[CRYPTO_LIB=])
+AC_SUBST(CRYPTO_LIB)
+AC_CHECK_LIB([ssl],[SSL_library_init],[SSL_LIB=-lssl],[SSL_LIB=])
+AC_SUBST(SSL_LIB)
+AC_CHECK_HEADERS([openssl/md2.h openssl/md5.h openssl/bio.h openssl/ssl.h openssl/err.h],[have_openssl=yes],[have_openssl=no])
+
+dnl xml is used for XML-based communication in ilo2_ribcl and oa_soap
+AC_CHECK_LIB([xml2],[xmlParseMemory],[XML2_LIB=-lxml2],[XML2_LIB=])
+AC_CHECK_HEADERS([libxml2/libxml/xmlexports.h],[XML2_INCLUDE="-I/usr/include/libxml2"],[XML2_INCLUDE])
+AC_SUBST(XML2_LIB)
+AC_SUBST(XML2_INCLUDE)
+
+dnl Build daemon statically or dynamically.
+openhpid_static="no"
+
+ENABLED_DIRS="$ENABLED_DIRS openhpid"
+AC_ARG_ENABLE([daemon],
+	[  --enable-dynamic-daemon   build HPI daemon and client library non-statically[[default=yes]]],
+        [if test "x$enableval" = "xno"; then
+        openhpid_static="yes"
+    fi],
+    [openhpid_static="no"])
+
+AM_CONDITIONAL(OPENHPID_STATIC, test x$openhpid_static = xyes)
+
+
+AC_ARG_ENABLE([clients],
+    [  --enable-clients        build HPI client programs [[default=yes]]],
+    [if test "x$enableval" = "xyes"; then
+        ENABLED_DIRS="$ENABLED_DIRS clients"
+    fi],
+    [ENABLED_DIRS="$ENABLED_DIRS clients"])
+
+AC_ARG_ENABLE([cpp_wrappers],
+    [  --enable-cpp_wrappers   build SaHpi C++ wrapper objects [[default=no]]],
+    [if test "x$enableval" = "xyes"; then
+        ENABLED_DIRS="$ENABLED_DIRS cpp"
+    fi])
+
+AC_SUBST(ENABLED_DIRS)
+
+dnl Checks for header files.
+AC_HEADER_STDC
+AC_CHECK_HEADERS([fcntl.h stdlib.h string.h sys/time.h unistd.h stdarg.h netinet/in.h])
+
+dnl Checks for library functions.
+AC_FUNC_ERROR_AT_LINE
+AC_FUNC_VPRINTF
+AC_CHECK_FUNCS([gettimeofday memset strdup])
+
+dnl Checks for other helper programs
+
+AC_PATH_PROGS(RPM, rpmbuild)
+
+dnl plugin enablement stanzas
+
+dnl list of static plugins
+STATIC_PLUGIN_LIST=
+STATIC_PLUGIN_EXTRA_LIBS=
+
+AC_CHECK_HEADER([linux/watchdog.h], [have_linux_watchdog_h=yes], [], [#include <linux/types.h>])
+AC_ARG_ENABLE([watchdog],
+    [  --enable-watchdog       build watchdog plugin [[default=yes if linux/watchdog.h exists]]],
+    [if test "x$enableval" = "xyes"; then
+        if test "x$have_linux_watchdog_h" = "xyes"; then
+            AC_SUBST(WATCHDOG,watchdog)
+        else
+            AC_MSG_ERROR("Can not build the watchdog plugin without linux/watchdog.h.")
+        fi
+    else
+        AC_SUBST(WATCHDOG,"")
+    fi],
+    [if test "x$have_linux_watchdog_h" = "xyes"; then
+        AC_SUBST(WATCHDOG,watchdog)
+    else
+        AC_SUBST(WATCHDOG,"")
+    fi])
+
+dnl
+dnl We really need to make ipmi enablement be contigent on OpenIPMI
+dnl
+
+if PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig pkg-config --atleast-version 1.4.20 OpenIPMI; then
+    have_openipmi=yes
+    AC_CHECK_LIB([OpenIPMI], [ipmi_smi_setup_con], [have_openipmi=yes])
+    OPENIPMI_CFLAGS=`PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig pkg-config --cflags OpenIPMI`
+    AC_SUBST(OPENIPMI_CFLAGS)
+    OPENIPMI_LIBS=`PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig pkg-config --libs OpenIPMI`
+    AC_SUBST(OPENIPMI_LIBS)
+fi
+
+AC_ARG_ENABLE([ipmi],
+    [  --enable-ipmi           build openipmi plugin [[default=yes if OpenIPMI exists]]],
+    [if test "x$enableval" = "xyes"; then
+        if test "x$have_openipmi" = "xyes"; then
+            AC_SUBST(IPMI,ipmi)
+	    AC_SUBST(WITH_IPMI,1)
+        else
+            OH_CHECK_FAIL(OpenIPMI,libOpenIPMI-devel,http://openipmi.sf.net,
+                         Can not build IPMI support without OpenIPMI >= 1.4.20)
+        fi
+    elif test "x$enableval" = "xstatic"; then
+        if test "x$have_openipmi" = "xyes"; then
+            AC_SUBST(IPMI,ipmi)
+	    AC_SUBST(WITH_IPMI,1)
+            STATIC_PLUGIN_LIST="$STATIC_PLUGIN_LIST ipmi"
+            STATIC_PLUGIN_EXTRA_LIBS="$STATIC_PLUGIN_EXTRA_LIBS"
+        else
+            OH_CHECK_FAIL(OpenIPMI,libOpenIPMI-devel,http://openipmi.sf.net,
+                         Can not build IPMI support without OpenIPMI >= 1.4.20)
+        fi
+    else
+	    AC_SUBST(WITH_IPMI,0)
+    fi],
+    [if test "x$have_openipmi" = "xyes"; then
+            AC_SUBST(IPMI,ipmi)
+	    AC_SUBST(WITH_IPMI,1)
+     else
+	    AC_SUBST(WITH_IPMI,0)
+     fi
+    ])
+
+AC_ARG_ENABLE([sysfs],
+    [  --enable-sysfs          build sysfs plugin [[default=yes if libsysfs exists]]],
+    [if test "x$enableval" = "xyes"; then
+        if test "x$have_sysfs" = "xyes"; then
+            AC_SUBST(SYSFS,sysfs)
+	    AC_SUBST(WITH_SYSFS,1)
+        else
+            OH_CHECK_FAIL(libsysfs,,http://linux-diag.sf.net,
+                Can not build sysfs support without libsysfs)
+        fi
+    else
+	    AC_SUBST(WITH_SYSFS,0)
+    fi],
+    [if test "x$have_sysfs" = "xyes"; then
+            AC_SUBST(SYSFS,sysfs)
+	    AC_SUBST(WITH_SYSFS,1)
+     else
+	    AC_SUBST(WITH_SYSFS,0)
+     fi
+    ])
+
+AC_ARG_ENABLE([snmp_bc],
+    [  --enable-snmp_bc        build IBM Blade Center plugin [[default=yes if net-snmp is installed]]],
+    [if test "x$enableval" = "xyes"; then
+        if test "x$have_netsnmp" = "xyes"; then
+            AC_SUBST(SNMP_BC,snmp_bc)
+	    AC_SUBST(WITH_SNMP_BC,1)
+            SNMPDIR=snmp
+        else
+            OH_CHECK_FAIL(net-snmp,net-snmp-devel,http://net-snmp.sourceforge.net/,
+                Can not build IBM Blade Center support without net-snmp)
+        fi
+    else
+	    AC_SUBST(WITH_SNMP_BC,0)
+    fi],
+    [if test "x$have_netsnmp" = "xyes"; then
+            AC_SUBST(SNMP_BC,snmp_bc)
+	    AC_SUBST(WITH_SNMP_BC,1)
+            SNMPDIR=snmp
+    else
+	    AC_SUBST(WITH_SNMP_BC,0)
+    fi]
+    )
+
+AC_ARG_ENABLE([ipmidirect],
+    [  --enable-ipmidirect     build direct ipmi plugin [[default=yes]]],
+    [if test "x$enableval" = "xyes"; then
+            AC_SUBST(IPMIDIRECT,ipmidirect)
+     elif test "x$enableval" = "xstatic"; then
+            AC_SUBST(IPMIDIRECT,ipmidirect)
+            STATIC_PLUGIN_LIST="$STATIC_PLUGIN_LIST ipmidirect"
+            STATIC_PLUGIN_EXTRA_LIBS="$STATIC_PLUGIN_EXTRA_LIBS $SSL_LIB -luuid -lm -lstdc++"
+     fi],
+    [AC_SUBST(IPMIDIRECT,ipmidirect)])
+
+dnl    [AC_SUBST(IPMIDIRECT,ipmidirect)])
+
+OH_CHECK_RTAS
+
+#Configure options for the RTAS plugin
+AC_ARG_ENABLE([rtas],
+    [  --enable-rtas           build rtas ppc plugin [[default=no]]],
+    [if test "x$enableval" = "xyes"; then
+        if test "x$have_rtas_lib" = "xyes"; then
+            AC_SUBST(RTAS,rtas)
+	    AC_SUBST(WITH_RTAS,1)
+        else
+            OH_CHECK_FAIL(librtas, librtas-devel, http://librtas.ozlabs.org/,
+                Cannot build RTAS plugin without the librtas library)
+        fi
+    else
+	    AC_SUBST(WITH_RTAS,0)
+    fi],
+    [AC_SUBST(WITH_RTAS,0)])
+
+# configure argument for the simulator plugin
+AC_ARG_ENABLE([simulator],
+    [  --enable-simulator      build simulator plugin [[default=yes]]],
+    [if test "x$enableval" = "xyes"; then
+        AC_SUBST(SIMULATOR,simulator)
+    fi],
+    [AC_SUBST(SIMULATOR,simulator)])
+
+# configure argument for the ilo2_ribcl plugin
+AC_ARG_ENABLE([ilo2_ribcl],
+    [  --enable-ilo2_ribcl     build ilo2_ribcl plugin [[default=no]]],
+    [if test "x$enableval" = "xyes"; then
+        if test "x$have_openssl" = "xyes"; then
+            if test -n "$XML2_INCLUDE"; then
+                AC_SUBST(ILO2_RIBCL,ilo2_ribcl)
+                AC_SUBST(WITH_ILO2_RIBCL,1)
+            else
+                OH_CHECK_FAIL(xml2-devel,,,Can not build ilo2_ribcl without xml2 headers)
+            fi
+        else
+            OH_CHECK_FAIL(openssl-devel,,,Can not build ilo2_ribcl without openssl headers)
+        fi
+    else
+        AC_SUBST(WITH_ILO2_RIBCL,0)
+    fi],
+    [if test "x$have_openssl" = "xyes" && test -n "$XML2_INCLUDE"; then
+        AC_SUBST(ILO2_RIBCL,ilo2_ribcl)
+        AC_SUBST(WITH_ILO2_RIBCL,1)
+     else
+        AC_SUBST(WITH_ILO2_RIBCL,0)
+     fi
+    ])
+
+# configure argument for the oa_soap plugin
+AC_ARG_ENABLE([oa_soap],
+    [  --enable-oa_soap        build oa_soap plugin [[default=no]]],
+    [if test "x$enableval" = "xyes"; then
+        if test "x$have_openssl" = "xyes"; then
+	    if test -n "$XML2_INCLUDE"; then
+                AC_SUBST(OA_SOAP,oa_soap)
+                AC_SUBST(WITH_OA_SOAP,1)
+	    else
+	    	OH_CHECK_FAIL(xml2-devel,,,Can not build oa_soap without xml2 headers)
+	    fi
+	else
+	    OH_CHECK_FAIL(openssl-devel,,,Can not build oa_soap without openssl headers)
+	fi
+    else
+        AC_SUBST(WITH_OA_SOAP,0)
+    fi],
+    [if test "x$have_openssl" = "xyes" && test -n "$XML2_INCLUDE"; then
+        AC_SUBST(OA_SOAP,oa_soap)
+        AC_SUBST(WITH_OA_SOAP,1)
+     else
+        AC_SUBST(WITH_OA_SOAP,0)
+     fi
+    ])
+
+dnl enable marshal library
+AC_SUBST(MARSHALDIR,marshal)
+
+dnl
+dnl create static plugin config
+dnl
+
+STATIC_PLUGIN=
+STATIC_PLUGIN_EXTERN=
+STATIC_PLUGIN_LIBS=
+
+for name in $STATIC_PLUGIN_LIST; do
+        STATIC_PLUGIN="$STATIC_PLUGIN { \"$name\", ${name}_get_interface },";
+        STATIC_PLUGIN_EXTERN="${STATIC_PLUGIN_EXTERN} extern int ${name}_get_interface(void **pp, const uuid_t uuid);";
+        STATIC_PLUGIN_LIBS="$STATIC_PLUGIN_LIBS \$(top_builddir)/plugins/$name/lib${name}.la";
+done
+
+dnl use src/plugin_static.c.in
+AC_SUBST(STATIC_PLUGIN_EXTERN)
+AC_SUBST(STATIC_PLUGIN)
+
+dnl additional libs
+AC_SUBST(STATIC_PLUGIN_LIBS)
+AC_SUBST(STATIC_PLUGIN_EXTRA_LIBS)
+
+dnl setup SNMPFLAGS
+AC_SUBST(SNMPFLAGS)
+AC_SUBST(SNMPLIBS)
+AC_SUBST(SNMPDIR)
+AC_SUBST(SSLDIR)
+
+dnl
+dnl This code was borrowed from linux-ha configure.in file
+dnl and is used for creating the proper substitutions
+dnl in the spec file. Without it, the spec file will
+dnl have ${exec_prefix}, etc. instead of the actual
+dnl directory.
+dnl
+dnl
+
+prefix=`eval echo "$prefix"`
+
+case $prefix in
+  NONE) prefix=/usr/local;;
+esac
+var() {
+  case $1 in
+    *'${'*)     res=`eval echo "$1"`;;
+    *)          res="$1";;
+  esac
+  case "$res" in
+    ""|NONE)    echo "$2";;
+    *)          echo "$res";;
+  esac
+}
+
+exec_prefix=`var "$exec_prefix" "$prefix"`
+bindir=`var "$bindir" "$exec_prefix/bin"`
+sbindir=`var "$sbindir" "$exec_prefix/sbin"`
+sysconfdir=`var "$sysconfdir" "$prefix/etc"`
+libdir=`var "$libdir" "$exec_prefix/lib"`
+includedir=`var "$includedir" "$exec_prefix/include"`
+localstatedir=`var "$localstatedir" "/var"`
+base_includedir="${includedir}"
+AC_SUBST(base_includedir)
+
+dnl
+dnl defines CONFPATH, OH_DEFAULT_CONF and OH_CLIENT_DEFAULT_CONF
+dnl
+
+#CONFPATH=${CONFPATH:=/etc/${PACKAGE_NAME}}
+
+#AC_ARG_WITH(confpath,
+#   [[  --with-confpath=PATH    use directory PATH to store openhpi configuration file [default=/etc/openhpi]]],
+#   [CONFPATH=$withval])
+
+dnl substitute @CONFPATH@ in all Makefiles
+CONFPATH=${sysconfdir}/openhpi
+AC_SUBST(CONFPATH)
+
+dnl create the #define in config.h
+AC_DEFINE_UNQUOTED(CONFPATH, "$CONFPATH",
+                   [openhpi specific config path])
+AC_DEFINE_UNQUOTED(OH_DEFAULT_CONF,"$CONFPATH/${PACKAGE_NAME}.conf",
+                   [default configfile])
+AC_DEFINE_UNQUOTED(OH_CLIENT_DEFAULT_CONF,"$CONFPATH/${HPI_CLIENT_PKG}.conf",
+                   [default client configfile])
+
+
+
+dnl defines OH_DEFAULT_UID_MAP and VARPATH
+dnl set VARPATH only if unset or null.
+VARPATH=${VARPATH:=${localstatedir}/lib/${PACKAGE_NAME}}
+
+AC_ARG_WITH(varpath,
+    [[  --with-varpath=PATH     use directory PATH to store openhpi specific data [default=$prefix/var/lib/openhpi]]],
+    [VARPATH=$withval])
+dnl substitute @VARPATH@ in all Makefiles
+AC_SUBST(VARPATH)
+dnl create the #define VARPATH and #define OH_DEFAULT_UID_MAP in config.h
+AC_DEFINE_UNQUOTED(VARPATH,"$VARPATH",[openhpi specific data path])
+AC_DEFINE_UNQUOTED(OH_DEFAULT_UID_MAP,"$VARPATH/uid_map",[uid map])
+
+
+dnl OH_PLUGIN_PATH - Directory where plugin libraries live.
+dnl default is "$libdir/openhpir"
+PLUGINPATH=${PLUGINPATH:=${libdir}/${PACKAGE_NAME}}
+AC_ARG_WITH(pluginpath,
+                [[  --with-pluginpath=PATH     use directory PATH to locate plugin libraries [default=LIBDIR/openhpi]]],
+                    [PLUGINPATH=$withval])
+dnl create #define OH_PLUGIN_PATH in config.h
+AC_DEFINE_UNQUOTED(OH_PLUGIN_PATH,"$PLUGINPATH",[openhpi plugin path])
+
+TEST_CLEAN='$(shell ls *.bb* *.da *.gcov *.gcno *.beam *.gcda *.summary)'
+AC_SUBST(TEST_CLEAN)
+
+AC_C_STRINGIZE
+
+dnl getting CFLAGS right takes some effort
+dnl we start with a good base set that has been built up
+CFLAGS="$CFLAGS $GLIB_CFLAGS"
+
+dnl next we have to do transformations to either turn on
+dnl test coverage support.
+
+AC_ARG_ENABLE([testcover],
+    [  --enable-testcover      adds test coverage and profiling support [[default=no]]],
+    [if test "x$enableval" = "xyes"; then
+            CFLAGS=`echo $CFLAGS | sed -e 's/-O\w\?\>[ ]*//g'`
+            CFLAGS="$CFLAGS -ftest-coverage -fprofile-arcs"
+            CXXFLAGS=`echo $CXXFLAGS | sed -e 's/-O\w\?\>[ ]*//g'`
+            CXXFLAGS="$CXXFLAGS -ftest-coverage -fprofile-arcs"
+    fi]
+    )
+
+dnl This makes libopenhpi debugger friendly
+dnl by eliminating optimizations and adding the -g flag
+
+AC_ARG_ENABLE([debuggable],
+    [  --enable-debuggable     adds -g flag and turns off optimization [[default=no]]],
+    [if test "x$enableval" = "xyes"; then
+            CFLAGS=`echo $CFLAGS | sed -e 's/-O\w\?\>[ ]*//g'`
+            CFLAGS=`echo $CFLAGS | sed -e 's/^-g\w*[ ]*\| -g\w*//g'`
+            CFLAGS="$CFLAGS -O0 -ggdb3"
+            CXXFLAGS=`echo $CXXFLAGS | sed -e 's/-O\w\?\>[ ]*//g'`
+            CXXFLAGS=`echo $CXXFLAGS | sed -e 's/^-g\w*[ ]*\| -g\w*//g'`
+            CXXFLAGS="$CXXFLAGS -O0 -ggdb3"
+    else
+            CFLAGS=`echo $CFLAGS | sed -e 's/^-g\w*[ ]*\| -g\w*//g'`
+            CXXFLAGS=`echo $CXXFLAGS | sed -e 's/^-g\w*[ ]*\| -g\w*//g'`
+    fi]
+    )
+
+dnl This will let the user decide whether he wants
+dnl to use dbg/trace messages.
+
+AC_ARG_ENABLE([debug-msgs],
+    [  --enable-debug-msgs     enables dynamic debug messages [[default=yes]]],
+    [if test "x$enableval" = "xyes"; then
+            AC_DEFINE([OH_DBG_MSGS],[1],[Enables dynamic debug messages])
+    fi],
+    [AC_DEFINE([OH_DBG_MSGS],[1],[Enables dynamic debug messages])]
+    )
+
+dnl Now we throw in a bunch of warnings.  C and C++ need
+dnl different sets here
+
+CC_WARNINGS="\
+        -Wall \
+        -Wmissing-prototypes \
+        -Wmissing-declarations \
+        -Wstrict-prototypes \
+        -Wpointer-arith \
+        -Wformat=2 \
+        -Wformat-security \
+        -Wformat-nonliteral \
+        -Wno-format-y2k \
+        -Wcast-qual \
+        -Wcast-align \
+        -Wno-strict-aliasing \
+	-fno-strict-aliasing \
+        -Wno-unused-value "
+
+CXX_WARNINGS="\
+        -Wall \
+        -Wpointer-arith \
+        -Wformat=2 \
+        -Wformat-security \
+        -Wformat-nonliteral \
+        -Wcast-qual \
+        -Wcast-align \
+        -Wshadow \
+        -Wwrite-strings \
+        -Wredundant-decls \
+        -Wno-strict-aliasing \
+	-fno-strict-aliasing \
+        -Wno-unused-value "
+
+if test -n "`gcc --version | grep ' 3.2'`" ; then
+        CC_WARNINGS=`echo $CC_WARNINGS | sed -e 's/-Wno-strict-aliasing//g'`
+        CXX_WARNINGS=`echo $CC_WARNINGS | sed -e 's/-Wno-strict-aliasing//g'`
+fi
+
+case $host_os in
+    solaris*)
+        CC_WARNINGS=`echo $CC_WARNINGS | sed -e 's/-Wcast-qual//g'`
+        CXX_WARNINGS=`echo $CXX_WARNINGS | sed -e 's/-Wwrite-strings//g'`
+        ;;
+esac
+
+dnl remerge the warnings into the FLAGS
+CXXFLAGS="$CFLAGS $CXX_WARNINGS"
+CFLAGS="$CFLAGS $CC_WARNINGS"
+
+dnl lastly, we add things if we are thread safe and have the openssl library
+dnl (this could probably happen earlier in this file)
+CFLAGS="$CFLAGS -D_GNU_SOURCE -D_REENTRANT -fexceptions"
+CXXFLAGS="$CXXFLAGS -D_GNU_SOURCE -D_REENTRANT -fexceptions"
+if test "x$have_openssl" = "xyes"; then
+	SSLDIR=ssl
+	AC_DEFINE([HAVE_OPENSSL],[1],[openssl library was found])
+fi
+AM_CONDITIONAL(HAVE_OPENSSL, test x$have_openssl = xyes)
+OH_SSL_INCLUDES="-I\$(top_srcdir)/ssl"
+AC_SUBST(OH_SSL_INCLUDES)
+
+OPENHPI_INCLUDES="-I\$(top_srcdir)/include -I\$(top_srcdir)/utils -I\$(top_builddir)/utils"
+dnl replace common includes here
+AC_SUBST(OPENHPI_INCLUDES)
+
+dnl Set up libs that will be linked to
+LIBS="$LIBS $SSL_LIB $GLIB_LIBS -lm -lpthread"
+
+AC_CHECK_PROG([found_docbook2html], [docbook2html], [yes])
+AC_ARG_ENABLE([docs],
+    [  --enable-docs            generate documentation [[default=yes if docbook2html exists]]],
+    [if test "x$enableval" = "xyes"; then
+        if test "x$found_docbook2html" = "xyes"; then
+            AC_SUBST(HLD,hld)
+            AC_SUBST(WITH_DOCBOOK2HTML,1)
+        else
+           OH_CHECK_FAIL(docbook2html,docbook-utils,http://sources.redhat.com/docbook-tools, Can not generate HTML design docs without docbook2html)
+	fi
+    else
+        AC_SUBST(HLD,"")
+        AC_SUBST(WITH_DOCBOOK2HTML,0)
+    fi],
+    [if test "x$found_docbook2html" = "xyes"; then
+        AC_SUBST(HLD,hld)
+        AC_SUBST(WITH_DOCBOOK2HTML,1)
+    else
+        AC_SUBST(HLD,"")
+        AC_SUBST(WITH_DOCBOOK2HTML,0)
+    fi])
+
+AC_CHECK_PROG([found_pod2man], [pod2man], [yes])
+AC_ARG_ENABLE([man],
+    [  --enable-man            generate man pages [[default=yes if pod2man exists]]],
+    [if test "x$enableval" = "xyes"; then
+        if test "x$found_pod2man" = "xyes"; then
+            AC_SUBST(MAN,man)
+        else
+            OH_CHECK_FAIL(pod2man,perl,http://www.perl.org,
+                          Can not generate man pages without pod2man)
+        fi
+    else
+        AC_SUBST(MAN,"")
+    fi],
+    [if test "x$found_pod2man" = "xyes"; then
+        AC_SUBST(MAN,man)
+    else
+        AC_SUBST(MAN,"")
+    fi])
+
+AC_CONFIG_FILES([openhpi.spec
+        openhpi.pc
+        rt-env.sh
+        Makefile
+        utils/openhpiutils.pc
+        utils/Makefile
+        utils/t/Makefile
+        utils/t/epath/Makefile
+        utils/t/rpt/Makefile
+        utils/t/sahpi/Makefile
+        utils/t/el/Makefile
+        utils/t/uid/Makefile
+        utils/t/ann/Makefile
+        marshal/Makefile
+        marshal/t/Makefile
+        plugins/Makefile
+        plugins/watchdog/Makefile
+        plugins/ipmi/Makefile
+        plugins/ipmi/t/Makefile
+        plugins/snmp_bc/Makefile
+        plugins/snmp_bc/t/Makefile
+        plugins/sysfs/Makefile
+        plugins/ipmidirect/Makefile
+        plugins/ipmidirect/t/Makefile
+        plugins/simulator/Makefile
+        plugins/simulator/t/Makefile
+        plugins/rtas/Makefile
+        plugins/ilo2_ribcl/Makefile
+        plugins/oa_soap/Makefile
+        scripts/Makefile
+        scripts/test/Makefile
+        snmp/Makefile
+	ssl/Makefile
+        src/Makefile
+        src/plugin_static.c
+        src/t/Makefile
+        src/t/ohpi/Makefile
+        docs/Makefile
+        docs/hld/Makefile
+        docs/man/Makefile
+        openhpid/Makefile
+        openhpid/openhpid.sh
+        hpi_shell/Makefile
+        cpp/Makefile
+        cpp/t/Makefile
+        clients/Makefile])
+
+AC_OUTPUT
Index: ltp/config.mk.in
===================================================================
--- ltp.orig/config.mk.in
+++ ltp/config.mk.in
@@ -9,3 +9,5 @@ LDFLAGS = @LDFLAGS@
 AIO_LIBS = @AIO_LIBS@
 SELINUX_LIBS = @SELINUX_LIBS@
 CRYPTO_LIB = @CRYPTO_LIB@
+
+PREFIX=@prefix@
Index: ltp/doc/man1/Makefile
===================================================================
--- ltp.orig/doc/man1/Makefile
+++ ltp/doc/man1/Makefile
@@ -1,5 +1,4 @@
-
-
+include ./../../config.mk
 PREFIX=/usr
 MANPAGES=ltp-bump.1 doio.1 iogen.1 ltp-pan.1
 
Index: ltp/doc/man3/Makefile
===================================================================
--- ltp.orig/doc/man3/Makefile
+++ ltp/doc/man3/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 
 
 PREFIX=/usr
Index: ltp/m4/Makefile.am
===================================================================
--- ltp.orig/m4/Makefile.am
+++ ltp/m4/Makefile.am
@@ -1 +1,2 @@
+include ./../config.mk
 # bogus makefile to appease automake
Index: ltp/testcases/DOTS/Makefile
===================================================================
--- ltp.orig/testcases/DOTS/Makefile
+++ ltp/testcases/DOTS/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk

 all:

 	cd src;make

 clean:

Index: ltp/testcases/DOTS/src/Makefile
===================================================================
--- ltp.orig/testcases/DOTS/src/Makefile
+++ ltp/testcases/DOTS/src/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk

 JAVAC = javac

 JAR = jar

 

Index: ltp/testcases/DOTS/src/dots/advcase/Makefile
===================================================================
--- ltp.orig/testcases/DOTS/src/dots/advcase/Makefile
+++ ltp/testcases/DOTS/src/dots/advcase/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk

 JAVAC = javac

 

 all:

Index: ltp/testcases/DOTS/src/dots/basecase/Makefile
===================================================================
--- ltp.orig/testcases/DOTS/src/dots/basecase/Makefile
+++ ltp/testcases/DOTS/src/dots/basecase/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk

 JAVAC = javac

 

 all:

Index: ltp/testcases/DOTS/src/dots/framework/Makefile
===================================================================
--- ltp.orig/testcases/DOTS/src/dots/framework/Makefile
+++ ltp/testcases/DOTS/src/dots/framework/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk

 JAVAC = javac

 

 all:

Index: ltp/testcases/DOTS/src/dots/perfmon/Makefile
===================================================================
--- ltp.orig/testcases/DOTS/src/dots/perfmon/Makefile
+++ ltp/testcases/DOTS/src/dots/perfmon/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk

 JAVAC = javac

 

 all:

Index: ltp/testcases/Makefile
===================================================================
--- ltp.orig/testcases/Makefile
+++ ltp/testcases/Makefile
@@ -1,3 +1,4 @@
+include ./../config.mk
 	SUBDIRS = `ls */Makefile | sed "s/Makefile//g" | grep -v open | grep -v pounder | grep -v DOTS | grep -v kdump | grep -v realtime | grep -v audit-test` 
 UCLINUX_SUBDIRS = kernel
 all:
Index: ltp/testcases/ballista/Makefile
===================================================================
--- ltp.orig/testcases/ballista/Makefile
+++ ltp/testcases/ballista/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 ifeq ($(shell perl -v > /dev/null 2>&1 && echo yes),yes)
 
 all: bal
Index: ltp/testcases/ballista/ballista/Makefile
===================================================================
--- ltp.orig/testcases/ballista/ballista/Makefile
+++ ltp/testcases/ballista/ballista/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # MakefileHost.dist: Makefile for Ballista Test Harness
 # Copyright (C) 1998-2001  Carnegie Mellon University
 #
Index: ltp/testcases/ballista/ballista/MakefileHost.dist
===================================================================
--- ltp.orig/testcases/ballista/ballista/MakefileHost.dist
+++ ltp/testcases/ballista/ballista/MakefileHost.dist
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # MakefileHost.dist: Makefile for Ballista Test Harness
 # Copyright (C) 1998-2001  Carnegie Mellon University
 #
Index: ltp/testcases/ballista/ballista/MakefileTarget.dist
===================================================================
--- ltp.orig/testcases/ballista/ballista/MakefileTarget.dist
+++ ltp/testcases/ballista/ballista/MakefileTarget.dist
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # MakefileTarget.dist: Makefile for Ballista Test Execution subsystem  
 # Copyright (C) 1998-2001  Carnegie Mellon University
 #
Index: ltp/testcases/ballista/ballista/compile/Makefile
===================================================================
--- ltp.orig/testcases/ballista/ballista/compile/Makefile
+++ ltp/testcases/ballista/ballista/compile/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile: Makefile for Ballista Datatype Template Compiler
 # Copyright (C) 1998-2001  Carnegie Mellon University
 #
Index: ltp/testcases/ballista/ballista/templates/Makefile
===================================================================
--- ltp.orig/testcases/ballista/ballista/templates/Makefile
+++ ltp/testcases/ballista/ballista/templates/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile: Makefile for Ballista Datatype Templates
 # Copyright (C) 1998-2001  Carnegie Mellon University
 #
Index: ltp/testcases/commands/Makefile
===================================================================
--- ltp.orig/testcases/commands/Makefile
+++ ltp/testcases/commands/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 #SUBDIRS = `ls */Makefile | sed "s/Makefile//g" | grep -v at | grep -v unzip`
 SUBDIRS = `ls */Makefile | sed "s/Makefile//g"`
 
Index: ltp/testcases/commands/ade/Makefile
===================================================================
--- ltp.orig/testcases/commands/ade/Makefile
+++ ltp/testcases/commands/ade/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = ar objdump size ld ldd nm file
 
 all:
Index: ltp/testcases/commands/ade/ar/Makefile
===================================================================
--- ltp.orig/testcases/commands/ade/ar/Makefile
+++ ltp/testcases/commands/ade/ar/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -w -O
 LDFLAGS += 
 
Index: ltp/testcases/commands/ade/file/Makefile
===================================================================
--- ltp.orig/testcases/commands/ade/file/Makefile
+++ ltp/testcases/commands/ade/file/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/ade/ld/Makefile
===================================================================
--- ltp.orig/testcases/commands/ade/ld/Makefile
+++ ltp/testcases/commands/ade/ld/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -O -Wall -fPIC
 LOADLIBES += 
 
Index: ltp/testcases/commands/ade/ldd/Makefile
===================================================================
--- ltp.orig/testcases/commands/ade/ldd/Makefile
+++ ltp/testcases/commands/ade/ldd/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -c -O -fpic
 LDFLAGS += 
 
Index: ltp/testcases/commands/ade/nm/Makefile
===================================================================
--- ltp.orig/testcases/commands/ade/nm/Makefile
+++ ltp/testcases/commands/ade/nm/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -O -Wall
 LOADLIBES += 
 
Index: ltp/testcases/commands/ade/objdump/Makefile
===================================================================
--- ltp.orig/testcases/commands/ade/objdump/Makefile
+++ ltp/testcases/commands/ade/objdump/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -w -o
 LDFLAGS +=
 
Index: ltp/testcases/commands/ade/size/Makefile
===================================================================
--- ltp.orig/testcases/commands/ade/size/Makefile
+++ ltp/testcases/commands/ade/size/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -w -O
 LDFLAGS += 
 
Index: ltp/testcases/commands/at/Makefile
===================================================================
--- ltp.orig/testcases/commands/at/Makefile
+++ ltp/testcases/commands/at/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/cpio/Makefile
===================================================================
--- ltp.orig/testcases/commands/cpio/Makefile
+++ ltp/testcases/commands/cpio/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/cron/Makefile
===================================================================
--- ltp.orig/testcases/commands/cron/Makefile
+++ ltp/testcases/commands/cron/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all: cron_dirs_check
 
 cron_dirs_check:
Index: ltp/testcases/commands/eject/Makefile
===================================================================
--- ltp.orig/testcases/commands/eject/Makefile
+++ ltp/testcases/commands/eject/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 CFLAGS+=    -I../../../include -Wall
 LOADLIBES+= -L../../../lib
 
Index: ltp/testcases/commands/fileutils/Makefile
===================================================================
--- ltp.orig/testcases/commands/fileutils/Makefile
+++ ltp/testcases/commands/fileutils/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = cp mv mkdir ln
 
 all:
Index: ltp/testcases/commands/fileutils/cp/Makefile
===================================================================
--- ltp.orig/testcases/commands/fileutils/cp/Makefile
+++ ltp/testcases/commands/fileutils/cp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/fileutils/ln/Makefile
===================================================================
--- ltp.orig/testcases/commands/fileutils/ln/Makefile
+++ ltp/testcases/commands/fileutils/ln/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/fileutils/mkdir/Makefile
===================================================================
--- ltp.orig/testcases/commands/fileutils/mkdir/Makefile
+++ ltp/testcases/commands/fileutils/mkdir/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/fileutils/mv/Makefile
===================================================================
--- ltp.orig/testcases/commands/fileutils/mv/Makefile
+++ ltp/testcases/commands/fileutils/mv/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/gzip/Makefile
===================================================================
--- ltp.orig/testcases/commands/gzip/Makefile
+++ ltp/testcases/commands/gzip/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/logrotate/Makefile
===================================================================
--- ltp.orig/testcases/commands/logrotate/Makefile
+++ ltp/testcases/commands/logrotate/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/mail/Makefile
===================================================================
--- ltp.orig/testcases/commands/mail/Makefile
+++ ltp/testcases/commands/mail/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/su/Makefile
===================================================================
--- ltp.orig/testcases/commands/su/Makefile
+++ ltp/testcases/commands/su/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tar/Makefile
===================================================================
--- ltp.orig/testcases/commands/tar/Makefile
+++ ltp/testcases/commands/tar/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tpm-tools/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/Makefile
+++ ltp/testcases/commands/tpm-tools/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = tpm tpmtoken
 
 all:
Index: ltp/testcases/commands/tpm-tools/tpm/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpm/Makefile
+++ ltp/testcases/commands/tpm-tools/tpm/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS	= tpm_selftest		\
 	tpm_version		\
 	tpm_getpubek		\
Index: ltp/testcases/commands/tpm-tools/tpm/tpm_changeauth/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpm/tpm_changeauth/Makefile
+++ ltp/testcases/commands/tpm-tools/tpm/tpm_changeauth/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tpm-tools/tpm/tpm_clear/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpm/tpm_clear/Makefile
+++ ltp/testcases/commands/tpm-tools/tpm/tpm_clear/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tpm-tools/tpm/tpm_getpubek/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpm/tpm_getpubek/Makefile
+++ ltp/testcases/commands/tpm-tools/tpm/tpm_getpubek/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/Makefile
+++ ltp/testcases/commands/tpm-tools/tpm/tpm_restrictpubek/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tpm-tools/tpm/tpm_selftest/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpm/tpm_selftest/Makefile
+++ ltp/testcases/commands/tpm-tools/tpm/tpm_selftest/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tpm-tools/tpm/tpm_takeownership/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpm/tpm_takeownership/Makefile
+++ ltp/testcases/commands/tpm-tools/tpm/tpm_takeownership/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tpm-tools/tpm/tpm_version/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpm/tpm_version/Makefile
+++ ltp/testcases/commands/tpm-tools/tpm/tpm_version/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tpm-tools/tpmtoken/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpmtoken/Makefile
+++ ltp/testcases/commands/tpm-tools/tpmtoken/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS	= tpmtoken_init		\
 	tpmtoken_setpasswd	\
 	tpmtoken_import		\
Index: ltp/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/Makefile
+++ ltp/testcases/commands/tpm-tools/tpmtoken/tpmtoken_import/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/Makefile
+++ ltp/testcases/commands/tpm-tools/tpmtoken/tpmtoken_init/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/Makefile
+++ ltp/testcases/commands/tpm-tools/tpmtoken/tpmtoken_objects/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/Makefile
+++ ltp/testcases/commands/tpm-tools/tpmtoken/tpmtoken_protect/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/Makefile
===================================================================
--- ltp.orig/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/Makefile
+++ ltp/testcases/commands/tpm-tools/tpmtoken/tpmtoken_setpasswd/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/commands/unzip/Makefile
===================================================================
--- ltp.orig/testcases/commands/unzip/Makefile
+++ ltp/testcases/commands/unzip/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Only build and install if we have the zip and unzip commands
 HAVE_ZIPTOOLS=$(shell which zip >/dev/null 2>&1\
  && which unzip >/dev/null 2>&1 && echo t)
Index: ltp/testcases/kdump/Makefile
===================================================================
--- ltp.orig/testcases/kdump/Makefile
+++ ltp/testcases/kdump/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 all: runkdump.conf
 	chmod a+x runkdump.sh lib/*.sh
 	./runkdump.sh
Index: ltp/testcases/kdump/lib/Makefile
===================================================================
--- ltp.orig/testcases/kdump/lib/Makefile
+++ ltp/testcases/kdump/lib/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 default:
 	$(MAKE) -C crasher
 	$(MAKE) -C lkdtm
Index: ltp/testcases/kdump/lib/crasher/Makefile
===================================================================
--- ltp.orig/testcases/kdump/lib/crasher/Makefile
+++ ltp/testcases/kdump/lib/crasher/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 obj-m := crasher.o
 KDIR := /lib/modules/$(shell uname -r)/build
 PWD := $(shell pwd)
Index: ltp/testcases/kdump/lib/kprobes/Makefile
===================================================================
--- ltp.orig/testcases/kdump/lib/kprobes/Makefile
+++ ltp/testcases/kdump/lib/kprobes/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #obj-m := lkdtm.o crasher.o
 obj-m := kprobes.o
 KDIR := /lib/modules/$(shell uname -r)/build
Index: ltp/testcases/kdump/lib/lkdtm/Makefile
===================================================================
--- ltp.orig/testcases/kdump/lib/lkdtm/Makefile
+++ ltp/testcases/kdump/lib/lkdtm/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 obj-m := lkdtm.o
 KDIR := /lib/modules/$(shell uname -r)/build
 PWD := $(shell pwd)
Index: ltp/testcases/kernel/Makefile
===================================================================
--- ltp.orig/testcases/kernel/Makefile
+++ ltp/testcases/kernel/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 SUBDIRS = power_management numa containers controllers connectors include fs io ipc mem pty sched security syscalls timers
 UCLINUX_SUBDIRS = include syscalls
 
Index: ltp/testcases/kernel/connectors/Makefile
===================================================================
--- ltp.orig/testcases/kernel/connectors/Makefile
+++ ltp/testcases/kernel/connectors/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = pec
 
 all:
Index: ltp/testcases/kernel/connectors/pec/Makefile
===================================================================
--- ltp.orig/testcases/kernel/connectors/pec/Makefile
+++ ltp/testcases/kernel/connectors/pec/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -I../../../../include -Wall
 LDLIBS += -L../../../../lib -lltp
 
Index: ltp/testcases/kernel/containers/Makefile
===================================================================
--- ltp.orig/testcases/kernel/containers/Makefile
+++ ltp/testcases/kernel/containers/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2007                 ##
Index: ltp/testcases/kernel/containers/libclone/Makefile
===================================================================
--- ltp.orig/testcases/kernel/containers/libclone/Makefile
+++ ltp/testcases/kernel/containers/libclone/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2007                 ##
Index: ltp/testcases/kernel/containers/mqns/Makefile
===================================================================
--- ltp.orig/testcases/kernel/containers/mqns/Makefile
+++ ltp/testcases/kernel/containers/mqns/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2009                 ##
Index: ltp/testcases/kernel/containers/netns/Makefile
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/Makefile
+++ ltp/testcases/kernel/containers/netns/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2008                 ##
Index: ltp/testcases/kernel/containers/pidns/Makefile
===================================================================
--- ltp.orig/testcases/kernel/containers/pidns/Makefile
+++ ltp/testcases/kernel/containers/pidns/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2007                 ##
Index: ltp/testcases/kernel/containers/sysvipc/Makefile
===================================================================
--- ltp.orig/testcases/kernel/containers/sysvipc/Makefile
+++ ltp/testcases/kernel/containers/sysvipc/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2007                 ##
Index: ltp/testcases/kernel/containers/utsname/Makefile
===================================================================
--- ltp.orig/testcases/kernel/containers/utsname/Makefile
+++ ltp/testcases/kernel/containers/utsname/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2007                 ##
Index: ltp/testcases/kernel/controllers/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/Makefile
+++ ltp/testcases/kernel/controllers/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 ifdef $(CROSS_COMPILE)
 CHECK_CGROUP := $(shell test -f $(TARGET_DIR)/usr/include/linux/cgroupstats.h && echo 'cgroup')
 else
Index: ltp/testcases/kernel/controllers/cgroup/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cgroup/Makefile
+++ ltp/testcases/kernel/controllers/cgroup/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall
 CPPFLAGS += -I../../../../include -I../libcontrollers
 LDLIBS += -L../../../../lib/ -lltp
Index: ltp/testcases/kernel/controllers/cpuctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuctl/Makefile
+++ ltp/testcases/kernel/controllers/cpuctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall
 CPPFLAGS += -I../../../../include -I../libcontrollers
 LDLIBS += -lm -L../../../../lib/ -L../libcontrollers -lcontrollers -lltp
Index: ltp/testcases/kernel/controllers/cpuset/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuset/Makefile
+++ ltp/testcases/kernel/controllers/cpuset/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS = cpuset_base_ops_test cpuset_lib cpuset_inherit_test
 SUBDIRS += cpuset_exclusive_test cpuset_hierarchy_test cpuset_syscall_test
 SUBDIRS += cpuset_hotplug_test cpuset_load_balance_test
Index: ltp/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
+++ ltp/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SRCS = $(wildcard *.sh)
 
 all:
Index: ltp/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
+++ ltp/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SRCS = $(wildcard *.sh)
 
 all:
Index: ltp/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
+++ ltp/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SRCS = $(wildcard *.sh)
 
 all:
Index: ltp/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
+++ ltp/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -Wall -g -Wextra
 LDLIBS := -lm
 
Index: ltp/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
+++ ltp/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SRCS = $(wildcard *.sh)
 
 all:
Index: ltp/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
+++ ltp/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -Wall -g -Wextra
 CPPFLAGS += -I../../../../include
 LDLIBS += -lm -L../../../../lib/ -lcontrollers -lltp
Index: ltp/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
+++ ltp/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -Wall -g -Wextra
 LDLIBS := -lm
 
Index: ltp/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile
+++ ltp/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -Wall -g -Wextra
 
 all: cpuset_memory_pressure
Index: ltp/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
+++ ltp/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -Wall -g -Wextra
 
 all: cpuset_mem_hog
Index: ltp/testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile
+++ ltp/testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -Wall -g -Wextra
 
 LIBSRCS=$(wildcard ../cpuset_lib/*.c)
Index: ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
+++ ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SRCS = $(wildcard *.sh)
 
 LIBSRCS=$(wildcard ../cpuset_lib/*.c)
Index: ltp/testcases/kernel/controllers/freezer/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/freezer/Makefile
+++ ltp/testcases/kernel/controllers/freezer/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Copyright (c) International Business Machines  Corp., 2008
 # Author: Matt Helsley <matthltc@us.ibm.com>
 #
Index: ltp/testcases/kernel/controllers/io-throttle/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/io-throttle/Makefile
+++ ltp/testcases/kernel/controllers/io-throttle/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall
 CPPFLAGS += -I../../../../include -I../libcontrollers
 LDLIBS += -lm -L../../../../lib/ -L../libcontrollers -lcontrollers -lltp
Index: ltp/testcases/kernel/controllers/libcontrollers/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/libcontrollers/Makefile
+++ ltp/testcases/kernel/controllers/libcontrollers/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 TARGET=libcontrollers.a
 SRCS=$(wildcard *.c)
 OBJS=$(patsubst %.c,%.o,$(SRCS))
Index: ltp/testcases/kernel/controllers/memcg/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/memcg/Makefile
+++ ltp/testcases/kernel/controllers/memcg/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall
 CPPFLAGS += -I../../../../include -I../libcontrollers
 LDLIBS += -L../../../../lib/ -lltp
Index: ltp/testcases/kernel/controllers/memctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/controllers/memctl/Makefile
+++ ltp/testcases/kernel/controllers/memctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall
 CPPFLAGS += -I../../../../include -I../libcontrollers
 LDLIBS += -lm -L../../../../lib/ -L../libcontrollers -lcontrollers -lltp
Index: ltp/testcases/kernel/device-drivers/acpi/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/acpi/Makefile
+++ ltp/testcases/kernel/device-drivers/acpi/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Makefile for GCOV profiling kernel module
 #
Index: ltp/testcases/kernel/device-drivers/agp/kernel_space/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/agp/kernel_space/Makefile
+++ ltp/testcases/kernel/device-drivers/agp/kernel_space/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 # Makefile for GCOV profiling kernel module
 #
Index: ltp/testcases/kernel/device-drivers/agp/user_space/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/agp/user_space/Makefile
+++ ltp/testcases/kernel/device-drivers/agp/user_space/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 CFLAGS += -Wall
 OBJS = tagp_ki.o user_tagp.o
Index: ltp/testcases/kernel/device-drivers/base/tbase/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/base/tbase/Makefile
+++ ltp/testcases/kernel/device-drivers/base/tbase/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 # Makefile for GCOV profiling kernel module
 #
Index: ltp/testcases/kernel/device-drivers/base/user_base/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/base/user_base/Makefile
+++ ltp/testcases/kernel/device-drivers/base/user_base/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 CFLAGS += -Wall
 OBJS = tbase_ki.o user_tbase.o
Index: ltp/testcases/kernel/device-drivers/block/kernel_space/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/block/kernel_space/Makefile
+++ ltp/testcases/kernel/device-drivers/block/kernel_space/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 EXTRA_CFLAGS += -Wall -Wextra -Wno-unused-parameter
 
Index: ltp/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/Makefile
+++ ltp/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 # Makefile for GCOV profiling kernel module
 #
Index: ltp/testcases/kernel/device-drivers/dev_sim_framework/user_space/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/dev_sim_framework/user_space/Makefile
+++ ltp/testcases/kernel/device-drivers/dev_sim_framework/user_space/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 CFLAGS += -Wall
 OBJS = tmod_ki.o user_tmod.o
Index: ltp/testcases/kernel/device-drivers/drm/kernel_space/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/drm/kernel_space/Makefile
+++ ltp/testcases/kernel/device-drivers/drm/kernel_space/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 # Makefile for GCOV profiling kernel module
 #
Index: ltp/testcases/kernel/device-drivers/drm/user_space/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/drm/user_space/Makefile
+++ ltp/testcases/kernel/device-drivers/drm/user_space/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 	KDIR := /lib/modules/$(shell uname -r)/build
 	CFLAGS := -I$(KDIR)/drivers/char/drm
Index: ltp/testcases/kernel/device-drivers/include/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/include/Makefile
+++ ltp/testcases/kernel/device-drivers/include/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Makefile for GCOV profiling kernel module
 #
Index: ltp/testcases/kernel/device-drivers/misc_modules/per_cpu_allocator_module/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/misc_modules/per_cpu_allocator_module/Makefile
+++ ltp/testcases/kernel/device-drivers/misc_modules/per_cpu_allocator_module/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 EXTRA_CFLAGS += -Wall -Wextra -Wno-unused-parameter
 
Index: ltp/testcases/kernel/device-drivers/misc_modules/per_cpu_atomic_operations_vs_interrupt_disabling_module/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/misc_modules/per_cpu_atomic_operations_vs_interrupt_disabling_module/Makefile
+++ ltp/testcases/kernel/device-drivers/misc_modules/per_cpu_atomic_operations_vs_interrupt_disabling_module/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 ifneq ($(KERNELRELEASE),)
          obj-m += test-cmpxchg-nolock.o
 else
Index: ltp/testcases/kernel/device-drivers/nls/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/nls/Makefile
+++ ltp/testcases/kernel/device-drivers/nls/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Makefile for GCOV profiling kernel module
 #
Index: ltp/testcases/kernel/device-drivers/pci/tpci/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/pci/tpci/Makefile
+++ ltp/testcases/kernel/device-drivers/pci/tpci/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 # Makefile for GCOV profiling kernel module
 #
Index: ltp/testcases/kernel/device-drivers/pci/user_tpci/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/pci/user_tpci/Makefile
+++ ltp/testcases/kernel/device-drivers/pci/user_tpci/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 CFLAGS += -Wall
 OBJS = tpci_ki.o user_tpci.o
Index: ltp/testcases/kernel/device-drivers/tbio/kernel_space/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/tbio/kernel_space/Makefile
+++ ltp/testcases/kernel/device-drivers/tbio/kernel_space/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 # Makefile for GCOV profiling kernel module
 #
Index: ltp/testcases/kernel/device-drivers/tbio/user_space/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/tbio/user_space/Makefile
+++ ltp/testcases/kernel/device-drivers/tbio/user_space/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 CFLAGS += -O2 -Wall -Wextra -g
 OBJS = tbio_ki.o user_tbio.o
Index: ltp/testcases/kernel/device-drivers/usb/tusb/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/usb/tusb/Makefile
+++ ltp/testcases/kernel/device-drivers/usb/tusb/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 # Makefile for GCOV profiling kernel module
 #
Index: ltp/testcases/kernel/device-drivers/usb/user_usb/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/usb/user_usb/Makefile
+++ ltp/testcases/kernel/device-drivers/usb/user_usb/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 CFLAGS += -Wall
 OBJS = tusb_ki.o user_tusb.o
Index: ltp/testcases/kernel/device-drivers/v4l/kernel_space/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/v4l/kernel_space/Makefile
+++ ltp/testcases/kernel/device-drivers/v4l/kernel_space/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 EXTRA_CFLAGS += -Wall -Wextra -Wno-unused-parameter
 
Index: ltp/testcases/kernel/device-drivers/v4l/user_space/Makefile
===================================================================
--- ltp.orig/testcases/kernel/device-drivers/v4l/user_space/Makefile
+++ ltp/testcases/kernel/device-drivers/v4l/user_space/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 # v4l-test: Test environment for Video For Linux Two API
 #
Index: ltp/testcases/kernel/fs/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/Makefile
+++ ltp/testcases/kernel/fs/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = acls doio fs_inod fsstress fs_perms fsx-linux ftest inode lftest linktest openfile proc stream fs_di fs_bind racer quota_remount
 
 all:
Index: ltp/testcases/kernel/fs/acls/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/acls/Makefile
+++ ltp/testcases/kernel/fs/acls/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 check_header = $(shell \
 	if echo "\#include <$(1)>" | $(CC) -E - > /dev/null 2>&1 ; \
 	then echo yes ; \
Index: ltp/testcases/kernel/fs/dmapi/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/dmapi/Makefile
+++ ltp/testcases/kernel/fs/dmapi/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #   Copyright (c) International Business Machines  Corp., 2004
 #
Index: ltp/testcases/kernel/fs/doio/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/doio/Makefile
+++ ltp/testcases/kernel/fs/doio/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 
 CFLAGS+= -Wall -I../../../../include -D_LARGEFILE64_SOURCE
 LDLIBS+= -L../../../../lib -lltp -lrt
Index: ltp/testcases/kernel/fs/fs-bench/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/fs-bench/Makefile
+++ ltp/testcases/kernel/fs/fs-bench/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 UTILS=boxmuler.o
 EXECS=cr ra radc 
 SCRIPTS=modaltr.sh test.sh test2.sh
Index: ltp/testcases/kernel/fs/fs_bind/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/fs_bind/Makefile
+++ ltp/testcases/kernel/fs/fs_bind/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Propagate make "commands" (TARGETS) to subdirs
 TARGETS=all clean install uninstall
 SUBDIRS=bin
Index: ltp/testcases/kernel/fs/fs_bind/bin/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/fs_bind/bin/Makefile
+++ ltp/testcases/kernel/fs/fs_bind/bin/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 .PHONY: all clean install
 
 LTP_SRC_ROOT=../../../../..
Index: ltp/testcases/kernel/fs/fs_di/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/fs_di/Makefile
+++ ltp/testcases/kernel/fs/fs_di/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS+= -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
Index: ltp/testcases/kernel/fs/fs_inod/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/fs_inod/Makefile
+++ ltp/testcases/kernel/fs/fs_inod/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 TARGETS=fs_inod
 
 all:
Index: ltp/testcases/kernel/fs/fs_perms/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/fs_perms/Makefile
+++ ltp/testcases/kernel/fs/fs_perms/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall
 CPPFLAGS += -I../../../../include
 LDLIBS += -lltp
Index: ltp/testcases/kernel/fs/fsstress/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/fsstress/Makefile
+++ ltp/testcases/kernel/fs/fsstress/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall -g -DNO_XFS -I. -D_LARGEFILE64_SOURCE -D_GNU_SOURCE
 LDFLAGS += 
 
Index: ltp/testcases/kernel/fs/fsx-linux/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/fsx-linux/Makefile
+++ ltp/testcases/kernel/fs/fsx-linux/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -w -O
 LDFLAGS += 
 
Index: ltp/testcases/kernel/fs/ftest/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/ftest/Makefile
+++ ltp/testcases/kernel/fs/ftest/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/fs/inode/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/inode/Makefile
+++ ltp/testcases/kernel/fs/inode/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/fs/lftest/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/lftest/Makefile
+++ ltp/testcases/kernel/fs/lftest/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS+= -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
Index: ltp/testcases/kernel/fs/linktest/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/linktest/Makefile
+++ ltp/testcases/kernel/fs/linktest/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 TARGETS=linktest.pl
 
 all:
Index: ltp/testcases/kernel/fs/openfile/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/openfile/Makefile
+++ ltp/testcases/kernel/fs/openfile/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall
 LOADLIBES += -lpthread
 
Index: ltp/testcases/kernel/fs/quota_remount/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/quota_remount/Makefile
+++ ltp/testcases/kernel/fs/quota_remount/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2009                 ##
Index: ltp/testcases/kernel/fs/racer/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/racer/Makefile
+++ ltp/testcases/kernel/fs/racer/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2008
 #
Index: ltp/testcases/kernel/fs/scsi/ltpfs/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/scsi/ltpfs/Makefile
+++ ltp/testcases/kernel/fs/scsi/ltpfs/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 # Makefile for GCOV profiling kernel module
 #
Index: ltp/testcases/kernel/fs/scsi/ltpscsi/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/scsi/ltpscsi/Makefile
+++ ltp/testcases/kernel/fs/scsi/ltpscsi/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SHELL = /bin/sh
 
 PREFIX=/usr/local
Index: ltp/testcases/kernel/fs/stream/Makefile
===================================================================
--- ltp.orig/testcases/kernel/fs/stream/Makefile
+++ ltp/testcases/kernel/fs/stream/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/hotplug/memory_hotplug/Makefile
===================================================================
--- ltp.orig/testcases/kernel/hotplug/memory_hotplug/Makefile
+++ ltp/testcases/kernel/hotplug/memory_hotplug/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile for linux memory toy/tool
 #
 SHELL   = /bin/sh
Index: ltp/testcases/kernel/include/Makefile
===================================================================
--- ltp.orig/testcases/kernel/include/Makefile
+++ ltp/testcases/kernel/include/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all uclinux: ../../../include/linux_syscall_numbers.h
 
 ../../../include/linux_syscall_numbers.h: linux_syscall_numbers.h
Index: ltp/testcases/kernel/io/Makefile
===================================================================
--- ltp.orig/testcases/kernel/io/Makefile
+++ ltp/testcases/kernel/io/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = direct_io disktest stress_cd stress_floppy writetest aio
 
 all:
Index: ltp/testcases/kernel/io/aio/Makefile
===================================================================
--- ltp.orig/testcases/kernel/io/aio/Makefile
+++ ltp/testcases/kernel/io/aio/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS = `ls */Makefile | sed "s/Makefile//g"`
 
 all:
Index: ltp/testcases/kernel/io/direct_io/Makefile
===================================================================
--- ltp.orig/testcases/kernel/io/direct_io/Makefile
+++ ltp/testcases/kernel/io/direct_io/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Makefile for diotests
 #
Index: ltp/testcases/kernel/io/disktest/Makefile
===================================================================
--- ltp.orig/testcases/kernel/io/disktest/Makefile
+++ ltp/testcases/kernel/io/disktest/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Disktest Makefile
 # Copyright (c) International Business Machines Corp., 2001
Index: ltp/testcases/kernel/io/disktest/Makefile.aix
===================================================================
--- ltp.orig/testcases/kernel/io/disktest/Makefile.aix
+++ ltp/testcases/kernel/io/disktest/Makefile.aix
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Disktest Makefile
 # Copyright (c) International Business Machines Corp., 2001
Index: ltp/testcases/kernel/io/disktest/Makefile.linux
===================================================================
--- ltp.orig/testcases/kernel/io/disktest/Makefile.linux
+++ ltp/testcases/kernel/io/disktest/Makefile.linux
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Disktest Makefile
 # Copyright (c) International Business Machines Corp., 2001
Index: ltp/testcases/kernel/io/disktest/Makefile.windows
===================================================================
--- ltp.orig/testcases/kernel/io/disktest/Makefile.windows
+++ ltp/testcases/kernel/io/disktest/Makefile.windows
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Used with MS Development Environment NMAKE
 !IF "$(CFG)" == ""
 CFG=disktest - Release
Index: ltp/testcases/kernel/io/ltp-aiodio/Makefile
===================================================================
--- ltp.orig/testcases/kernel/io/ltp-aiodio/Makefile
+++ ltp/testcases/kernel/io/ltp-aiodio/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS+= -Wall -O -g -DAIO -I../../../../include
 LDLIBS+= -L../../../../lib -laio -lltp
 
Index: ltp/testcases/kernel/io/stress_cd/Makefile
===================================================================
--- ltp.orig/testcases/kernel/io/stress_cd/Makefile
+++ ltp/testcases/kernel/io/stress_cd/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall -O -g
 LDLIBS := -lpthread
 
Index: ltp/testcases/kernel/io/stress_floppy/Makefile
===================================================================
--- ltp.orig/testcases/kernel/io/stress_floppy/Makefile
+++ ltp/testcases/kernel/io/stress_floppy/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all: 
 
 install: generate
Index: ltp/testcases/kernel/io/writetest/Makefile
===================================================================
--- ltp.orig/testcases/kernel/io/writetest/Makefile
+++ ltp/testcases/kernel/io/writetest/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS+=-Wall -O2 -g  `getconf LFS_CFLAGS` -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
 
 all: writetest
Index: ltp/testcases/kernel/ipc/Makefile
===================================================================
--- ltp.orig/testcases/kernel/ipc/Makefile
+++ ltp/testcases/kernel/ipc/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = semaphore pipeio ipc_stress
 
 all:
Index: ltp/testcases/kernel/ipc/ipc_stress/Makefile
===================================================================
--- ltp.orig/testcases/kernel/ipc/ipc_stress/Makefile
+++ ltp/testcases/kernel/ipc/ipc_stress/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -O -g -D_LINUX_ -Wall 
 LOADLIBES += -lpthread
 
Index: ltp/testcases/kernel/ipc/ipc_stress/Makefile.linux
===================================================================
--- ltp.orig/testcases/kernel/ipc/ipc_stress/Makefile.linux
+++ ltp/testcases/kernel/ipc/ipc_stress/Makefile.linux
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS= -O -lpthread -D_LINUX_
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
Index: ltp/testcases/kernel/ipc/pipeio/Makefile
===================================================================
--- ltp.orig/testcases/kernel/ipc/pipeio/Makefile
+++ ltp/testcases/kernel/ipc/pipeio/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/ipc/semaphore/Makefile
===================================================================
--- ltp.orig/testcases/kernel/ipc/semaphore/Makefile
+++ ltp/testcases/kernel/ipc/semaphore/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall -I ../../../../include -I ../include
 LDLIBS := -L ../../../../lib -lpthread -lltp
 
Index: ltp/testcases/kernel/mem/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/Makefile
+++ ltp/testcases/kernel/mem/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = hugetlb mem mmapstress mtest01 mtest05 mtest06 mtest07 page shmt vmtests
 
 all:
Index: ltp/testcases/kernel/mem/hugetlb/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/hugetlb/Makefile
+++ ltp/testcases/kernel/mem/hugetlb/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/mem/hugetlb/hugemmap/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ ltp/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -I../../../../../include -g -Wall
 LOADLIBES += -L../../../../../lib -lltp 
 
Index: ltp/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
+++ ltp/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -I../lib -I../../../../../include -g -Wall
 LOADLIBES += -L../../../../../lib -lltp -L../lib -lipc
 
Index: ltp/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
+++ ltp/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -I../lib -I../../../../../include -g -Wall
 LOADLIBES += -L../../../../../lib -lltp -L../lib -lipc
 
Index: ltp/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
+++ ltp/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -I../lib -I../../../../../include -g -Wall
 LOADLIBES += -L../../../../../lib -lltp -L../lib -lipc
 
Index: ltp/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
+++ ltp/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -I../lib -I../../../../../include -g -Wall
 LOADLIBES += -L../../../../../lib -lltp -L../lib -lipc
 
Index: ltp/testcases/kernel/mem/hugetlb/lib/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/hugetlb/lib/Makefile
+++ ltp/testcases/kernel/mem/hugetlb/lib/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/mem/libmm/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/libmm/Makefile
+++ ltp/testcases/kernel/mem/libmm/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/mem/mem/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/mem/Makefile
+++ ltp/testcases/kernel/mem/mem/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/mem/mmapstress/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/mmapstress/Makefile
+++ ltp/testcases/kernel/mem/mmapstress/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/mem/mtest01/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/mtest01/Makefile
+++ ltp/testcases/kernel/mem/mtest01/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall -I../../../../include
 LOADLIBES+=	-L../../../../lib -lltp
 
Index: ltp/testcases/kernel/mem/mtest05/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/mtest05/Makefile
+++ ltp/testcases/kernel/mem/mtest05/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall
 CPPFLAGS += -I../../../../include
 LDLIBS += -lpthread -L../../../../lib -lltp
Index: ltp/testcases/kernel/mem/mtest06/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/mtest06/Makefile
+++ ltp/testcases/kernel/mem/mtest06/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall
 CPPFLAGS += -I../../../../include
 LDLIBS += -lpthread -L../../../../lib -lltp
Index: ltp/testcases/kernel/mem/mtest07/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/mtest07/Makefile
+++ ltp/testcases/kernel/mem/mtest07/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall -g
 LDLIBS := -lpthread -lm
 
Index: ltp/testcases/kernel/mem/page/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/page/Makefile
+++ ltp/testcases/kernel/mem/page/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/mem/shmt/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/shmt/Makefile
+++ ltp/testcases/kernel/mem/shmt/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/mem/vmtests/Makefile
===================================================================
--- ltp.orig/testcases/kernel/mem/vmtests/Makefile
+++ ltp/testcases/kernel/mem/vmtests/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/module/Makefile
===================================================================
--- ltp.orig/testcases/kernel/module/Makefile
+++ ltp/testcases/kernel/module/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = delete_module
 
 all:
Index: ltp/testcases/kernel/module/create_module/Makefile
===================================================================
--- ltp.orig/testcases/kernel/module/create_module/Makefile
+++ ltp/testcases/kernel/module/create_module/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/module/delete_module/Makefile
===================================================================
--- ltp.orig/testcases/kernel/module/delete_module/Makefile
+++ ltp/testcases/kernel/module/delete_module/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
 #
Index: ltp/testcases/kernel/module/query_module/Makefile
===================================================================
--- ltp.orig/testcases/kernel/module/query_module/Makefile
+++ ltp/testcases/kernel/module/query_module/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
 #
Index: ltp/testcases/kernel/numa/Makefile
===================================================================
--- ltp.orig/testcases/kernel/numa/Makefile
+++ ltp/testcases/kernel/numa/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2007
 #
Index: ltp/testcases/kernel/performance_counters/Makefile
===================================================================
--- ltp.orig/testcases/kernel/performance_counters/Makefile
+++ ltp/testcases/kernel/performance_counters/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/power_management/Makefile
===================================================================
--- ltp.orig/testcases/kernel/power_management/Makefile
+++ ltp/testcases/kernel/power_management/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2008                 ##
Index: ltp/testcases/kernel/pty/Makefile
===================================================================
--- ltp.orig/testcases/kernel/pty/Makefile
+++ ltp/testcases/kernel/pty/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 
 CFLAGS+= -O -Wall -g -D_GNU_SOURCE -I../../../include
 LDLIBS+= -L../../../lib -lltp
Index: ltp/testcases/kernel/sched/Makefile
===================================================================
--- ltp.orig/testcases/kernel/sched/Makefile
+++ ltp/testcases/kernel/sched/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = cfs-scheduler clisrv hyperthreading nptl process_stress pthreads sched_stress tool 
 
 all:
Index: ltp/testcases/kernel/sched/cfs-scheduler/Makefile
===================================================================
--- ltp.orig/testcases/kernel/sched/cfs-scheduler/Makefile
+++ ltp/testcases/kernel/sched/cfs-scheduler/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2008
 #
Index: ltp/testcases/kernel/sched/clisrv/Makefile
===================================================================
--- ltp.orig/testcases/kernel/sched/clisrv/Makefile
+++ ltp/testcases/kernel/sched/clisrv/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS+= -Wall -O -D_LINUX
 CFILES=pthcli.c pthserv.c readline.c writen.c
 OFILES=$(CFILES:.c=.o)
Index: ltp/testcases/kernel/sched/hyperthreading/Makefile
===================================================================
--- ltp.orig/testcases/kernel/sched/hyperthreading/Makefile
+++ ltp/testcases/kernel/sched/hyperthreading/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS = ht_enabled ht_affinity ht_interrupt
 
 all:
Index: ltp/testcases/kernel/sched/hyperthreading/ht_affinity/Makefile
===================================================================
--- ltp.orig/testcases/kernel/sched/hyperthreading/ht_affinity/Makefile
+++ ltp/testcases/kernel/sched/hyperthreading/ht_affinity/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Check that the definitions below are correct for your system
 
 CFLAGS    += -I../../../../../include -Wall
Index: ltp/testcases/kernel/sched/hyperthreading/ht_enabled/Makefile
===================================================================
--- ltp.orig/testcases/kernel/sched/hyperthreading/ht_enabled/Makefile
+++ ltp/testcases/kernel/sched/hyperthreading/ht_enabled/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Check that the definitions below are correct for your system
 
 CFLAGS   +=	-I../../../../../include -Wall
Index: ltp/testcases/kernel/sched/hyperthreading/ht_interrupt/Makefile
===================================================================
--- ltp.orig/testcases/kernel/sched/hyperthreading/ht_interrupt/Makefile
+++ ltp/testcases/kernel/sched/hyperthreading/ht_interrupt/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Check that the definitions below are correct for your system
 
 CFLAGS+=	-I../../../../../include -Wall
Index: ltp/testcases/kernel/sched/nptl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/sched/nptl/Makefile
+++ ltp/testcases/kernel/sched/nptl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2004
 #
Index: ltp/testcases/kernel/sched/process_stress/Makefile
===================================================================
--- ltp.orig/testcases/kernel/sched/process_stress/Makefile
+++ ltp/testcases/kernel/sched/process_stress/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -O -w -g -D_LINUX
 
 SRCS=$(wildcard *.c)
Index: ltp/testcases/kernel/sched/pthreads/Makefile
===================================================================
--- ltp.orig/testcases/kernel/sched/pthreads/Makefile
+++ ltp/testcases/kernel/sched/pthreads/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CPPFLAGS += -I../../../../include
 CFLAGS += -Wall
 LDLIBS += -lpthread -L../../../../lib -lltp
Index: ltp/testcases/kernel/sched/sched_stress/Makefile
===================================================================
--- ltp.orig/testcases/kernel/sched/sched_stress/Makefile
+++ ltp/testcases/kernel/sched/sched_stress/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall
 
 SRCS=$(wildcard *_tc*.c)
Index: ltp/testcases/kernel/sched/tool/Makefile
===================================================================
--- ltp.orig/testcases/kernel/sched/tool/Makefile
+++ ltp/testcases/kernel/sched/tool/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall -O -g
 LDLIBS := -lpthread
 
Index: ltp/testcases/kernel/security/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/Makefile
+++ ltp/testcases/kernel/security/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = mmc_security filecaps integrity cap_bound
 
 all:
Index: ltp/testcases/kernel/security/cap_bound/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/cap_bound/Makefile
+++ ltp/testcases/kernel/security/cap_bound/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2008                 ##
Index: ltp/testcases/kernel/security/digsig/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/digsig/Makefile
+++ ltp/testcases/kernel/security/digsig/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS = writeexec twiddlebit
 
 all:
Index: ltp/testcases/kernel/security/digsig/twiddlebit/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/digsig/twiddlebit/Makefile
+++ ltp/testcases/kernel/security/digsig/twiddlebit/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 
 all: hw_signed swapbit
Index: ltp/testcases/kernel/security/digsig/writeexec/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/digsig/writeexec/Makefile
+++ ltp/testcases/kernel/security/digsig/writeexec/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 LIBS= -ldl
 
 
Index: ltp/testcases/kernel/security/filecaps/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/filecaps/Makefile
+++ ltp/testcases/kernel/security/filecaps/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 ################################################################################
 ##                                                                            ##
 ## Copyright (c) International Business Machines  Corp., 2008                 ##
Index: ltp/testcases/kernel/security/integrity/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/integrity/Makefile
+++ ltp/testcases/kernel/security/integrity/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS = ima
 
 all:
Index: ltp/testcases/kernel/security/integrity/ima/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/integrity/ima/Makefile
+++ ltp/testcases/kernel/security/integrity/ima/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SUBDIRS = src tests policy
 
 all:
Index: ltp/testcases/kernel/security/integrity/ima/policy/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/integrity/ima/policy/Makefile
+++ ltp/testcases/kernel/security/integrity/ima/policy/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	mkdir -p ../../../../../policy; cp measure* ../../../../../policy/
Index: ltp/testcases/kernel/security/integrity/ima/tests/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/integrity/ima/tests/Makefile
+++ ltp/testcases/kernel/security/integrity/ima/tests/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	chmod 755 *.sh; cp *.sh ../../../../../bin/
Index: ltp/testcases/kernel/security/mmc_security/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/mmc_security/Makefile
+++ ltp/testcases/kernel/security/mmc_security/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SCRIPTS=ask_password.sh  assign_password.sh  change_password.sh  force_erase.sh  remove_password.sh
 
 all:
Index: ltp/testcases/kernel/security/selinux-testsuite/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS = tests 
 
 all:
Index: ltp/testcases/kernel/security/selinux-testsuite/policy/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/policy/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/policy/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 include /etc/selinux/config
 SELINUX_SRC=/etc/selinux/$(SELINUXTYPE)/src/policy
 
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 REDHAT_RELEASE=$(shell rpm -q redhat-release)
 REDHAT_VERS=$(shell echo $(REDHAT_RELEASE) | cut -f3 -d"-" | sed -e "s/[^0-9]*//g")
 POLICYDEVEL = /usr/share/selinux/devel
Index: ltp/testcases/kernel/security/selinux-testsuite/refpolicy/redhat/5/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/refpolicy/redhat/5/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/refpolicy/redhat/5/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../5/config.mk
 POLICYDEVEL = /usr/share/selinux/devel
 SEMODULE = /usr/sbin/semodule
 
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 REDHAT_RELEASE=$(shell rpm -q redhat-release)
 
 SUBDIRS=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys dyntrace dyntrans bounds
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/bounds/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/bounds/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 LDLIBS += -lselinux -lpthread
 
@@ -8,4 +9,4 @@ install:
 	ln -f selinux_bounds.sh ../../../../../bin/
 
 clean:
-	rm -f $(TARGETS)
\ No newline at end of file
+	rm -f $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/capable_file/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/capable_file/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/capable_file/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/capable_net/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/capable_net/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/capable_net/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/capable_sys/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/capable_sys/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/capable_sys/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/domain_trans/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/domain_trans/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/domain_trans/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	ln -f selinux_domain_trans.sh ../../../../../bin/
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/dyntrace/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/dyntrace/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/dyntrace/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 LDLIBS += -lselinux
 
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/dyntrans/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/dyntrans/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/dyntrans/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 LDLIBS += -lselinux
 
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/entrypoint/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/entrypoint/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/entrypoint/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	ln -f selinux_entrypoint.sh ../../../../../bin/
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/execshare/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/execshare/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/execshare/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 LDLIBS += -lselinux
 
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/exectrace/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/exectrace/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/exectrace/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=selinux_exectrace_parent selinux_exectrace_child
 LDLIBS += -lselinux
 
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/execute_no_trans/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/execute_no_trans/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/execute_no_trans/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	ln -f selinux_execute_no_trans.sh ../../../../../bin/
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/fdreceive/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/fdreceive/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/fdreceive/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/file/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/file/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/file/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 LDLIBS += -lselinux
 
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/inherit/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/inherit/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/inherit/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=selinux_inherit_child selinux_inherit_parent
 
 LDFLAGS +=-static
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/ioctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/ioctl/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/ioctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=selinux_ioctl selinux_noioctl
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/link/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/link/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/link/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	ln -f selinux_link.sh ../../../../../bin/
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/mkdir/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/mkdir/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/mkdir/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	ln -f selinux_mkdir.sh ../../../../../bin/
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/msg/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/msg/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/msg/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/open/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/open/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/open/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/ptrace/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/ptrace/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/ptrace/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/readlink/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/readlink/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/readlink/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	ln -f selinux_readlink.sh ../../../../../bin/
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/relabel/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/relabel/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/relabel/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	ln -f selinux_relabel.sh ../../../../../bin/
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/rename/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/rename/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/rename/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	ln -f selinux_rename.sh ../../../../../bin/
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/rxdir/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/rxdir/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/rxdir/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	ln -f selinux_rxdir.sh ../../../../../bin/
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/sem/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/sem/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/sem/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/setattr/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/setattr/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/setattr/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/setnice/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/setnice/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/setnice/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=selinux_setnice_parent selinux_setnice_child
 
 LDLIBS += -lselinux
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/shm/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/shm/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/shm/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/sigkill/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/sigkill/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/sigkill/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=selinux_sigkill_server
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/stat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/stat/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/stat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	ln -f selinux_stat.sh ../../../../../bin/
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/sysctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/sysctl/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/sysctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 all:
 install:
 	ln -f selinux_sysctl.sh ../../../../../bin/
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/task_create/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/task_create/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/task_create/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=selinux_task_create_parent
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/task_getpgid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/task_getpgid/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/task_getpgid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/task_getscheduler/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/task_getscheduler/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/task_getscheduler/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/task_getsid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/task_getsid/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/task_getsid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/task_setnice/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/task_setnice/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/task_setnice/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/task_setpgid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/task_setpgid/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/task_setpgid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 all: $(TARGETS)
 install:
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/task_setscheduler/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/task_setscheduler/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/task_setscheduler/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
 all: $(TARGETS)
Index: ltp/testcases/kernel/security/selinux-testsuite/tests/wait/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/selinux-testsuite/tests/wait/Makefile
+++ ltp/testcases/kernel/security/selinux-testsuite/tests/wait/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../../config.mk
 TARGETS=selinux_wait_parent selinux_wait_child
 LDLIBS += -lselinux
 
Index: ltp/testcases/kernel/security/smack/Makefile
===================================================================
--- ltp.orig/testcases/kernel/security/smack/Makefile
+++ ltp/testcases/kernel/security/smack/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copyright (c) Casey Schaufler, 2009
 #
Index: ltp/testcases/kernel/syscalls/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/Makefile
+++ ltp/testcases/kernel/syscalls/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/abort/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/abort/Makefile
+++ ltp/testcases/kernel/syscalls/abort/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/accept/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/accept/Makefile
+++ ltp/testcases/kernel/syscalls/accept/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/accept4/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/accept4/Makefile
+++ ltp/testcases/kernel/syscalls/accept4/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2008
 #
Index: ltp/testcases/kernel/syscalls/access/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/access/Makefile
+++ ltp/testcases/kernel/syscalls/access/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/acct/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/acct/Makefile
+++ ltp/testcases/kernel/syscalls/acct/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/add_key/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/add_key/Makefile
+++ ltp/testcases/kernel/syscalls/add_key/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/adjtimex/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/adjtimex/Makefile
+++ ltp/testcases/kernel/syscalls/adjtimex/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/alarm/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/alarm/Makefile
+++ ltp/testcases/kernel/syscalls/alarm/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/asyncio/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/asyncio/Makefile
+++ ltp/testcases/kernel/syscalls/asyncio/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/bdflush/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/bdflush/Makefile
+++ ltp/testcases/kernel/syscalls/bdflush/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/bind/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/bind/Makefile
+++ ltp/testcases/kernel/syscalls/bind/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/brk/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/brk/Makefile
+++ ltp/testcases/kernel/syscalls/brk/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/cacheflush/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/cacheflush/Makefile
+++ ltp/testcases/kernel/syscalls/cacheflush/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/capget/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/capget/Makefile
+++ ltp/testcases/kernel/syscalls/capget/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/capset/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/capset/Makefile
+++ ltp/testcases/kernel/syscalls/capset/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/chdir/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/chdir/Makefile
+++ ltp/testcases/kernel/syscalls/chdir/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/chmod/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/chmod/Makefile
+++ ltp/testcases/kernel/syscalls/chmod/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/chown/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/chown/Makefile
+++ ltp/testcases/kernel/syscalls/chown/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/chroot/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/chroot/Makefile
+++ ltp/testcases/kernel/syscalls/chroot/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/clock_getres/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/clock_getres/Makefile
+++ ltp/testcases/kernel/syscalls/clock_getres/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/clock_nanosleep/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/clock_nanosleep/Makefile
+++ ltp/testcases/kernel/syscalls/clock_nanosleep/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/clock_nanosleep2/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/clock_nanosleep2/Makefile
+++ ltp/testcases/kernel/syscalls/clock_nanosleep2/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/clone/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/clone/Makefile
+++ ltp/testcases/kernel/syscalls/clone/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/close/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/close/Makefile
+++ ltp/testcases/kernel/syscalls/close/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/confstr/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/confstr/Makefile
+++ ltp/testcases/kernel/syscalls/confstr/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/connect/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/connect/Makefile
+++ ltp/testcases/kernel/syscalls/connect/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/creat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/creat/Makefile
+++ ltp/testcases/kernel/syscalls/creat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/dup/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/dup/Makefile
+++ ltp/testcases/kernel/syscalls/dup/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/dup2/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/dup2/Makefile
+++ ltp/testcases/kernel/syscalls/dup2/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/dup3/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/dup3/Makefile
+++ ltp/testcases/kernel/syscalls/dup3/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/epoll/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/epoll/Makefile
+++ ltp/testcases/kernel/syscalls/epoll/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/epoll2/examples/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/epoll2/examples/Makefile
+++ ltp/testcases/kernel/syscalls/epoll2/examples/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  epoll ( Efficent event polling implementation )
 #  Copyright (C) 2001,...,2002	 Davide Libenzi
Index: ltp/testcases/kernel/syscalls/epoll_create1/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/epoll_create1/Makefile
+++ ltp/testcases/kernel/syscalls/epoll_create1/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/eventfd2/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/eventfd2/Makefile
+++ ltp/testcases/kernel/syscalls/eventfd2/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/execl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/execl/Makefile
+++ ltp/testcases/kernel/syscalls/execl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/execle/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/execle/Makefile
+++ ltp/testcases/kernel/syscalls/execle/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/execlp/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/execlp/Makefile
+++ ltp/testcases/kernel/syscalls/execlp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/execv/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/execv/Makefile
+++ ltp/testcases/kernel/syscalls/execv/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/execve/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/execve/Makefile
+++ ltp/testcases/kernel/syscalls/execve/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/execvp/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/execvp/Makefile
+++ ltp/testcases/kernel/syscalls/execvp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/exit/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/exit/Makefile
+++ ltp/testcases/kernel/syscalls/exit/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/exit_group/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/exit_group/Makefile
+++ ltp/testcases/kernel/syscalls/exit_group/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/faccessat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/faccessat/Makefile
+++ ltp/testcases/kernel/syscalls/faccessat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fadvise/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fadvise/Makefile
+++ ltp/testcases/kernel/syscalls/fadvise/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copied from ../open/Makefile by Masatake YAMATO
 #
Index: ltp/testcases/kernel/syscalls/fallocate/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fallocate/Makefile
+++ ltp/testcases/kernel/syscalls/fallocate/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 
 #
 #  Copyright (c) International Business Machines  Corp., 2001
Index: ltp/testcases/kernel/syscalls/fchdir/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fchdir/Makefile
+++ ltp/testcases/kernel/syscalls/fchdir/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fchmod/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fchmod/Makefile
+++ ltp/testcases/kernel/syscalls/fchmod/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fchmodat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fchmodat/Makefile
+++ ltp/testcases/kernel/syscalls/fchmodat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fchown/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fchown/Makefile
+++ ltp/testcases/kernel/syscalls/fchown/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fchownat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fchownat/Makefile
+++ ltp/testcases/kernel/syscalls/fchownat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fcntl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fcntl/Makefile
+++ ltp/testcases/kernel/syscalls/fcntl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fdatasync/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fdatasync/Makefile
+++ ltp/testcases/kernel/syscalls/fdatasync/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/flock/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/flock/Makefile
+++ ltp/testcases/kernel/syscalls/flock/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fmtmsg/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fmtmsg/Makefile
+++ ltp/testcases/kernel/syscalls/fmtmsg/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fork/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fork/Makefile
+++ ltp/testcases/kernel/syscalls/fork/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fpathconf/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fpathconf/Makefile
+++ ltp/testcases/kernel/syscalls/fpathconf/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fstat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fstat/Makefile
+++ ltp/testcases/kernel/syscalls/fstat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fstatat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fstatat/Makefile
+++ ltp/testcases/kernel/syscalls/fstatat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fstatfs/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fstatfs/Makefile
+++ ltp/testcases/kernel/syscalls/fstatfs/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/fsync/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/fsync/Makefile
+++ ltp/testcases/kernel/syscalls/fsync/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ftruncate/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ftruncate/Makefile
+++ ltp/testcases/kernel/syscalls/ftruncate/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/futimesat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/futimesat/Makefile
+++ ltp/testcases/kernel/syscalls/futimesat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/get_mempolicy/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/get_mempolicy/Makefile
+++ ltp/testcases/kernel/syscalls/get_mempolicy/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/get_robust_list/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/get_robust_list/Makefile
+++ ltp/testcases/kernel/syscalls/get_robust_list/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getcontext/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getcontext/Makefile
+++ ltp/testcases/kernel/syscalls/getcontext/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getcpu/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getcpu/Makefile
+++ ltp/testcases/kernel/syscalls/getcpu/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getcwd/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getcwd/Makefile
+++ ltp/testcases/kernel/syscalls/getcwd/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getdents/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getdents/Makefile
+++ ltp/testcases/kernel/syscalls/getdents/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getdomainname/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getdomainname/Makefile
+++ ltp/testcases/kernel/syscalls/getdomainname/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getdtablesize/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getdtablesize/Makefile
+++ ltp/testcases/kernel/syscalls/getdtablesize/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getegid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getegid/Makefile
+++ ltp/testcases/kernel/syscalls/getegid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/geteuid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/geteuid/Makefile
+++ ltp/testcases/kernel/syscalls/geteuid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getgid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getgid/Makefile
+++ ltp/testcases/kernel/syscalls/getgid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getgroups/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getgroups/Makefile
+++ ltp/testcases/kernel/syscalls/getgroups/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/gethostid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/gethostid/Makefile
+++ ltp/testcases/kernel/syscalls/gethostid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/gethostname/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/gethostname/Makefile
+++ ltp/testcases/kernel/syscalls/gethostname/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getitimer/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getitimer/Makefile
+++ ltp/testcases/kernel/syscalls/getitimer/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getpagesize/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getpagesize/Makefile
+++ ltp/testcases/kernel/syscalls/getpagesize/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getpeername/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getpeername/Makefile
+++ ltp/testcases/kernel/syscalls/getpeername/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getpgid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getpgid/Makefile
+++ ltp/testcases/kernel/syscalls/getpgid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getpgrp/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getpgrp/Makefile
+++ ltp/testcases/kernel/syscalls/getpgrp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getpid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getpid/Makefile
+++ ltp/testcases/kernel/syscalls/getpid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getppid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getppid/Makefile
+++ ltp/testcases/kernel/syscalls/getppid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getpriority/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getpriority/Makefile
+++ ltp/testcases/kernel/syscalls/getpriority/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getresgid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getresgid/Makefile
+++ ltp/testcases/kernel/syscalls/getresgid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getresuid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getresuid/Makefile
+++ ltp/testcases/kernel/syscalls/getresuid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getrlimit/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getrlimit/Makefile
+++ ltp/testcases/kernel/syscalls/getrlimit/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getrusage/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getrusage/Makefile
+++ ltp/testcases/kernel/syscalls/getrusage/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getsid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getsid/Makefile
+++ ltp/testcases/kernel/syscalls/getsid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getsockname/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getsockname/Makefile
+++ ltp/testcases/kernel/syscalls/getsockname/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getsockopt/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getsockopt/Makefile
+++ ltp/testcases/kernel/syscalls/getsockopt/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/gettid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/gettid/Makefile
+++ ltp/testcases/kernel/syscalls/gettid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copied from ../getpid/Makefile by Masatake YAMATO
 #
Index: ltp/testcases/kernel/syscalls/gettimeofday/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/gettimeofday/Makefile
+++ ltp/testcases/kernel/syscalls/gettimeofday/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/getuid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/getuid/Makefile
+++ ltp/testcases/kernel/syscalls/getuid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/inotify/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/inotify/Makefile
+++ ltp/testcases/kernel/syscalls/inotify/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) SWSoft, 2007
 #
Index: ltp/testcases/kernel/syscalls/inotify_init/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/inotify_init/Makefile
+++ ltp/testcases/kernel/syscalls/inotify_init/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/ioctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ioctl/Makefile
+++ ltp/testcases/kernel/syscalls/ioctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ioperm/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ioperm/Makefile
+++ ltp/testcases/kernel/syscalls/ioperm/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/iopl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/iopl/Makefile
+++ ltp/testcases/kernel/syscalls/iopl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/lib/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/lib/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/lib/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/msgctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/msgctl/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/msgctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/msgget/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/msgget/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/msgget/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/msgrcv/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/msgrcv/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/msgrcv/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/msgsnd/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/msgsnd/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/msgsnd/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/semctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/semctl/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/semctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/semget/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/semget/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/semget/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/semop/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/semop/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/semop/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/shmat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/shmat/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/shmat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/shmctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/shmdt/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/shmdt/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/shmdt/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ipc/shmget/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ipc/shmget/Makefile
+++ ltp/testcases/kernel/syscalls/ipc/shmget/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/keyctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/keyctl/Makefile
+++ ltp/testcases/kernel/syscalls/keyctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/kill/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/kill/Makefile
+++ ltp/testcases/kernel/syscalls/kill/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/lchown/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/lchown/Makefile
+++ ltp/testcases/kernel/syscalls/lchown/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/libevent/Makefile.am
===================================================================
--- ltp.orig/testcases/kernel/syscalls/libevent/Makefile.am
+++ ltp/testcases/kernel/syscalls/libevent/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 AUTOMAKE_OPTIONS = foreign no-dependencies
 
 CFLAGS = -Wall @CFLAGS@
Index: ltp/testcases/kernel/syscalls/libevent/Makefile.in
===================================================================
--- ltp.orig/testcases/kernel/syscalls/libevent/Makefile.in
+++ ltp/testcases/kernel/syscalls/libevent/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated automatically by automake 1.4-p6 from Makefile.am
 
 # Copyright (C) 1994, 1995-8, 1999, 2001 Free Software Foundation, Inc.
Index: ltp/testcases/kernel/syscalls/libevent/sample/Makefile.am
===================================================================
--- ltp.orig/testcases/kernel/syscalls/libevent/sample/Makefile.am
+++ ltp/testcases/kernel/syscalls/libevent/sample/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 AUTOMAKE_OPTIONS = foreign no-dependencies
 
 LDADD = -L.. -levent
Index: ltp/testcases/kernel/syscalls/libevent/sample/Makefile.in
===================================================================
--- ltp.orig/testcases/kernel/syscalls/libevent/sample/Makefile.in
+++ ltp/testcases/kernel/syscalls/libevent/sample/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Makefile.in generated automatically by automake 1.4-p6 from Makefile.am
 
 # Copyright (C) 1994, 1995-8, 1999, 2001 Free Software Foundation, Inc.
Index: ltp/testcases/kernel/syscalls/libevent/test/Makefile.am
===================================================================
--- ltp.orig/testcases/kernel/syscalls/libevent/test/Makefile.am
+++ ltp/testcases/kernel/syscalls/libevent/test/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 AUTOMAKE_OPTIONS = foreign no-dependencies
 
 LDADD = -L.. -levent
Index: ltp/testcases/kernel/syscalls/libevent/test/Makefile.in
===================================================================
--- ltp.orig/testcases/kernel/syscalls/libevent/test/Makefile.in
+++ ltp/testcases/kernel/syscalls/libevent/test/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Makefile.in generated automatically by automake 1.4-p6 from Makefile.am
 
 # Copyright (C) 1994, 1995-8, 1999, 2001 Free Software Foundation, Inc.
Index: ltp/testcases/kernel/syscalls/link/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/link/Makefile
+++ ltp/testcases/kernel/syscalls/link/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/linkat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/linkat/Makefile
+++ ltp/testcases/kernel/syscalls/linkat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/listen/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/listen/Makefile
+++ ltp/testcases/kernel/syscalls/listen/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/llseek/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/llseek/Makefile
+++ ltp/testcases/kernel/syscalls/llseek/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/lseek/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/lseek/Makefile
+++ ltp/testcases/kernel/syscalls/lseek/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/lstat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/lstat/Makefile
+++ ltp/testcases/kernel/syscalls/lstat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/madvise/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/madvise/Makefile
+++ ltp/testcases/kernel/syscalls/madvise/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/mallopt/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mallopt/Makefile
+++ ltp/testcases/kernel/syscalls/mallopt/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/memcmp/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/memcmp/Makefile
+++ ltp/testcases/kernel/syscalls/memcmp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/memcpy/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/memcpy/Makefile
+++ ltp/testcases/kernel/syscalls/memcpy/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/memmap/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/memmap/Makefile
+++ ltp/testcases/kernel/syscalls/memmap/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/memset/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/memset/Makefile
+++ ltp/testcases/kernel/syscalls/memset/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/mincore/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mincore/Makefile
+++ ltp/testcases/kernel/syscalls/mincore/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/mkdir/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mkdir/Makefile
+++ ltp/testcases/kernel/syscalls/mkdir/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/mkdirat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mkdirat/Makefile
+++ ltp/testcases/kernel/syscalls/mkdirat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/mknod/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mknod/Makefile
+++ ltp/testcases/kernel/syscalls/mknod/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/mknodat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mknodat/Makefile
+++ ltp/testcases/kernel/syscalls/mknodat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/mlock/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mlock/Makefile
+++ ltp/testcases/kernel/syscalls/mlock/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/mlockall/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mlockall/Makefile
+++ ltp/testcases/kernel/syscalls/mlockall/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/mmap/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mmap/Makefile
+++ ltp/testcases/kernel/syscalls/mmap/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/modify_ldt/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/modify_ldt/Makefile
+++ ltp/testcases/kernel/syscalls/modify_ldt/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/mount/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mount/Makefile
+++ ltp/testcases/kernel/syscalls/mount/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
 #  Copyright (C) International Business Machines  Corp., 2007
Index: ltp/testcases/kernel/syscalls/move_pages/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/move_pages/Makefile
+++ ltp/testcases/kernel/syscalls/move_pages/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
@@ -60,4 +61,4 @@ move_page03.mode:
 move_page11.mode:
 	@/bin/sh ./move_pages11.mode.sh
 
-.PHONY: move_pages03.mode
\ No newline at end of file
+.PHONY: move_pages03.mode
Index: ltp/testcases/kernel/syscalls/mprotect/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mprotect/Makefile
+++ ltp/testcases/kernel/syscalls/mprotect/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/mq_notify/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mq_notify/Makefile
+++ ltp/testcases/kernel/syscalls/mq_notify/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/mq_open/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mq_open/Makefile
+++ ltp/testcases/kernel/syscalls/mq_open/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/mq_timedreceive/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mq_timedreceive/Makefile
+++ ltp/testcases/kernel/syscalls/mq_timedreceive/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/mq_timedsend/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mq_timedsend/Makefile
+++ ltp/testcases/kernel/syscalls/mq_timedsend/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/mq_unlink/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mq_unlink/Makefile
+++ ltp/testcases/kernel/syscalls/mq_unlink/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/mremap/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/mremap/Makefile
+++ ltp/testcases/kernel/syscalls/mremap/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/msync/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/msync/Makefile
+++ ltp/testcases/kernel/syscalls/msync/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/munlock/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/munlock/Makefile
+++ ltp/testcases/kernel/syscalls/munlock/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/munlockall/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/munlockall/Makefile
+++ ltp/testcases/kernel/syscalls/munlockall/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/munmap/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/munmap/Makefile
+++ ltp/testcases/kernel/syscalls/munmap/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/nanosleep/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/nanosleep/Makefile
+++ ltp/testcases/kernel/syscalls/nanosleep/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/newuname/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/newuname/Makefile
+++ ltp/testcases/kernel/syscalls/newuname/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/nftw/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/nftw/Makefile
+++ ltp/testcases/kernel/syscalls/nftw/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # IBM Corporation 
 # 10/31/2002   Port to LTP     robbiew@us.ibm.com 
 # 06/30/2001   Port to Linux   nsharoff@us.ibm.com
Index: ltp/testcases/kernel/syscalls/nice/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/nice/Makefile
+++ ltp/testcases/kernel/syscalls/nice/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/open/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/open/Makefile
+++ ltp/testcases/kernel/syscalls/open/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/openat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/openat/Makefile
+++ ltp/testcases/kernel/syscalls/openat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/paging/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/paging/Makefile
+++ ltp/testcases/kernel/syscalls/paging/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/pathconf/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pathconf/Makefile
+++ ltp/testcases/kernel/syscalls/pathconf/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/pause/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pause/Makefile
+++ ltp/testcases/kernel/syscalls/pause/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/pcllib/Makefile.am
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pcllib/Makefile.am
+++ ltp/testcases/kernel/syscalls/pcllib/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 
 SUBDIRS = . pcl test include man
 
Index: ltp/testcases/kernel/syscalls/pcllib/Makefile.in
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pcllib/Makefile.in
+++ ltp/testcases/kernel/syscalls/pcllib/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.6.3 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/kernel/syscalls/pcllib/include/Makefile.am
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pcllib/include/Makefile.am
+++ ltp/testcases/kernel/syscalls/pcllib/include/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 include_HEADERS = pcl.h
 
Index: ltp/testcases/kernel/syscalls/pcllib/include/Makefile.in
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pcllib/include/Makefile.in
+++ ltp/testcases/kernel/syscalls/pcllib/include/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Makefile.in generated by automake 1.6.3 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/kernel/syscalls/pcllib/man/Makefile.am
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pcllib/man/Makefile.am
+++ ltp/testcases/kernel/syscalls/pcllib/man/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 man3_MANS = pcl.3
 
Index: ltp/testcases/kernel/syscalls/pcllib/man/Makefile.in
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pcllib/man/Makefile.in
+++ ltp/testcases/kernel/syscalls/pcllib/man/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Makefile.in generated by automake 1.6.3 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/kernel/syscalls/pcllib/pcl/Makefile.am
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pcllib/pcl/Makefile.am
+++ ltp/testcases/kernel/syscalls/pcllib/pcl/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 INCLUDES = -I../include
 
Index: ltp/testcases/kernel/syscalls/pcllib/pcl/Makefile.in
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pcllib/pcl/Makefile.in
+++ ltp/testcases/kernel/syscalls/pcllib/pcl/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Makefile.in generated by automake 1.6.3 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/kernel/syscalls/pcllib/test/Makefile.am
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pcllib/test/Makefile.am
+++ ltp/testcases/kernel/syscalls/pcllib/test/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 
 INCLUDES = -I../include
 
Index: ltp/testcases/kernel/syscalls/pcllib/test/Makefile.in
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pcllib/test/Makefile.in
+++ ltp/testcases/kernel/syscalls/pcllib/test/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Makefile.in generated by automake 1.6.3 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/kernel/syscalls/personality/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/personality/Makefile
+++ ltp/testcases/kernel/syscalls/personality/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/pipe/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pipe/Makefile
+++ ltp/testcases/kernel/syscalls/pipe/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/pipe2/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pipe2/Makefile
+++ ltp/testcases/kernel/syscalls/pipe2/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/poll/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/poll/Makefile
+++ ltp/testcases/kernel/syscalls/poll/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ppoll/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ppoll/Makefile
+++ ltp/testcases/kernel/syscalls/ppoll/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/prctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/prctl/Makefile
+++ ltp/testcases/kernel/syscalls/prctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/pread/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pread/Makefile
+++ ltp/testcases/kernel/syscalls/pread/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/profil/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/profil/Makefile
+++ ltp/testcases/kernel/syscalls/profil/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/pselect/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pselect/Makefile
+++ ltp/testcases/kernel/syscalls/pselect/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ptrace/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ptrace/Makefile
+++ ltp/testcases/kernel/syscalls/ptrace/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/pwrite/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/pwrite/Makefile
+++ ltp/testcases/kernel/syscalls/pwrite/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/read/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/read/Makefile
+++ ltp/testcases/kernel/syscalls/read/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/readdir/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/readdir/Makefile
+++ ltp/testcases/kernel/syscalls/readdir/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/readlink/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/readlink/Makefile
+++ ltp/testcases/kernel/syscalls/readlink/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/readlinkat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/readlinkat/Makefile
+++ ltp/testcases/kernel/syscalls/readlinkat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/readv/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/readv/Makefile
+++ ltp/testcases/kernel/syscalls/readv/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/reboot/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/reboot/Makefile
+++ ltp/testcases/kernel/syscalls/reboot/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/recv/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/recv/Makefile
+++ ltp/testcases/kernel/syscalls/recv/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/recvfrom/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/recvfrom/Makefile
+++ ltp/testcases/kernel/syscalls/recvfrom/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/recvmsg/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/recvmsg/Makefile
+++ ltp/testcases/kernel/syscalls/recvmsg/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/remap_file_pages/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/remap_file_pages/Makefile
+++ ltp/testcases/kernel/syscalls/remap_file_pages/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/rename/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/rename/Makefile
+++ ltp/testcases/kernel/syscalls/rename/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/renameat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/renameat/Makefile
+++ ltp/testcases/kernel/syscalls/renameat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/rmdir/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/rmdir/Makefile
+++ ltp/testcases/kernel/syscalls/rmdir/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/rt_sigaction/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/rt_sigaction/Makefile
+++ ltp/testcases/kernel/syscalls/rt_sigaction/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/rt_sigprocmask/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/rt_sigprocmask/Makefile
+++ ltp/testcases/kernel/syscalls/rt_sigprocmask/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile
+++ ltp/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/rt_sigsuspend/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/rt_sigsuspend/Makefile
+++ ltp/testcases/kernel/syscalls/rt_sigsuspend/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/sbrk/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sbrk/Makefile
+++ ltp/testcases/kernel/syscalls/sbrk/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sched_get_priority_max/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sched_get_priority_max/Makefile
+++ ltp/testcases/kernel/syscalls/sched_get_priority_max/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sched_get_priority_min/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sched_get_priority_min/Makefile
+++ ltp/testcases/kernel/syscalls/sched_get_priority_min/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sched_getparam/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sched_getparam/Makefile
+++ ltp/testcases/kernel/syscalls/sched_getparam/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sched_getscheduler/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sched_getscheduler/Makefile
+++ ltp/testcases/kernel/syscalls/sched_getscheduler/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sched_rr_get_interval/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sched_rr_get_interval/Makefile
+++ ltp/testcases/kernel/syscalls/sched_rr_get_interval/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sched_setparam/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sched_setparam/Makefile
+++ ltp/testcases/kernel/syscalls/sched_setparam/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sched_setscheduler/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sched_setscheduler/Makefile
+++ ltp/testcases/kernel/syscalls/sched_setscheduler/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sched_yield/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sched_yield/Makefile
+++ ltp/testcases/kernel/syscalls/sched_yield/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/select/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/select/Makefile
+++ ltp/testcases/kernel/syscalls/select/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/send/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/send/Makefile
+++ ltp/testcases/kernel/syscalls/send/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sendfile/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sendfile/Makefile
+++ ltp/testcases/kernel/syscalls/sendfile/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sendmsg/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sendmsg/Makefile
+++ ltp/testcases/kernel/syscalls/sendmsg/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sendto/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sendto/Makefile
+++ ltp/testcases/kernel/syscalls/sendto/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/set_robust_list/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/set_robust_list/Makefile
+++ ltp/testcases/kernel/syscalls/set_robust_list/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/set_thread_area/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/set_thread_area/Makefile
+++ ltp/testcases/kernel/syscalls/set_thread_area/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/set_tid_address/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/set_tid_address/Makefile
+++ ltp/testcases/kernel/syscalls/set_tid_address/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/setdomainname/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setdomainname/Makefile
+++ ltp/testcases/kernel/syscalls/setdomainname/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setegid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setegid/Makefile
+++ ltp/testcases/kernel/syscalls/setegid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setfsgid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setfsgid/Makefile
+++ ltp/testcases/kernel/syscalls/setfsgid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setfsuid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setfsuid/Makefile
+++ ltp/testcases/kernel/syscalls/setfsuid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setgid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setgid/Makefile
+++ ltp/testcases/kernel/syscalls/setgid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setgroups/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setgroups/Makefile
+++ ltp/testcases/kernel/syscalls/setgroups/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sethostname/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sethostname/Makefile
+++ ltp/testcases/kernel/syscalls/sethostname/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setitimer/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setitimer/Makefile
+++ ltp/testcases/kernel/syscalls/setitimer/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setpgid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setpgid/Makefile
+++ ltp/testcases/kernel/syscalls/setpgid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setpgrp/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setpgrp/Makefile
+++ ltp/testcases/kernel/syscalls/setpgrp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setpriority/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setpriority/Makefile
+++ ltp/testcases/kernel/syscalls/setpriority/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setregid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setregid/Makefile
+++ ltp/testcases/kernel/syscalls/setregid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setresgid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setresgid/Makefile
+++ ltp/testcases/kernel/syscalls/setresgid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setresuid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setresuid/Makefile
+++ ltp/testcases/kernel/syscalls/setresuid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setreuid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setreuid/Makefile
+++ ltp/testcases/kernel/syscalls/setreuid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setrlimit/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setrlimit/Makefile
+++ ltp/testcases/kernel/syscalls/setrlimit/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setsid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setsid/Makefile
+++ ltp/testcases/kernel/syscalls/setsid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setsockopt/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setsockopt/Makefile
+++ ltp/testcases/kernel/syscalls/setsockopt/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/settimeofday/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/settimeofday/Makefile
+++ ltp/testcases/kernel/syscalls/settimeofday/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/setuid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/setuid/Makefile
+++ ltp/testcases/kernel/syscalls/setuid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sgetmask/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sgetmask/Makefile
+++ ltp/testcases/kernel/syscalls/sgetmask/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/sigaction/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sigaction/Makefile
+++ ltp/testcases/kernel/syscalls/sigaction/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sigaltstack/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sigaltstack/Makefile
+++ ltp/testcases/kernel/syscalls/sigaltstack/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sighold/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sighold/Makefile
+++ ltp/testcases/kernel/syscalls/sighold/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/signal/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/signal/Makefile
+++ ltp/testcases/kernel/syscalls/signal/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/signalfd/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/signalfd/Makefile
+++ ltp/testcases/kernel/syscalls/signalfd/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/signalfd4/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/signalfd4/Makefile
+++ ltp/testcases/kernel/syscalls/signalfd4/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/sigpending/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sigpending/Makefile
+++ ltp/testcases/kernel/syscalls/sigpending/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sigprocmask/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sigprocmask/Makefile
+++ ltp/testcases/kernel/syscalls/sigprocmask/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sigrelse/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sigrelse/Makefile
+++ ltp/testcases/kernel/syscalls/sigrelse/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sigreturn/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sigreturn/Makefile
+++ ltp/testcases/kernel/syscalls/sigreturn/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/sigsuspend/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sigsuspend/Makefile
+++ ltp/testcases/kernel/syscalls/sigsuspend/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/socket/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/socket/Makefile
+++ ltp/testcases/kernel/syscalls/socket/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/socketcall/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/socketcall/Makefile
+++ ltp/testcases/kernel/syscalls/socketcall/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/socketpair/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/socketpair/Makefile
+++ ltp/testcases/kernel/syscalls/socketpair/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sockioctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sockioctl/Makefile
+++ ltp/testcases/kernel/syscalls/sockioctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/splice/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/splice/Makefile
+++ ltp/testcases/kernel/syscalls/splice/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ssetmask/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ssetmask/Makefile
+++ ltp/testcases/kernel/syscalls/ssetmask/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/stat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/stat/Makefile
+++ ltp/testcases/kernel/syscalls/stat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/statfs/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/statfs/Makefile
+++ ltp/testcases/kernel/syscalls/statfs/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/statvfs/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/statvfs/Makefile
+++ ltp/testcases/kernel/syscalls/statvfs/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/stime/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/stime/Makefile
+++ ltp/testcases/kernel/syscalls/stime/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/string/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/string/Makefile
+++ ltp/testcases/kernel/syscalls/string/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/swapoff/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/swapoff/Makefile
+++ ltp/testcases/kernel/syscalls/swapoff/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/swapon/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/swapon/Makefile
+++ ltp/testcases/kernel/syscalls/swapon/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/switch/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/switch/Makefile
+++ ltp/testcases/kernel/syscalls/switch/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #################################################################################
 #  Copyright (c) International Business Machines  Corp., 2008                   #
 #                                                                               #
Index: ltp/testcases/kernel/syscalls/symlink/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/symlink/Makefile
+++ ltp/testcases/kernel/syscalls/symlink/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/symlinkat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/symlinkat/Makefile
+++ ltp/testcases/kernel/syscalls/symlinkat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sync/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sync/Makefile
+++ ltp/testcases/kernel/syscalls/sync/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sync_file_range/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sync_file_range/Makefile
+++ ltp/testcases/kernel/syscalls/sync_file_range/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/syscall/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/syscall/Makefile
+++ ltp/testcases/kernel/syscalls/syscall/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sysconf/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sysconf/Makefile
+++ ltp/testcases/kernel/syscalls/sysconf/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sysctl/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sysctl/Makefile
+++ ltp/testcases/kernel/syscalls/sysctl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sysfs/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sysfs/Makefile
+++ ltp/testcases/kernel/syscalls/sysfs/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/sysinfo/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/sysinfo/Makefile
+++ ltp/testcases/kernel/syscalls/sysinfo/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/syslog/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/syslog/Makefile
+++ ltp/testcases/kernel/syscalls/syslog/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/tee/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/tee/Makefile
+++ ltp/testcases/kernel/syscalls/tee/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/time/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/time/Makefile
+++ ltp/testcases/kernel/syscalls/time/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/timer_getoverrun/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/timer_getoverrun/Makefile
+++ ltp/testcases/kernel/syscalls/timer_getoverrun/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/timer_gettime/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/timer_gettime/Makefile
+++ ltp/testcases/kernel/syscalls/timer_gettime/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/timerfd/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/timerfd/Makefile
+++ ltp/testcases/kernel/syscalls/timerfd/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/times/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/times/Makefile
+++ ltp/testcases/kernel/syscalls/times/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/tkill/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/tkill/Makefile
+++ ltp/testcases/kernel/syscalls/tkill/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/truncate/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/truncate/Makefile
+++ ltp/testcases/kernel/syscalls/truncate/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/ulimit/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ulimit/Makefile
+++ ltp/testcases/kernel/syscalls/ulimit/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/umask/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/umask/Makefile
+++ ltp/testcases/kernel/syscalls/umask/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/umount/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/umount/Makefile
+++ ltp/testcases/kernel/syscalls/umount/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/uname/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/uname/Makefile
+++ ltp/testcases/kernel/syscalls/uname/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/unlink/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/unlink/Makefile
+++ ltp/testcases/kernel/syscalls/unlink/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/unlinkat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/unlinkat/Makefile
+++ ltp/testcases/kernel/syscalls/unlinkat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/unshare/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/unshare/Makefile
+++ ltp/testcases/kernel/syscalls/unshare/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/ustat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/ustat/Makefile
+++ ltp/testcases/kernel/syscalls/ustat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/utime/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/utime/Makefile
+++ ltp/testcases/kernel/syscalls/utime/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/utimensat/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/utimensat/Makefile
+++ ltp/testcases/kernel/syscalls/utimensat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/utimes/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/utimes/Makefile
+++ ltp/testcases/kernel/syscalls/utimes/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2009
 #
Index: ltp/testcases/kernel/syscalls/vfork/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/vfork/Makefile
+++ ltp/testcases/kernel/syscalls/vfork/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/vhangup/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/vhangup/Makefile
+++ ltp/testcases/kernel/syscalls/vhangup/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/vmsplice/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/vmsplice/Makefile
+++ ltp/testcases/kernel/syscalls/vmsplice/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/wait/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/wait/Makefile
+++ ltp/testcases/kernel/syscalls/wait/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/wait4/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/wait4/Makefile
+++ ltp/testcases/kernel/syscalls/wait4/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/waitpid/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/waitpid/Makefile
+++ ltp/testcases/kernel/syscalls/waitpid/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/write/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/write/Makefile
+++ ltp/testcases/kernel/syscalls/write/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/syscalls/writev/Makefile
===================================================================
--- ltp.orig/testcases/kernel/syscalls/writev/Makefile
+++ ltp/testcases/kernel/syscalls/writev/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/timers/Makefile
===================================================================
--- ltp.orig/testcases/kernel/timers/Makefile
+++ ltp/testcases/kernel/timers/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/timers/clock_gettime/Makefile
===================================================================
--- ltp.orig/testcases/kernel/timers/clock_gettime/Makefile
+++ ltp/testcases/kernel/timers/clock_gettime/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/timers/clock_settime/Makefile
===================================================================
--- ltp.orig/testcases/kernel/timers/clock_settime/Makefile
+++ ltp/testcases/kernel/timers/clock_settime/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/timers/timer_create/Makefile
===================================================================
--- ltp.orig/testcases/kernel/timers/timer_create/Makefile
+++ ltp/testcases/kernel/timers/timer_create/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/timers/timer_delete/Makefile
===================================================================
--- ltp.orig/testcases/kernel/timers/timer_delete/Makefile
+++ ltp/testcases/kernel/timers/timer_delete/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/kernel/timers/timer_settime/Makefile
===================================================================
--- ltp.orig/testcases/kernel/timers/timer_settime/Makefile
+++ ltp/testcases/kernel/timers/timer_settime/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/misc/Makefile
===================================================================
--- ltp.orig/testcases/misc/Makefile
+++ ltp/testcases/misc/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 SUBDIRS = crash f00f math tcore_patch_test_suites
 
 all:
Index: ltp/testcases/misc/crash/Makefile
===================================================================
--- ltp.orig/testcases/misc/crash/Makefile
+++ ltp/testcases/misc/crash/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/misc/f00f/Makefile
===================================================================
--- ltp.orig/testcases/misc/f00f/Makefile
+++ ltp/testcases/misc/f00f/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/misc/math/Makefile
===================================================================
--- ltp.orig/testcases/misc/math/Makefile
+++ ltp/testcases/misc/math/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = abs atof float fptests nextafter
 
 all:
Index: ltp/testcases/misc/math/abs/Makefile
===================================================================
--- ltp.orig/testcases/misc/math/abs/Makefile
+++ ltp/testcases/misc/math/abs/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/misc/math/atof/Makefile
===================================================================
--- ltp.orig/testcases/misc/math/atof/Makefile
+++ ltp/testcases/misc/math/atof/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/misc/math/float/Makefile
===================================================================
--- ltp.orig/testcases/misc/math/float/Makefile
+++ ltp/testcases/misc/math/float/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS+= -I../../../../include -Wall -g 
 LOADLIBES+= -lpthread -lm -L../../../../lib -lltp
 
Index: ltp/testcases/misc/math/float/bessel/Makefile
===================================================================
--- ltp.orig/testcases/misc/math/float/bessel/Makefile
+++ ltp/testcases/misc/math/float/bessel/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -Wall
 LOADLIBES = -lm 
 BIN = genj0 genj1 geny0 geny1 genlgamma genbessel
Index: ltp/testcases/misc/math/float/exp_log/Makefile
===================================================================
--- ltp.orig/testcases/misc/math/float/exp_log/Makefile
+++ ltp/testcases/misc/math/float/exp_log/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -Wall
 LOADLIBES = -lm
 
Index: ltp/testcases/misc/math/float/iperb/Makefile
===================================================================
--- ltp.orig/testcases/misc/math/float/iperb/Makefile
+++ ltp/testcases/misc/math/float/iperb/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -Wall
 LOADLIBES = -lm
 
Index: ltp/testcases/misc/math/float/power/Makefile
===================================================================
--- ltp.orig/testcases/misc/math/float/power/Makefile
+++ ltp/testcases/misc/math/float/power/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -Wall
 LOADLIBES = -lm
 
Index: ltp/testcases/misc/math/float/trigo/Makefile
===================================================================
--- ltp.orig/testcases/misc/math/float/trigo/Makefile
+++ ltp/testcases/misc/math/float/trigo/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -Wall
 LOADLIBES = -lm
 
Index: ltp/testcases/misc/math/fptests/Makefile
===================================================================
--- ltp.orig/testcases/misc/math/fptests/Makefile
+++ ltp/testcases/misc/math/fptests/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/misc/math/nextafter/Makefile
===================================================================
--- ltp.orig/testcases/misc/math/nextafter/Makefile
+++ ltp/testcases/misc/math/nextafter/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/misc/tcore_patch_test_suites/Makefile
===================================================================
--- ltp.orig/testcases/misc/tcore_patch_test_suites/Makefile
+++ ltp/testcases/misc/tcore_patch_test_suites/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 CFLAGS += -Wall
 CPPFLAGS += -I../../../include
 LDFLAGS += -L../../../lib
Index: ltp/testcases/network/Makefile
===================================================================
--- ltp.orig/testcases/network/Makefile
+++ ltp/testcases/network/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 SUBDIRS = `ls */Makefile | sed "s/Makefile//g"`
 
 all:
Index: ltp/testcases/network/can/filter-tests/Makefile
===================================================================
--- ltp.orig/testcases/network/can/filter-tests/Makefile
+++ ltp/testcases/network/can/filter-tests/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  $Id: Makefile,v 1.1 2009/03/02 15:33:55 subrata_modak Exp $
 #
Index: ltp/testcases/network/dhcpd/Makefile
===================================================================
--- ltp.orig/testcases/network/dhcpd/Makefile
+++ ltp/testcases/network/dhcpd/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/iproute/Makefile
===================================================================
--- ltp.orig/testcases/network/iproute/Makefile
+++ ltp/testcases/network/iproute/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/iptables/Makefile
===================================================================
--- ltp.orig/testcases/network/iptables/Makefile
+++ ltp/testcases/network/iptables/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/ipv6/Makefile
===================================================================
--- ltp.orig/testcases/network/ipv6/Makefile
+++ ltp/testcases/network/ipv6/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = `ls */Makefile | sed "s/Makefile//g"`
 
 all:
Index: ltp/testcases/network/ipv6/echo6/Makefile
===================================================================
--- ltp.orig/testcases/network/ipv6/echo6/Makefile
+++ ltp/testcases/network/ipv6/echo6/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -w -O 
 LDLIBS += 
 
Index: ltp/testcases/network/ipv6/finger6/Makefile
===================================================================
--- ltp.orig/testcases/network/ipv6/finger6/Makefile
+++ ltp/testcases/network/ipv6/finger6/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install: 
Index: ltp/testcases/network/ipv6/perf_lan6/Makefile
===================================================================
--- ltp.orig/testcases/network/ipv6/perf_lan6/Makefile
+++ ltp/testcases/network/ipv6/perf_lan6/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -w -O
 LDLIBS += 
 
Index: ltp/testcases/network/ipv6/ping6/Makefile
===================================================================
--- ltp.orig/testcases/network/ipv6/ping6/Makefile
+++ ltp/testcases/network/ipv6/ping6/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/ipv6/sendfile6/Makefile
===================================================================
--- ltp.orig/testcases/network/ipv6/sendfile6/Makefile
+++ ltp/testcases/network/ipv6/sendfile6/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -w -O
 LDLIBS += 
 
Index: ltp/testcases/network/ipv6/tcpdump6/Makefile
===================================================================
--- ltp.orig/testcases/network/ipv6/tcpdump6/Makefile
+++ ltp/testcases/network/ipv6/tcpdump6/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install: 
Index: ltp/testcases/network/lib6/Makefile
===================================================================
--- ltp.orig/testcases/network/lib6/Makefile
+++ ltp/testcases/network/lib6/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/network/multicast/Makefile
===================================================================
--- ltp.orig/testcases/network/multicast/Makefile
+++ ltp/testcases/network/multicast/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = mc_cmds mc_commo mc_member mc_opts
 
 all:
Index: ltp/testcases/network/multicast/mc_cmds/Makefile
===================================================================
--- ltp.orig/testcases/network/multicast/mc_cmds/Makefile
+++ ltp/testcases/network/multicast/mc_cmds/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/multicast/mc_commo/Makefile
===================================================================
--- ltp.orig/testcases/network/multicast/mc_commo/Makefile
+++ ltp/testcases/network/multicast/mc_commo/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -O -Wall
 LDLIBS += 
 
Index: ltp/testcases/network/multicast/mc_member/Makefile
===================================================================
--- ltp.orig/testcases/network/multicast/mc_member/Makefile
+++ ltp/testcases/network/multicast/mc_member/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -w -O
 LDLIBS += 
 
Index: ltp/testcases/network/multicast/mc_opts/Makefile
===================================================================
--- ltp.orig/testcases/network/multicast/mc_opts/Makefile
+++ ltp/testcases/network/multicast/mc_opts/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall -g 
 LDLIBS += 
 
Index: ltp/testcases/network/nfs/Makefile
===================================================================
--- ltp.orig/testcases/network/nfs/Makefile
+++ ltp/testcases/network/nfs/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = `ls */Makefile | sed "s/Makefile//g" `
 all:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
Index: ltp/testcases/network/nfs/fsx-linux/Makefile
===================================================================
--- ltp.orig/testcases/network/nfs/fsx-linux/Makefile
+++ ltp/testcases/network/nfs/fsx-linux/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -w -O
 LDLIBS += 
 
Index: ltp/testcases/network/nfs/nfs01/Makefile
===================================================================
--- ltp.orig/testcases/network/nfs/nfs01/Makefile
+++ ltp/testcases/network/nfs/nfs01/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -w -O
 LDLIBS += 
 
Index: ltp/testcases/network/nfs/nfs02/Makefile
===================================================================
--- ltp.orig/testcases/network/nfs/nfs02/Makefile
+++ ltp/testcases/network/nfs/nfs02/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install: generate
Index: ltp/testcases/network/nfs/nfs03/Makefile
===================================================================
--- ltp.orig/testcases/network/nfs/nfs03/Makefile
+++ ltp/testcases/network/nfs/nfs03/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/nfs/nfs04/Makefile
===================================================================
--- ltp.orig/testcases/network/nfs/nfs04/Makefile
+++ ltp/testcases/network/nfs/nfs04/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS+= -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
 SRCS=$(wildcard *.c)
 TARGETS=$(patsubst %.c,%,$(SRCS))
Index: ltp/testcases/network/nfs/nfs_fsstress/Makefile
===================================================================
--- ltp.orig/testcases/network/nfs/nfs_fsstress/Makefile
+++ ltp/testcases/network/nfs/nfs_fsstress/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -Wall -g -DNO_XFS -I. -D_LARGEFILE64_SOURCE -D_GNU_SOURCE
 LDFLAGS += 
 
Index: ltp/testcases/network/nfs/nfslock01/Makefile
===================================================================
--- ltp.orig/testcases/network/nfs/nfslock01/Makefile
+++ ltp/testcases/network/nfs/nfslock01/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -w -O
 TESTS	= nfs_flock nfs_flock_dgen nfs_flock_frk
 
Index: ltp/testcases/network/nfs/nfsstat01/Makefile
===================================================================
--- ltp.orig/testcases/network/nfs/nfsstat01/Makefile
+++ ltp/testcases/network/nfs/nfsstat01/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all: 
 
 install:
Index: ltp/testcases/network/nfs/nfsstress/Makefile
===================================================================
--- ltp.orig/testcases/network/nfs/nfsstress/Makefile
+++ ltp/testcases/network/nfs/nfsstress/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -O -w -g
 LDLIBS := -lpthread
 
Index: ltp/testcases/network/nfsv4/Makefile
===================================================================
--- ltp.orig/testcases/network/nfsv4/Makefile
+++ ltp/testcases/network/nfsv4/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS := $(patsubst %/Makefile,%,$(wildcard */Makefile))
 
 all clean install:
Index: ltp/testcases/network/nfsv4/acl/Makefile
===================================================================
--- ltp.orig/testcases/network/nfsv4/acl/Makefile
+++ ltp/testcases/network/nfsv4/acl/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #       @(#)Makefile	ACL Basic tests
 #
Index: ltp/testcases/network/nfsv4/locks/Makefile
===================================================================
--- ltp.orig/testcases/network/nfsv4/locks/Makefile
+++ ltp/testcases/network/nfsv4/locks/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 TARGETS := locktests
 
 all: $(TARGETS)
Index: ltp/testcases/network/rpc/Makefile
===================================================================
--- ltp.orig/testcases/network/rpc/Makefile
+++ ltp/testcases/network/rpc/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = basic_tests
 
 all:
Index: ltp/testcases/network/rpc/basic_tests/Makefile
===================================================================
--- ltp.orig/testcases/network/rpc/basic_tests/Makefile
+++ ltp/testcases/network/rpc/basic_tests/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS = rpc01 rpcinfo rup rusers
 
 all:
Index: ltp/testcases/network/rpc/basic_tests/rpc01/Makefile
===================================================================
--- ltp.orig/testcases/network/rpc/basic_tests/rpc01/Makefile
+++ ltp/testcases/network/rpc/basic_tests/rpc01/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS += -w -O
 LDLIBS += 
 
Index: ltp/testcases/network/rpc/basic_tests/rpcinfo/Makefile
===================================================================
--- ltp.orig/testcases/network/rpc/basic_tests/rpcinfo/Makefile
+++ ltp/testcases/network/rpc/basic_tests/rpcinfo/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/rpc/basic_tests/rup/Makefile
===================================================================
--- ltp.orig/testcases/network/rpc/basic_tests/rup/Makefile
+++ ltp/testcases/network/rpc/basic_tests/rup/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/rpc/basic_tests/rusers/Makefile
===================================================================
--- ltp.orig/testcases/network/rpc/basic_tests/rusers/Makefile
+++ ltp/testcases/network/rpc/basic_tests/rusers/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/rpc/rpc-tirpc-full-test-suite/inc/Makefile.hdr
===================================================================
--- ltp.orig/testcases/network/rpc/rpc-tirpc-full-test-suite/inc/Makefile.hdr
+++ ltp/testcases/network/rpc/rpc-tirpc-full-test-suite/inc/Makefile.hdr
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 CFLAGS_TIRPC=-ltirpc -lpthread
 LDFLAGS_TIRPC=-I/usr/include/tirpc
 CFLAGS_RPC=-lnsl
Index: ltp/testcases/network/sctp/Makefile
===================================================================
--- ltp.orig/testcases/network/sctp/Makefile
+++ ltp/testcases/network/sctp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS =  lib testlib func_tests 
 
 all:
Index: ltp/testcases/network/sctp/func_tests/Makefile
===================================================================
--- ltp.orig/testcases/network/sctp/func_tests/Makefile
+++ ltp/testcases/network/sctp/func_tests/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  (C) Copyright IBM Corp. 2001, 2003
 #
Index: ltp/testcases/network/sctp/lib/Makefile
===================================================================
--- ltp.orig/testcases/network/sctp/lib/Makefile
+++ ltp/testcases/network/sctp/lib/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # (C) Copyright IBM Corp. 2003
 #
Index: ltp/testcases/network/sctp/testlib/Makefile
===================================================================
--- ltp.orig/testcases/network/sctp/testlib/Makefile
+++ ltp/testcases/network/sctp/testlib/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/network/sockets/Makefile
===================================================================
--- ltp.orig/testcases/network/sockets/Makefile
+++ ltp/testcases/network/sockets/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
Index: ltp/testcases/network/stress/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/Makefile
+++ ltp/testcases/network/stress/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = `ls */Makefile | sed "s/Makefile//g"`
 
 all:
Index: ltp/testcases/network/stress/broken_ip/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/broken_ip/Makefile
+++ ltp/testcases/network/stress/broken_ip/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SCRIPTS = broken_ip4-version broken_ip4-ihl broken_ip4-totlen \
 	  broken_ip4-fragment broken_ip4-protcol \
 	  broken_ip4-checksum broken_ip4-dstaddr \
Index: ltp/testcases/network/stress/dns/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/dns/Makefile
+++ ltp/testcases/network/stress/dns/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SCRIPTS = dns4-stress dns6-stress \
 	  dns-stress01-rmt dns-stress02-rmt
 
Index: ltp/testcases/network/stress/ftp/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/ftp/Makefile
+++ ltp/testcases/network/stress/ftp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SCRIPTS = ftp4-download-stress ftp6-download-stress \
 	  ftp-download-stress01-rmt ftp-download-stress02-rmt \
 	  ftp4-upload-stress ftp6-upload-stress \
Index: ltp/testcases/network/stress/http/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/http/Makefile
+++ ltp/testcases/network/stress/http/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SCRIPTS = http4-stress http6-stress \
 	  http-stress01-rmt http-stress02-rmt
 
Index: ltp/testcases/network/stress/icmp/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/icmp/Makefile
+++ ltp/testcases/network/stress/icmp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS = `ls */Makefile | sed "s/Makefile//g"`
 
 all:
Index: ltp/testcases/network/stress/icmp/multi-diffip/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/icmp/multi-diffip/Makefile
+++ ltp/testcases/network/stress/icmp/multi-diffip/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = icmp4-multi-diffip01 \
 	  icmp4-multi-diffip02 icmp4-multi-diffip03 \
 	  icmp4-multi-diffip04 icmp4-multi-diffip05 \
Index: ltp/testcases/network/stress/icmp/multi-diffnic/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/icmp/multi-diffnic/Makefile
+++ ltp/testcases/network/stress/icmp/multi-diffnic/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = icmp4-multi-diffnic01 \
 	  icmp4-multi-diffnic02 icmp4-multi-diffnic03 \
 	  icmp4-multi-diffnic04 icmp4-multi-diffnic05 \
Index: ltp/testcases/network/stress/icmp/uni-basic/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/icmp/uni-basic/Makefile
+++ ltp/testcases/network/stress/icmp/uni-basic/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = icmp4-uni-basic01 \
 	  icmp4-uni-basic02 icmp4-uni-basic03 \
 	  icmp4-uni-basic04 icmp4-uni-basic05 \
Index: ltp/testcases/network/stress/interface/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/interface/Makefile
+++ ltp/testcases/network/stress/interface/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SCRIPTS = if4-updown \
 	  if4-addr-change \
 	  if4-alias-adddel if4-alias-addlarge \
Index: ltp/testcases/network/stress/multicast/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/multicast/Makefile
+++ ltp/testcases/network/stress/multicast/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS = `ls */Makefile | sed "s/Makefile//g"`
 
 all:
Index: ltp/testcases/network/stress/multicast/grp-operation/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/multicast/grp-operation/Makefile
+++ ltp/testcases/network/stress/multicast/grp-operation/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = mcast4-grpope01 mcast4-grpope02 mcast4-grpope03 mcast4-grpope04 \
 	  mcast6-grpope01 mcast6-grpope02 mcast6-grpope03 mcast6-grpope04
 
Index: ltp/testcases/network/stress/multicast/packet-flood/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/multicast/packet-flood/Makefile
+++ ltp/testcases/network/stress/multicast/packet-flood/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = mcast4-pktfld01 mcast4-pktfld02 \
 	  mcast6-pktfld01 mcast6-pktfld02
 
Index: ltp/testcases/network/stress/multicast/query-flood/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/multicast/query-flood/Makefile
+++ ltp/testcases/network/stress/multicast/query-flood/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = mcast4-queryfld01 mcast4-queryfld02 mcast4-queryfld03 \
 	  mcast4-queryfld04 mcast4-queryfld05 mcast4-queryfld06 \
 	  mcast6-queryfld01 mcast6-queryfld02 mcast6-queryfld03 \
Index: ltp/testcases/network/stress/ns-tools/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/ns-tools/Makefile
+++ ltp/testcases/network/stress/ns-tools/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SCRIPTS=check_envval \
 	get_ifname initialize_if set_ipv4addr add_ipv6addr \
 	check_icmpv4_connectivity check_icmpv6_connectivity \
Index: ltp/testcases/network/stress/route/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/route/Makefile
+++ ltp/testcases/network/stress/route/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SCRIPTS = route4-change-dst route4-change-gw route4-change-if \
 	  route4-redirect route4-ifdown route4-rmmod \
 	  route6-change-dst route6-change-gw route6-change-if \
Index: ltp/testcases/network/stress/ssh/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/ssh/Makefile
+++ ltp/testcases/network/stress/ssh/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SCRIPTS = ssh4-stress ssh6-stress \
 	  ssh-stress01-rmt ssh-stress02-rmt ssh-stress03-rmt
 
Index: ltp/testcases/network/stress/tcp/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/tcp/Makefile
+++ ltp/testcases/network/stress/tcp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS = `ls */Makefile | sed "s/Makefile//g"`
 
 all:
Index: ltp/testcases/network/stress/tcp/multi-diffip/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/tcp/multi-diffip/Makefile
+++ ltp/testcases/network/stress/tcp/multi-diffip/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = tcp4-multi-diffip01 \
 	  tcp4-multi-diffip02 tcp4-multi-diffip03 \
 	  tcp4-multi-diffip04 tcp4-multi-diffip05 \
Index: ltp/testcases/network/stress/tcp/multi-diffnic/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/tcp/multi-diffnic/Makefile
+++ ltp/testcases/network/stress/tcp/multi-diffnic/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = tcp4-multi-diffnic01 \
 	  tcp4-multi-diffnic02 tcp4-multi-diffnic03 \
 	  tcp4-multi-diffnic04 tcp4-multi-diffnic05 \
Index: ltp/testcases/network/stress/tcp/multi-diffport/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/tcp/multi-diffport/Makefile
+++ ltp/testcases/network/stress/tcp/multi-diffport/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = tcp4-multi-diffport01 \
 	  tcp4-multi-diffport02 tcp4-multi-diffport03 \
 	  tcp4-multi-diffport04 tcp4-multi-diffport05 \
Index: ltp/testcases/network/stress/tcp/multi-sameport/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/tcp/multi-sameport/Makefile
+++ ltp/testcases/network/stress/tcp/multi-sameport/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = tcp4-multi-sameport01 \
 	  tcp4-multi-sameport02 tcp4-multi-sameport03 \
 	  tcp4-multi-sameport04 tcp4-multi-sameport05 \
Index: ltp/testcases/network/stress/tcp/uni-basic/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/tcp/uni-basic/Makefile
+++ ltp/testcases/network/stress/tcp/uni-basic/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = tcp4-uni-basic01 \
 	  tcp4-uni-basic02 tcp4-uni-basic03 \
 	  tcp4-uni-basic04 tcp4-uni-basic05 \
Index: ltp/testcases/network/stress/tcp/uni-dsackoff/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/tcp/uni-dsackoff/Makefile
+++ ltp/testcases/network/stress/tcp/uni-dsackoff/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = tcp4-uni-dsackoff01 \
 	  tcp4-uni-dsackoff02 tcp4-uni-dsackoff03 \
 	  tcp4-uni-dsackoff04 tcp4-uni-dsackoff05 \
Index: ltp/testcases/network/stress/tcp/uni-pktlossdup/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/tcp/uni-pktlossdup/Makefile
+++ ltp/testcases/network/stress/tcp/uni-pktlossdup/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = tcp4-uni-pktlossdup01 \
 	  tcp4-uni-pktlossdup02 tcp4-uni-pktlossdup03 \
 	  tcp4-uni-pktlossdup04 tcp4-uni-pktlossdup05 \
Index: ltp/testcases/network/stress/tcp/uni-sackoff/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/tcp/uni-sackoff/Makefile
+++ ltp/testcases/network/stress/tcp/uni-sackoff/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = tcp4-uni-sackoff01 \
 	  tcp4-uni-sackoff02 tcp4-uni-sackoff03 \
 	  tcp4-uni-sackoff04 tcp4-uni-sackoff05 \
Index: ltp/testcases/network/stress/tcp/uni-smallsend/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/tcp/uni-smallsend/Makefile
+++ ltp/testcases/network/stress/tcp/uni-smallsend/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = tcp4-uni-smallsend01 \
 	  tcp4-uni-smallsend02 tcp4-uni-smallsend03 \
 	  tcp4-uni-smallsend04 tcp4-uni-smallsend05 \
Index: ltp/testcases/network/stress/tcp/uni-tso/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/tcp/uni-tso/Makefile
+++ ltp/testcases/network/stress/tcp/uni-tso/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = tcp4-uni-tso01 \
 	  tcp4-uni-tso02 tcp4-uni-tso03 \
 	  tcp4-uni-tso04 tcp4-uni-tso05 \
Index: ltp/testcases/network/stress/tcp/uni-winscale/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/tcp/uni-winscale/Makefile
+++ ltp/testcases/network/stress/tcp/uni-winscale/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = tcp4-uni-winscale01 \
 	  tcp4-uni-winscale02 tcp4-uni-winscale03 \
 	  tcp4-uni-winscale04 tcp4-uni-winscale05 \
Index: ltp/testcases/network/stress/udp/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/udp/Makefile
+++ ltp/testcases/network/stress/udp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 SUBDIRS = `ls */Makefile | sed "s/Makefile//g"`
 
 all:
Index: ltp/testcases/network/stress/udp/multi-diffip/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/udp/multi-diffip/Makefile
+++ ltp/testcases/network/stress/udp/multi-diffip/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = udp4-multi-diffip01 \
 	  udp4-multi-diffip02 udp4-multi-diffip03 \
 	  udp4-multi-diffip04 udp4-multi-diffip05 \
Index: ltp/testcases/network/stress/udp/multi-diffnic/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/udp/multi-diffnic/Makefile
+++ ltp/testcases/network/stress/udp/multi-diffnic/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = udp4-multi-diffnic01 \
 	  udp4-multi-diffnic02 udp4-multi-diffnic03 \
 	  udp4-multi-diffnic04 udp4-multi-diffnic05 \
Index: ltp/testcases/network/stress/udp/multi-diffport/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/udp/multi-diffport/Makefile
+++ ltp/testcases/network/stress/udp/multi-diffport/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = udp4-multi-diffport01 \
 	  udp4-multi-diffport02 udp4-multi-diffport03 \
 	  udp4-multi-diffport04 udp4-multi-diffport05 \
Index: ltp/testcases/network/stress/udp/uni-basic/Makefile
===================================================================
--- ltp.orig/testcases/network/stress/udp/uni-basic/Makefile
+++ ltp/testcases/network/stress/udp/uni-basic/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 SCRIPTS = udp4-uni-basic01 \
 	  udp4-uni-basic02 udp4-uni-basic03 \
 	  udp4-uni-basic04 udp4-uni-basic05 \
Index: ltp/testcases/network/tcp_cmds/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/Makefile
+++ ltp/testcases/network/tcp_cmds/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 SUBDIRS = `ls */Makefile | sed "s/Makefile//g"`
 
 all:
Index: ltp/testcases/network/tcp_cmds/arp/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/arp/Makefile
+++ ltp/testcases/network/tcp_cmds/arp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/tcp_cmds/echo/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/echo/Makefile
+++ ltp/testcases/network/tcp_cmds/echo/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS += -w -O 
 LDLIBS += 
 
Index: ltp/testcases/network/tcp_cmds/finger/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/finger/Makefile
+++ ltp/testcases/network/tcp_cmds/finger/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/tcp_cmds/ftp/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/ftp/Makefile
+++ ltp/testcases/network/tcp_cmds/ftp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 generate:
 	../../generate.sh
 
Index: ltp/testcases/network/tcp_cmds/host/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/host/Makefile
+++ ltp/testcases/network/tcp_cmds/host/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/tcp_cmds/netstat/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/netstat/Makefile
+++ ltp/testcases/network/tcp_cmds/netstat/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/tcp_cmds/perf_lan/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/perf_lan/Makefile
+++ ltp/testcases/network/tcp_cmds/perf_lan/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS+=    -I../../../../include -Wall -w -O
 LOADLIBES+= -L../../../../lib -lltp
 LDLIBS += 
Index: ltp/testcases/network/tcp_cmds/ping/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/ping/Makefile
+++ ltp/testcases/network/tcp_cmds/ping/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/tcp_cmds/rcp/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/rcp/Makefile
+++ ltp/testcases/network/tcp_cmds/rcp/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 generate:
Index: ltp/testcases/network/tcp_cmds/rdist/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/rdist/Makefile
+++ ltp/testcases/network/tcp_cmds/rdist/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 generate:
Index: ltp/testcases/network/tcp_cmds/rlogin/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/rlogin/Makefile
+++ ltp/testcases/network/tcp_cmds/rlogin/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/tcp_cmds/rsh/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/rsh/Makefile
+++ ltp/testcases/network/tcp_cmds/rsh/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/tcp_cmds/rwho/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/rwho/Makefile
+++ ltp/testcases/network/tcp_cmds/rwho/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/tcp_cmds/sendfile/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/sendfile/Makefile
+++ ltp/testcases/network/tcp_cmds/sendfile/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 CFLAGS+=    -I../../../../include -Wall -w -O
 LOADLIBES+= -L../../../../lib -lltp
 LDLIBS +=
Index: ltp/testcases/network/tcp_cmds/ssh/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/ssh/Makefile
+++ ltp/testcases/network/tcp_cmds/ssh/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/tcp_cmds/tcpdump/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/tcpdump/Makefile
+++ ltp/testcases/network/tcp_cmds/tcpdump/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/tcp_cmds/telnet/Makefile
===================================================================
--- ltp.orig/testcases/network/tcp_cmds/telnet/Makefile
+++ ltp/testcases/network/tcp_cmds/telnet/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/traceroute/Makefile
===================================================================
--- ltp.orig/testcases/network/traceroute/Makefile
+++ ltp/testcases/network/traceroute/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all:
 
 install:
Index: ltp/testcases/network/xinetd/Makefile
===================================================================
--- ltp.orig/testcases/network/xinetd/Makefile
+++ ltp/testcases/network/xinetd/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all:
 
 install:
Index: ltp/testcases/open_hpi_testsuite/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # (C) Copyright IBM Corp 2003-2006
Index: ltp/testcases/open_hpi_testsuite/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/clients/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/clients/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/clients/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 MAINTAINERCLEANFILES = Makefile.in
 MOSTLYCLEANFILES     = @TEST_CLEAN@
 
Index: ltp/testcases/open_hpi_testsuite/clients/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/clients/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/clients/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/cpp/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/cpp/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/cpp/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #      -*- linux-c -*-
 #
 # (C) Copyright IBM Corp. 2005
Index: ltp/testcases/open_hpi_testsuite/cpp/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/cpp/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/cpp/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/cpp/t/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/cpp/t/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/cpp/t/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../t/config.mk
 # (C) Copyright IBM Corp 2005
 # All rights reserved.
 #
Index: ltp/testcases/open_hpi_testsuite/cpp/t/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/cpp/t/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/cpp/t/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../t/config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/docs/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/docs/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/docs/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # All rights reserved.
Index: ltp/testcases/open_hpi_testsuite/docs/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/docs/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/docs/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/docs/hld/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/docs/hld/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/docs/hld/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # All rights reserved.
Index: ltp/testcases/open_hpi_testsuite/docs/hld/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/docs/hld/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/docs/hld/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/docs/man/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/docs/man/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/docs/man/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copyright IBM 2005
 #
Index: ltp/testcases/open_hpi_testsuite/docs/man/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/docs/man/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/docs/man/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/hpi_shell/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/hpi_shell/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/hpi_shell/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 
 .NOTPARALLEL:
 
Index: ltp/testcases/open_hpi_testsuite/hpi_shell/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/hpi_shell/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/hpi_shell/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/marshal/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/marshal/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/marshal/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 # Copyright (c) 2004 by FORCE Computers.
 #
Index: ltp/testcases/open_hpi_testsuite/marshal/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/marshal/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/marshal/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/marshal/t/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/marshal/t/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/marshal/t/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../t/config.mk
 #
 # Copyright (c) 2004 by FORCE Computers.
 #
Index: ltp/testcases/open_hpi_testsuite/marshal/t/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/marshal/t/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/marshal/t/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../t/config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/openhpid/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/openhpid/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/openhpid/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 # Copyright (c) 2004-2006 by IBM Corporation.
 #
Index: ltp/testcases/open_hpi_testsuite/openhpid/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/openhpid/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/openhpid/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # All rights reserved.
Index: ltp/testcases/open_hpi_testsuite/plugins/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/ilo2_ribcl/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/ilo2_ribcl/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/ilo2_ribcl/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copyright (C) 2007-2008, Hewlett-Packard Development Company, LLP
 #                     All rights reserved.
Index: ltp/testcases/open_hpi_testsuite/plugins/ilo2_ribcl/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/ilo2_ribcl/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/ilo2_ribcl/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/ipmi/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/ipmi/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/ipmi/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # All rights reserved.
Index: ltp/testcases/open_hpi_testsuite/plugins/ipmi/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/ipmi/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/ipmi/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/ipmi/t/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/ipmi/t/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/ipmi/t/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../t/config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # All rights reserved.
Index: ltp/testcases/open_hpi_testsuite/plugins/ipmi/t/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/ipmi/t/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/ipmi/t/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../t/config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/ipmidirect/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/ipmidirect/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/ipmidirect/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # All rights reserved.
Index: ltp/testcases/open_hpi_testsuite/plugins/ipmidirect/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/ipmidirect/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/ipmidirect/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/ipmidirect/t/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/ipmidirect/t/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/ipmidirect/t/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../t/config.mk
 #
 # Copyright (c) 2004 by FORCE Computers
 #
Index: ltp/testcases/open_hpi_testsuite/plugins/ipmidirect/t/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/ipmidirect/t/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/ipmidirect/t/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../t/config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/oa_soap/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/oa_soap/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/oa_soap/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Copyright (C) 2007-2008, Hewlett-Packard Development Company, LLP
 #                     All rights reserved.
 #
Index: ltp/testcases/open_hpi_testsuite/plugins/oa_soap/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/oa_soap/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/oa_soap/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/rtas/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/rtas/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/rtas/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #      -*- linux-c -*-
 #
 # (C) Copyright IBM Corp. 2005
Index: ltp/testcases/open_hpi_testsuite/plugins/rtas/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/rtas/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/rtas/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/simulator/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/simulator/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/simulator/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #      -*- linux-c -*-
 #
 # (C) Copyright IBM Corp. 2005, 2006
Index: ltp/testcases/open_hpi_testsuite/plugins/simulator/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/simulator/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/simulator/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/simulator/t/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/simulator/t/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/simulator/t/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../t/config.mk
 # (C) Copyright IBM Corp 2005
 # All rights reserved.
 #
Index: ltp/testcases/open_hpi_testsuite/plugins/simulator/t/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/simulator/t/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/simulator/t/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../t/config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/snmp_bc/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/snmp_bc/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/snmp_bc/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # (C) Copyright IBM Corp 2003, 2006
 # All rights reserved.
 # 
Index: ltp/testcases/open_hpi_testsuite/plugins/snmp_bc/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/snmp_bc/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/snmp_bc/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/snmp_bc/t/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/snmp_bc/t/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/snmp_bc/t/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../t/config.mk
 # (C) Copyright IBM Corp 2003, 2006
 # All rights reserved.
 #
Index: ltp/testcases/open_hpi_testsuite/plugins/snmp_bc/t/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/snmp_bc/t/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/snmp_bc/t/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../t/config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/sysfs/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/sysfs/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/sysfs/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # All rights reserved.
Index: ltp/testcases/open_hpi_testsuite/plugins/sysfs/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/sysfs/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/sysfs/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/plugins/watchdog/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/watchdog/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/plugins/watchdog/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # All rights reserved.
Index: ltp/testcases/open_hpi_testsuite/plugins/watchdog/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/plugins/watchdog/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/plugins/watchdog/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/scripts/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/scripts/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/scripts/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # (C) Copyright IBM Corp 2003-2006
Index: ltp/testcases/open_hpi_testsuite/scripts/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/scripts/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/scripts/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/scripts/test/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/scripts/test/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/scripts/test/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # All rights reserved.
Index: ltp/testcases/open_hpi_testsuite/scripts/test/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/scripts/test/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/scripts/test/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/snmp/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/snmp/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/snmp/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # (C) Copyright IBM Corp 2003, 2004
 # All rights reserved.
 # 
Index: ltp/testcases/open_hpi_testsuite/snmp/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/snmp/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/snmp/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/src/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/src/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/src/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # (C) Copyright IBM Corp 2003-2006
Index: ltp/testcases/open_hpi_testsuite/src/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/src/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/src/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/src/t/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/src/t/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/src/t/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../t/config.mk
 # (C) Copyright IBM Corp 2003, 2004
 # All rights reserved.
 #
Index: ltp/testcases/open_hpi_testsuite/src/t/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/src/t/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/src/t/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../t/config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/src/t/ohpi/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/src/t/ohpi/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/src/t/ohpi/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # (C) Copyright IBM Corp 2004
 # All rights reserved.
 #
Index: ltp/testcases/open_hpi_testsuite/src/t/ohpi/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/src/t/ohpi/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/src/t/ohpi/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/ssl/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/ssl/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/ssl/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # (C) Copyright IBM Corp 2003, 2004
 # All rights reserved.
 # 
Index: ltp/testcases/open_hpi_testsuite/ssl/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/ssl/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/ssl/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/utils/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/utils/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 #
 # Copyright (c) 2003 Intel Corporation
 # (C) Copyright IBM Corp 2003, 2004
Index: ltp/testcases/open_hpi_testsuite/utils/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/utils/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/utils/t/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/utils/t/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../t/config.mk
 #
 # Copyright (c) 2003, Intel Corporation
 # All rights reserved.
Index: ltp/testcases/open_hpi_testsuite/utils/t/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/utils/t/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../t/config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/utils/t/ann/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/ann/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/utils/t/ann/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # (C) Copyright IBM Corp 2005
 # All rights reserved.
 #
Index: ltp/testcases/open_hpi_testsuite/utils/t/ann/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/ann/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/utils/t/ann/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/utils/t/el/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/el/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/utils/t/el/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # (C) Copyright IBM Corp 2003, 2004
 # All rights reserved.
 #
Index: ltp/testcases/open_hpi_testsuite/utils/t/el/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/el/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/utils/t/el/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/utils/t/epath/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/epath/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/utils/t/epath/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 #
 # Copyright (c) 2003, 2004 Intel Corporation
 # All rights reserved.
Index: ltp/testcases/open_hpi_testsuite/utils/t/epath/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/epath/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/utils/t/epath/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/utils/t/rpt/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/rpt/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/utils/t/rpt/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # (C) Copyright IBM Corp 2003, 2004
 # All rights reserved.
 #
Index: ltp/testcases/open_hpi_testsuite/utils/t/rpt/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/rpt/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/utils/t/rpt/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/utils/t/sahpi/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/sahpi/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/utils/t/sahpi/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # (C) Copyright IBM Corp 2004
 # All rights reserved.
 #
Index: ltp/testcases/open_hpi_testsuite/utils/t/sahpi/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/sahpi/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/utils/t/sahpi/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_hpi_testsuite/utils/t/uid/Makefile.am
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/uid/Makefile.am
+++ ltp/testcases/open_hpi_testsuite/utils/t/uid/Makefile.am
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # (C) Copyright IBM Corp 2003, 2004
 # All rights reserved.
 #
Index: ltp/testcases/open_hpi_testsuite/utils/t/uid/Makefile.in
===================================================================
--- ltp.orig/testcases/open_hpi_testsuite/utils/t/uid/Makefile.in
+++ ltp/testcases/open_hpi_testsuite/utils/t/uid/Makefile.in
@@ -1,3 +1,4 @@
+include ./../../../t/../config.mk
 # Makefile.in generated by automake 1.10.1 from Makefile.am.
 # @configure_input@
 
Index: ltp/testcases/open_posix_testsuite/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/Makefile
+++ ltp/testcases/open_posix_testsuite/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 # Copyright (c) 2002, Intel Corporation. All rights reserved.
 # Created by:  inaky.perez-gonzalez REMOVE-THIS AT intel DOT com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/functional/mqueues/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/functional/mqueues/Makefile
+++ ltp/testcases/open_posix_testsuite/functional/mqueues/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 INCLUDE = -I../../include
 LIB=-lrt -lpthread
 
Index: ltp/testcases/open_posix_testsuite/functional/semaphores/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/functional/semaphores/Makefile
+++ ltp/testcases/open_posix_testsuite/functional/semaphores/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 
 INCLUDE = -I../../include
 LIB=
Index: ltp/testcases/open_posix_testsuite/functional/threads/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/functional/threads/Makefile
+++ ltp/testcases/open_posix_testsuite/functional/threads/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 include Makefile.inc
 SUBDIRS=robust_test pi_test
 
Index: ltp/testcases/open_posix_testsuite/functional/threads/Makefile.inc
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/functional/threads/Makefile.inc
+++ ltp/testcases/open_posix_testsuite/functional/threads/Makefile.inc
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 #
 # Include this file in your Makefile for linking against the built NPTL 
 # and GLIBC
Index: ltp/testcases/open_posix_testsuite/functional/threads/pi_test/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/functional/threads/pi_test/Makefile
+++ ltp/testcases/open_posix_testsuite/functional/threads/pi_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 include ../Makefile.inc
 
 SRCS=$(wildcard *.c)
Index: ltp/testcases/open_posix_testsuite/functional/threads/robust_test/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/functional/threads/robust_test/Makefile
+++ ltp/testcases/open_posix_testsuite/functional/threads/robust_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 include ../Makefile.inc
 
 SRCS=$(wildcard *.c)
Index: ltp/testcases/open_posix_testsuite/functional/threads/schedule/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/functional/threads/schedule/Makefile
+++ ltp/testcases/open_posix_testsuite/functional/threads/schedule/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/functional/timers/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/functional/timers/Makefile
+++ ltp/testcases/open_posix_testsuite/functional/timers/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Copyright (c) 2002, Intel Corporation. All rights reserved.
 # Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/functional/timers/clocks/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/functional/timers/clocks/Makefile
+++ ltp/testcases/open_posix_testsuite/functional/timers/clocks/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2002, Intel Corporation. All rights reserved.
 # Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/functional/timers/timers/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/functional/timers/timers/Makefile
+++ ltp/testcases/open_posix_testsuite/functional/timers/timers/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2002, Intel Corporation. All rights reserved.
 # Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/mqueues/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/mqueues/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/mqueues/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 INCLUDE = -I../../include
 LIB=-lrt
 
Index: ltp/testcases/open_posix_testsuite/stress/semaphores/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/semaphores/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/semaphores/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 INCLUDE = -I../../include
 
 CFLAGS=-Wall -O2 -g
Index: ltp/testcases/open_posix_testsuite/stress/threads/fork/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/fork/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/fork/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/pthread_cancel/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/pthread_cancel/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/pthread_cancel/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/pthread_cond_timedwait/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/pthread_cond_timedwait/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/pthread_cond_timedwait/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/pthread_create/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/pthread_create/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/pthread_create/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/pthread_exit/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/pthread_exit/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/pthread_exit/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/pthread_getschedparam/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/pthread_getschedparam/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/pthread_getschedparam/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/pthread_kill/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/pthread_kill/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/pthread_kill/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/pthread_mutex_init/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/pthread_mutex_init/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/pthread_mutex_init/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/pthread_mutex_lock/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/pthread_mutex_lock/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/pthread_mutex_lock/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/pthread_mutex_trylock/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/pthread_mutex_trylock/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/pthread_mutex_trylock/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/pthread_once/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/pthread_once/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/pthread_once/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/pthread_self/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/pthread_self/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/pthread_self/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/sem_getvalue/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/sem_getvalue/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/sem_getvalue/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/sem_init/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/sem_init/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/sem_init/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/open_posix_testsuite/stress/threads/sem_open/Makefile
===================================================================
--- ltp.orig/testcases/open_posix_testsuite/stress/threads/sem_open/Makefile
+++ ltp/testcases/open_posix_testsuite/stress/threads/sem_open/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../../config.mk
 # Copyright (c) 2004, Intel Corporation. All rights reserved.
 # Created by:  adam.li@intel.com
 # This file is licensed under the GPL license.  For the full content
Index: ltp/testcases/pounder21/Makefile
===================================================================
--- ltp.orig/testcases/pounder21/Makefile
+++ ltp/testcases/pounder21/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 # Quickie makefile to (sort of) automate various pounder tasks.
 
 # Copyright (C) 2003-2006 IBM
Index: ltp/testcases/pounder21/src/cpufreq/Makefile
===================================================================
--- ltp.orig/testcases/pounder21/src/cpufreq/Makefile
+++ ltp/testcases/pounder21/src/cpufreq/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile for CPU frequency tester
 
 # Copyright (C) 2003-2006 IBM
Index: ltp/testcases/pounder21/src/mem_alloc_test/Makefile
===================================================================
--- ltp.orig/testcases/pounder21/src/mem_alloc_test/Makefile
+++ ltp/testcases/pounder21/src/mem_alloc_test/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile for OOM tester
 
 # Copyright (C) 2003-2006 IBM
Index: ltp/testcases/pounder21/src/memxfer5b/Makefile
===================================================================
--- ltp.orig/testcases/pounder21/src/memxfer5b/Makefile
+++ ltp/testcases/pounder21/src/memxfer5b/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Makefile for memory streaming benchmark
 
 # Copyright (C) 2003-2006 IBM
Index: ltp/testcases/pounder21/src/ramsnake/Makefile
===================================================================
--- ltp.orig/testcases/pounder21/src/ramsnake/Makefile
+++ ltp/testcases/pounder21/src/ramsnake/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Build shared memory stress test
 
 # Copyright (C) 2003-2006 IBM
Index: ltp/testcases/pounder21/src/randacoords/Makefile
===================================================================
--- ltp.orig/testcases/pounder21/src/randacoords/Makefile
+++ ltp/testcases/pounder21/src/randacoords/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Build program to generate random coordinates
 
 # Copyright (C) 2003-2006 IBM
Index: ltp/testcases/pounder21/src/randasyscall/Makefile
===================================================================
--- ltp.orig/testcases/pounder21/src/randasyscall/Makefile
+++ ltp/testcases/pounder21/src/randasyscall/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Build the random syscall generator
 
 # Copyright (C) 2003-2006 IBM
Index: ltp/testcases/pounder21/src/time_tests/Makefile
===================================================================
--- ltp.orig/testcases/pounder21/src/time_tests/Makefile
+++ ltp/testcases/pounder21/src/time_tests/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Build time tests
 
 # Copyright (C) 2003-2006 IBM
Index: ltp/testcases/pounder21/src/xbonkers/Makefile
===================================================================
--- ltp.orig/testcases/pounder21/src/xbonkers/Makefile
+++ ltp/testcases/pounder21/src/xbonkers/Makefile
@@ -1,3 +1,4 @@
+include ./../../../../config.mk
 # Build a program to move X windows across a screen
 
 # Copyright (C) 2003-2006 IBM
Index: ltp/tools/Makefile
===================================================================
--- ltp.orig/tools/Makefile
+++ ltp/tools/Makefile
@@ -1,3 +1,4 @@
+include ./../config.mk
 SUBDIRS = apicmds genload netpipe-2.4 netpipe-2.4-ipv6 #top-LTP
 
 CFLAGS+= -Wall -I../include
Index: ltp/tools/apicmds/Makefile
===================================================================
--- ltp.orig/tools/apicmds/Makefile
+++ ltp/tools/apicmds/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 CFLAGS+=	-D_GNU_SOURCE -I../../include
 LOADLIBES+=	-L../../lib -lltp
 
Index: ltp/tools/genload/Makefile
===================================================================
--- ltp.orig/tools/genload/Makefile
+++ ltp/tools/genload/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 CFLAGS+= -DPACKAGE=\"stress\" -DVERSION=\"0.17pre11\" 
 
 LDLIBS+= -lm
Index: ltp/tools/netpipe-2.4-ipv6/Makefile
===================================================================
--- ltp.orig/tools/netpipe-2.4-ipv6/Makefile
+++ ltp/tools/netpipe-2.4-ipv6/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 #
 # Makefile for NetPIPE
 # $Id: Makefile,v 1.6 2006/07/04 22:29:03 vapier Exp $
Index: ltp/tools/netpipe-2.4/Makefile
===================================================================
--- ltp.orig/tools/netpipe-2.4/Makefile
+++ ltp/tools/netpipe-2.4/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 #
 # Makefile for NetPIPE
 #
Index: ltp/tools/top-LTP/Makefile
===================================================================
--- ltp.orig/tools/top-LTP/Makefile
+++ ltp/tools/top-LTP/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 VERSION      := 3
 SUBVERSION   := 1
 MINORVERSION := 5
Index: ltp/utils/Makefile
===================================================================
--- ltp.orig/utils/Makefile
+++ ltp/utils/Makefile
@@ -1,3 +1,4 @@
+include ./../config.mk
 ################################################################################ 
 ####
 ## Copyright (c) International Business Machines  Corp., 2008 ##
Index: ltp/utils/benchmark/Makefile
===================================================================
--- ltp.orig/utils/benchmark/Makefile
+++ ltp/utils/benchmark/Makefile
@@ -1,3 +1,4 @@
+include ./../../config.mk
 ################################################################################
 ####
 ## Copyright (c) International Business Machines  Corp., 2008 ##
Index: ltp/utils/benchmark/ebizzy-0.3/Makefile
===================================================================
--- ltp.orig/utils/benchmark/ebizzy-0.3/Makefile
+++ ltp/utils/benchmark/ebizzy-0.3/Makefile
@@ -1,3 +1,4 @@
+include ./../../../config.mk
 all: ebizzy
 
 configure:

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
