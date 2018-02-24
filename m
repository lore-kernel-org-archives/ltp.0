From: sunlianwen <sunlw.fnst@cn.fujitsu.com>
Date: Sat, 24 Feb 2018 11:52:54 +0800
Subject: [LTP] about net_stress.ipsec_dccp fail
Message-ID: <36e394d8-3391-0a6e-d3fb-563c9d583c00@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Alexey

    I have a problem consult with you about net_stress.ipsec_dccp. when 
execute net_stress.ipsec_dccp on RHEL7.5Beta,

dccp4_ipsec* / dccp6_ipsce* all faill and report the same error . the 
error info is "socket(10, 6, 33) failed: ESOCKTNOSUPPORT",

I debug this error, find this error happen  on create a ipv6 dccp  
socket,but ipv6 dccp type socket is no support on RHEL7.5Beta.

so I want to know whether this error cause by RHEL7.5Beta system self no 
support or all socket no support ipv6 dccp type socket by no?

and I have a another thought maybe no right is that add a judge about 
whether need execute "IPv6 socket is also able to access IPv4 protocol 
stack"

on the line of 578 of server_init() if I only test ipv4 .

562 static void server_init(void)
563 {
564         char *src_addr = NULL;
565         struct addrinfo hints;
566
567         memset(&hints, 0, sizeof(struct addrinfo));
568         hints.ai_family = AF_INET6;
569         hints.ai_socktype = sock_type;
570         hints.ai_flags = AI_PASSIVE;
571
572         if (source_addr && !strchr(source_addr, ':'))
573                 SAFE_ASPRINTF(&src_addr, "::ffff:%s", source_addr);
574         setup_addrinfo(src_addr ? src_addr : source_addr, tcp_port,
575                        &hints, &local_addrinfo);
576         free(src_addr);
577
578         /* IPv6 socket is also able to access IPv4 protocol stack */
579         sfd = SAFE_SOCKET(family, sock_type, protocol);
580         SAFE_SETSOCKOPT_INT(sfd, SOL_SOCKET, SO_REUSEADDR, 1);


below is my debug about  "socket(10, 6, 33) failed: ESOCKTNOSUPPORT"

man socket we can know socket()

int socket(int domain, int type, int protocol);

file path: linux/include/linux/socket.h

160 /* Supported address families. */
161 #define AF_UNSPEC       0
162 #define AF_UNIX         1       /* Unix domain sockets          */
163 #define AF_LOCAL        1       /* POSIX name for AF_UNIX       */
164 #define AF_INET         2       /* Internet IP Protocol         */
165 #define AF_AX25         3       /* Amateur Radio AX.25          */
166 #define AF_IPX          4       /* Novell IPX                   */
167 #define AF_APPLETALK    5       /* AppleTalk DDP                */
168 #define AF_NETROM       6       /* Amateur Radio NET/ROM        */
169 #define AF_BRIDGE       7       /* Multiprotocol bridge         */
170 #define AF_ATMPVC       8       /* ATM PVCs                     */
171 #define AF_X25          9       /* Reserved for X.25 project    */
172 #define AF_INET6        10      /* IP version 6                 */
...

line 172 ,we can know the domain =10  is  mean ipv6

file path: linux/include/linux/net.h

  63 enum sock_type {
  64         SOCK_STREAM     = 1,
  65         SOCK_DGRAM      = 2,
  66         SOCK_RAW        = 3,
  67         SOCK_RDM        = 4,
  68         SOCK_SEQPACKET  = 5,
  69         SOCK_DCCP       = 6,
  70         SOCK_PACKET     = 10,
  71 };

line 69, we can know type=6 is mean SOCK_DCCP

rhel7.5Beta system etc config file : /etc/protocols

  42 irtp    28      IRTP            # Internet Reliable Transaction 
Protocol
  43 iso-tp4 29      ISO-TP4         # ISO Transport Protocol Class 4
  44 netblt  30      NETBLT          # Bulk Data Transfer Protocol
  45 mfe-nsp 31      MFE-NSP         # MFE Network Services Protocol
  46 merit-inp       32      MERIT-INP               # MERIT Internodal 
Protocol
  47 dccp    33      DCCP            # Datagram Congestion Control Protocol

line 47 ,we can know protocols=33 is mean DCCP


file path:linux/include/uapi/asm-generic/errno.h

  76 #define EPROTONOSUPPORT 93      /* Protocol not supported */
  77 #define ESOCKTNOSUPPORT 94      /* Socket type not supported */

line 77 we can know  Socket type not support

that's all

Thanks

LianWen Sun






-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180224/af23951d/attachment.html>
