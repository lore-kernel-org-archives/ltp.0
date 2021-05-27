From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 May 2021 08:32:34 +0200
Subject: [LTP] [LTP PATCH v2 1/3] nfs_lib.sh: Detect unsupported protocol
In-Reply-To: <20210526172503.18621-1-pvorel@suse.cz>
References: <20210526172503.18621-1-pvorel@suse.cz>
Message-ID: <YK89Av7F3kML4ERn@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> Caused by disabled CONFIG_NFSD_V[34] in kernel config.

Looking for other errno in nfs-utils (in utils/mount/):
EACCES 13 Permission denied
EAFNOSUPPORT 97 Address family not supported by protocol
EAGAIN 11 Resource temporarily unavailable
EALREADY 114 Operation already in progress
ECONNREFUSED 111 Connection refused
EINVAL 22 Invalid argument
EIO 5 Input/output error
ENOMEM 12 Cannot allocate memory
EOPNOTSUPP 95 Operation not supported
EPROTONOSUPPORT 93 Protocol not supported
ESPIPE 29 Illegal seek
ETIMEDOUT 110 Connection timed out

I suppose I should add only:
EAFNOSUPPORT 97 Address family not supported by protocol
(I guess for kernel without IPv6 support).

But doing a quick test with v3 enabled and v4 disabled:
CONFIG_NFS_V2=m
CONFIG_NFS_V3=m
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_V4=y

nfs-utils does not print it for enabled protocol:

nfs01 1 TINFO: setup NFSv3, socket type tcp6
nfs01 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp6,vers=3 [fd00:1:1:1::2]:/var/tmp/LTP_nfs01.XXXXySFHMF/3/tcp6 /var/tmp/LTP_nfs01.XXXXySFHMF/3/0
mount: mounting [fd00:1:1:1::2]:/var/tmp/LTP_nfs01.XXXXySFHMF/3/tcp6 on /var/tmp/LTP_nfs01.XXXXySFHMF/3/0 failed: Input/output error
nfs01 1 TBROK: mount command failed

but it does for disabled protocol:

nfs01 1 TINFO: setup NFSv4, socket type tcp6
nfs01 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp6,vers=4 [fd00:1:1:1::2]:/var/tmp/LTP_nfs01.XXXXWyckxh/4/tcp6 /var/tmp/LTP_nfs01.XXXXWyckxh/4/0
NFS: NFSv4 is not compiled into kernel
mount: mounting [fd00:1:1:1::2]:/var/tmp/LTP_nfs01.XXXXWyckxh/4/tcp6 on /var/tmp/LTP_nfs01.XXXXWyckxh/4/0 failed: Protocol not supported
mount: mounting [fd00:1:1:1::2]:/var/tmp/LTP_nfs01.XXXXWyckxh/4/tcp6 on /var/tmp/LTP_nfs01.XXXXWyckxh/4/0 failed: Protocol not supported
nfs01 1 TCONF: Protocol not supported

It might be a problem with LTP tst_net.sh library, which might not support
disabled IPv6 properly. Testing ping02.sh -6:

ping02 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
ping02 1 TINFO: add local addr 10.0.0.2/24
ping02 1 TINFO: add local addr fd00:1:1:1::2/64
RTNETLINK answers: Operation not supported
ping02 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
ping02 1 TINFO: add remote addr 10.0.0.1/24
ping02 1 TINFO: add remote addr fd00:1:1:1::1/64
RTNETLINK answers: Operation not supported
# tst_net_iface_prefix.c:133: TINFO: prefix and interface not found for 'fd00:1:1:1::2'.

ping02 1 TINFO: Network config (local -- remote):
ping02 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
ping02 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
ping02 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
ping02 1 TINFO: timeout per run is 0h 5m 0s
ping6: socket: Address family not supported by protocol
ping02 1 TFAIL: ping6 -I ltp_ns_veth2 -c 3 -s 8 -f -p 000102030405060708090a0b0c0d0e0f fd00:1:1:1::1 >/dev/null failed unexpectedly

=> It's not a priority, I'll try to have look into it in when time permits.
https://github.com/linux-test-project/ltp/issues/821

Kind regards,
Petr
