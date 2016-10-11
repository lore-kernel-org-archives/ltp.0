From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Oct 2016 15:38:24 +0200
Subject: [LTP] [PATCH] lsmod01: parse a copy of /proc/modules
In-Reply-To: <57FCD515.20202@oracle.com>
References: <1472468916-13152-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160829125050.GD30021@rei.lan> <57C43307.8000709@oracle.com>
 <8140813.24444.1472477694219.JavaMail.zimbra@redhat.com>
 <57C43FEF.50402@oracle.com> <57C440C0.5050307@oracle.com>
 <2063556369.71871.1472485781200.JavaMail.zimbra@redhat.com>
 <57FCD515.20202@oracle.com>
Message-ID: <20161011133824.GA17083@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Tried this all again.
> 
> This is from a 4.1-based kernel in a VirtualBox host:
> 
> [root@ol6-x64 mnt]# mount|grep mnt
> 127.0.0.1:/opt/ on /mnt type nfs (rw,vers=3,addr=127.0.0.1)
> [root@ol6-x64 mnt]# grep sunrpc /proc/modules
> sunrpc 329262 28
> nfsv3,rpcsec_gss_krb5,nfsv4,nfs,nfsd,lockd,nfs_acl,auth_rpcgss, Live
> 0xffffffffa0366000
> [root@ol6-x64 mnt]# dd if=/dev/zero of=file bs=512
> 
> While the above dd command is running, in a separate shell I see:
> 
> [stas@ol6-x64 ~]$ lsmod|grep sunrpc
> sunrpc                329262  36
> nfsv3,rpcsec_gss_krb5,nfsv4,nfs,nfsd,lockd,nfs_acl,auth_rpcgss
> [stas@ol6-x64 ~]$

Hmm, 36, really increased by 8 because of the one dd?

That sounds even more strange.

> [root@ol6-x64 mnt]# grep sunrpc /proc/modules
> sunrpc 329262 28
> nfsv3,rpcsec_gss_krb5,nfsv4,nfs,nfsd,lockd,nfs_acl,auth_rpcgss, Live
> 0xffffffffa0366000
> [root@ol6-x64 mnt]# dd if=/proc/modules bs=1 | cat > temp2; grep sunrpc
> temp2
> 2564+0 records in
> 2564+0 records out
> 2564 bytes (2.6 kB) copied, 0.00313203 s, 819 kB/s
> sunrpc 329262 29
> nfsv3,rpcsec_gss_krb5,nfsv4,nfs,nfsd,lockd,nfs_acl,auth_rpcgss, Live
> 0xffffffffa0366000
> [root@ol6-x64 mnt]#
> 
> The same situation is with NFSv4.
> 
> So it turns out that writing to a file on NFS increases the sunrpc
> module reference counter. I don't observe this with ext4.ko.
> 
> So I find that my original patch is fine, it just needs a proper
> description.
> 
> Thoughts?

Isn't the original patch just workaround? Since we write to the nfs
TMPDIR as well, just differently, there is always possibility that we
only made the problem less probable and that it will fail in one of
thousand runs. Have you tried to run the test in a loop for some time?

-- 
Cyril Hrubis
chrubis@suse.cz
