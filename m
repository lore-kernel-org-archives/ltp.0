Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1V1TFv-0006t7-UW
	for ltp-list@lists.sourceforge.net; Tue, 23 Jul 2013 03:27:20 +0000
Received: from mail-pa0-f49.google.com ([209.85.220.49])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V1TFt-0003xY-FS
	for ltp-list@lists.sourceforge.net; Tue, 23 Jul 2013 03:27:19 +0000
Received: by mail-pa0-f49.google.com with SMTP id bi5so3779926pad.22
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jul 2013 20:27:11 -0700 (PDT)
Date: Tue, 23 Jul 2013 11:27:03 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <20130723032703.GG3004@localhost.localdomain>
References: <1374548876-24829-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1374548876-24829-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] testcases/network/sctp: update sctp test to
 upstream version 1.0.15
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>
Cc: Daniel Borkmann <dborkman@redhat.com>, Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>

On Tue, Jul 23, 2013 at 11:07:56AM +0800, Hangbin Liu wrote:
> SCTP test in ltp is based on lksctp. But the last patch for sctp in ltp is
> 2006. It has changed a lot and fixed many bugs. Update sctp test to upstream
> version 1.0.15 now.
> 
> Format code with
> for file in `find ~/git/ltp/testcases/network/sctp -name *.c -o -name *.h`; do
> 	~/git/linux/scripts/cleanfile $file
> 	~/git/linux/scripts/Lindent $file
> 	rm -f ${file}~
> done
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
Note: Some distros may fail test_sockopt, test_sockopt_v6, test_tcp_style and
test_tcp_style_v6 because of bug https://bugzilla.redhat.com/show_bug.cgi?id=903296

Test result:
# ./test_1_to_1_accept_close
test_1_to_1_accept_close.c    1  TPASS  :  accept() with a bad socket descriptor - EBADF
test_1_to_1_accept_close.c    2  TPASS  :  accept() with invalid socket - ENOTSOCK
test_1_to_1_accept_close.c    3  TPASS  :  accept() with invalid address - EFAULT
test_1_to_1_accept_close.c    4  TPASS  :  accept() on a non-listening socket - EINVAL
test_1_to_1_accept_close.c    5  TPASS  :  accept() on an established socket - EINVAL
test_1_to_1_accept_close.c    6  TPASS  :  accept() a closed association - SUCCESS
test_1_to_1_accept_close.c    7  TPASS  :  accept() on a listening socket - SUCCESS
test_1_to_1_accept_close.c    8  TPASS  :  close() with a bad socket descriptor - EBADF
test_1_to_1_accept_close.c    9  TPASS  :  close() with a valid socket descriptor - SUCCESS
test_1_to_1_accept_close.c   10  TPASS  :  close() with a closed socket descriptor - EBADF
# ./test_1_to_1_addrs
test_1_to_1_addrs.c    1  TPASS  :  sctp_getladdrs() with a bad socket descriptor - EBADF
test_1_to_1_addrs.c    2  TPASS  :  sctp_getladdrs() with invalid socket - ENOTSOCK
test_1_to_1_addrs.c    3  TPASS  :  sctp_getladdrs() with socket of different protocol - EOPNOTSUPP
test_1_to_1_addrs.c    4  TPASS  :  sctp_getladdrs() - SUCCESS
test_1_to_1_addrs.c    5  TPASS  :  sctp_freeladdrs() - SUCCESS
test_1_to_1_addrs.c    6  TPASS  :  sctp_getpaddrs() with a bad socket descriptor - EBADF
test_1_to_1_addrs.c    7  TPASS  :  sctp_getpaddrs() with invalid socket - ENOTSOCK
test_1_to_1_addrs.c    8  TPASS  :  sctp_getpaddrs() with socket of different protocol - EOPNOTSUPP
test_1_to_1_addrs.c    9  TPASS  :  sctp_getpaddrs() - SUCCESS
test_1_to_1_addrs.c   10  TPASS  :  sctp_freepaddrs() - SUCCESS
# ./test_1_to_1_connect
test_1_to_1_connect.c    1  TPASS  :  connect() with bad socket descriptor - EBADF
test_1_to_1_connect.c    2  TPASS  :  connect() with invalid socket - ENOTSOCK
test_1_to_1_connect.c    3  TPASS  :  connect() with invalid address - EFAULT
test_1_to_1_connect.c    4  TPASS  :  connect() with invalid address length - EINVAL
test_1_to_1_connect.c    5  TPASS  :  connect() with invalid address family - EINVAL
test_1_to_1_connect.c    6  TPASS  :  valid blocking connect() - SUCCESS
test_1_to_1_connect.c    7  TPASS  :  connect() when accept queue is full - ECONNREFUSED
test_1_to_1_connect.c    8  TPASS  :  connect() on a listening socket - EISCONN
test_1_to_1_connect.c    9  TPASS  :  connect() on an established socket - EISCONN
test_1_to_1_connect.c   10  TPASS  :  connect() to re-establish a closed association - SUCCESS
# ./test_1_to_1_connectx
test_1_to_1_connectx.c    1  TPASS  :  sctp_connectx() with bad socket descriptor - EBADF
test_1_to_1_connectx.c    2  TPASS  :  sctp_connectx() with invalid socket - ENOTSOCK
test_1_to_1_connectx.c    3  TPASS  :  sctp_connectx() with invalid address - EINVAL
test_1_to_1_connectx.c    4  TPASS  :  sctp_connectx() with invalid address length - EINVAL
test_1_to_1_connectx.c    5  TPASS  :  sctp_connectx() with invalid address family - EINVAL
test_1_to_1_connectx.c    6  TPASS  :  valid blocking sctp_connectx() - SUCCESS
test_1_to_1_connectx.c    7  TPASS  :  sctp_connectx() when accept queue is full - ECONNREFUSED
test_1_to_1_connectx.c    8  TPASS  :  sctp_connectx() on a listening socket - EISCONN
test_1_to_1_connectx.c    9  TPASS  :  sctp_connectx() on an established socket - EISCONN
test_1_to_1_connectx.c   10  TPASS  :  sctp_connectx() to re-establish a closed association - SUCCESS
# ./test_1_to_1_events
test_1_to_1_events.c    1  TPASS  :  COMM_UP notification on client socket - SUCCESS
test_1_to_1_events.c    2  TPASS  :  COMM_UP notification on server socket - SUCCESS
test_1_to_1_events.c    3  TPASS  :  Data message on server socket - SUCCESS
test_1_to_1_events.c    4  TPASS  :  SHUTDOWN notification on accepted socket - SUCCESS
# ./test_1_to_1_initmsg_connect
test_1_to_1_initmsg_connect.c    1  TPASS  :  connect() with init timeout set to 0 - SUCCESS
# ./test_1_to_1_nonblock
test_1_to_1_nonblock.c    1  TPASS  :  non-blocking accept() - EAGAIN
test_1_to_1_nonblock.c    2  TPASS  :  non-blocking connect() - EINPROGRESS
test_1_to_1_nonblock.c    3  TPASS  :  accept() after a non-blocking connect - SUCCESS
test_1_to_1_nonblock.c    4  TPASS  :  non-blocking recvmsg() - EAGAIN
test_1_to_1_nonblock.c    5  TPASS  :  non-blocking recvmsg() when data is available - SUCCESS
# ./test_1_to_1_recvfrom
test_1_to_1_recvfrom.c    1  TPASS  :  recvfrom() with a bad socket descriptor - EBADF
test_1_to_1_recvfrom.c    2  TPASS  :  recvfrom() with invalid socket - ENOTSOCK
test_1_to_1_recvfrom.c    3  TPASS  :  recvfrom() with invalid message ptr - EFAULT
test_1_to_1_recvfrom.c    4  TPASS  :  recvfrom() on listening socket - ENOTCONN
test_1_to_1_recvfrom.c    5  TPASS  :  recvfrom() on a socket that has received shutdown - EOF
test_1_to_1_recvfrom.c    6  TPASS  :  recvfrom() on a socket with pending message that has sent shutdown - SUCCESS
test_1_to_1_recvfrom.c    7  TPASS  :  recvfrom() on a socket with no pending messages and  has sent shutdown - ENOTCONN
# ./test_1_to_1_recvmsg
test_1_to_1_recvmsg.c    1  TPASS  :  recvmsg() with a bad socket descriptor - EBADF
test_1_to_1_recvmsg.c    2  TPASS  :  recvmsg() with invalid socket - ENOTSOCK
test_1_to_1_recvmsg.c    3  TPASS  :  recvmsg() with invalid iovec ptr - EFAULT
test_1_to_1_recvmsg.c    4  TPASS  :  recvmsg() with invalid msghdr ptr - EFAULT
test_1_to_1_recvmsg.c    5  TPASS  :  recvmsg() on listening socket - ENOTCONN
test_1_to_1_recvmsg.c    6  TPASS  :  recvmsg() on a socket that has received shutdown - EOF
test_1_to_1_recvmsg.c    7  TPASS  :  recvmsg() on a socket with pending message that has sent shutdown - SUCCESS
test_1_to_1_recvmsg.c    8  TPASS  :  recvmsg() on a socket with no pending messages and  has sent shutdown - ENOTCONN
# ./test_1_to_1_rtoinfo
test_1_to_1_rtoinfo.c    1  TPASS  :  getsockopt() SCTP_RTOINFO - SUCCESS
test_1_to_1_rtoinfo.c    2  TPASS  :  setsockopt() SCTP_RTOINFO - SUCCESS
test_1_to_1_rtoinfo.c    3  TPASS  :  setsockopt()/getsockopt SCTP_RTOINFO compare - SUCCESS
# ./test_1_to_1_send
test_1_to_1_send.c    1  TPASS  :  send() with a bad socket descriptor - EBADF
test_1_to_1_send.c    2  TPASS  :  send() with invalid socket - ENOTSOCK
test_1_to_1_send.c    3  TPASS  :  send() on a listening socket - EPIPE
test_1_to_1_send.c    4  TPASS  :  send() on a closed association - EPIPE
test_1_to_1_send.c    5  TBROK  :  bind: Address already in use
test_1_to_1_send.c    6  TBROK  :  Remaining cases broken
# ./test_1_to_1_sendmsg
test_1_to_1_sendmsg.c    1  TPASS  :  sendmsg() with a bad socket descriptor - EBADF
test_1_to_1_sendmsg.c    2  TPASS  :  sendmsg() with invalid socket - ENOTSOCK
test_1_to_1_sendmsg.c    3  TPASS  :  sendmsg() on a listening socket - EPIPE
test_1_to_1_sendmsg.c    4  TPASS  :  sendmsg() with invalid iovec ptr - EFAULT
test_1_to_1_sendmsg.c    5  TPASS  :  sendmsg() with invalid iovec length - EINVAL
test_1_to_1_sendmsg.c    6  TPASS  :  sendmsg() with invalid msghdr ptr - EFAULT
test_1_to_1_sendmsg.c    7  TPASS  :  sendmsg() with invalid sinfo flags - EINVAL
test_1_to_1_sendmsg.c    8  TPASS  :  sendmsg() with SCTP_EOF flag - EINVAL
test_1_to_1_sendmsg.c    9  TPASS  :  sendmsg() with SCTP_ABORT flag - EINVAL
test_1_to_1_sendmsg.c   10  TPASS  :  sendmsg() on a closed association - EPIPE
test_1_to_1_sendmsg.c   11  TBROK  :  bind: Address already in use
test_1_to_1_sendmsg.c   12  TBROK  :  Remaining cases broken
# ./test_1_to_1_sendto
test_1_to_1_sendto.c    1  TPASS  :  sendto() from client to server - SUCCESS
test_1_to_1_sendto.c    2  TPASS  :  sendto() from accept socket to client - SUCCESS
test_1_to_1_sendto.c    3  TPASS  :  sendto() from unconnected client to server - SUCCESS
test_1_to_1_sendto.c    4  TPASS  :  sendto() partial data from a buffer - SUCCESS
# ./test_1_to_1_shutdown
test_1_to_1_shutdown.c    1  TPASS  :  shutdown() with a bad socket descriptor - EBADF
test_1_to_1_shutdown.c    2  TPASS  :  shutdown() with an invalid socket - ENOTSOCK
test_1_to_1_shutdown.c    3  TPASS  :  shutdown() with SHUT_WR flag - SUCCESS
test_1_to_1_shutdown.c    4  TPASS  :  shutdown() with SHUT_RD flag - SUCCESS
test_1_to_1_shutdown.c    5  TPASS  :  shutdown() with SHUT_RDWR flag - SUCCESS
test_1_to_1_shutdown.c    6  TPASS  :  shutdown() on an unconnected socket - SUCCESS
# ./test_1_to_1_socket_bind_listen
test_1_to_1_socket_bind_listen.c    1  TPASS  :  socket() with invalid domain - EAFNOSUPPORT
test_1_to_1_socket_bind_listen.c    2  TPASS  :  socket() with invalid type - EINVAL
test_1_to_1_socket_bind_listen.c    3  TPASS  :  socket() - SUCCESS
test_1_to_1_socket_bind_listen.c    4  TPASS  :  bind() with invalid address ptr - EFAULT
test_1_to_1_socket_bind_listen.c    5  TPASS  :  bind() with invalid address length - EINVAL
test_1_to_1_socket_bind_listen.c    6  TPASS  :  bind() with invalid socket descriptor - ENOTSOCK
test_1_to_1_socket_bind_listen.c    7  TPASS  :  bind() with invalid local address - EADDRNOTAVAIL
test_1_to_1_socket_bind_listen.c    8  TPASS  :  bind() on an already bound socket - EINVAL
test_1_to_1_socket_bind_listen.c    9  TPASS  :  bind() with INADDR_ANY address and non-zero port - SUCCESS
test_1_to_1_socket_bind_listen.c   10  TPASS  :  bind() with INADDR_ANY address and zero port - SUCCESS
test_1_to_1_socket_bind_listen.c   11  TPASS  :  bind() with local address and zero port - SUCCESS
test_1_to_1_socket_bind_listen.c   12  TPASS  :  listen() with bad socket descriptor - EBADF
test_1_to_1_socket_bind_listen.c   13  TPASS  :  listen() with invalid socket - ENOTSOCK
test_1_to_1_socket_bind_listen.c   14  TPASS  :  listen() on a bound socket - SUCCESS
# ./test_1_to_1_sockopt
test_1_to_1_sockopt.c    1  TPASS  :  setsockopt() with a bad socket descriptor - EBADF
test_1_to_1_sockopt.c    2  TPASS  :  setsockopt() with an invalid socket - ENOTSOCK
test_1_to_1_sockopt.c    3  TPASS  :  setsockopt() with an invalid level - ENOPROTOOPT
test_1_to_1_sockopt.c    4  TPASS  :  setsockopt() with invalid option buffer - EFAULT
test_1_to_1_sockopt.c    5  TPASS  :  setsockopt() with invalid option name - EOPNOTSUPP
test_1_to_1_sockopt.c    6  TPASS  :  getsockopt() with a bad socket descriptor - EBADF
test_1_to_1_sockopt.c    7  TPASS  :  getsockopt() with an invalid socket - ENOTSOCK
test_1_to_1_sockopt.c    8  TPASS  :  getsockopt() with invalid option buffer - EFAULT
test_1_to_1_sockopt.c    9  TPASS  :  getsockopt() with invalid option name - EOPNOTSUPP
test_1_to_1_sockopt.c   10  TPASS  :  getsockopt() SCTP_INITMSG - SUCCESS
test_1_to_1_sockopt.c   11  TPASS  :  setsockopt() SCTP_INITMSG - SUCCESS
test_1_to_1_sockopt.c   12  TPASS  :  setsockopt() SO_LINGER - SUCCESS
test_1_to_1_sockopt.c   13  TPASS  :  getsockopt() SO_LINGER - SUCCESS
test_1_to_1_sockopt.c   14  TPASS  :  getsockopt() SO_RCVBUF - SUCCESS
test_1_to_1_sockopt.c   15  TPASS  :  getsockopt() SCTP_STATUS - SUCCESS
test_1_to_1_sockopt.c   16  TPASS  :  setsockopt() SO_RCVBUF - SUCCESS
test_1_to_1_sockopt.c   17  TPASS  :  setsockopt() SO_SNDBUF - SUCCESS
test_1_to_1_sockopt.c   18  TPASS  :  getsockopt() SO_SNDBUF - SUCCESS
test_1_to_1_sockopt.c   19  TPASS  :  getsockopt() SCTP_PRIMARY_ADDR - SUCCESS
test_1_to_1_sockopt.c   20  TPASS  :  setsockopt() SCTP_PRIMARY_ADDR - SUCCESS
test_1_to_1_sockopt.c   21  TPASS  :  getsockopt() SCTP_ASSOCINFO - SUCCESS
test_1_to_1_sockopt.c   22  TPASS  :  setsockopt() SCTP_ASSOCINFO - SUCCESS
# ./test_1_to_1_threads
test_1_to_1_threads.c    1  TPASS  :  send and receive data across multiple threads - SUCCESS
# ./test_assoc_abort
test_assoc_abort.c    1  TPASS  :  ABORT an association using SCTP_ABORT
# ./test_assoc_shutdown
test_assoc_shutdown.c    1  TPASS  :  Graceful shutdown of associations using SCTP_EOF
# ./test_autoclose
test_autoclose.c    0  TINFO  :  Waiting for the associations to close automatically in 5 secs
test_autoclose.c    1  TPASS  :  Autoclose of associations
# ./test_basic
test_basic.c    1  TPASS  :  socket
test_basic.c    2  TPASS  :  bind
test_basic.c    3  TPASS  :  recvmsg on a socket neither listening nor established
test_basic.c    4  TPASS  :  listen
test_basic.c    5  TPASS  :  sendmsg with a valid msg_name
test_basic.c    6  TPASS  :  recvmsg COMM_UP notifications
test_basic.c    7  TPASS  :  sendmsg with NULL associd and NULL msg_name
test_basic.c    8  TPASS  :  sendmsg with incorrect associd
test_basic.c    9  TPASS  :  sendmsg with valid associd
test_basic.c   10  TPASS  :  recvmsg
test_basic.c   11  TPASS  :  sctp_getladdrs
test_basic.c    0  TINFO  :  LOCAL ADDR 127.0.0.1 PORT 1024
test_basic.c    0  TINFO  :  LOCAL ADDR 10.66.86.114 PORT 1024
test_basic.c    0  TINFO  :  LOCAL ADDR 192.168.0.20 PORT 1024
test_basic.c   12  TPASS  :  sctp_freeladdrs
test_basic.c   13  TPASS  :  sctp_getpaddrs
test_basic.c    0  TINFO  :  PEER ADDR 127.0.0.1 PORT 1025
test_basic.c   14  TPASS  :  sctp_freepaddrs
test_basic.c   15  TPASS  :  recvmsg SHUTDOWN_COMP notification
# ./test_basic_v6
test_basic.c    1  TPASS  :  socket
test_basic.c    2  TPASS  :  bind
test_basic.c    3  TPASS  :  recvmsg on a socket neither listening nor established
test_basic.c    4  TPASS  :  listen
test_basic.c    5  TPASS  :  sendmsg with a valid msg_name
test_basic.c    6  TPASS  :  recvmsg COMM_UP notifications
test_basic.c    7  TPASS  :  sendmsg with NULL associd and NULL msg_name
test_basic.c    8  TPASS  :  sendmsg with incorrect associd
test_basic.c    9  TPASS  :  sendmsg with valid associd
test_basic.c   10  TPASS  :  recvmsg
test_basic.c   11  TPASS  :  sctp_getladdrs
test_basic.c    0  TINFO  :  LOCAL ADDR 0000:0000:0000:0000:0000:ffff:7f00:0001 PORT 1024
test_basic.c    0  TINFO  :  LOCAL ADDR 0000:0000:0000:0000:0000:0000:0000:0001 PORT 1024
test_basic.c    0  TINFO  :  LOCAL ADDR 0000:0000:0000:0000:0000:ffff:0a42:5672 PORT 1024
test_basic.c    0  TINFO  :  LOCAL ADDR 2620:0052:0000:4257:2e76:8aff:fe56:ef28 PORT 1024
test_basic.c    0  TINFO  :  LOCAL ADDR fe80:0000:0000:0000:2e76:8aff:fe56:ef28 PORT 1024
test_basic.c    0  TINFO  :  LOCAL ADDR 0000:0000:0000:0000:0000:ffff:c0a8:0014 PORT 1024
test_basic.c    0  TINFO  :  LOCAL ADDR 3ffe:0501:ffff:0100:0000:0000:0000:0020 PORT 1024
test_basic.c    0  TINFO  :  LOCAL ADDR fe80:0000:0000:0000:2e76:8aff:fe56:ef29 PORT 1024
test_basic.c    0  TINFO  :  LOCAL ADDR 3ffe:0501:ffff:0101:0000:0000:0000:0020 PORT 1024
test_basic.c    0  TINFO  :  LOCAL ADDR fe80:0000:0000:0000:2e76:8aff:fe56:ef2b PORT 1024
test_basic.c   12  TPASS  :  sctp_freeladdrs
test_basic.c   13  TPASS  :  sctp_getpaddrs
test_basic.c    0  TINFO  :  PEER ADDR 0000:0000:0000:0000:0000:0000:0000:0001 PORT 1025
test_basic.c   14  TPASS  :  sctp_freepaddrs
test_basic.c   15  TPASS  :  recvmsg SHUTDOWN_COMP notification
# ./test_connect
test_connect.c    1  TPASS  :  non-blocking connect
test_connect.c    2  TPASS  :  connect on a socket to create an assoc that is already established
test_connect.c    3  TPASS  :  blocking connect
test_connect.c    4  TPASS  :  connect on a peeled off socket
test_connect.c    5  TPASS  :  connect to create an assoc that matches a peeled off assoc
# ./test_connectx
test_connectx.c    1  TPASS  :  non-blocking connectx
test_connectx.c    2  TPASS  :  connectx on a socket to create an assoc that is already established
test_connectx.c    3  TPASS  :  Association id match between sctp_connectx() and notification.
test_connectx.c    4  TPASS  :  blocking connectx
test_connectx.c    5  TPASS  :  connectx on a peeled off socket
test_connectx.c    6  TPASS  :  connectx to create an assoc that matches a peeled off assoc
test_connectx.c    7  TPASS  :  server association 1 peers ok
test_connectx.c    8  TPASS  :  server association 2 peers ok
test_connectx.c    9  TPASS  :  client association 1 peers ok
test_connectx.c   10  TPASS  :  client association 2 peers ok
# ./test_fragments
test_fragments.c    1  TPASS  :  setsockopt(SCTP_DISABLE_FRAGMENTS)
test_fragments.c    2  TPASS  :  getsockopt(SCTP_DISABLE_FRAGMENTS)
test_fragments.c    3  TPASS  :  Send a message that exceeds assoc frag point
test_fragments.c    0  TINFO  :  Sent 1353 byte message
test_fragments.c    0  TINFO  :  Received 1353 byte message
test_fragments.c    0  TINFO  :  Sent 2000 byte message
test_fragments.c    0  TINFO  :  Received 2000 byte message
test_fragments.c    0  TINFO  :  Sent 5000 byte message
test_fragments.c    0  TINFO  :  Received 5000 byte message
test_fragments.c    0  TINFO  :  Sent 10000 byte message
test_fragments.c    0  TINFO  :  Received 10000 byte message
test_fragments.c    0  TINFO  :  Sent 20000 byte message
test_fragments.c    0  TINFO  :  Received 20000 byte message
test_fragments.c    0  TINFO  :  Sent 32768 byte message
test_fragments.c    0  TINFO  :  Received 32768 byte message
test_fragments.c    4  TPASS  :  Send/Receive fragmented messages
# ./test_fragments_v6
test_fragments.c    1  TPASS  :  setsockopt(SCTP_DISABLE_FRAGMENTS)
test_fragments.c    2  TPASS  :  getsockopt(SCTP_DISABLE_FRAGMENTS)
test_fragments.c    3  TPASS  :  Send a message that exceeds assoc frag point
test_fragments.c    0  TINFO  :  Sent 1353 byte message
test_fragments.c    0  TINFO  :  Received 1353 byte message
test_fragments.c    0  TINFO  :  Sent 2000 byte message
test_fragments.c    0  TINFO  :  Received 2000 byte message
test_fragments.c    0  TINFO  :  Sent 5000 byte message
test_fragments.c    0  TINFO  :  Received 5000 byte message
test_fragments.c    0  TINFO  :  Sent 10000 byte message
test_fragments.c    0  TINFO  :  Received 10000 byte message
test_fragments.c    0  TINFO  :  Sent 20000 byte message
test_fragments.c    0  TINFO  :  Received 20000 byte message
test_fragments.c    0  TINFO  :  Sent 32768 byte message
test_fragments.c    0  TINFO  :  Received 32768 byte message
test_fragments.c    4  TPASS  :  Send/Receive fragmented messages
# ./test_getname
test_getname.c    1  TPASS  :  getsockname on an unconnected socket
test_getname.c    2  TPASS  :  getpeername on an unconnected socket
test_getname.c    3  TPASS  :  getsockname on a connected client socket
test_getname.c    4  TPASS  :  getpeername on a connected client socket
test_getname.c    5  TPASS  :  getsockname on a connected server socket
test_getname.c    6  TPASS  :  getpeername on a connected server socket
test_getname.c    7  TPASS  :  getsockname/getpeername server/client match
test_getname.c    8  TPASS  :  getsockname on a bad socket descriptor - EBADF
test_getname.c    9  TPASS  :  getsockname on an invalid socket - ENOTSOCK
test_getname.c   10  TPASS  :  getsockname with invalid buffer - EFAULT
test_getname.c   11  TPASS  :  getpeername on a bad socket descriptor - EBADF
test_getname.c   12  TPASS  :  getpeername on an invalid socket - ENOTSOCK
test_getname.c   13  TPASS  :  getpeername with invalid buffer - EFAULT
# ./test_getname_v6
test_getname.c    1  TPASS  :  getsockname on an unconnected socket
test_getname.c    2  TPASS  :  getpeername on an unconnected socket
test_getname.c    3  TPASS  :  getsockname on a connected client socket
test_getname.c    4  TPASS  :  getpeername on a connected client socket
test_getname.c    5  TPASS  :  getsockname on a connected server socket
test_getname.c    6  TPASS  :  getpeername on a connected server socket
test_getname.c    7  TPASS  :  getsockname/getpeername server/client match
test_getname.c    8  TPASS  :  getsockname on a bad socket descriptor - EBADF
test_getname.c    9  TPASS  :  getsockname on an invalid socket - ENOTSOCK
test_getname.c   10  TPASS  :  getsockname with invalid buffer - EFAULT
test_getname.c   11  TPASS  :  getpeername on a bad socket descriptor - EBADF
test_getname.c   12  TPASS  :  getpeername on an invalid socket - ENOTSOCK
test_getname.c   13  TPASS  :  getpeername with invalid buffer - EFAULT
# ./test_inaddr_any
test_inaddr_any.c    1  TPASS  :  bind INADDR_ANY address
test_inaddr_any.c    2  TPASS  :  send msgs from a socket with INADDR_ANY bind address
# ./test_inaddr_any_v6
test_inaddr_any.c    1  TPASS  :  bind INADDR_ANY address
test_inaddr_any.c    2  TPASS  :  send msgs from a socket with INADDR_ANY bind address
# ./test_peeloff
test_peeloff.c    1  TPASS  :  sctp_peeloff
test_peeloff.c    2  TPASS  :  listen on a peeled off socket
test_peeloff.c    3  TPASS  :  sctp_peeloff on a peeled off socket
test_peeloff.c    4  TPASS  :  Receive msgs on peeled off sockets
test_peeloff.c    5  TPASS  :  Send msgs on peeled off sockets
test_peeloff.c    6  TPASS  :  peeled off socket cannot initialize a new assoc
# ./test_peeloff_v6
test_peeloff.c    1  TPASS  :  sctp_peeloff
test_peeloff.c    2  TPASS  :  listen on a peeled off socket
test_peeloff.c    3  TPASS  :  sctp_peeloff on a peeled off socket
test_peeloff.c    4  TPASS  :  Receive msgs on peeled off sockets
test_peeloff.c    5  TPASS  :  Send msgs on peeled off sockets
test_peeloff.c    6  TPASS  :  peeled off socket cannot initialize a new assoc
# ./test_recvmsg
test_recvmsg.c    1  TPASS  :  recvmsg with MSG_PEEK flag
test_recvmsg.c    2  TPASS  :  MSG_EOR in msg_flags set correctly
# ./test_sctp_sendrecvmsg
test_sctp_sendrecvmsg.c    1  TPASS  :  sctp_sendmsg
test_sctp_sendrecvmsg.c    2  TPASS  :  sctp_recvmsg SCTP_COMM_UP notification
test_sctp_sendrecvmsg.c    3  TPASS  :  sctp_recvmsg data
test_sctp_sendrecvmsg.c    0  TINFO  :  creating a fillmsg of size 3087
test_sctp_sendrecvmsg.c    4  TPASS  :  sctp_sendmsg with ttl
test_sctp_sendrecvmsg.c    5  TPASS  :  sctp_sendmsg with zero ttl
test_sctp_sendrecvmsg.c    6  TPASS  :  sctp_sendmsg fragmented msg with ttl
test_sctp_sendrecvmsg.c    0  TINFO  :  **  SLEEPING for 3 seconds **
test_sctp_sendrecvmsg.c    7  TPASS  :  sctp_recvmsg msg with zero ttl
test_sctp_sendrecvmsg.c    8  TPASS  :  sctp_recvmsg SEND_FAILED for message with ttl
test_sctp_sendrecvmsg.c    9  TPASS  :  sctp_recvmsg SEND_FAILED for fragmented message with ttl
test_sctp_sendrecvmsg.c   10  TPASS  :  sctp_send
# ./test_sctp_sendrecvmsg_v6
test_sctp_sendrecvmsg.c    1  TPASS  :  sctp_sendmsg
test_sctp_sendrecvmsg.c    2  TPASS  :  sctp_recvmsg SCTP_COMM_UP notification
test_sctp_sendrecvmsg.c    3  TPASS  :  sctp_recvmsg data
test_sctp_sendrecvmsg.c    0  TINFO  :  creating a fillmsg of size 3087
test_sctp_sendrecvmsg.c    4  TPASS  :  sctp_sendmsg with ttl
test_sctp_sendrecvmsg.c    5  TPASS  :  sctp_sendmsg with zero ttl
test_sctp_sendrecvmsg.c    6  TPASS  :  sctp_sendmsg fragmented msg with ttl
test_sctp_sendrecvmsg.c    0  TINFO  :  **  SLEEPING for 3 seconds **
test_sctp_sendrecvmsg.c    7  TPASS  :  sctp_recvmsg msg with zero ttl
test_sctp_sendrecvmsg.c    8  TPASS  :  sctp_recvmsg SEND_FAILED for message with ttl
test_sctp_sendrecvmsg.c    9  TPASS  :  sctp_recvmsg SEND_FAILED for fragmented message with ttl
test_sctp_sendrecvmsg.c   10  TPASS  :  sctp_send
# ./test_sockopt
test_sockopt.c  1 PASS : getsockopt(SCTP_STATUS) on a socket with no assoc
test_sockopt.c  2 PASS : getsockopt(SCTP_STATUS)
test_sockopt.c  3 PASS : getsockopt(SCTP_STATUS) with invalid associd
test_sockopt.c  4 PASS : getsockopt(SCTP_STATUS) with NULL associd
test_sockopt.c  5 PASS : getsockopt(SCTP_EVENTS)
test_sockopt.c  6 PASS : setsockopt(SCTP_EVENTS)
test_sockopt.c  7 PASS : setsockopt(SCTP_EVENTS) - SCTP_SHUTDOWN_EVENT
test_sockopt.c  8 PASS : sctp_opt_info(SCTP_STATUS)
test_sockopt.c  9 PASS : getsockopt(SCTP_INITMSG)
test_sockopt.c 10 PASS : setsockopt(SCTP_INITMSG)
test_sockopt.c 11 PASS : getsockopt(SCTP_PEER_ADDR_PARAMS)
test_sockopt.c 12 PASS : setsockopt(SCTP_DELAYED_ACK_TIME)
test_sockopt.c 13 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS)
test_sockopt.c 14 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid associd
test_sockopt.c 15 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style valid associd valid address
test_sockopt.c 16 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid transport
test_sockopt.c 17 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid parameter length
test_sockopt.c 18 PASS : setsockopt(SCTP_DELAYED_ACK_TIME) - one-to-many style invalid parameter length
test_sockopt.c 19 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid sack delay
test_sockopt.c 20 PASS : setsockopt(SCTP_DELAYED_ACK_TIME) - one-to-many style invalid sack delay
test_sockopt.c 21 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid path MTU
test_sockopt.c 22 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid hb enable flags
test_sockopt.c 23 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid PMTU discovery enable flags
test_sockopt.c 24 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid sack delay enable flags
test_sockopt.c 25 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid hb demand
test_sockopt.c 26 PASS : setsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style socket
test_sockopt.c 27 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style socket
test_sockopt.c 28 PASS : setsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style invalid associd
test_sockopt.c 29 PASS : setsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style associd belonging to another socket
test_sockopt.c 30 PASS : setsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style valid associd
test_sockopt.c 31 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style valid associd
test_sockopt.c 32 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style zero associd
test_sockopt.c 33 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style peeled off socket
test_sockopt.c 34 PASS : setsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-one style socket
test_sockopt.c 35 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-one style socket
test_sockopt.c 36 PASS : setsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-one style assoc
test_sockopt.c 37 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-one style assoc
test_sockopt.c 38 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-one style accepted socket
test_sockopt.c 39 PASS : getsockopt(SCTP_GET_PEER_ADDR_INFO) - null associd and null addr
test_sockopt.c 40 PASS : getsockopt(SCTP_GET_PEER_ADDR_INFO) - valid associd and null addr
test_sockopt.c 41 PASS : getsockopt(SCTP_GET_PEER_ADDR_INFO) - valid associd and invalid addr
test_sockopt.c 42 PASS : getsockopt(SCTP_GET_PEER_ADDR_INFO) - valid associd and valid addr
test_sockopt.c 43 PASS : getsockopt(SCTP_GET_PEER_ADDR_INFO) - valid associd and valid addr peeled off socket
test_sockopt.c 44 PASS : getsockopt(SCTP_GET_PEER_ADDR_INFO) - valid associd and valid addr accepted socket
# ./test_sockopt_v6
test_sockopt.c  1 PASS : getsockopt(SCTP_STATUS) on a socket with no assoc
test_sockopt.c  2 PASS : getsockopt(SCTP_STATUS)
test_sockopt.c  3 PASS : getsockopt(SCTP_STATUS) with invalid associd
test_sockopt.c  4 PASS : getsockopt(SCTP_STATUS) with NULL associd
test_sockopt.c  5 PASS : getsockopt(SCTP_EVENTS)
test_sockopt.c  6 PASS : setsockopt(SCTP_EVENTS)
test_sockopt.c  7 PASS : setsockopt(SCTP_EVENTS) - SCTP_SHUTDOWN_EVENT
test_sockopt.c  8 PASS : sctp_opt_info(SCTP_STATUS)
test_sockopt.c  9 PASS : getsockopt(SCTP_INITMSG)
test_sockopt.c 10 PASS : setsockopt(SCTP_INITMSG)
test_sockopt.c 11 PASS : getsockopt(SCTP_PEER_ADDR_PARAMS)
test_sockopt.c 12 PASS : setsockopt(SCTP_DELAYED_ACK_TIME)
test_sockopt.c 13 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS)
test_sockopt.c 14 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid associd
test_sockopt.c 15 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style valid associd valid address
test_sockopt.c 16 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid transport
test_sockopt.c 17 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid parameter length
test_sockopt.c 18 PASS : setsockopt(SCTP_DELAYED_ACK_TIME) - one-to-many style invalid parameter length
test_sockopt.c 19 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid sack delay
test_sockopt.c 20 PASS : setsockopt(SCTP_DELAYED_ACK_TIME) - one-to-many style invalid sack delay
test_sockopt.c 21 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid path MTU
test_sockopt.c 22 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid hb enable flags
test_sockopt.c 23 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid PMTU discovery enable flags
test_sockopt.c 24 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid sack delay enable flags
test_sockopt.c 25 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid hb demand
test_sockopt.c 26 PASS : setsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style socket
test_sockopt.c 27 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style socket
test_sockopt.c 28 PASS : setsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style invalid associd
test_sockopt.c 29 PASS : setsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style associd belonging to another socket
test_sockopt.c 30 PASS : setsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style valid associd
test_sockopt.c 31 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style valid associd
test_sockopt.c 32 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style zero associd
test_sockopt.c 33 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-many style peeled off socket
test_sockopt.c 34 PASS : setsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-one style socket
test_sockopt.c 35 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-one style socket
test_sockopt.c 36 PASS : setsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-one style assoc
test_sockopt.c 37 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-one style assoc
test_sockopt.c 38 PASS : getsockopt(SCTP_DEFAULT_SEND_PARAM) - one-to-one style accepted socket
test_sockopt.c 39 PASS : getsockopt(SCTP_GET_PEER_ADDR_INFO) - null associd and null addr
test_sockopt.c 40 PASS : getsockopt(SCTP_GET_PEER_ADDR_INFO) - valid associd and null addr
test_sockopt.c 41 PASS : getsockopt(SCTP_GET_PEER_ADDR_INFO) - valid associd and invalid addr
test_sockopt.c 42 PASS : getsockopt(SCTP_GET_PEER_ADDR_INFO) - valid associd and valid addr
test_sockopt.c 43 PASS : getsockopt(SCTP_GET_PEER_ADDR_INFO) - valid associd and valid addr peeled off socket
test_sockopt.c 44 PASS : getsockopt(SCTP_GET_PEER_ADDR_INFO) - valid associd and valid addr accepted socket
#  ./test_tcp_style
test_tcp_style.c  1 PASS : accept on non-listening socket
test_tcp_style.c  2 PASS : connect to non-listening socket
test_tcp_style.c  3 PASS : connect to listening socket
test_tcp_style.c  4 PASS : connect after max backlog
test_tcp_style.c  5 PASS : accept from listening socket
test_tcp_style.c  6 PASS : connect on an established socket
test_tcp_style.c  7 PASS : accept on an established socket
test_tcp_style.c  8 PASS : client sockets -> accepted sockets
test_tcp_style.c  9 PASS : accepted sockets -> client sockets
test_tcp_style.c 10 PASS : send on a listening socket
test_tcp_style.c 11 PASS : recv on a listening socket
test_tcp_style.c 12 PASS : recv on a SHUTDOWN received socket
test_tcp_style.c 13 PASS : recv SHUTDOWN_COMP notification on a SHUT_WR socket
test_tcp_style.c 14 PASS : recv on a SHUTDOWN sent socket
test_tcp_style.c 15 PASS : recv on a SHUT_RD socket
test_tcp_style.c 16 PASS : recv on a SHUT_RDWR socket
test_tcp_style.c 17 PASS : accept of a CLOSED association
test_tcp_style.c 18 PASS : send to a CLOSED association
test_tcp_style.c 19 PASS : auto-connect using sendto
test_tcp_style.c 20 PASS : sendmsg with SCTP_EOF flag
test_tcp_style.c 21 PASS : sendmsg with SCTP_ABORT flag
test_tcp_style.c 22 PASS : sendmsg with no flags
# ./test_tcp_style_v6
test_tcp_style.c  1 PASS : accept on non-listening socket
test_tcp_style.c  2 PASS : connect to non-listening socket
test_tcp_style.c  3 PASS : connect to listening socket
test_tcp_style.c  4 PASS : connect after max backlog
test_tcp_style.c  5 PASS : accept from listening socket
test_tcp_style.c  6 PASS : connect on an established socket
test_tcp_style.c  7 PASS : accept on an established socket
test_tcp_style.c  8 PASS : client sockets -> accepted sockets
test_tcp_style.c  9 PASS : accepted sockets -> client sockets
test_tcp_style.c 10 PASS : send on a listening socket
test_tcp_style.c 11 PASS : recv on a listening socket
test_tcp_style.c 12 PASS : recv on a SHUTDOWN received socket
test_tcp_style.c 13 PASS : recv SHUTDOWN_COMP notification on a SHUT_WR socket
test_tcp_style.c 14 PASS : recv on a SHUTDOWN sent socket
test_tcp_style.c 15 PASS : recv on a SHUT_RD socket
test_tcp_style.c 16 PASS : recv on a SHUT_RDWR socket
test_tcp_style.c 17 PASS : accept of a CLOSED association
test_tcp_style.c 18 PASS : send to a CLOSED association
test_tcp_style.c 19 PASS : auto-connect using sendto
test_tcp_style.c 20 PASS : sendmsg with SCTP_EOF flag
test_tcp_style.c 21 PASS : sendmsg with SCTP_ABORT flag
test_tcp_style.c 22 PASS : sendmsg with no flags
# ./test_timetolive
test_timetolive.c    0  TINFO  :  Creating fillmsg of size 3087
test_timetolive.c    1  TPASS  :  Send a message with timeout
test_timetolive.c    2  TPASS  :  Send a message with no timeout
test_timetolive.c    3  TPASS  :  Send a fragmented message with timeout
test_timetolive.c    0  TINFO  :   **  SLEEPING for 3 seconds **
test_timetolive.c    4  TPASS  :  Receive message with no timeout
test_timetolive.c    5  TPASS  :  Receive SEND_FAILED for message with timeout
test_timetolive.c    6  TPASS  :  Receive SEND_FAILED for fragmented message with timeout
# ./test_timetolive_v6
test_timetolive.c    0  TINFO  :  Creating fillmsg of size 3087
test_timetolive.c    1  TPASS  :  Send a message with timeout
test_timetolive.c    2  TPASS  :  Send a message with no timeout
test_timetolive.c    3  TPASS  :  Send a fragmented message with timeout
test_timetolive.c    0  TINFO  :   **  SLEEPING for 3 seconds **
test_timetolive.c    4  TPASS  :  Receive message with no timeout
test_timetolive.c    5  TPASS  :  Receive SEND_FAILED for message with timeout
test_timetolive.c    6  TPASS  :  Receive SEND_FAILED for fragmented message with timeout

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
