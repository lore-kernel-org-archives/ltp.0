From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 1 Mar 2021 16:51:06 +0100
Subject: [LTP] NFS tests failure: RPC: Couldn't create auth handle (flavor
 390004)
Message-ID: <YD0NapQGu/HEi5HK@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

I'm looking to some NFS failures on recent openSUSE kernel 5.11.

"RPC:       Couldn't create auth handle (flavor 390004)" error has something to
do with krb5i, but module rpcsec_gss_krb5 is loaded.

Any idea what could cause "nfs41_sequence_process: Error 0 free the slot"
and "NFS reply lookup: -2"?

Kind regards,
Petr

[35133.723728] nfsd_inet6addr_event: removed fd00:0001:0001:0001:0000:0000:0000:0002
[35133.723783] nfsd_inet6addr_event: removed fe80:0000:0000:0000:04c0:ffff:fecb:0122
[35133.741177] nfsd_inetaddr_event: removed 10.0.0.2
[35133.745023] IPv6: ADDRCONF(NETDEV_CHANGE): ltp_ns_veth2: link becomes ready
[35134.023324] NFS:   parsing nfs mount option 'source'
[35134.023329] NFS:   parsing nfs mount option 'proto'
[35134.023330] NFS:   parsing nfs mount option 'vers'
[35134.023332] NFS:   parsing nfs mount option 'addr'
[35134.023334] NFS:   parsing nfs mount option 'clientaddr'
[35134.023336] NFS: MNTPATH: '/tmp/LTP_nfs01.Npv7p6ePHT/4.1/tcp'
[35134.023338] --> nfs4_try_get_tree()
[35134.023346] NFS: get client cookie (0x000000003f4944e9/0x00000000c67386ff)
[35134.023380] RPC:       Couldn't create auth handle (flavor 390004)
[35134.023392] nfs_create_rpc_client: cannot create RPC client. Error = -22
[35134.023826] nfs_callback_create_svc: service created
[35134.023827] NFS: create per-net callback data; net=f0000358
[35134.023919] nfs_callback_up: service started
[35134.023920] NFS: nfs4_discover_server_trunking: testing '10.0.0.2'
[35134.023967] nfsd4_exchange_id rqstp=00000000b0a905ff exid=00000000c41af45a clname.len=22 clname.data=000000004be94038 ip_addr=10.0.0.1 flags 101, spa_how 0
[35134.023981] nfsd4_exchange_id seqid 0 flags 20001
[35134.024131] nfsd4_exchange_id rqstp=00000000b0a905ff exid=00000000c41af45a clname.len=22 clname.data=000000004be94038 ip_addr=10.0.0.1 flags 101, spa_how 0
[35134.024150] nfsd4_exchange_id seqid 0 flags 20001
[35134.024271] --> nfs4_proc_create_session clp=000000003f4944e9 session=000000008231b4d6
[35134.024277] nfs4_init_channel_attrs: Fore Channel : max_rqst_sz=1049620 max_resp_sz=1049480 max_ops=8 max_reqs=64
[35134.024281] nfs4_init_channel_attrs: Back Channel : max_rqst_sz=4096 max_resp_sz=4096 max_resp_sz_cached=0 max_ops=2 max_reqs=16
[35134.024334] check_slot_seqid enter. seqid 1 slot_seqid 0
[35134.024337] NFSD: move_to_confirm nfs4_client 0000000005ccbb59
[35134.024462] --> nfs4_setup_session_slot_tables
[35134.024464] --> nfs4_realloc_slot_table: max_reqs=30, tbl->max_slots 0
[35134.024469] nfs4_realloc_slot_table: tbl=0000000054cdc1a8 slots=00000000b96721b4 max_slots=30
[35134.024471] <-- nfs4_realloc_slot_table: return 0
[35134.024473] --> nfs4_realloc_slot_table: max_reqs=16, tbl->max_slots 0
[35134.024476] nfs4_realloc_slot_table: tbl=00000000a895ddf2 slots=0000000031ce2890 max_slots=16
[35134.024478] <-- nfs4_realloc_slot_table: return 0
[35134.024479] slot table setup returned 0
[35134.024480] nfs4_proc_create_session client>seqid 2 sessionid 1614612109:2516949716:5:0
[35134.024482] <-- nfs4_proc_create_session
[35134.024483] nfs4_schedule_state_renewal: requeueing work. Lease period = 5
[35134.024489] --> nfs41_proc_reclaim_complete
[35134.024491] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=30
[35134.024492] NFS: nfs4_discover_server_trunking: status = 0
[35134.024493] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.024497] encode_sequence: sessionid=1614612109:2516949716:5:0 seqid=1 slotid=0 max_slotid=0 cache_this=0
[35134.024510] --> _nfs41_proc_secinfo_no_name
[35134.024512] --> nfs41_call_sync_prepare data->seq_server 00000000faf52af4
[35134.024535] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.024539] nfsd4_sequence: slotid 0
[35134.024540] check_slot_seqid enter. seqid 1 slot_seqid 0
[35134.024544] alloc_cld_upcall: allocated xid 5
[35134.046004] --> nfsd4_store_cache_entry slot 000000008e086c0f
[35134.046096] --> nfs4_reclaim_complete_done
[35134.046104] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.046109] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.046112] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.046115] nfs41_sequence_process: Error 0 free the slot
[35134.046117] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.046120] <-- nfs4_reclaim_complete_done
[35134.046127] <-- nfs41_proc_reclaim_complete status=0
[35134.046130] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=16
[35134.046133] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.046136] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.046138] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=30
[35134.046141] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.046148] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.046151] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.046153] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.046153] --> nfs41_call_sync_prepare data->seq_server 00000000faf52af4
[35134.046162] encode_sequence: sessionid=1614612109:2516949716:5:0 seqid=2 slotid=0 max_slotid=0 cache_this=0
[35134.046247] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.046251] nfsd4_sequence: slotid 0
[35134.046253] check_slot_seqid enter. seqid 2 slot_seqid 1
[35134.046258] nfsd: fh_compose(exp fe:01/2 /, ino=2)
[35134.046264] --> nfsd4_store_cache_entry slot 000000008e086c0f
[35134.046373] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.046378] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.046380] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.046382] nfs41_sequence_process: Error 0 free the slot
[35134.046384] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.046389] <-- _nfs41_proc_secinfo_no_name status=0
[35134.058969] --> nfs41_call_sync_prepare data->seq_server 00000000faf52af4
[35134.058975] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=30
[35134.058981] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.058989] encode_sequence: sessionid=1614612109:2516949716:5:0 seqid=3 slotid=0 max_slotid=0 cache_this=0
[35134.059137] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.059142] nfsd4_sequence: slotid 0
[35134.059144] check_slot_seqid enter. seqid 3 slot_seqid 2
[35134.059149] nfsd: fh_compose(exp fe:01/2 /, ino=2)
[35134.059155] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.059162] --> nfsd4_store_cache_entry slot 000000008e086c0f
[35134.059254] decode_attr_type: type=040000
[35134.059258] decode_attr_change: change attribute=6934706255420194816
[35134.059260] decode_attr_size: file size=4096
[35134.059262] decode_attr_fsid: fsid=(0x0/0x0)
[35134.059265] decode_attr_fileid: fileid=2
[35134.059267] decode_attr_fs_locations: fs_locations done, error = 0
[35134.059269] decode_attr_mode: file mode=0755
[35134.059271] decode_attr_nlink: nlink=23
[35134.059273] decode_attr_owner: uid=0
[35134.059275] decode_attr_group: gid=0
[35134.059276] decode_attr_rdev: rdev=(0x0:0x0)
[35134.059278] decode_attr_space_used: space used=4096
[35134.059279] decode_attr_time_access: atime=1614577167
[35134.059281] decode_attr_time_metadata: ctime=1606120833
[35134.059284] decode_attr_time_modify: mtime=1606120833
[35134.059285] decode_attr_mounted_on_fileid: fileid=1
[35134.059287] decode_getfattr_attrs: xdr returned 0
[35134.059289] decode_getfattr_generic: xdr returned 0
[35134.059293] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.059296] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.059299] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.059300] nfs41_sequence_process: Error 0 free the slot
[35134.059303] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.059311] --> nfs41_call_sync_prepare data->seq_server 00000000faf52af4
[35134.059314] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=30
[35134.059317] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.059322] encode_sequence: sessionid=1614612109:2516949716:5:0 seqid=4 slotid=0 max_slotid=0 cache_this=0
[35134.059439] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.059444] nfsd4_sequence: slotid 0
[35134.059445] check_slot_seqid enter. seqid 4 slot_seqid 3
[35134.059450] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.059455] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.059459] --> nfsd4_store_cache_entry slot 000000008e086c0f
[35134.059620] decode_attr_supported: bitmask=fdffbfff:40f9be3e:00000803
[35134.059643] decode_attr_fh_expire_type: expire type=0x0
[35134.059645] decode_attr_link_support: link support=true
[35134.059646] decode_attr_symlink_support: symlink support=true
[35134.059648] decode_attr_aclsupport: ACLs supported=3
[35134.059649] decode_attr_exclcreat_supported: bitmask=00001010:00000032:00000000
[35134.059651] decode_server_caps: xdr returned 0!
[35134.059654] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.059657] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.059659] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.059660] nfs41_sequence_process: Error 0 free the slot
[35134.059662] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.059668] --> nfs41_call_sync_prepare data->seq_server 00000000faf52af4
[35134.059671] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=30
[35134.059672] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.059677] encode_sequence: sessionid=1614612109:2516949716:5:0 seqid=5 slotid=0 max_slotid=0 cache_this=0
[35134.059800] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.059804] nfsd4_sequence: slotid 0
[35134.059806] check_slot_seqid enter. seqid 5 slot_seqid 4
[35134.059810] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.059816] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.059820] --> nfsd4_store_cache_entry slot 000000008e086c0f
[35134.059932] decode_attr_lease_time: lease time=90
[35134.059936] decode_attr_maxfilesize: maxfilesize=17592186040320
[35134.059938] decode_attr_maxread: maxread=1048576
[35134.059939] decode_attr_maxwrite: maxwrite=1048576
[35134.059941] decode_attr_time_delta: time_delta=0 4000000
[35134.059942] decode_attr_pnfstype: bitmap is 40000000
[35134.059944] decode_attr_layout_blksize: bitmap is 2
[35134.059945] decode_attr_clone_blksize: bitmap is 0
[35134.059946] decode_attr_xattrsupport: XATTR support=false
[35134.059947] decode_fsinfo: xdr returned 0!
[35134.059950] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.059952] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.059954] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.059955] nfs41_sequence_process: Error 0 free the slot
[35134.059957] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.059964] Server FSID: 0:0
[35134.059967] Pseudo-fs root FH@0000000032a8b38c is 8 bytes, crc: 0x62d40c52:
[35134.059970]  01000100 00000000
[35134.059973] --> nfs41_call_sync_prepare data->seq_server 00000000faf52af4
[35134.059975] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=30
[35134.059977] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.059981] encode_sequence: sessionid=1614612109:2516949716:5:0 seqid=6 slotid=0 max_slotid=0 cache_this=0
[35134.060025] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.060028] nfsd4_sequence: slotid 0
[35134.060029] check_slot_seqid enter. seqid 6 slot_seqid 5
[35134.060032] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.060036] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.060039] --> nfsd4_store_cache_entry slot 000000008e086c0f
[35134.060146] decode_attr_supported: bitmask=fdffbfff:40f9be3e:00000803
[35134.060151] decode_attr_fh_expire_type: expire type=0x0
[35134.060152] decode_attr_link_support: link support=true
[35134.060154] decode_attr_symlink_support: symlink support=true
[35134.060155] decode_attr_aclsupport: ACLs supported=3
[35134.060156] decode_attr_exclcreat_supported: bitmask=00001010:00000032:00000000
[35134.060158] decode_server_caps: xdr returned 0!
[35134.060161] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.060163] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.060165] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.060167] nfs41_sequence_process: Error 0 free the slot
[35134.060168] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.060175] --> nfs41_call_sync_prepare data->seq_server 00000000faf52af4
[35134.060177] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=30
[35134.060179] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.060183] encode_sequence: sessionid=1614612109:2516949716:5:0 seqid=7 slotid=0 max_slotid=0 cache_this=0
[35134.060267] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.060272] nfsd4_sequence: slotid 0
[35134.060274] check_slot_seqid enter. seqid 7 slot_seqid 6
[35134.060278] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.060284] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.060288] --> nfsd4_store_cache_entry slot 000000008e086c0f
[35134.060449] decode_attr_lease_time: lease time=90
[35134.060468] decode_attr_maxfilesize: maxfilesize=17592186040320
[35134.060470] decode_attr_maxread: maxread=1048576
[35134.060471] decode_attr_maxwrite: maxwrite=1048576
[35134.060472] decode_attr_time_delta: time_delta=0 4000000
[35134.060474] decode_attr_pnfstype: bitmap is 40000000
[35134.060476] decode_attr_layout_blksize: bitmap is 2
[35134.060477] decode_attr_clone_blksize: bitmap is 0
[35134.060478] decode_attr_xattrsupport: XATTR support=false
[35134.060479] decode_fsinfo: xdr returned 0!
[35134.060481] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.060483] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.060485] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.060487] nfs41_sequence_process: Error 0 free the slot
[35134.060488] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.060494] set_pnfs_layoutdriver: Using NFSv4 I/O
[35134.060497] --> nfs41_call_sync_prepare data->seq_server 00000000faf52af4
[35134.060499] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=30
[35134.060501] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.060505] encode_sequence: sessionid=1614612109:2516949716:5:0 seqid=8 slotid=0 max_slotid=0 cache_this=0
[35134.060604] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.060608] nfsd4_sequence: slotid 0
[35134.060609] check_slot_seqid enter. seqid 8 slot_seqid 7
[35134.060613] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.060617] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.060621] --> nfsd4_store_cache_entry slot 000000008e086c0f
[35134.060727] decode_attr_maxlink: maxlink=255
[35134.060730] decode_attr_maxname: maxname=255
[35134.060731] decode_pathconf: xdr returned 0!
[35134.060734] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.060736] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.060739] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.060740] nfs41_sequence_process: Error 0 free the slot
[35134.060741] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.060752] NFS:   parsing nfs mount option 'source'
[35134.060755] NFS: MNTPATH: '/'
[35134.060851] --> nfs41_call_sync_prepare data->seq_server 00000000faf52af4
[35134.060855] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=30
[35134.060858] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.060864] encode_sequence: sessionid=1614612109:2516949716:5:0 seqid=9 slotid=0 max_slotid=0 cache_this=0
[35134.060914] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.060918] nfsd4_sequence: slotid 0
[35134.060919] check_slot_seqid enter. seqid 9 slot_seqid 8
[35134.060922] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.060927] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.060929] --> nfsd4_store_cache_entry slot 000000008e086c0f
[35134.060980] decode_attr_supported: bitmask=fdffbfff:40f9be3e:00000803
[35134.060985] decode_attr_fh_expire_type: expire type=0x0
[35134.060986] decode_attr_link_support: link support=true
[35134.060989] decode_attr_symlink_support: symlink support=true
[35134.060990] decode_attr_aclsupport: ACLs supported=3
[35134.060992] decode_attr_exclcreat_supported: bitmask=00001010:00000032:00000000
[35134.060995] decode_server_caps: xdr returned 0!
[35134.060998] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.061001] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.061003] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.061005] nfs41_sequence_process: Error 0 free the slot
[35134.061007] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.061015] --> nfs41_call_sync_prepare data->seq_server 00000000faf52af4
[35134.061017] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=30
[35134.061020] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.061027] encode_sequence: sessionid=1614612109:2516949716:5:0 seqid=10 slotid=0 max_slotid=0 cache_this=0
[35134.061116] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.061122] nfsd4_sequence: slotid 0
[35134.061124] check_slot_seqid enter. seqid 10 slot_seqid 9
[35134.061128] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.061134] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.061140] --> nfsd4_store_cache_entry slot 000000008e086c0f
[35134.061220] decode_attr_type: type=040000
[35134.061223] decode_attr_change: change attribute=6934706255420194816
[35134.061225] decode_attr_size: file size=4096
[35134.061227] decode_attr_fsid: fsid=(0x0/0x0)
[35134.061229] decode_attr_fileid: fileid=2
[35134.061231] decode_attr_fs_locations: fs_locations done, error = 0
[35134.061233] decode_attr_mode: file mode=0755
[35134.061235] decode_attr_nlink: nlink=23
[35134.061237] decode_attr_owner: uid=0
[35134.061239] decode_attr_group: gid=0
[35134.061241] decode_attr_rdev: rdev=(0x0:0x0)
[35134.061243] decode_attr_space_used: space used=4096
[35134.061245] decode_attr_time_access: atime=1614577167
[35134.061247] decode_attr_time_metadata: ctime=1606120833
[35134.061249] decode_attr_time_modify: mtime=1606120833
[35134.061250] decode_attr_mounted_on_fileid: fileid=1
[35134.061252] decode_getfattr_attrs: xdr returned 0
[35134.061254] decode_getfattr_generic: xdr returned 0
[35134.061256] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.061259] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.061261] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.061264] nfs41_sequence_process: Error 0 free the slot
[35134.061266] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.061275] NFS: nfs_fhget(0:82/2 fh_crc=0x62d40c52 ct=1)
[35134.061294] NFS: permission(0:82/2), mask=0x81, res=-10
[35134.061300] --> nfs41_call_sync_prepare data->seq_server 00000000faf52af4
[35134.061303] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=30
[35134.061305] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.061310] encode_sequence: sessionid=1614612109:2516949716:5:0 seqid=11 slotid=0 max_slotid=0 cache_this=0
[35134.061396] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.061402] nfsd4_sequence: slotid 0
[35134.061404] check_slot_seqid enter. seqid 11 slot_seqid 10
[35134.061408] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.061414] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.061418] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.061421] --> nfsd4_store_cache_entry slot 000000008e086c0f
[35134.061503] decode_attr_type: type=00
[35134.061505] decode_attr_change: change attribute=6934706255420194816
[35134.061507] decode_attr_size: file size=4096
[35134.061508] decode_attr_fsid: fsid=(0x0/0x0)
[35134.061510] decode_attr_fileid: fileid=0
[35134.061512] decode_attr_fs_locations: fs_locations done, error = 0
[35134.061514] decode_attr_mode: file mode=00
[35134.061515] decode_attr_nlink: nlink=1
[35134.061517] decode_attr_rdev: rdev=(0x0:0x0)
[35134.061519] decode_attr_space_used: space used=0
[35134.061521] decode_attr_time_access: atime=0
[35134.061523] decode_attr_time_metadata: ctime=1606120833
[35134.061525] decode_attr_time_modify: mtime=1606120833
[35134.061526] decode_attr_mounted_on_fileid: fileid=0
[35134.061527] decode_getfattr_attrs: xdr returned 0
[35134.061529] decode_getfattr_generic: xdr returned 0
[35134.061532] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.061535] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.061537] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.061538] nfs41_sequence_process: Error 0 free the slot
[35134.061540] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.061546] NFS: nfs_update_inode(0:82/2 fh_crc=0x62d40c52 ct=2 info=0x26040)
[35134.061553] NFS: permission(0:82/2), mask=0x1, res=0
[35134.061559] NFS: lookup(/tmp)
[35134.061562] NFS call  lookup /tmp
[35134.061564] --> nfs41_call_sync_prepare data->seq_server 00000000faf52af4
[35134.061567] --> nfs4_alloc_slot used_slots=0000 highest_used=4294967295 max_slots=30
[35134.061569] <-- nfs4_alloc_slot used_slots=0001 highest_used=0 slotid=0
[35134.061575] encode_sequence: sessionid=1614612109:2516949716:5:0 seqid=12 slotid=0 max_slotid=0 cache_this=0
[35134.061642] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.061646] nfsd4_sequence: slotid 0
[35134.061648] check_slot_seqid enter. seqid 12 slot_seqid 11
[35134.061651] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.061655] nfsd: fh_verify(8: 00010001 00000000 00000000 00000000 00000000 00000000)
[35134.061658] nfsd: nfsd_lookup(fh 8: 00010001 00000000 00000000 00000000 00000000 00000000, tmp)
[35134.061663] --> nfsd4_store_cache_entry slot 000000008e086c0f
[35134.061691] --> nfs4_alloc_slot used_slots=0001 highest_used=0 max_slots=30
[35134.061694] <-- nfs4_alloc_slot used_slots=0003 highest_used=1 slotid=1
[35134.061695] nfs4_free_slot: slotid 1 highest_used_slotid 0
[35134.061696] nfs41_sequence_process: Error 0 free the slot
[35134.061698] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
[35134.061701] NFS reply lookup: -2
[35134.061704] NFS: dentry_delete(/tmp, 80c)
[35134.061730] NFS4: Couldn't follow remote path
[35134.061731] <-- nfs4_try_get_tree() = -2 [error]
[35134.061745] NFS: clear cookie (0x0000000002f41426/0x0000000000000000)
[35134.061948] NFS: releasing superblock cookie (0x00000000faf52af4/0x0000000000000000)
[35134.101941] --> nfs4_proc_destroy_session
[35134.102103] nfsd4_destroy_session: 1614612109:2516949716:5:0
[35134.102111] __find_in_sessionid_hashtbl: 1614612109:2516949716:5:0
[35134.102427] <-- nfs4_proc_destroy_session
[35134.102432] nfs4_destroy_session Destroy backchannel for xprt 00000000733269a8
[35134.102604] alloc_cld_upcall: allocated xid 6
[35134.125122] NFS: destroy per-net callback data; net=f0000358
[35134.125256] nfs_callback_down: service destroyed
[35134.125267] NFS: releasing client cookie (0x000000003f4944e9/0x00000000c67386ff)
