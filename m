From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 28 Jun 2021 16:06:24 +0200
Subject: [LTP] [PATCH] Add documentation for netdevice and rtnetlink
 libraries
In-Reply-To: <20210625160644.11831-1-mdoucha@suse.cz>
References: <20210625160644.11831-1-mdoucha@suse.cz>
Message-ID: <YNnXYHVjfAalJFQy@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

thanks for improving docs, generally LGTM.

I have only minor formatting notes.

I wonder if we one day generated API docs with something like doxygen. Googling
showed asciidoxy [1] which should do transformation from Doxygen XML output to AsciiDoc.
Doc examples and comments in the code would be probably easier to keep in mind
when need update. But that's idea for future.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

>  create mode 100644 doc/network-c-api.txt

> +A few safe functions have extra parameters for quick return value validation.
> +The ellipsis (+...+) represents the standard parameters of the underlying system
> +function:
> +
> +* +SAFE_SEND(char strict, ...)+
> +* +SAFE_SENDTO(char strict, ...)+
> +** If +strict+ is non-zero, the return value must be equal to the data length
> +   argument. Otherwise the test will fail and exit.
> +
> +* +SAFE_SENDMSG(size_t msg_len, ...)+
> +* +SAFE_RECV(size_t msg_len, ...)+
> +* +SAFE_RECVMSG(size_t msg_len, ...)+
> +** If +msg_len+ is non-zero, the return value must be equal to the +msg_len+
> +   argument. Otherwise the test will fail and exit.
> +
> +There are also some custom functions for simpler configuration and queries:
> +
> +- +int SAFE_SETSOCKOPT_INT(int sockfd, int level, int optname, int value)+ -
nit: I'd use ? (en dash) here (I can fix it before merge).
Even better would be to start description on new line, but let's ignore that.

> +  Simple setsockopt() variant for passing integers by value.
> +
> +- +int TST_GETSOCKPORT(int sockfd)+ - Get port number (in host byte order) of a
> +  bound socket.
> +
> +- +unsigned short TST_GET_UNUSED_PORT(int family, int type)+ - Get a random
> +  port number (in network byte order) which is currently closed for the given
> +  socket family and type. Note that another application may open the port while
> +  the test is still running. The test user is responsible for setting up test
> +  environment without such interference.
> +
> +1.2 Address conversion functions
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> ++#include "tst_net.h"+
> +
> +LTP library also provides helper functions for quick initialization of socket
> +address structures:
> +
> +- +void tst_get_in_addr(const char *ip_str, struct in_addr *ip)+ - Convert
> +  human-readable IPv4 address string +ip_str+ to binary representation in
> +  network byte order. The converted value will be stored in the second argument.
> +
> +- +void tst_get_in6_addr(const char *ip_str, struct in6_addr *ip6)+ - Convert
> +  human-readable IPv6 address string +ip_str+ to binary representation in
> +  network byte order. The converted value will be stored in the second argument.
> +
> +- +socklen_t tst_get_connect_address(int sock, struct sockaddr_storage *addr)+ -
> +  Find the address which can be used to send data to bound socket +sock+ from
> +  another socket. The address will be stored in the second argument. This
> +  function automatically converts wildcard bind address to localhost. Returns
> +  size of the address in bytes.
> +
> +- +void tst_init_sockaddr_inet(struct sockaddr_in *sa, const char *ip_str,
> +  uint16_t port)+ - Initialize socket address structure +sa+ using
> +  human-readable IPv4 address +ip_str+ and port number +port+ in host byte
> +  order.
> +
> +- +void tst_init_sockaddr_inet_bin(struct sockaddr_in *sa, uint32_t ip_val,
> +  uint16_t port)+ - Initialize socket address structure +sa+ using binary IPv4
> +  address +ip_val+ and port number +port+, both in host byte order.
> +
> +- +void tst_init_sockaddr_inet6(struct sockaddr_in6 *sa, const char *ip_str,
> +  uint16_t port)+ - Initialize socket address structure +sa+ using
> +  human-readable IPv6 address +ip_str+ and port number +port+ in host byte
> +  order.
> +
> +- +void tst_init_sockaddr_inet6_bin(struct sockaddr_in6 *sa, const struct
> +  in6_addr *ip_val, uint16_t port)+ - Initialize socket address structure +sa+
> +  using binary IPv6 address +ip_val+ and port number +port+, both in host byte
> +  order.
> +
> +.Example Usage
> +[source,c]
> +-------------------------------------------------------------------------------
> +
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_net.h"
> +#include "tst_net.h"
> +
> +static int sockfd = -1;
> +
> +static void setup(void)
> +{
> +	struct sockaddr_in addr;
> +
> +	tst_init_sockaddr_inet_bin(&addr, INADDR_ANY, 0);
> +	sockfd = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> +	SAFE_SETSOCKOPT_INT(sockfd, SOL_SOCKET, SO_SNDBUF, 4096);
> +	SAFE_BIND(sockfd, (struct sockaddr *)&addr, sizeof(addr));
> +	SAFE_LISTEN(sockfd, 8);
> +
nit: blank line here.
> +}
> +
> +-------------------------------------------------------------------------------
> +
> +2 Configuring network devices
> +-----------------------------
> +
> ++#include "tst_netdevice.h"+
> +
> +When opening a localhost socket isn't enough and the test needs special device
> +or routing configuration, the netdevice library can create the required network
> +setup without calling external programs. Internally, the netdevice functions
> +use rtnetlink socket to communicate with the kernel.
> +
> +All of these functions will terminate the test on failure, unless stated
> +otherwise. Error values described below are returned only during test cleanup
> +stage.
> +
> +2.1 Network device management
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +- +int NETDEV_INDEX_BY_NAME(const char *ifname)+ - Returns the device index for
> +  the given device name, or -1 on error.
> +
> +- +int NETDEV_SET_STATE(const char *ifname, int up)+ - Enable or disable a
> +  network device +ifname+. Returns 0 on success, -1 on error.
> +
> +- +int CREATE_VETH_PAIR(const char *ifname1, const char *ifname2)+ - Creates a
> +  connected pair of virtual network devices with given device names. Returns 1
> +  on success, 0 on error. Add +"CONFIG_VETH"+ to +test.needs_kconfigs+ if your
> +  test calls this function.
> +
> +- +int REMOVE_NETDEV(const char *ifname)+ - Removes network device +ifname+.
> +  Returns 1 on success, 0 on error.
> +
> +2.2 Network address management
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +- +int NETDEV_ADD_ADDRESS(const char \*ifname, unsigned int family, const void
> +  *address, unsigned int prefix, size_t addrlen, unsigned int flags)+ - Adds
> +  new address to network device +ifname+. This is a low-level function which
> +  allows setting any type of address. You must specify the protocol +family+,
> +  address length in bytes (+addrlen+) and network prefix length (+prefix+). The
> +  +address+ itself must be in binary representation in network byte order. You
> +  can also pass rtnetlink flags from the +IFA_F_*+ group. Returns 1 on success,
> +  0 on error.
> +
> +- +int NETDEV_ADD_ADDRESS_INET(const char *ifname, in_addr_t address, unsigned
> +  int prefix, unsigned int flags)+ - Adds new IPv4 address to network device
> +  +ifname+. Parameters have the same meaning as in +NETDEV_ADD_ADDRESS()+.
> +  Returns 1 on success, 0 on error.
> +
> +- +int NETDEV_REMOVE_ADDRESS(const char *ifname, unsigned int family, const
> +  void *address, size_t addrlen)+ - Removes the specified address from network
> +  device +ifname+. Parameters have the same meaning as in
> +  +NETDEV_ADD_ADDRESS()+. Returns 1 on success, 0 on error.
> +
> +- +int NETDEV_REMOVE_ADDRESS_INET(const char *ifname, in_addr_t address)+ -
> +  Removes specified IPv4 +address+ (in network byte order) from network device
> +  +ifname+. Returns 1 on success, 0 on error.
> +
> +2.3 Network namespace device assignment
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Warning: Moving a network device to another namespace will erase previous
> +configuration. Move the device to the correct namespace first, then configure
> +it.

nit: formating like this makes warning more visible [2]:

WARNING: Moving a network device to another namespace will erase previous
         configuration. Move the device to the correct namespace first,
         then configure it.

Kind regards,
Petr

[1] https://pypi.org/project/asciidoxy/
[2] https://github.com/pevik/ltp/wiki/LTP-C-Test-Network-API#23-network-namespace-device-assignment

Kind regards,
Petr
