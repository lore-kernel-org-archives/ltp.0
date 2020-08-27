From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 27 Aug 2020 11:58:13 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscalls/setsockopt05: associate receiver with
 destination address
In-Reply-To: <1175d50f-9b07-ec6e-4840-f5b61d677753@suse.cz>
References: <20200826103913.27678-1-mdoucha@suse.cz>
 <10ca0dc0c59d782bcccd5aedc99dadb5c76fed91.1598530309.git.jstancek@redhat.com>
 <1175d50f-9b07-ec6e-4840-f5b61d677753@suse.cz>
Message-ID: <452994585.10362765.1598543893067.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi,
> I assume that cycling through different source ports prevented the issue?

Yes, it did, it ran fine over night.

> 
> Reviewed-by: Martin Doucha <mdoucha@suse.cz>
> 
> On 27. 08. 20 14:14, Jan Stancek wrote:
> > to avoid sporadic ECONNREFUSED errors (caused by delayed ICMP):
> >   safe_net.c:202: BROK: setsockopt05.c:70: send(6, 0x3ffcaf7d828, 4000,
> >   32768) failed: ECONNREFUSED (111)
> > 
> > per man(7) udp:
> >   ECONNREFUSED
> >     No receiver was associated with the destination address.
> >     This might be caused by a previous packet sent over the socket.
> > 
> > per https://tools.ietf.org/html/rfc1122#page-78
> >   The application is also responsible to avoid confusion from a delayed
> >   ICMP
> >   error message resulting from an earlier use of the same port(s).
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  .../kernel/syscalls/setsockopt/setsockopt05.c | 23 ++++++++++++++-----
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> > b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> > index e78ef236e337..0b7ff39d2663 100644
> > --- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> > +++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> > @@ -31,13 +31,14 @@
> >  #define BUFSIZE 4000
> >  
> >  static struct sockaddr_in addr;
> > +static int dst_sock = -1;
> >  
> >  static void setup(void)
> >  {
> >  	int real_uid = getuid();
> >  	int real_gid = getgid();
> > -	int sock;
> >  	struct ifreq ifr;
> > +	socklen_t addrlen = sizeof(addr);
> >  
> >  	SAFE_UNSHARE(CLONE_NEWUSER);
> >  	SAFE_UNSHARE(CLONE_NEWNET);
> > @@ -45,14 +46,23 @@ static void setup(void)
> >  	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
> >  	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
> >  
> > -	tst_init_sockaddr_inet_bin(&addr, INADDR_LOOPBACK, 12345);
> > -	sock = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
> > +	tst_init_sockaddr_inet_bin(&addr, INADDR_LOOPBACK, 0);
> > +	dst_sock = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
> > +
> >  	strcpy(ifr.ifr_name, "lo");
> >  	ifr.ifr_mtu = 1500;
> > -	SAFE_IOCTL(sock, SIOCSIFMTU, &ifr);
> > +	SAFE_IOCTL(dst_sock, SIOCSIFMTU, &ifr);
> >  	ifr.ifr_flags = IFF_UP;
> > -	SAFE_IOCTL(sock, SIOCSIFFLAGS, &ifr);
> > -	SAFE_CLOSE(sock);
> > +	SAFE_IOCTL(dst_sock, SIOCSIFFLAGS, &ifr);
> > +
> > +	SAFE_BIND(dst_sock, (struct sockaddr *)&addr, addrlen);
> > +	SAFE_GETSOCKNAME(dst_sock, (struct sockaddr*)&addr, &addrlen);
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (dst_sock != -1)
> > +		SAFE_CLOSE(dst_sock);
> >  }
> >  
> >  static void run(void)
> > @@ -82,6 +92,7 @@ static void run(void)
> >  static struct tst_test test = {
> >  	.test_all = run,
> >  	.setup = setup,
> > +	.cleanup = cleanup,
> >  	.taint_check = TST_TAINT_W | TST_TAINT_D,
> >  	.needs_kconfigs = (const char *[]) {
> >  		"CONFIG_USER_NS=y",
> > 
> 
> 
> --
> Martin Doucha   mdoucha@suse.cz
> QA Engineer for Software Maintenance
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic
> 
> 

