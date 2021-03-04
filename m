From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 4 Mar 2021 18:02:03 +0100
Subject: [LTP] NFS tests failure: RPC: Couldn't create auth handle
 (flavor 390004)
In-Reply-To: <89a20590-e81c-4959-f7d7-da95e6423107@oracle.com>
References: <YD0NapQGu/HEi5HK@pevik>
 <89a20590-e81c-4959-f7d7-da95e6423107@oracle.com>
Message-ID: <YEESix61jnGdJ4P/@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > I'm looking to some NFS failures on recent openSUSE kernel 5.11.

> > "RPC:       Couldn't create auth handle (flavor 390004)" error has something to
> > do with krb5i, but module rpcsec_gss_krb5 is loaded.

Hi Alexey,

> Hi Petr,

> Do other security flavours work well, or without them using "none" opt?
> Also 'sys' is not default in your setup? If it doesn't work just for
> krb5 it might be some misconfiguration with kerberos setup there...

thanks for a tip. No, define sec=... in /etc/nfsmount.conf does not help.

* Adding sec=sys into /etc/nfsmount.conf leads to (or keeping the default):
nfs01 1 TINFO: Mounting NFS: mount -t nfs -o proto=tcp,vers=4.1 10.0.0.2:/tmp/LTP_nfs01.nM6Epvvg20/4.1/tcp /tmp/LTP_nfs01.nM6Epvvg20/4.1/0
mount.nfs: mounting 10.0.0.2:/tmp/LTP_nfs01.nM6Epvvg20/4.1/tcp failed, reason given by server: No such file or directory
nfs01 1 TBROK: mount command failed

* sec=none
nfs01 1 TINFO: setup NFSv4.1, socket type tcp
nfs01 1 TINFO: Mounting NFS: mount -t nfs -o proto=tcp,vers=4.1 10.0.0.2:/tmp/LTP_nfs01.pCXxr8Cr0I/4.1/tcp /tmp/LTP_nfs01.pCXxr8Cr0I/4.1/0
mount.nfs: Operation not permitted

* sec=krb5 or sec=krb5i or sec=krb5p
nfs01 1 TINFO: setup NFSv4.1, socket type tcp
nfs01 1 TINFO: Mounting NFS: mount -t nfs -o proto=tcp,vers=4.1 10.0.0.2:/tmp/LTP_nfs01.9oZybEIlye/4.1/tcp /tmp/LTP_nfs01.9oZybEIlye/4.1/0
mount.nfs: an incorrect mount option was specified

I have to dig more into the docs.

BTW what services are required to be running for NFS tests?
I have running: proc-fs-nfsd.mount, var-lib-nfs-rpc_pipefs.mount, nfs-idmapd.service, nfs-mountd.service, nfs-server.service, nfsdcld.servicenfs-client.target.

Kind regards,
Petr

> > Any idea what could cause "nfs41_sequence_process: Error 0 free the slot"
> > and "NFS reply lookup: -2"?

> > Kind regards,
> > Petr
