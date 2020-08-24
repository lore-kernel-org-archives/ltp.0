From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 24 Aug 2020 11:01:17 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/setsockopt05: associate receiver with
 destination address
In-Reply-To: <de536b1b-0751-f50c-3869-b1b7956bda84@suse.cz>
References: <c73f6b2e1232d6a892ecef76370ea2cf6c7dd044.1598270814.git.jstancek@redhat.com>
 <de536b1b-0751-f50c-3869-b1b7956bda84@suse.cz>
Message-ID: <1425720351.9865762.1598281277578.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi,
> 
> On 24. 08. 20 14:10, Jan Stancek wrote:
> > to avoid sporadic ECONNREFUSED errors:
> >   safe_net.c:202: BROK: setsockopt05.c:70: send(6, 0x3ffcaf7d828, 4000,
> >   32768) failed: ECONNREFUSED (111)
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/syscalls/setsockopt/setsockopt05.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> > b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> > index e78ef236e337..469e5a64bf71 100644
> > --- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> > +++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> > @@ -37,6 +37,7 @@ static void setup(void)
> >  	int real_uid = getuid();
> >  	int real_gid = getgid();
> >  	int sock;
> > +	int port = TST_GET_UNUSED_PORT(AF_INET, SOCK_DGRAM);
> >  	struct ifreq ifr;
> >  
> >  	SAFE_UNSHARE(CLONE_NEWUSER);
> > @@ -45,14 +46,14 @@ static void setup(void)
> >  	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
> >  	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
> >  
> > -	tst_init_sockaddr_inet_bin(&addr, INADDR_LOOPBACK, 12345);
> > +	tst_init_sockaddr_inet_bin(&addr, INADDR_LOOPBACK, port);
> 
> Please don't use TST_GET_UNUSED_PORT() this way. The correct way to do
> this is to set port to 0 and then read the address back using
> SAFE_GETSOCKNAME() after bind(). It's the same amount of code but
> without any race conditions.

Fair point.

> 
> >  	sock = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
> >  	strcpy(ifr.ifr_name, "lo");
> >  	ifr.ifr_mtu = 1500;
> >  	SAFE_IOCTL(sock, SIOCSIFMTU, &ifr);
> >  	ifr.ifr_flags = IFF_UP;
> >  	SAFE_IOCTL(sock, SIOCSIFFLAGS, &ifr);
> > -	SAFE_CLOSE(sock);
> 
> Don't forget to close the socket in cleanup().
> 
> > +	SAFE_BIND(sock, (struct sockaddr *)&addr, sizeof(struct sockaddr));
> >  }
> >  
> >  static void run(void)
> > 
> 
> Though I wonder whether setsockopt(SO_NO_CHECK, 1) is really supposed to
> flush the partial packet. Are you sure it's not a bug in the kernel?

I assumed it's from previous one, not partial one. From man(7) udp:

 ECONNREFUSED
              No receiver was associated with the destination address.
              This might be caused by a previous packet sent over the socket.

