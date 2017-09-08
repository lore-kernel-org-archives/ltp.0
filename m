From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 8 Sep 2017 05:32:26 -0400 (EDT)
Subject: [LTP] [RFC PATCH v9 6/7] network: Add tools for setup IP
 related environment variables
In-Reply-To: <6796162e-c84e-05a4-8350-c94feb5d2513@oracle.com>
References: <20170824234436.18145-1-pvorel@suse.cz>
 <20170824234436.18145-7-pvorel@suse.cz>
 <6796162e-c84e-05a4-8350-c94feb5d2513@oracle.com>
Message-ID: <837915861.10699397.1504863146663.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it




----- Original Message -----
> On 08/25/2017 02:44 AM, Petr Vorel wrote:
> 
> 
> 
> New tools:
> * tst_net_ip_prefix
> Strip prefix from IP address and save both
> If no prefix found sets default prefix.
> 
> * tst_net_iface_prefix
> tst_net_iface_prefix reads prefix and interface from rtnetlink.
> 
> * tst_net_vars takes input of local and remote address and setup most of
> test link (IP related) environment variables.
> 
> NOTABLE CHANGES IN ENVIRONMENT VARIABLES:
> Network variables are defined for both local and remote:
> IPV4_NETWORK was replaced by IPV4_LNETWORK and IPV4_RNETWORK
> IPV6_NETWORK was replaced by IPV6_LNETWORK and IPV6_RNETWORK
> 
> NEW VARIABLES:
> IPV4_LHOST, IPV4_RHOST, IPV4_LNETMASK, IPV4_RNETMASK, IPV4_LPREFIX,
> IPV4_RPREFIX,
> IPV6_LHOST, IPV6_RHOST, IPV6_LNETMASK, IPV6_RNETMASK, IPV6_LPREFIX,
> IPV6_RPREFIX,
> 
> For full list of environment variables which tools setup run:
> tst_net_ip_prefix -h
> tst_net_iface_prefix -h
> tst_net_vars -h
> 
> Thanks a lot to Alexey Kodanev who reviewed many versions of this patch
> and give feedback and pointed out errors, as well as to Cyril Hrubis who
> reviewed orignal version of tst_net_vars.c.
> 
> Applied with minor changes below, thank you!

Hi,

this breaks the build for me on older RHELs.
I can build it OK with HEAD at
  782ed69385e1 "network/stress: Reduce the default number of cycles for various tests"
but later commits fail.

RHEL5.6:
---------

make[2]: Entering directory `/root/ltp/testcases/lib'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -D_FORTIFY_SOURCE=2 -I../../include -I../../include -I../../in
clude/old/   -L../../lib  tst_net_iface_prefix.c   -lltp -o tst_net_iface_prefix
In file included from /usr/include/net/if.h:26,
                 from tst_net_iface_prefix.c:19:
/usr/include/sys/types.h:46: error: conflicting types for ‘loff_t’
/usr/include/linux/types.h:30: error: previous declaration of ‘loff_t’ was here
/usr/include/sys/types.h:62: error: conflicting types for ‘dev_t’
/usr/include/linux/types.h:13: error: previous declaration of ‘dev_t’ was here
In file included from /usr/include/sys/types.h:133,
                 from /usr/include/net/if.h:26,
                 from tst_net_iface_prefix.c:19:
/usr/include/time.h:105: error: conflicting types for ‘timer_t’
/usr/include/linux/types.h:22: error: previous declaration of ‘timer_t’ was here
In file included from /usr/include/net/if.h:26,
                 from tst_net_iface_prefix.c:19:
/usr/include/sys/types.h:198: error: conflicting types for ‘int64_t’
/usr/include/linux/types.h:98: error: previous declaration of ‘int64_t’ was here
/usr/include/sys/types.h:204: error: conflicting types for ‘u_int64_t’
/usr/include/linux/types.h:97: error: previous declaration of ‘u_int64_t’ was here
In file included from /usr/include/sys/types.h:220,
                 from /usr/include/net/if.h:26,
                 from tst_net_iface_prefix.c:19:
/usr/include/sys/select.h:78: error: conflicting types for ‘fd_set’
/usr/include/linux/types.h:12: error: previous declaration of ‘fd_set’ was here
In file included from /usr/include/net/if.h:26,
                 from tst_net_iface_prefix.c:19:
/usr/include/sys/types.h:235: error: conflicting types for ‘blkcnt_t’
/usr/include/linux/types.h:114: error: previous declaration of ‘blkcnt_t’ was here
In file included from /usr/include/sys/uio.h:29,
                 from /usr/include/sys/socket.h:27,
                 from /usr/include/net/if.h:27,
                 from tst_net_iface_prefix.c:19:
/usr/include/bits/uio.h:45: error: redefinition of ‘struct iovec’
In file included from /usr/include/sys/socket.h:35,
                 from /usr/include/net/if.h:27,
                 from tst_net_iface_prefix.c:19:
/usr/include/bits/socket.h:146: error: redefinition of ‘struct sockaddr’
/usr/include/bits/socket.h:163: error: redefinition of ‘struct __kernel_sockaddr_storage’
/usr/include/bits/socket.h:173: error: expected identifier before numeric constant
/usr/include/bits/socket.h:216: error: redefinition of ‘struct msghdr’
/usr/include/bits/socket.h:234: error: redefinition of ‘struct cmsghdr’
/usr/include/bits/socket.h:264: error: conflicting types for ‘__cmsg_nxthdr’
/usr/include/linux/socket.h:129: error: previous definition of ‘__cmsg_nxthdr’ was here
/usr/include/bits/socket.h:292: error: expected identifier before numeric constant
/usr/include/bits/socket.h:303: error: redefinition of ‘struct ucred’
/usr/include/bits/socket.h:315: error: redefinition of ‘struct linger’
In file included from /usr/include/netinet/in.h:23,
                 from ../../include/tst_safe_net.h:23,
                 from ../../include/tst_test.h:82,
                 from tst_net_iface_prefix.c:24:
/usr/include/stdint.h:56: error: conflicting types for ‘uint64_t’
/usr/include/linux/types.h:96: error: previous declaration of ‘uint64_t’ was here
tst_net_iface_prefix.c: In function ‘read_iface_prefix’:
tst_net_iface_prefix.c:80: warning: comparison between signed and unsigned
make[2]: *** [tst_net_iface_prefix] Error 1
make[2]: Leaving directory `/root/ltp/testcases/lib'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/ltp/testcases'
make: *** [testcases-all] Error 2

RHEL6.0:
---------

make[2]: Entering directory `/root/ltp/testcases/lib'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -D_FORTIFY_SOURCE=2 -I../../include -I../../include -I../../include/old/   -L../../lib  tst_net_iface_prefix.c   -lltp -o tst_net_iface_prefix
In file included from /usr/include/linux/rtnetlink.h:5,
                 from tst_net_iface_prefix.c:18:
/usr/include/linux/netlink.h:34: error: expected specifier-qualifier-list before ‘sa_family_t’
tst_net_iface_prefix.c: In function ‘read_iface_prefix’:
tst_net_iface_prefix.c:80: warning: comparison between signed and unsigned integer expressions
make[2]: *** [tst_net_iface_prefix] Error 1
make[2]: Leaving directory `/root/ltp/testcases/lib'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/ltp/testcases'
make: *** [testcases-all] Error 2

Regards,
Jan
