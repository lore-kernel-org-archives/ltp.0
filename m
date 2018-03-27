From: Michael Moese <mmoese@suse.de>
Date: Tue, 27 Mar 2018 11:58:00 +0200
Subject: [LTP] [PATCH v6 0/3] Add regression test for CVE-2017-17053
In-Reply-To: <5ABA136A.8080609@cn.fujitsu.com>
References: <20180309124418.30271-1-mmoese@suse.de>
 <5AB35983.6060900@cn.fujitsu.com> <5ABA136A.8080609@cn.fujitsu.com>
Message-ID: <20180327095800.zgaz35pw2p4vz4u2@g206.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
I'm sorry, I must have missed your mail. 

The testcase cannot run if the TAINT_W flag is already set, as this
is triggered on vulnerable kernels - so if you have a already 
tainted kernel, this test cannot reliably detect if the kernel is 
safe to this CVE or not. 
Where does the warning message you get result from? Is this 
something you can fix?

Michael

On Tue, Mar 27, 2018 at 05:48:26PM +0800, Xiao Yang wrote:
> Hi，
> 
> Can anybody help me look into this issue?
> 
> Thanks,
> Xiao Yang
> 
> On 2018/03/22 15:21, Xiao Yang wrote:
> > Hi Michael,
> > 
> > Sorry to bother you.
> > 
> > tst_taint_init() always got TBROK before verifying CVE-2017-17053 on my
> > enviorment, as below:
> > -----------------------------------------------------------------
> > [root@RHEL7U5RC_Intel64 cve]# ./cve-2017-17053
> > tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
> > tst_taint.c:88: BROK: Kernel is already tainted: 512
> > ......
> > -----------------------------------------------------------------
> > 
> > On my enviorment, __ioremap_caller() displayed the warning message and
> > set /proc/sys/kernel/tainted to
> > TST_TAINT_W(512) when too high physical address wasn't handled.  Is this
> > a usual case?  should we break
> > and skip CVE-2017-17053 due to this existed TST_TAINT_W?
> > 
> > Please see the the following warning message:
> > -----------------------------------------------------------------
> > [    0.059261] ioremap: invalid physical address fffffffffff90000
> > [    0.059263] ------------[ cut here ]------------
> > [    0.059268] WARNING: CPU: 0 PID: 1 at arch/x86/mm/ioremap.c:103
> > __ioremap_caller+0x2f2/0x340
> > [    0.059269] Modules linked in:
> > [    0.059272] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> > 3.10.0-860.el7.x86_64 #1
> > [    0.059273] Hardware name: LENOVO QiTianM7150/To be filled by O.E.M.,
> > BIOS 90KT20CUS 09/14/2010
> > [    0.059275] Call Trace:
> > [    0.059281]  [<ffffffffaed0d768>] dump_stack+0x19/0x1b
> > [    0.059284]  [<ffffffffae6916d8>] __warn+0xd8/0x100
> > [    0.059286]  [<ffffffffae69181d>] warn_slowpath_null+0x1d/0x20
> > [    0.059288]  [<ffffffffae66f442>] __ioremap_caller+0x2f2/0x340
> > [    0.059290]  [<ffffffffaed0064a>] ? acpi_os_map_memory+0xfd/0x155
> > [    0.059293]  [<ffffffffae7f7606>] ? kmem_cache_alloc_trace+0x1d6/0x200
> > [    0.059295]  [<ffffffffae66f4c4>] ioremap_cache+0x14/0x20
> > [    0.059297]  [<ffffffffaed0064a>] acpi_os_map_memory+0xfd/0x155
> > [    0.059301]  [<ffffffffae9ec576>]
> > acpi_ex_system_memory_space_handler+0xdd/0x1ca
> > [    0.059304]  [<ffffffffae9e5fa3>]
> > acpi_ev_address_space_dispatch+0x1c5/0x231
> > [    0.059306]  [<ffffffffae9e963a>] acpi_ex_access_region+0x20e/0x2a2
> > [    0.059309]  [<ffffffffae9cf86d>] ? acpi_os_release_lock+0xe/0x10
> > [    0.059312]  [<ffffffffae9fae9c>] ?
> > acpi_ut_update_ref_count+0x99/0x2bf
> > [    0.059314]  [<ffffffffae9e99f5>] acpi_ex_field_datum_io+0x105/0x196
> > [    0.059316]  [<ffffffffae9e9c0e>]
> > acpi_ex_extract_from_field+0x98/0x228
> > [    0.059318]  [<ffffffffae9fca3a>] ?
> > acpi_ut_create_internal_object_dbg+0x23/0x8a
> > [    0.059321]  [<ffffffffae9e91bd>]
> > acpi_ex_read_data_from_field+0x13c/0x178
> > [    0.059323]  [<ffffffffae9ec8fc>]
> > acpi_ex_resolve_node_to_value+0x1a3/0x245
> > [    0.059325]  [<ffffffffae9ecbbb>] acpi_ex_resolve_to_value+0x21d/0x23a
> > [    0.059327]  [<ffffffffae9e26c3>]
> > acpi_ds_evaluate_name_path+0x8d/0x11b
> > [    0.059329]  [<ffffffffae9e2aaa>] acpi_ds_exec_end_op+0x98/0x3f3
> > [    0.059332]  [<ffffffffae9f4fb8>] acpi_ps_parse_loop+0x526/0x583
> > [    0.059335]  [<ffffffffae9fd618>] ?
> > acpi_ut_create_generic_state+0x37/0x54
> > [    0.059337]  [<ffffffffae9f5ac0>] acpi_ps_parse_aml+0x98/0x289
> > [    0.059339]  [<ffffffffae9f6313>] acpi_ps_execute_method+0x1c7/0x272
> > [    0.059341]  [<ffffffffae9f0a40>] acpi_ns_evaluate+0x1c1/0x258
> > [    0.059343]  [<ffffffffae9f3387>] acpi_evaluate_object+0x135/0x252
> > [    0.059346]  [<ffffffffae9cfc7e>] acpi_evaluate_integer+0x52/0x84
> > [    0.059348]  [<ffffffffae9cf811>] ? acpi_os_signal_semaphore+0x21/0x2d
> > [    0.059350]  [<ffffffffae9d3818>] acpi_bus_get_status_handle+0x1e/0x39
> > [    0.059353]  [<ffffffffae9d5d1b>] acpi_bus_check_add+0x81/0x1c2
> > [    0.059355]  [<ffffffffae6c0d02>] ? up+0x32/0x50
> > [    0.059358]  [<ffffffffae9f316c>] acpi_ns_walk_namespace+0xcb/0x184
> > [    0.059360]  [<ffffffffae9d5c9a>] ? acpi_add_single_object+0x4f9/0x4f9
> > [    0.059362]  [<ffffffffae9d5c9a>] ? acpi_add_single_object+0x4f9/0x4f9
> > [    0.059364]  [<ffffffffae9f36a2>] acpi_walk_namespace+0x95/0xc5
> > [    0.059367]  [<ffffffffaf3b722b>] ? acpi_sleep_proc_init+0x2a/0x2a
> > [    0.059369]  [<ffffffffae9d60dd>] acpi_bus_scan+0x5c/0x90
> > [    0.059371]  [<ffffffffaf3b76b1>] acpi_scan_init+0x89/0x1d8
> > [    0.059373]  [<ffffffffaf3b74ce>] acpi_init+0x2a3/0x2bd
> > [    0.059376]  [<ffffffffae60210a>] do_one_initcall+0xba/0x240
> > [    0.059379]  [<ffffffffaf36c362>] kernel_init_freeable+0x180/0x21f
> > [    0.059381]  [<ffffffffaf36bb1f>] ? initcall_blacklist+0xb0/0xb0
> > [    0.059383]  [<ffffffffaecfc6b0>] ? rest_init+0x80/0x80
> > [    0.059385]  [<ffffffffaecfc6be>] kernel_init+0xe/0xf0
> > [    0.059388]  [<ffffffffaed1f637>] ret_from_fork_nospec_begin+0x21/0x21
> > [    0.059390]  [<ffffffffaecfc6b0>] ? rest_init+0x80/0x80
> > [    0.059393] ---[ end trace a7b32a0fce036eb7 ]---
> > -----------------------------------------------------------------
> > 
> > Please let me know if more information is needed, thanks.
> > 
> > Thanks,
> > Xiao Yang
> > On 2018/03/09 20:44, Michael Moese wrote:
> > 
> > > Add a regression test for CVE-2017-17053. This testcase is depending
> > > on some new library functions included in this series.
> > > 
> > > This patch series consists of reworked patches according to previous
> > > review comments, as well as a small new library wrapper function
> > > SAFE_SIGACTION() to install a signal handler.
> > > 
> > > Michael Moese (3):
> > >    Add library support for /proc/sys/kernel/tainted
> > >    Add a library wrapper for sigaction()
> > >    Add regression test for CVE-2017-17053
> > > 
> > >   doc/test-writing-guidelines.txt |  42 ++++++++++
> > >   include/tst_safe_macros.h       |  20 +++++
> > >   include/tst_taint.h             | 104 +++++++++++++++++++++++++
> > >   lib/tst_taint.c                 | 106 +++++++++++++++++++++++++
> > >   runtest/cve                     |   1 +
> > >   testcases/cve/.gitignore        |   1 +
> > >   testcases/cve/Makefile          |   2 +
> > >   testcases/cve/cve-2017-17053.c  | 166
> > > ++++++++++++++++++++++++++++++++++++++++
> > >   8 files changed, 442 insertions(+)
> > >   create mode 100644 include/tst_taint.h
> > >   create mode 100644 lib/tst_taint.c
> > >   create mode 100644 testcases/cve/cve-2017-17053.c
> > > 
> > 
> > 
> > 
> > 
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
