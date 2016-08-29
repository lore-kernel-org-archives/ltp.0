From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 29 Aug 2016 11:49:41 -0400 (EDT)
Subject: [LTP] [PATCH] lsmod01: parse a copy of /proc/modules
In-Reply-To: <57C440C0.5050307@oracle.com>
References: <1472468916-13152-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160829125050.GD30021@rei.lan> <57C43307.8000709@oracle.com>
 <8140813.24444.1472477694219.JavaMail.zimbra@redhat.com>
 <57C43FEF.50402@oracle.com> <57C440C0.5050307@oracle.com>
Message-ID: <2063556369.71871.1472485781200.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>, ltp@lists.linux.it
> Sent: Monday, 29 August, 2016 4:03:44 PM
> Subject: Re: [LTP] [PATCH] lsmod01: parse a copy of /proc/modules
> 
> 
> 
> On 08/29/2016 05:00 PM, Stanislav Kholmanskikh wrote:
> > 
> > 
> > On 08/29/2016 04:34 PM, Jan Stancek wrote:
> >>
> >>
> >>
> >>
> >> ----- Original Message -----
> >>> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> >>> To: "Cyril Hrubis" <chrubis@suse.cz>
> >>> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>, ltp@lists.linux.it
> >>> Sent: Monday, 29 August, 2016 3:05:11 PM
> >>> Subject: Re: [LTP] [PATCH] lsmod01: parse a copy of /proc/modules
> >>>
> >>>
> >>>
> >>> On 08/29/2016 03:50 PM, Cyril Hrubis wrote:
> >>>> Hi!
> >>>>> In my environment, if TMPDIR is on NFSv4, this test case fails with:
> >>>>>
> >>>>> lsmod01 1 TFAIL : lsmod output different from /proc/modules.
> >>>>>   21c21
> >>>>>   < sunrpc 207591 28
> >>>>>   ---
> >>>>>   > sunrpc 207591 29
> >>>>>
> >>>>> To avoid such problems I separate the process of getting data from
> >>>>> /proc/modules and the process of parsing it in the pipe structure.
> >>>>
> >>>> So the sunrpc module gets its ref counter incremented from somewhere of
> >>>> the nfs kernel code once we open file on NFS?
> >>>
> >>> Looks so. I hava a share mounted from localhost:
> >>>
> >>> [root@skholman-m7 mnt]# mount|grep mnt
> >>> 127.0.0.1:/opt on /mnt type nfs
> >>> (rw,vers=4,addr=127.0.0.1,clientaddr=127.0.0.1)
> >>> [root@skholman-m7 mnt]# awk '{print $1, $2, $3}' /proc/modules|sort >
> >>> /tmp/not_nfs
> >>> [root@skholman-m7 mnt]# awk '{print $1, $2, $3}' /proc/modules|sort > nfs
> >>> [root@skholman-m7 mnt]# grep sunrpc nfs
> >>> sunrpc 207591 29
> >>> [root@skholman-m7 mnt]# grep sunrpc /tmp/not_nfs
> >>> sunrpc 207591 28
> >>> [root@skholman-m7 mnt]#
> >>
> >> And if you do that with just "cat /proc/modules", then there's no
> >> difference?
> >> Could it be that it's actually first write that takes extra ref?
> >> cat is reading in 65536 byte chunks for me, awk only 1024.
> > 
> > Yes, there is no difference if I use "cat /proc/modules":
> > 
> > [root@skholman-m7 mnt]# awk '{print $1, $2, $3}' /proc/modules|sort > nfs
> > [root@skholman-m7 mnt]# grep sunrpc nfs
> > sunrpc 207591 29
> > [root@skholman-m7 mnt]# cat /proc/modules > temp
> > [root@skholman-m7 mnt]# awk '{print $1, $2, $3}' temp|sort > nfs
> > [root@skholman-m7 mnt]# grep sunrpc temp
> > sunrpc 207591 28 nfs,nfsd,lockd,nfs_acl,auth_rpcgss, Live
> > 0x00000000101ec000
> > [root@skholman-m7 mnt]#
> > 
> > As for 1024. lsmod also reads /proc/modules in 1024 bytes chunks.
> 
> I suppose it's something related to using the pipe construction, since
> this change also "fixes" the issue:

I'm suspecting this to be some kind of race between opening file on
nfs and reading /proc/modules at the same time:

# sh -c "cat /proc/modules | cat > temp2"; grep sunrpc temp2
sunrpc 300464 31 nfsv3,rpcsec_gss_krb5,nfsv4,nfs,nfsd,auth_rpcgss,nfs_acl,lockd, Live 0xffffffffa03a4000

# taskset -c 0 sh -c "cat /proc/modules | cat > temp2"; grep sunrpc temp2
sunrpc 300464 30 nfsv3,rpcsec_gss_krb5,nfsv4,nfs,nfsd,auth_rpcgss,nfs_acl,lockd, Live 0xffffffffa03a4000

or

# dd if=/proc/modules bs=1 | cat > temp2; grep sunrpc temp2
6332+0 records in
6332+0 records out
6332 bytes (6.3 kB) copied, 0.00288249 s, 2.2 MB/s
sunrpc 300464 30 nfsv3,rpcsec_gss_krb5,nfsv4,nfs,nfsd,auth_rpcgss,nfs_acl,lockd, Live 0xffffffffa03a4000

# dd if=/proc/modules bs=2 | cat > temp2; grep sunrpc temp2
3166+0 records in
3166+0 records out
6332 bytes (6.3 kB) copied, 0.00148174 s, 4.3 MB/s
sunrpc 300464 31 nfsv3,rpcsec_gss_krb5,nfsv4,nfs,nfsd,auth_rpcgss,nfs_acl,lockd, Live 0xffffffffa03a4000

or

# cat /proc/modules | sh -c cat > temp2; grep sunrpc temp2
sunrpc 300464 31 nfsv3,rpcsec_gss_krb5,nfsv4,nfs,nfsd,auth_rpcgss,nfs_acl,lockd, Live 0xffffffffa03a4000

# cat /proc/modules | sh -c "cat > temp2"; grep sunrpc temp2
sunrpc 300464 30 nfsv3,rpcsec_gss_krb5,nfsv4,nfs,nfsd,auth_rpcgss,nfs_acl,lockd, Live 0xffffffffa03a4000

