From: CKI Project <cki-project@redhat.com>
Date: Mon, 11 Nov 2019 19:57:56 -0000
Subject: [LTP] =?utf-8?b?4p2MIEZBSUw6IFN0YWJsZSBxdWV1ZTogcXVldWUtNS4z?=
Message-ID: <cki.4669B22B29.JOCN4MGVFE@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello,

We ran automated tests on a patchset that was proposed for merging into this
kernel tree. The patches were applied to:

       Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
            Commit: 81584694bb70 - Linux 5.3.10

The results of these automated tests are provided below.

    Overall result: FAILED (see details below)
             Merge: OK
           Compile: OK
             Tests: FAILED

All kernel binaries, config files, and logs are available for download here:

  https://artifacts.cki-project.org/pipelines/278526

One or more kernel tests failed:

    ppc64le:
     ? selinux-policy: serge-testsuite

    aarch64:
     ? selinux-policy: serge-testsuite

    x86_64:
     ? selinux-policy: serge-testsuite
     ? LTP lite

We hope that these logs can help you find the problem quickly. For the full
detail on our testing procedures, please scroll to the bottom of this message.

Please reply to this email if you have any questions about the tests that we
ran or if you have any suggestions on how to make future tests more effective.

        ,-.   ,-.
       ( C ) ( K )  Continuous
        `-',-.`-'   Kernel
          ( I )     Integration
           `-'
______________________________________________________________________________

Merge testing
-------------

We cloned this repository and checked out the following commit:

  Repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
  Commit: 81584694bb70 - Linux 5.3.10


We grabbed the 0e626424553f commit of the stable queue repository.

We then merged the patchset with `git am`:

  bonding-fix-state-transition-issue-in-link-monitoring.patch
  cdc-ncm-handle-incomplete-transfer-of-mtu.patch
  ipv4-fix-table-id-reference-in-fib_sync_down_addr.patch
  net-ethernet-octeon_mgmt-account-for-second-possible-vlan-header.patch
  net-fix-data-race-in-neigh_event_send.patch
  net-qualcomm-rmnet-fix-potential-uaf-when-unregistering.patch
  net-tls-fix-sk_msg-trim-on-fallback-to-copy-mode.patch
  net-usb-qmi_wwan-add-support-for-dw5821e-with-esim-support.patch
  nfc-fdp-fix-incorrect-free-object.patch
  nfc-netlink-fix-double-device-reference-drop.patch
  nfc-st21nfca-fix-double-free.patch
  qede-fix-null-pointer-deref-in-__qede_remove.patch
  net-mscc-ocelot-don-t-handle-netdev-events-for-other-netdevs.patch
  net-mscc-ocelot-fix-null-pointer-on-lag-slave-removal.patch
  net-tls-don-t-pay-attention-to-sk_write_pending-when-pushing-partial-records.patch
  net-tls-add-a-tx-lock.patch
  selftests-tls-add-test-for-concurrent-recv-and-send.patch
  ipv6-fixes-rt6_probe-and-fib6_nh-last_probe-init.patch
  net-hns-fix-the-stray-netpoll-locks-causing-deadlock-in-napi-path.patch
  net-prevent-load-store-tearing-on-sk-sk_stamp.patch
  net-sched-prevent-duplicate-flower-rules-from-tcf_proto-destroy-race.patch
  net-smc-fix-ethernet-interface-refcounting.patch
  vsock-virtio-fix-sock-refcnt-holding-during-the-shutdown.patch
  r8169-fix-page-read-in-r8168g_mdio_read.patch
  alsa-timer-fix-incorrectly-assigned-timer-instance.patch
  alsa-bebob-fix-to-detect-configured-source-of-sampling-clock-for-focusrite-saffire-pro-i-o-series.patch
  alsa-hda-ca0132-fix-possible-workqueue-stall.patch
  mm-memcontrol-fix-null-ptr-deref-in-percpu-stats-flush.patch
  mm-memcontrol-fix-network-errors-from-failing-__gfp_atomic-charges.patch
  mm-meminit-recalculate-pcpu-batch-and-high-limits-after-init-completes.patch
  mm-thp-handle-page-cache-thp-correctly-in-pagetranscompoundmap.patch
  mm-vmstat-hide-proc-pagetypeinfo-from-normal-users.patch
  dump_stack-avoid-the-livelock-of-the-dump_lock.patch
  mm-slab-make-page_cgroup_ino-to-recognize-non-compound-slab-pages-properly.patch
  btrfs-consider-system-chunk-array-size-for-new-system-chunks.patch
  btrfs-tree-checker-fix-wrong-check-on-max-devid.patch
  btrfs-save-i_size-to-avoid-double-evaluation-of-i_size_read-in-compress_file_range.patch
  tools-gpio-use-building_out_of_srctree-to-determine-srctree.patch
  pinctrl-intel-avoid-potential-glitches-if-pin-is-in-gpio-mode.patch
  perf-tools-fix-time-sorting.patch
  perf-map-use-zalloc-for-map_groups.patch
  drm-radeon-fix-si_enable_smc_cac-failed-issue.patch
  hid-wacom-generic-treat-serial-number-and-related-fields-as-unsigned.patch
  mm-khugepaged-fix-might_sleep-warn-with-config_highpte-y.patch
  soundwire-depend-on-acpi.patch
  soundwire-depend-on-acpi-of.patch
  soundwire-bus-set-initial-value-to-port_status.patch
  blkcg-make-blkcg_print_stat-print-stats-only-for-online-blkgs.patch
  arm64-do-not-mask-out-pte_rdonly-in-pte_same.patch
  asoc-rsnd-dma-fix-ssi9-4-5-6-7-busif-dma-address.patch
  ceph-fix-use-after-free-in-__ceph_remove_cap.patch
  ceph-fix-rcu-case-handling-in-ceph_d_revalidate.patch
  ceph-add-missing-check-in-d_revalidate-snapdir-handling.patch
  ceph-don-t-try-to-handle-hashed-dentries-in-non-o_creat-atomic_open.patch
  ceph-don-t-allow-copy_file_range-when-stripe_count-1.patch
  iio-adc-stm32-adc-fix-stopping-dma.patch
  iio-imu-adis16480-make-sure-provided-frequency-is-positive.patch
  iio-imu-inv_mpu6050-fix-no-data-on-mpu6050.patch
  iio-srf04-fix-wrong-limitation-in-distance-measuring.patch
  arm-sunxi-fix-cpu-powerdown-on-a83t.patch
  arm-dts-imx6-logicpd-re-enable-snvs-power-key.patch
  cpufreq-intel_pstate-fix-invalid-epb-setting.patch
  clone3-validate-stack-arguments.patch
  netfilter-nf_tables-align-nft_expr-private-data-to-64-bit.patch
  netfilter-ipset-fix-an-error-code-in-ip_set_sockfn_get.patch
  intel_th-gth-fix-the-window-switching-sequence.patch
  intel_th-pci-add-comet-lake-pch-support.patch
  intel_th-pci-add-jasper-lake-pch-support.patch
  x86-dumpstack-64-don-t-evaluate-exception-stacks-before-setup.patch
  x86-apic-32-avoid-bogus-ldr-warnings.patch
  smb3-fix-persistent-handles-reconnect.patch
  can-usb_8dev-fix-use-after-free-on-disconnect.patch
  can-flexcan-disable-completely-the-ecc-mechanism.patch
  can-c_can-c_can_poll-only-read-status-register-after-status-irq.patch
  can-peak_usb-fix-a-potential-out-of-sync-while-decoding-packets.patch
  can-rx-offload-can_rx_offload_queue_sorted-fix-error-handling-avoid-skb-mem-leak.patch
  can-gs_usb-gs_can_open-prevent-memory-leak.patch
  can-dev-add-missing-of_node_put-after-calling-of_get_child_by_name.patch
  can-mcba_usb-fix-use-after-free-on-disconnect.patch
  can-peak_usb-fix-slab-info-leak.patch
  configfs-fix-a-deadlock-in-configfs_symlink.patch
  alsa-usb-audio-more-validations-of-descriptor-units.patch
  alsa-usb-audio-simplify-parse_audio_unit.patch
  alsa-usb-audio-unify-the-release-of-usb_mixer_elem_info-objects.patch
  alsa-usb-audio-remove-superfluous-blength-checks.patch
  alsa-usb-audio-clean-up-check_input_term.patch
  alsa-usb-audio-fix-possible-null-dereference-at-create_yamaha_midi_quirk.patch
  alsa-usb-audio-remove-some-dead-code.patch
  alsa-usb-audio-fix-copy-paste-error-in-the-validator.patch
  usbip-implement-sg-support-to-vhci-hcd-and-stub-driver.patch

Compile testing
---------------

We compiled the kernel for 3 architectures:

    aarch64:
      make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg

    ppc64le:
      make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg

    x86_64:
      make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg


Hardware testing
----------------
We booted each kernel and ran the following tests:

  aarch64:
    Host 1:
       ? Boot test
       ? Podman system integration test (as root)
       ? Podman system integration test (as user)
       ? LTP lite
       ? Loopdev Sanity
       ? jvm test suite
       ? AMTU (Abstract Machine Test Utility)
       ? LTP: openposix test suite
       ? Ethernet drivers sanity
       ? Networking socket: fuzz
       ? Networking route: pmtu
       ? Networking route_func: local
       ? Networking route_func: forward
       ? audit: audit testsuite test
       ? httpd: mod_ssl smoke sanity
       ? iotop: sanity
       ? tuned: tune-processes-through-perf
       ? ALSA PCM loopback test
       ? ALSA Control (mixer) Userspace Element test
       ? Usex - version 1.9-29
       ? ? CIFS Connectathon
       ? ? POSIX pjd-fstest suites

    Host 2:
       ? Boot test
       ? selinux-policy: serge-testsuite
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? ? Storage blktests

  ppc64le:
    Host 1:
       ? Boot test
       ? selinux-policy: serge-testsuite
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? ? Storage blktests

    Host 2:
       ? Boot test
       ? Podman system integration test (as root)
       ? Podman system integration test (as user)
       ? LTP lite
       ? Loopdev Sanity
       ? jvm test suite
       ? AMTU (Abstract Machine Test Utility)
       ? LTP: openposix test suite
       ? Ethernet drivers sanity
       ? Networking socket: fuzz
       ? Networking route: pmtu
       ? Networking route_func: local
       ? Networking route_func: forward
       ? audit: audit testsuite test
       ? httpd: mod_ssl smoke sanity
       ? iotop: sanity
       ? tuned: tune-processes-through-perf
       ? ALSA PCM loopback test
       ? ALSA Control (mixer) Userspace Element test
       ? Usex - version 1.9-29
       ? ? CIFS Connectathon
       ? ? POSIX pjd-fstest suites

  x86_64:
    Host 1:
       ? Boot test
       ? selinux-policy: serge-testsuite
       ? lvm thinp sanity
       ? storage: software RAID testing
       ? ? Storage blktests

    Host 2:
       ? Boot test
       ? Podman system integration test (as root)
       ? Podman system integration test (as user)
       ? LTP lite
       ? Loopdev Sanity
       ? jvm test suite
       ? AMTU (Abstract Machine Test Utility)
       ? LTP: openposix test suite
       ? Ethernet drivers sanity
       ? Networking socket: fuzz
       ? Networking route: pmtu
       ? Networking route_func: local
       ? Networking route_func: forward
       ? audit: audit testsuite test
       ? httpd: mod_ssl smoke sanity
       ? iotop: sanity
       ? tuned: tune-processes-through-perf
       ? pciutils: sanity smoke test
       ? ALSA PCM loopback test
       ? ALSA Control (mixer) Userspace Element test
       ? Usex - version 1.9-29
       ? stress: stress-ng
       ? ? CIFS Connectathon
       ? ? POSIX pjd-fstest suites

  Test sources: https://github.com/CKI-project/tests-beaker
    ? Pull requests are welcome for new tests or improvements to existing tests!

Waived tests
------------
If the test run included waived tests, they are marked with ?. Such tests are
executed but their results are not taken into account. Tests are waived when
their results are not reliable enough, e.g. when they're just introduced or are
being fixed.

Testing timeout
---------------
We aim to provide a report within reasonable timeframe. Tests that haven't
finished running are marked with ?. Reports for non-upstream kernels have
a Beaker recipe linked to next to each host.

