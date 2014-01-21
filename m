Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1W5QO9-0007F4-TX
	for ltp-list@lists.sourceforge.net; Tue, 21 Jan 2014 01:44:25 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W5QO8-0000Kg-60
	for ltp-list@lists.sourceforge.net; Tue, 21 Jan 2014 01:44:25 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s0L1iHIG027905
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jan 2014 01:44:18 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s0L1iHKV024044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jan 2014 01:44:17 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s0L1iHIj024021
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jan 2014 01:44:17 GMT
Message-ID: <52DDD0ED.6040702@oracle.com>
Date: Tue, 21 Jan 2014 09:44:13 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <1387171228-505-1-git-send-email-xu.simon@oracle.com>
	<52BA3898.3050909@oracle.com>
In-Reply-To: <52BA3898.3050909@oracle.com>
Subject: Re: [LTP] [PATCH] sctp: Avoid using file descriptor 0 to get
	ENOTSOCK
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
To: ltp-list@lists.sourceforge.net

Could anyone help to review this?

Thanks
Simon

On 2013/12/25 9:44, Simon Xu wrote:
> Could anyone help to review this?
>
> Thanks
> Simon
>
> On 2013/12/16 13:20, Simon Xu wrote:
>> On some systems, errno will not be ENOTSOCK when operating on file descriptor
>> 0 in an ssh session:
>>
>> test_1_to_1_accept_close.c    2  TBROK  :  accept with invalid socketerror:-1, errno:22
>> test_1_to_1_addrs.c    2  TBROK  :  sctp_getladdrs with invalid socket error:-1, errno:95
>> test_1_to_1_connect.c    2  TBROK  :  connect with invalid socket error:-1, errno:22
>> test_1_to_1_recvfrom.c    2  TBROK  :  recvfrom with invalid socket count:0, errno:9
>> test_1_to_1_recvmsg.c    2  TBROK  :  recvmsg with invalid socket count:0, errno:9
>> test_1_to_1_send.c    2  TBROK  :  send with invalid socket count:15, errno:9
>> test_1_to_1_sendmsg.c    2  TBROK  :  sendmsg with invalid socket count:-1, errno:106
>> test_1_to_1_shutdown.c    2  TBROK  :  shutdown with an invalid socket error:0, errno:9
>> test_1_to_1_socket_bind_listen.c    6  TBROK  :  bind() with invalid socket descriptor error:-1, errno:22
>> test_1_to_1_sockopt.c    2  TBROK  :  setsockopt with an invalid socket error:-1, errno:95
>> test_getname.c    9  TBROK  :  getsockname on an invalid socket error:0 errno:9
>>
>> This patch gets a non-socket file descriptor by creating a temporary file
>> to replace file descriptor 0.
>>
>> https://github.com/borkmann/lksctp-tools/commit/c43ead6daa0b9ae5763d6cf3d21357a789651417
>> Signed-off-by: Simon Xu <xu.simon@oracle.com>
>> ---
>>    utils/sctp/func_tests/test_1_to_1_accept_close.c   | 17 ++++++++++--
>>    utils/sctp/func_tests/test_1_to_1_addrs.c          | 32 ++++++++++++++++++----
>>    utils/sctp/func_tests/test_1_to_1_connect.c        | 17 ++++++++++--
>>    utils/sctp/func_tests/test_1_to_1_recvfrom.c       | 17 ++++++++++--
>>    utils/sctp/func_tests/test_1_to_1_recvmsg.c        | 17 ++++++++++--
>>    utils/sctp/func_tests/test_1_to_1_send.c           | 17 ++++++++++--
>>    utils/sctp/func_tests/test_1_to_1_sendmsg.c        | 17 ++++++++++--
>>    utils/sctp/func_tests/test_1_to_1_shutdown.c       | 17 ++++++++++--
>>    .../func_tests/test_1_to_1_socket_bind_listen.c    | 32 ++++++++++++++++++----
>>    utils/sctp/func_tests/test_1_to_1_sockopt.c        | 32 ++++++++++++++++++----
>>    utils/sctp/func_tests/test_getname.c               | 32 ++++++++++++++++++----
>>    11 files changed, 202 insertions(+), 45 deletions(-)
>>
>> diff --git a/utils/sctp/func_tests/test_1_to_1_accept_close.c b/utils/sctp/func_tests/test_1_to_1_accept_close.c
>> index ea1c57a..cbb1814 100644
>> --- a/utils/sctp/func_tests/test_1_to_1_accept_close.c
>> +++ b/utils/sctp/func_tests/test_1_to_1_accept_close.c
>> @@ -78,6 +78,8 @@ main(int argc, char *argv[])
>>    	int sk,lstn_sk,clnt_sk[SK_MAX],acpt_sk,pf_class;
>>    	int new_sk[SK_MAX],clnt2_sk[SK_MAX];
>>    	int error;
>> +	int fd, err_no = 0;
>> +	char filename[21];
>>    
>>            struct sockaddr_in conn_addr,lstn_addr,acpt_addr;
>>    
>> @@ -134,10 +136,19 @@ main(int argc, char *argv[])
>>    	tst_resm(TPASS, "accept() with a bad socket descriptor - EBADF");
>>    
>>            /*accept() TEST2: Invalid socket ENOTSOCK, Expected error*/
>> -        error = accept(0, (struct sockaddr *) &acpt_addr, &len);
>> -        if (error != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	error = accept(fd, (struct sockaddr *) &acpt_addr, &len);
>> +	if (error == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (error != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "accept with invalid socket"
>> -                         "error:%d, errno:%d", error, errno);
>> +                         "error:%d, errno:%d", error, err_no);
>>    
>>    	tst_resm(TPASS, "accept() with invalid socket - ENOTSOCK");
>>    
>> diff --git a/utils/sctp/func_tests/test_1_to_1_addrs.c b/utils/sctp/func_tests/test_1_to_1_addrs.c
>> index 40eed7f..5d56918 100644
>> --- a/utils/sctp/func_tests/test_1_to_1_addrs.c
>> +++ b/utils/sctp/func_tests/test_1_to_1_addrs.c
>> @@ -92,6 +92,8 @@ main(int argc, char *argv[])
>>            char * buffer_rcv;
>>    	char incmsg[CMSG_SPACE(sizeof(sctp_cmsg_data_t))];
>>    	struct sockaddr *laddrs, *paddrs;
>> +	int fd, err_no = 0;
>> +	char filename[21];
>>    
>>            struct sockaddr_in conn_addr,lstn_addr,acpt_addr;
>>    	struct sockaddr_in *addr;
>> @@ -176,10 +178,19 @@ main(int argc, char *argv[])
>>    		 "EBADF");
>>    
>>    	/*sctp_getladdrs() TEST2: Invalid socket, ENOTSOCK Expected error*/
>> -	error = sctp_getladdrs(0, 0, &laddrs);
>> -	if (error != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	error = sctp_getladdrs(fd, 0, &laddrs);
>> +	if (error == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (error != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "sctp_getladdrs with invalid socket "
>> -			 "error:%d, errno:%d", error, errno);
>> +			 "error:%d, errno:%d", error, err_no);
>>    
>>    	tst_resm(TPASS, "sctp_getladdrs() with invalid socket - ENOTSOCK");
>>    
>> @@ -225,10 +236,19 @@ main(int argc, char *argv[])
>>    		 "EBADF");
>>    
>>    	/*sctp_getpaddrs() TEST7: Invalid socket, ENOTSOCK Expected error*/
>> -	error = sctp_getpaddrs(0, 0, &paddrs);
>> -	if (error != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	error = sctp_getpaddrs(fd, 0, &paddrs);
>> +	if (error == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (error != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "sctp_getpaddrs with invalid socket "
>> -			 "error:%d, errno:%d", error, errno);
>> +			 "error:%d, errno:%d", error, err_no);
>>    
>>    	tst_resm(TPASS, "sctp_getpaddrs() with invalid socket - ENOTSOCK");
>>    	
>> diff --git a/utils/sctp/func_tests/test_1_to_1_connect.c b/utils/sctp/func_tests/test_1_to_1_connect.c
>> index 6670f72..e1993e4 100644
>> --- a/utils/sctp/func_tests/test_1_to_1_connect.c
>> +++ b/utils/sctp/func_tests/test_1_to_1_connect.c
>> @@ -72,6 +72,8 @@ main(int argc, char *argv[])
>>    	socklen_t len;
>>    	int sk,lstn_sk,clnt_sk[SK_MAX],acpt_sk[SK_MAX],pf_class;
>>    	int sk1,clnt2_sk;
>> +	int fd, err_no = 0;
>> +	char filename[21];
>>    
>>            struct sockaddr_in conn_addr,lstn_addr,acpt_addr;
>>    
>> @@ -120,10 +122,19 @@ main(int argc, char *argv[])
>>    	tst_resm(TPASS, "connect() with bad socket descriptor - EBADF");
>>    	
>>    	/*connect () TEST2: Invalid socket, ENOTSOCK Expected error*/
>> -	error = connect(0, (const struct sockaddr *) &conn_addr, len);
>> -	if (error != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	error = connect(fd, (const struct sockaddr *) &conn_addr, len);
>> +	if (error == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (error != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "connect with invalid socket "
>> -                         "error:%d, errno:%d", error, errno);
>> +                         "error:%d, errno:%d", error, err_no);
>>    
>>    	tst_resm(TPASS, "connect() with invalid socket - ENOTSOCK");
>>    
>> diff --git a/utils/sctp/func_tests/test_1_to_1_recvfrom.c b/utils/sctp/func_tests/test_1_to_1_recvfrom.c
>> index a4bdf6a..0ede562 100644
>> --- a/utils/sctp/func_tests/test_1_to_1_recvfrom.c
>> +++ b/utils/sctp/func_tests/test_1_to_1_recvfrom.c
>> @@ -69,6 +69,8 @@ main(int argc, char *argv[])
>>            char *message = "hello, world!\n";
>>    	char *message_rcv;
>>            int count;
>> +	int fd, err_no = 0;
>> +	char filename[21];
>>    
>>            struct sockaddr_in conn_addr,lstn_addr,svr_addr;
>>    
>> @@ -122,11 +124,20 @@ main(int argc, char *argv[])
>>    	tst_resm(TPASS, "recvfrom() with a bad socket descriptor - EBADF");
>>    
>>    	/*recvfrom () TEST2: Invalid socket , ENOTSOCK Expected error*/
>> -	count = recvfrom(0, message_rcv, msg_count, flag,
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	count = recvfrom(fd, message_rcv, msg_count, flag,
>>    			 (struct sockaddr *)&svr_addr, &len);
>> -	if (count != -1 || errno != ENOTSOCK)
>> +	if (count == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (count != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "recvfrom with invalid socket "
>> -			 "count:%d, errno:%d", count, errno);
>> +			 "count:%d, errno:%d", count, err_no);
>>    
>>    	tst_resm(TPASS, "recvfrom() with invalid socket - ENOTSOCK");
>>    
>> diff --git a/utils/sctp/func_tests/test_1_to_1_recvmsg.c b/utils/sctp/func_tests/test_1_to_1_recvmsg.c
>> index ceccc31..5f06bb6 100644
>> --- a/utils/sctp/func_tests/test_1_to_1_recvmsg.c
>> +++ b/utils/sctp/func_tests/test_1_to_1_recvmsg.c
>> @@ -67,6 +67,8 @@ main(int argc, char *argv[])
>>            socklen_t len;
>>    	int sk,pf_class,lstn_sk,acpt_sk;
>>    	int flag = 0;
>> +	int fd, err_no = 0;
>> +	char filename[21];
>>    	struct msghdr inmessage;
>>            char *message = "hello, world!\n";
>>    	struct iovec iov_rcv;
>> @@ -128,10 +130,19 @@ main(int argc, char *argv[])
>>    	tst_resm(TPASS, "recvmsg() with a bad socket descriptor - EBADF");
>>    
>>    	/*recvmsg () TEST2: Invalid socket , ENOTSOCK Expected error*/
>> -	count = recvmsg(0, &inmessage, flag);
>> -	if (count != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	count = recvmsg(fd, &inmessage, flag);
>> +	if (count == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (count != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "recvmsg with invalid socket "
>> -			 "count:%d, errno:%d", count, errno);
>> +			 "count:%d, errno:%d", count, err_no);
>>    
>>    	tst_resm(TPASS, "recvmsg() with invalid socket - ENOTSOCK");
>>    
>> diff --git a/utils/sctp/func_tests/test_1_to_1_send.c b/utils/sctp/func_tests/test_1_to_1_send.c
>> index 4966020..8d9516c 100644
>> --- a/utils/sctp/func_tests/test_1_to_1_send.c
>> +++ b/utils/sctp/func_tests/test_1_to_1_send.c
>> @@ -69,6 +69,8 @@ main(int argc, char *argv[])
>>    	int sk,sk1,pf_class,lstn_sk,acpt_sk,acpt1_sk, flag, count;
>>            char *message = "hello, world!\n";
>>            char *message_rcv;
>> +	int fd, err_no = 0;
>> +	char filename[21];
>>    
>>            struct sockaddr_in conn_addr,lstn_addr,svr_addr;
>>    
>> @@ -118,10 +120,19 @@ main(int argc, char *argv[])
>>    	tst_resm(TPASS, "send() with a bad socket descriptor - EBADF");
>>    	
>>    	/*send () TEST2: Invalid socket, ENOTSOCK Expected error*/
>> -	count = send(0, message, len_snd, flag);
>> -	if (count != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	count = send(fd, message, len_snd, flag);
>> +	if (count == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (count != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "send with invalid socket "
>> -			 "count:%d, errno:%d", count, errno);
>> +			 "count:%d, errno:%d", count, err_no);
>>    
>>    	tst_resm(TPASS, "send() with invalid socket - ENOTSOCK");
>>    
>> diff --git a/utils/sctp/func_tests/test_1_to_1_sendmsg.c b/utils/sctp/func_tests/test_1_to_1_sendmsg.c
>> index 7ac0b54..13c920d 100644
>> --- a/utils/sctp/func_tests/test_1_to_1_sendmsg.c
>> +++ b/utils/sctp/func_tests/test_1_to_1_sendmsg.c
>> @@ -86,6 +86,8 @@ main(int argc, char *argv[])
>>            struct sockaddr_in conn_addr,lstn_addr,svr_addr;
>>            struct iovec iov_rcv;
>>    	char incmsg[CMSG_SPACE(sizeof(sctp_cmsg_data_t))];
>> +	int fd, err_no = 0;
>> +	char filename[21];
>>    
>>    	/* Rather than fflush() throughout the code, set stdout to
>>             * be unbuffered.
>> @@ -151,10 +153,19 @@ main(int argc, char *argv[])
>>    	tst_resm(TPASS, "sendmsg() with a bad socket descriptor - EBADF");
>>    	
>>    	/*sendmsg () TEST2: Invalid socket, ENOTSOCK Expected error*/
>> -	count = sendmsg(0, &outmessage, flag);
>> -	if (count != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	count = sendmsg(fd, &outmessage, flag);
>> +	if (count == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (count != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "sendmsg with invalid socket "
>> -			 "count:%d, errno:%d", count, errno);
>> +			 "count:%d, errno:%d", count, err_no);
>>    
>>    	tst_resm(TPASS, "sendmsg() with invalid socket - ENOTSOCK");
>>    
>> diff --git a/utils/sctp/func_tests/test_1_to_1_shutdown.c b/utils/sctp/func_tests/test_1_to_1_shutdown.c
>> index de505f7..c209498 100644
>> --- a/utils/sctp/func_tests/test_1_to_1_shutdown.c
>> +++ b/utils/sctp/func_tests/test_1_to_1_shutdown.c
>> @@ -70,6 +70,8 @@ main(int argc, char *argv[])
>>            char *message = "hello, world!\n";
>>    	char msgbuf[100];
>>    	int pf_class;
>> +	int fd, err_no = 0;
>> +	char filename[21];
>>    
>>            /* Rather than fflush() throughout the code, set stdout to
>>    	 * be unbuffered.
>> @@ -112,10 +114,19 @@ main(int argc, char *argv[])
>>    	tst_resm(TPASS, "shutdown() with a bad socket descriptor - EBADF");
>>    
>>    	/*shutdown() TEST2: Invalid socket, ENOTSOCK Expected error*/
>> -        error = shutdown(0, SHUT_WR);
>> -	if (error != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	error = shutdown(fd, SHUT_WR);
>> +	if (error == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (error != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "shutdown with an invalid socket "
>> -			 "error:%d, errno:%d", error, errno);
>> +			 "error:%d, errno:%d", error, err_no);
>>    
>>    	tst_resm(TPASS, "shutdown() with an invalid socket - ENOTSOCK");
>>    
>> diff --git a/utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c b/utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c
>> index 6ba9c98..06c6847 100644
>> --- a/utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c
>> +++ b/utils/sctp/func_tests/test_1_to_1_socket_bind_listen.c
>> @@ -85,6 +85,8 @@ main(int argc, char *argv[])
>>            int sk,pf_class;
>>    	int error = 0;
>>    	int uid;
>> +	int fd, err_no = 0;
>> +	char filename[21];
>>    
>>            struct sockaddr_in bind_addr;
>>    
>> @@ -141,10 +143,19 @@ main(int argc, char *argv[])
>>    	tst_resm(TPASS, "bind() with invalid address length - EINVAL");
>>    
>>    	/*bind() TEST6: Invalid socket descriptor, ENOTSOCK Expect Error*/
>> -	error = bind(0, (struct sockaddr *) &bind_addr, sizeof(bind_addr));
>> -	if (error != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	error = bind(fd, (struct sockaddr *) &bind_addr, sizeof(bind_addr));
>> +	if (error == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (error != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "bind() with invalid socket "
>> -			 "descriptor error:%d, errno:%d", error, errno);
>> +			 "descriptor error:%d, errno:%d", error, err_no);
>>    
>>    	tst_resm(TPASS, "bind() with invalid socket descriptor - ENOTSOCK");
>>    
>> @@ -247,10 +258,19 @@ main(int argc, char *argv[])
>>    	tst_resm(TPASS, "listen() with bad socket descriptor - EBADF");
>>    
>>    	/*listen() TEST14: Invalid socket ENOTSOCK, Expected error*/
>> -	error = listen(0, 3);
>> -	if (error != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	error = listen(fd, 3);
>> +	if (error == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (error != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "listen() with invalid socket "
>> -			 "error:%d, errno:%d", error, errno);
>> +			 "error:%d, errno:%d", error, err_no);
>>    
>>    	tst_resm(TPASS, "listen() with invalid socket - ENOTSOCK");
>>    
>> diff --git a/utils/sctp/func_tests/test_1_to_1_sockopt.c b/utils/sctp/func_tests/test_1_to_1_sockopt.c
>> index e222991..4cd84da 100644
>> --- a/utils/sctp/func_tests/test_1_to_1_sockopt.c
>> +++ b/utils/sctp/func_tests/test_1_to_1_sockopt.c
>> @@ -98,6 +98,8 @@ main(void)
>>    	struct sctp_prim sprimaddr;/*SCTP_PRIMARY_ADDR set*/
>>    	struct sctp_assocparams sassocparams;  /* SCTP_ASSOCPARAMS set */
>>    	struct sctp_assocparams gassocparams;  /* SCTP_ASSOCPARAMS get */
>> +	int fd, err_no = 0;
>> +	char filename[21];
>>    
>>    	/* Rather than fflush() throughout the code, set stdout to
>>             * be unbuffered.
>> @@ -118,10 +120,19 @@ main(void)
>>    	tst_resm(TPASS, "setsockopt() with a bad socket descriptor - EBADF");
>>    
>>    	/*setsockopt() TEST2: Invalid socket ENOTSOCK, Expected error*/
>> -        error = setsockopt(0, IPPROTO_SCTP, 0, 0, 0);
>> -	if (error != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	error = setsockopt(fd, IPPROTO_SCTP, 0, 0, 0);
>> +	if (error == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (error != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "setsockopt with an invalid socket "
>> -			 "error:%d, errno:%d", error, errno);
>> +			 "error:%d, errno:%d", error, err_no);
>>    
>>    	tst_resm(TPASS, "setsockopt() with an invalid socket - ENOTSOCK");
>>    
>> @@ -159,10 +170,19 @@ main(void)
>>    	tst_resm(TPASS, "getsockopt() with a bad socket descriptor - EBADF");
>>    
>>    	/*getsockopt() TEST7: Invalid socket ENOTSOCK, Expected error*/
>> -        error = getsockopt(0, IPPROTO_SCTP, 0, 0, 0);
>> -	if (error != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	error = getsockopt(fd, IPPROTO_SCTP, 0, 0, 0);
>> +	if (error == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (error != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "getsockopt with an invalid socket "
>> -			 "error:%d, errno:%d", error, errno);
>> +			 "error:%d, errno:%d", error, err_no);
>>    
>>    	tst_resm(TPASS, "getsockopt() with an invalid socket - ENOTSOCK");
>>    #if 0
>> diff --git a/utils/sctp/func_tests/test_getname.c b/utils/sctp/func_tests/test_getname.c
>> index d7011f6..0d4d080 100644
>> --- a/utils/sctp/func_tests/test_getname.c
>> +++ b/utils/sctp/func_tests/test_getname.c
>> @@ -66,6 +66,8 @@ main(int argc, char *argv[])
>>    	socklen_t len;
>>    	int error;
>>    	int pf_class;
>> +	int fd, err_no = 0;
>> +	char filename[21];
>>    
>>            /* Rather than fflush() throughout the code, set stdout to
>>    	 * be unbuffered.
>> @@ -208,10 +210,19 @@ main(int argc, char *argv[])
>>    	tst_resm(TPASS, "getsockname on a bad socket descriptor - EBADF");
>>    
>>    	/*getsockname(): Invalid socket, ENOTSOCK expected error*/
>> -	error = getsockname(0, (struct sockaddr *)&clt_local_addr, &len);
>> -	if (error != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	error = getsockname(fd, (struct sockaddr *)&clt_local_addr, &len);
>> +	if (error == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (error != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "getsockname on an invalid socket "
>> -			 "error:%d errno:%d", error, errno);
>> +			 "error:%d errno:%d", error, err_no);
>>    
>>    	tst_resm(TPASS, "getsockname on an invalid socket - ENOTSOCK");
>>    
>> @@ -234,10 +245,19 @@ main(int argc, char *argv[])
>>    	tst_resm(TPASS, "getpeername on a bad socket descriptor - EBADF");
>>    
>>    	/*getpeername(): Invalid socket, ENOTSOCK expected error*/
>> -	error = getpeername(0, (struct sockaddr *)&clt_local_addr, &len);
>> -	if (error != -1 || errno != ENOTSOCK)
>> +	strcpy(filename, "/tmp/sctptest.XXXXXX");
>> +	fd = mkstemp(filename);
>> +	if (fd == -1)
>> +		tst_brkm(TBROK, tst_exit, "Failed to mkstemp %s: %s",
>> +				filename, strerror(errno));
>> +	error = getpeername(fd, (struct sockaddr *)&clt_local_addr, &len);
>> +	if (error == -1)
>> +		err_no = errno;
>> +	close(fd);
>> +	unlink(filename);
>> +	if (error != -1 || err_no != ENOTSOCK)
>>    		tst_brkm(TBROK, tst_exit, "getpeername on an invalid socket "
>> -			 "error:%d errno:%d", error, errno);
>> +			 "error:%d errno:%d", error, err_no);
>>    
>>    	tst_resm(TPASS, "getpeername on an invalid socket - ENOTSOCK");

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
